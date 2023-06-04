'use strict'

import 'dotenv/config'
import fetch from 'node-fetch';

async function getBearerToken() {
    const response = await fetch('https://api.tcgplayer.com/token', {
        method: 'POST',
        body: new URLSearchParams({
            'grant_type': 'client_credentials',
            'client_id': process.env.client_id,
            'client_secret': process.env.client_secret
        })
    })

    const bearer = await response.json()

    const bearerToken = {
        access_token: bearer.access_token,
        token_type: bearer.token_type,
        expires_in: bearer.expires_in,
        userName: bearer.userName,
        issued: bearer['.issued'],
        expires: bearer['.expires']
    }
    return bearerToken;
}

function setPricing(price, multiplier) {
    var converted = Math.ceil((price * multiplier) / 5) * 5 
    return converted < 30 ? 30 : converted;
}

export {
    getBearerToken,
    setPricing
};