Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E2340290
	for <linux-fbdev@vger.kernel.org>; Fri, 23 Jan 2026 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166666; cv=none; b=XSLwnqyBwOElbAI8F/sQLR6x1BR+rmXbvqtfSPNVqV2j/mfT1zONbf1pwnbhWKjcEc7GVk12h29qGrqCXQqZ5LA1uQm7UeX4VrhfMSaKpFE7dz/M6h8t78C+MUFXZh5PPdYaveuy8o4kTPInVnxMQ5k0ee5V/U1EGRlq9HG6EIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166666; c=relaxed/simple;
	bh=JzYSUCqqeWKfNi9rdKkxtfHev0ia4H+r1I/ZRyvcQiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkhbp2Hbzu5DNb+dJh3SBz3PkCP6+Ii+Na6oRYoJbh2owZEv4LkdsIBC/asY2b0s8G0nXrOHSmPi8uQ0vKFGeVEkEUxJ1Pm7recEj8rCJV4Rg5nL/YE82Bfct8mV7hmwApBenQ13DqpReaYIjiQwL1UW30SbV23CsYr06jemSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAztp8++; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAztp8++"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso2017433b3a.3
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Jan 2026 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769166663; x=1769771463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54G7XuhdW75vYSZtlnacHikNaLX+O6Mlc4zbY7Y1Luc=;
        b=hAztp8++AFV3mA0CV5I1xTB6mzXvh0DiZUWpiGqlZOGQvdZZU6qJEc7HprCfpRlM/O
         P1JP9mpEjogKrEvETqxYGVSrNlQuZ/Y4JoyIzB01x2lKKAM6EBsZ6XlDO0HVxdRB3nr8
         ZX85jqkVDgRrfpgLzVYTRIIzs9SmAPoMlY9xf63JUuwC9Krnf02EpO5afVvN6OnVxalw
         8rswvL+F9X5RlzfAdLS3vwI68mxSyzKa3XPBWEvDAPrPgkNHWl0qHY0CylpeFP5m1pNa
         WTSmLmYeFrzOVKYtYgxr5LOC/Pmm399ueF6NFPOLb7ESMCotPxiSuaUh2S4gxmtKCZui
         HHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166663; x=1769771463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54G7XuhdW75vYSZtlnacHikNaLX+O6Mlc4zbY7Y1Luc=;
        b=pgEMoTK9uQWa0mjOLZCDztV5+U2MI6S8aCoeO5vPA7PO6LwfU8jwInaEt+SY09ej/G
         DngvWAyi49Bbxkm3rt+UuaxH7DvVokQHKPu2Urk1DvbG0Lz8sErpvDD8sjjm8fzH0GYs
         Z16QRDYGkihLGjKYnMHm1jbUzuJ3+jgtmvg9hFLsenjUTZTlnkFlzsx1SlBT50wfvhzJ
         beY8MI6VaVkIjdDQwB8pyh7iFPjLUdWLzPme3H5wle4FsikftM2XkYX/FUhCzdjDebRl
         CUqrmZDTz6YcxeOI0nNVryKUmlWzBwKMraYrdoRVW/zJ4RYLfc1W+0Rm02XC0fgt6dFf
         Jzhw==
X-Forwarded-Encrypted: i=1; AJvYcCVnn45VWfklASa2XuM1dWjMW+O3ZC39W2vGj0z3o1p5L7TrB4usS0mlKny43tFRrAoaXqbe3Q6Zcb9pJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdoP4ZGaiakr9HT/lNjzRsDWdDoBi8fNKWLSeWQrDio/wGoyXm
	hITcUvgNAH1PUQNYNLTo4oF8qSekVbPw0hthaitR/pzmfgwDJC6nCnWS
X-Gm-Gg: AZuq6aK7JmHLQ42ELZl6dx9bg2py1kwDeNxAJtUySpkHKTa9Z7RMFqOgpJX/zO4XS8Y
	j8BOln3T+F4w15wgD8nbRvnlDATQNl1doaszsSEYL9EqYY4UkKKjZ46EcqMkwuUkHwi0ZAM40oA
	cDIeODnJlQoCgQ59uxg17uMK9r/me7sd9rzOK/rHfj5ErinVzDDil5QeF3ecFUVPomOHKG81ryh
	6mylvz+1MmzSRTgUIOD5kKY9kHOvzN0NvSbIhuJFv3dba6HHOBttenCUIgqV17QIsn6MITwdvqw
	7+TMTwf/61Uj1gRmJ+V1tw7DnlK6arKQz3hW2AYhmbHiK9W4qSux0ERPRFcUGeQ7aPdqcbt0vIU
	Hl/24MIguoeOL08BSKCBGN7uEP9hLlLaXoELClF1S4Fsfw4oFsZzn22xOUx3cWZW54Fqaq+exOO
	7XlME6cRIoH2/GN6Vbug2AS6DjlXPDVRGFpw==
X-Received: by 2002:a05:6a00:bc8c:b0:823:aa5:23f1 with SMTP id d2e1a72fcca58-82317eea693mr2402046b3a.57.1769166663318;
        Fri, 23 Jan 2026 03:11:03 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231864489csm1949221b3a.9.2026.01.23.03.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:11:02 -0800 (PST)
Message-ID: <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
Date: Fri, 23 Jan 2026 16:41:24 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
To: Krzysztof Kozlowski <krzk@kernel.org>, lee@kernel.org,
 danielt@kernel.org, jingoohan1@gmail.com
Cc: deller@gmx.de, pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-2-tessolveupstream@gmail.com>
 <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20-01-2026 20:01, Krzysztof Kozlowski wrote:
> On 20/01/2026 13:50, Sudarshan Shetty wrote:
>> Update the gpio-backlight binding to support configurations that require
>> more than one GPIO for enabling/disabling the backlight.
> 
> 
> Why? Which devices need it? How a backlight would have three enable
> GPIOs? I really do not believe, so you need to write proper hardware
> justification.
>

To clarify our hardware setup: 
the panel requires one GPIO for the backlight enable signal, and it 
also has a PWM input. Since the QCS615 does not provide a PWM controller 
for this use case, the PWM input is connected to a GPIO that is driven 
high to provide a constant 100% duty cycle, as explained in the link 
below.
https://lore.kernel.org/all/20251028061636.724667-1-tessolveupstream@gmail.com/T/#m93ca4e5c7bf055715ed13316d91f0cd544244cf5
 
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  .../leds/backlight/gpio-backlight.yaml        | 24 +++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> index 584030b6b0b9..4e4a856cbcd7 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> @@ -16,8 +16,18 @@ properties:
>>      const: gpio-backlight
>>  
>>    gpios:
>> -    description: The gpio that is used for enabling/disabling the backlight.
>> -    maxItems: 1
>> +    description: |
>> +      The gpio that is used for enabling/disabling the backlight.
>> +      Multiple GPIOs can be specified for panels that require several
>> +      enable signals. All GPIOs are controlled together.
>> +    type: array
> 
> There is no such syntax in the bindings, from where did you get it? Type
> is already defined.
> 
> items:
>   minItems: 1
>   maxItems: 3
> 
> 
>> +    minItems: 1
>> +    items:
>> +      type: array
>> +      minItems: 3
>> +      maxItems: 3
>> +      items:
>> +        type: integer
> 
> All this is some odd stuff - just to be clear, don't send us LLM output.
> I don't want to waste my time to review microslop.
> 
> Was it done with help of Microslop?
>

I understand now that the schema changes I proposed were not correct, 
and I will address this in the next patch series. My intention was to 
check whether the gpio-backlight binding could support more than one 
enable-type GPIO. 
Could you please advise what would be an appropriate maximum number of 
GPIOs for gpio-backlight in such a scenario? For example, would allowing 
2 GPIOs be acceptable, or should this case be handled in a different way?
 
> Best regards,
> Krzysztof

