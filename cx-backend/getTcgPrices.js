'use strict'

import 'dotenv/config'
import fetch from 'node-fetch';
import { getBearerToken, setPricing } from './utils.js';

async function handler(event) {
    const bearer = await getBearerToken();

    const eventBody = JSON.parse(event.body)
    const productId = eventBody.id;
    const multiplier = eventBody.multiplier;
    
    console.log(event.body)
    console.log(eventBody)
    console.log(productId)
    console.log(multiplier)

    const response = {
        statusCode: 0,
        body: ""
    }

    if(!Number.isInteger(multiplier)) {
        response.statusCode = 400,
        response.body = `Bad multiplier value, ${multiplier} is not a number.`
        return response;
    }

    var url = `https://api.tcgplayer.com/pricing/product/${productId}`

    const req = await fetch(url, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'Authorization': `bearer ${bearer.access_token}`
        }
    })

    const prices = await req.json();
    console.log(prices.success)

    if(prices.success) {
        response.statusCode = 200
        const priceData = {
            id: productId,
            nonfoilMid: prices.results.find((type) => type.subTypeName === 'Normal') != undefined 
                ? setPricing(prices.results.find((type) => type.subTypeName === 'Normal').midPrice, multiplier)
                : "No price available",
            foilMid: prices.results.find((type) => type.subTypeName === 'Foil') != undefined 
                ? setPricing(prices.results.find((type) => type.subTypeName === 'Foil').midPrice, multiplier)
                : "No price available",
        }

        response.body = JSON.stringify(priceData, null, 2)
    } else {
        response.statusCode = 404
        response.body = prices.errors[0]
    }
    
    console.log(response)

    return response;
}

const _handler = handler;
export { _handler as handler };

// function test() {
//     handler({
//         pathParameters: { "id": "491816", "multiplier": "50" }
//     }).then((response) => console.log(response))
// }

// test();