Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536335293D
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517977; cv=none; b=IFkl9yssoNXpbplrdKxXqnSt3a/1HFX3tn9SGe8up5r3htu81o/VlJTD7NQJnaDHZvH6H8DwETB7nF3EWwhi1hglOzPAqIwPfVxe3X+u4i7rrSIvVpCNssoEbgfQk+LzCvZ4H/nBqgx/eT0XteeRDPLsnV+ShC5X7yjFmYubSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517977; c=relaxed/simple;
	bh=dnr0XDRXOdzvkZI3AmE1l0zN5ERZuqLrbJ/VzZeX6ac=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ac9AGCvdJz/4uT5BAtg3hW6BHtwcjm//gIm0VgS78k+DtWPwh5m6guEvp2iTF6KIoUYWjo9nplymtjHYxZQGIBNnebt/dGZ8krL58YQ+vak6Bgk2zYkHiPoEsNepql9xEovNQGlYMY4lP5j3Fc9Fnlvq324Yv3BHJDnQn27SHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRHi3CHb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRHi3CHb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d52768ccso37665905ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769517975; x=1770122775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0f9xEgBB4m5dikvKwwgGmgDkV1uot0Bgrh0VsHDieZs=;
        b=TRHi3CHb3ePv20iZui8jdsNOwHomD5fMlEQZ7Yv2nBMmFVLIWxwA+s5Smfj1TdPcR7
         gHgImO3QMWDmVwa3gOYjvW9cgW0CY2M1Z9GoGphWVjiZ55d8HBHkp/IW91MlhWl0z5eM
         uloNotgyR9plmvQJDPb6c/frK0cHXrcRfeWBM5Y64jMWsyVihCsfhAO/LDqwdfjS59va
         bguULMiW6FrA4c5WXBHDReEHVCJ6wo62k2M5dmtPuSVOJStk2Jemw5BHGGZ0Ki/cJTYw
         Oi6geDPrJQmtAB7BRyoMYclFvddjoHx1JiK2x8QBs6JSxUAfy3X+cYQ+9ecunLb/b+CM
         Fyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517975; x=1770122775;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0f9xEgBB4m5dikvKwwgGmgDkV1uot0Bgrh0VsHDieZs=;
        b=AvjmcLm6fK7zwxJPhZV+fhX7+wj5J0U3maECUWq8FvLRQVlW8sLzKfblCaBlzW/FGf
         DXqcEouifLRUOcaP7SmZVCuf3/agY79a6xbpNqyokGMj/2v9nCOa7nwgBaCh9D9s/7bv
         gzDYJdmhwKunSWVS0fjyXNtVLOu1xvANh6Y5j2NtLX1mWHzF5JMbxFLLKJGp+LpKJjpm
         ZqhYx4cVxpDGG3IOoWAmJ6MzwX1FIJguHuJcMb//BtRhIM7dqVKDVc8Q5rpgPwp7FSWT
         gBnH+Q+hYD6eaFnvPKmaykOITjnepJY1F4Ae66rKqskTxzmXJ/J1eIRWzVPMbHWFH4+F
         OWHg==
X-Forwarded-Encrypted: i=1; AJvYcCXrZYNsD8gtRpMrDxi9Km6kj53pGlVR6g3ih+EvSPT8eWbokuYgk2HsvWVuLuNNkbU7/kwlqaehbqJjqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Jej/lnyQHXUP+H4eq4Bg4hi0LwTtO3gznArJadIF9oiPRHyW
	e/Jx05rc91Lhz6fTOwfyKwUXJFjhpxEuCOzQER3IeglL4mTqTS4OV206
X-Gm-Gg: AZuq6aIZC4y/mZlYkqBqRK8SQ3dfs7LY96mnZnaGf9dNZfMvarWb6a4T2Dfgxqj6qYq
	gNPqOJA/h10RR/9kKsYDJmh74/R1VLya8wCvQMJtO2XS240g/ydSI7Dmvs5+TQBVg+3jB+vXJjb
	MKKRXsifYXJbvw+BQ6S+u+Dxm9aHHGTUADZiysVjLT4CQksMUaJsfIskOQbhTAFkjow0GaaOmtN
	Ql4rSxLYcwfq7qhj4FqfiW3E8QiygnyYKqj+gjxkhA07e2S2muS9+WOmrMB8F090k/K+wlLbUqL
	zhLfk2TKMG6G18LdjJPd0o9EAe48HSyvZ1VSlngJAZRYr/4u37Vm8Qs9CaVeJk7d+LfDuk8mRUn
	kQNUAyacxVSCyrAenvzWNcWfN7WWl3URnlAdBQ5LkwhlHZyPN/29FwvivXDYwKvRcEJsT8lEBne
	h+Lop3vtx9SgSh04shJtfwXOb+zjg86605DQ==
X-Received: by 2002:a17:902:e802:b0:2a7:a5b3:bf4f with SMTP id d9443c01a7336-2a870de2274mr13541465ad.34.1769517974606;
        Tue, 27 Jan 2026 04:46:14 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa675sm119001545ad.15.2026.01.27.04.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 04:46:14 -0800 (PST)
Message-ID: <5f78fbe8-288d-4b0a-af57-e834bd1186ba@gmail.com>
Date: Tue, 27 Jan 2026 18:16:36 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
From: tessolveupstream@gmail.com
To: Krzysztof Kozlowski <krzk@kernel.org>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com
Cc: deller@gmx.de, pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-2-tessolveupstream@gmail.com>
 <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
 <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
Content-Language: en-US
In-Reply-To: <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23-01-2026 16:41, tessolveupstream@gmail.com wrote:
> 
> 
> On 20-01-2026 20:01, Krzysztof Kozlowski wrote:
>> On 20/01/2026 13:50, Sudarshan Shetty wrote:
>>> Update the gpio-backlight binding to support configurations that require
>>> more than one GPIO for enabling/disabling the backlight.
>>
>>
>> Why? Which devices need it? How a backlight would have three enable
>> GPIOs? I really do not believe, so you need to write proper hardware
>> justification.
>>
> 
> To clarify our hardware setup: 
> the panel requires one GPIO for the backlight enable signal, and it 
> also has a PWM input. Since the QCS615 does not provide a PWM controller 
> for this use case, the PWM input is connected to a GPIO that is driven 
> high to provide a constant 100% duty cycle, as explained in the link 
> below.
> https://lore.kernel.org/all/20251028061636.724667-1-tessolveupstream@gmail.com/T/#m93ca4e5c7bf055715ed13316d91f0cd544244cf5
>  
>>>
>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>> ---
>>>  .../leds/backlight/gpio-backlight.yaml        | 24 +++++++++++++++++--
>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>> index 584030b6b0b9..4e4a856cbcd7 100644
>>> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>> @@ -16,8 +16,18 @@ properties:
>>>      const: gpio-backlight
>>>  
>>>    gpios:
>>> -    description: The gpio that is used for enabling/disabling the backlight.
>>> -    maxItems: 1
>>> +    description: |
>>> +      The gpio that is used for enabling/disabling the backlight.
>>> +      Multiple GPIOs can be specified for panels that require several
>>> +      enable signals. All GPIOs are controlled together.
>>> +    type: array
>>
>> There is no such syntax in the bindings, from where did you get it? Type
>> is already defined.
>>
>> items:
>>   minItems: 1
>>   maxItems: 3
>>
>>
>>> +    minItems: 1
>>> +    items:
>>> +      type: array
>>> +      minItems: 3
>>> +      maxItems: 3
>>> +      items:
>>> +        type: integer
>>
>> All this is some odd stuff - just to be clear, don't send us LLM output.
>> I don't want to waste my time to review microslop.
>>
>> Was it done with help of Microslop?
>>
> 
> I understand now that the schema changes I proposed were not correct, 
> and I will address this in the next patch series. My intention was to 
> check whether the gpio-backlight binding could support more than one 
> enable-type GPIO. 
> Could you please advise what would be an appropriate maximum number of 
> GPIOs for gpio-backlight in such a scenario? For example, would allowing 
> 2 GPIOs be acceptable, or should this case be handled in a different way?
> 

In line with Daniel’s suggestion, I am planning to adopt a fixed upper 
limit for the number of backlight GPIOs. The current hardware only 
requires two GPIOs, so the maxItems can be set to 2.

If future platforms or customers require support for a higher number 
of GPIOs, this limit can be increased and the driver can be 
updated accordingly.

Kindly advise if this solution aligns with your expectations, or if 
you prefer an alternative maximum value.
 
>> Best regards,
>> Krzysztof
> 

