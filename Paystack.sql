SELECT 
    id AS transaction_id,
    status AS transaction_status,
    currency AS payment_currency,
    country_code AS card_country_code,
    CASE
        WHEN currency = 'NGN' AND country_code = 'NG' THEN 'Naira transactions with Naira card'
        WHEN
            currency = 'NGN'
                AND country_code != 'NG'
                AND country_code IS NOT NULL
        THEN
            'Naira transactions with foreign card'
        WHEN currency = 'USD' AND country_code = 'NG' THEN 'Dollar transactions with Naira card'
        WHEN
            currency = 'USD'
                AND country_code != 'NG'
                AND country_code IS NOT NULL
                AND country_code != 'US'
        THEN
            'Dollar transactions with foreign card excluding the US'
    END AS Transaction_detail
FROM
    paystack
WHERE
    status != 'abandoned'

