'use strict'

import 'dotenv/config'
import fetch from 'node-fetch';
import { getBearerToken, setPricing } from './utils.js';

async function handler(event) {
    const bearer = await getBearerToken();

    const productId = event.pathParameters.id
    const multiplier = event.body

    var url = `https://api.tcgplayer.com/pricing/product/${productId}`

    const req = await fetch(url, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'Authorization': `bearer ${bearer.access_token}`
        }
    })

    const prices = await req.json();

    const response = {
        statusCode: 0,
        body: ""
    }

    if(prices.success) {
        response.statusCode = 200
        const priceData = {
            id: productId,
            nonfoilMid: setPricing(prices.results.find((type) => type.subTypeName === 'Normal').midPrice, multiplier),
            foilMid: prices.results.find((type) => type.subTypeName === 'Normal') != undefined 
                ? setPricing(prices.results.find((type) => type.subTypeName === 'Normal').midPrice, multiplier)
                : "No price available",
        }

        response.body = JSON.stringify(priceData, null, 2)
    } else {
        response.statusCode = 404
        response.body = "Error"
    }
    
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