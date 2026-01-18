Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190F1F8755
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Jan 2026 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768754895; cv=none; b=en/AL9U+IKzI4hGNIgikEROHCrylQQdNiwu+NmWf7686dE5auMIpkMYdKm3TKUR/tfYq2q5MiUP0G9fv3p87/DJzd3+IgPQ65rb5jHl2zLuNJK4elmrjSgaDeKm0dz0UzAsVhm0KjwmSGNEa/3X000tuTemQ1GClhIrc8P0KpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768754895; c=relaxed/simple;
	bh=ObBNgYmI7km2QNXCjpehnGoXCANLUlsMEgFWywznUhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVUKySPAdKkp0apyLrzD1xY1nXTcPQQbCWnu1lBn/rhJ3ybEU/qKHyAkU5AArRb7TuNv9wKVHgV2zRfEqBiNUkOHbSg6ayh2/HG18BT1JAPp3A4pnPeZXs3xtvcFnfo8g6M/A3Zcan9UKt6v0nJ0/WRHCLRQMViYp/7wSd/peK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZmroWXG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZmroWXG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0f3f74587so22509955ad.2
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Jan 2026 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768754893; x=1769359693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0twtbtNGNQIp4HwkKCyjxkTPom6wsw2QrSPQrsy5co=;
        b=QZmroWXGE2ruM9WWPVMd5Mce81h1MzxLNb1GU2Y88ANcqBMiCbfAvudkzw5F6thdSA
         vTpwCuadlDcbqtWRwRws1YPx8LEChH0aSro75GGoOrdZGv6IgERwWpt327lE99aPAKnb
         VbEshIC/mA3s9Wih+XOrIitoKa8xUL19DBZhJFE06S6Av0lxu5Gr6NzXtc6l5UkcV4Fm
         YmenxwTZ09K1BfQktlGa4wcCibAv8oBNKOk1OxIhchOsN+bFQvQxXjVvcC2nyY5CJFVW
         rT61hvktJ6wuyGTNZRFff/1bdHhbtkT24b/1DV8ptMuqvhTt1KgD3jgIxM+J8cVIEEoB
         b1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768754893; x=1769359693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0twtbtNGNQIp4HwkKCyjxkTPom6wsw2QrSPQrsy5co=;
        b=gCfPIkjvnOOFEktDM9MQVixisz8Va3MCs3wLn7KYc5t4mfjvzHjXDCzPsnMAgGIUzH
         SvoSP3P9QZmNG0lPGpLiUYBLmQsVNTgVWPwq8ry3KJHQC6xC6b1Int4zib79oM9tcWSo
         uD/Ehj3mdHe35ROHuT7kAYt5ArDTpCR+yvg7qUG9exBouZVn5xvJT5fGM1kFuFhVtEPw
         P5qUtdaBPymwtq8ShcucyMfMc2NiVkPhHzYPC67qept/Hhhpnmk83cMuuOB6va4CihxG
         SU68wwtvj0oxnKNnpRXujZNKZLRtKhZG0aLmkR0rMzXxbOg1Vw0USBmhErydQi/Jc1ac
         4nnw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3rX5UOrqrTFKPKX5XntMl0nKulLdoe5zK3JhMD90ZURVnMc/rS0e64TDOI42zwSpbLQvNsHQsOMkoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfC0G8KRlp9m8xx6/PxFllESNuvkV2l2Y8E0jvPAy1NvUie7m0
	qLMmkgOQbragELn4D+UZXAK8TfCwNwgToRbZOxQJWs129sucv1jof+jq
X-Gm-Gg: AY/fxX6V1dikUfz1Xc24TIgNpa6aKK4W+Ok1RBt+6ceoKJSRNiBDl6jKu4JmpkYh5Ea
	DkfZYGapOEXwXRLOFRpqWyJpHOARWefx/RdCkyPRZ9ETiFYO4qR7vn8rHf+RhypY1B7Yli2HJQl
	KLzZKEp9nOC0AfhSdgWmhl0UdySnTYfnzttAh6NCzlVZIjlsJWc9lUXq3lv2xqsRFp8Ig3rKf+B
	Od+1AFfYTKvg1GGC822wzy6s0el7/bexynrA2H8lf24BmlXwMVCZdvuhEDcPsgDbGR38waq7Oh+
	jmR16h/z1kvVlUB7L7ASEAdkM5dy2h8ctEfUGxxJKyvwzOOokYzixzOYWcR0KSK428rEnrk4qZ0
	SIwBFbUB90+CHXmo4r3HpV8v0yj93Ilf0NKcFoA0SKuuUfT0kj2iBb94iU4j30bikPzJJybrrHp
	36kD0JnDXU1jD0I9m29m9ogiVI6bUkJ5H0DqA=
X-Received: by 2002:a17:903:124d:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2a7175be718mr92063215ad.30.1768754892810;
        Sun, 18 Jan 2026 08:48:12 -0800 (PST)
Received: from [192.168.31.239] ([167.103.54.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbbf5sm70904105ad.47.2026.01.18.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 08:48:12 -0800 (PST)
Message-ID: <95a49665-f379-48a7-a2b5-d288cdfdc0a8@gmail.com>
Date: Sun, 18 Jan 2026 22:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
To: Daniel Thompson <daniel@riscstar.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105085120.230862-1-tessolveupstream@gmail.com>
 <20260105085120.230862-2-tessolveupstream@gmail.com>
 <aVuKdAyXfWLs-WJI@aspen.lan> <c182df66-8503-49cf-8d1d-7da17214b843@gmail.com>
 <aWe7_hFpmO0E2sJe@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aWe7_hFpmO0E2sJe@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14-01-2026 21:23, Daniel Thompson wrote:
> On Tue, Jan 13, 2026 at 10:15:53AM +0530, tessolveupstream@gmail.com wrote:
>>
>>
>> On 05-01-2026 15:25, Daniel Thompson wrote:
>>> On Mon, Jan 05, 2026 at 02:21:19PM +0530, Sudarshan Shetty wrote:
>>>> Update the gpio-backlight binding to support configurations that require
>>>> more than one GPIO for enabling/disabling the backlight.
>>>>
>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>> ---
>>>>  .../bindings/leds/backlight/gpio-backlight.yaml      | 12 +++++++++++-
>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>>> index 584030b6b0b9..1483ce4a3480 100644
>>>> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>>>> @@ -17,7 +17,8 @@ properties:
>>>>
>>>>    gpios:
>>>>      description: The gpio that is used for enabling/disabling the backlight.
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>
>>> Why 2?
>>>
>>
>> In the current design, the LVDS panel has a single backlight that
>> is controlled by two GPIOs. Initially, It described as two separate
>> backlight devices using the same gpio-backlight driver, since the
>> existing driver supports only one GPIO per instance.
>>
>> So the maintainer suggested to extend the gpio-backlight driver
>> and bindings to support multiple GPIOs.
>> https://lore.kernel.org/all/q63bdon55app4gb2il5e7skyc6z2amcnaiqbqlhen7arkxphtb@3jejbelji2ti/
> 
> Right. So, once we support multiple GPIOs then why limit it to 2?
> 

Okay, got the point. I'm removing the maxItems constraint entirely 
to allow any number of GPIOs as below:

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 1483ce4a3480..82698519daff 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -16,9 +16,11 @@ properties:
     const: gpio-backlight

   gpios:
-    description: The gpio that is used for enabling/disabling the backlight.
+    description: |
+      The gpio that is used for enabling/disabling the backlight.
+      Multiple GPIOs can be specified for panels that require several
+      enable signals.
     minItems: 1
-    maxItems: 2

   default-on:
     description: enable the backlight at boot.

Does this approach work for you?
> 
> Daniel.

