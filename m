Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3325BEF8
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768279532; cv=none; b=ldjwZhgvN8pDWBsf1waomFlVd5QajQ3kZr6xMQBUMd6E/J2aa/KH6TJ/5eOJpKc5+OD4TAglDSjx4geXf1m+qfM3jofqgapKZZjBe1omsULBYUWw2mSeZh0dSaznB9EI5ZOQKuhhm57pWbFuolPU/W0M1R0XuhE6l4Y3HTNDmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768279532; c=relaxed/simple;
	bh=cN1lliBDvJ2161XpgMqnGbtxFjb3awzneHzXZEap+mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLIKQt4MEeGm1koGAYEJgbkjWzWHTz/t2PMusJg63fvClsU6fT+tBkN+5PG0ZT4qyYTD631hVs6PYxk1kEAjHhbluRwxE1GvK2F/udbfxy1q98G6j+os/G28lIEG6gY51o+1YEBP7rVU6q9+pjOIyjmMZuDpb+4DSirLsN1Hfo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuVJsQA3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuVJsQA3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so2729381b3a.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 20:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768279530; x=1768884330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iy6S9q8/CD1KaKEpgdKuwKLpEadDje8AFP0pfPr3/5I=;
        b=YuVJsQA3Res31y46H78DBm8nL4DRqWkA0OnGcC8aMdPhc7SJgxNz+xh0jWdwp1tTpc
         IKU42eIgHvAmQVhRpj7/TmvHBpDSVJNMNJWujPh6/AC8Qr8fM9J7lalJs60RnF5eazUR
         lnBIlSvxLbwdS8P53zapTA7P/7RqIajhv/pOzfScahgdayojMH2t0IVCQertgK1lZPc7
         tqR4dcwE9UBJawy/MpSB9o6R6Ljy3pryxPV3BrUUeNNvCLdKF+6g8bgTP5nRZK1XsAsY
         9JchQB/IE5Ptnhd45oT4PM4daLNm4ykcT6yskaVhvlkm8d6QKzOBgcPkLagSIL2HST3B
         G0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768279530; x=1768884330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy6S9q8/CD1KaKEpgdKuwKLpEadDje8AFP0pfPr3/5I=;
        b=LLccy4ioq5cil7ZUDA87muJaD5+IzYpx0yKjZ6/jF+U5xr330kHAdZPHLWEaPws+36
         vyY56yWMoPie5ezpoi0mU8nKd6SQugJ60Kka8XJbLobuf7h4I/edDhZRvau3DgqRiqn+
         obTAWgt2eo093T3coB7G8T1b2Adl6nPijym+9A+V+umoDqmMltY3foqsoML3QLeFAoIP
         wXrKsyDGvWq3AkZs2CO6p0P8UnDa09ZxcC13zDOnd2coTN+VOXbYv28n3ibvFR7hN8B6
         TrrLeRus/mtedQnBqsf1e6sOuJ9StEY2zLY/eHvcbG9rkAXjHXbVpelUF7egZ11aTzKF
         9ZdA==
X-Forwarded-Encrypted: i=1; AJvYcCWGyZF6vln4f9Ee09Nlah7j4uPyREhDseipH+yts6X1w8Ell3h8+zW4YaSxifBbG1QVUdwqv1vlkmgPAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4K5yUCQO982eKTJgZkpUxeD09Y3wZgB9KhfLgm1GxtEeS5IL6
	kLY/BwURdOELxuyfwSDGKGRXEi4p/RCramJeDGPdEinyK1rRoIgZfeMq
X-Gm-Gg: AY/fxX7Y9v04spbPmLRNgnvDjEewkhzvl8ISGr/ozVNNy2TmvGbw0RSLtHWRpVUTDR+
	RwKt6AK6ZaJaQM32pn1DT+VrKu/HjEJHbPHKg14S3J55CsmEoYqJ3J7nj9+TYJ9ci18G2Yp960T
	Z2l0RNhdpbawgH/ykLvjKfzyFL+WQDovygncASllqvaFHYZkCJvaTtMsw+ZQbAaIyAfFuJdksR2
	zb02pKKAXwOgfdZU8v8sIlYucHcfKSsm1Dg+D55i1nJtLUHh590Idh1709J+FE94jXXyp8cEXmD
	ETKhNMJH08Pxzgs5QMjyk4JmleqbKwDgf+y+rhY5I6gPiPE0WEJjGH00m6rhDtZJFr8fcq9xy6o
	1zrf6rJ99n1U5q4WnkYieq6ILr8NN2gaZUWcuQlt3ZWE3+P9A3AGlpzsSnVv5i3kj7mM2Ec3oZ7
	CYs5/Ito6HrrTA9pcVoOBHpqdWH0w/COUoqg==
X-Google-Smtp-Source: AGHT+IFqbGus3DZt4vurEFth5/Rb5XoyKQRcXgMFVDwspPX6ajf+F0/ZgCzEPgnpPLFp0Bu5b44dew==
X-Received: by 2002:a05:6a00:438a:b0:81f:4ce8:d641 with SMTP id d2e1a72fcca58-81f4ce8f745mr5760972b3a.37.1768279530424;
        Mon, 12 Jan 2026 20:45:30 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f36f88f4bsm8338351b3a.36.2026.01.12.20.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 20:45:29 -0800 (PST)
Message-ID: <c182df66-8503-49cf-8d1d-7da17214b843@gmail.com>
Date: Tue, 13 Jan 2026 10:15:53 +0530
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
 <aVuKdAyXfWLs-WJI@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aVuKdAyXfWLs-WJI@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05-01-2026 15:25, Daniel Thompson wrote:
> On Mon, Jan 05, 2026 at 02:21:19PM +0530, Sudarshan Shetty wrote:
>> Update the gpio-backlight binding to support configurations that require
>> more than one GPIO for enabling/disabling the backlight.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>  .../bindings/leds/backlight/gpio-backlight.yaml      | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> index 584030b6b0b9..1483ce4a3480 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
>> @@ -17,7 +17,8 @@ properties:
>>
>>    gpios:
>>      description: The gpio that is used for enabling/disabling the backlight.
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
> 
> Why 2?
> 

In the current design, the LVDS panel has a single backlight that
is controlled by two GPIOs. Initially, It described as two separate 
backlight devices using the same gpio-backlight driver, since the 
existing driver supports only one GPIO per instance.

So the maintainer suggested to extend the gpio-backlight driver 
and bindings to support multiple GPIOs.
https://lore.kernel.org/all/q63bdon55app4gb2il5e7skyc6z2amcnaiqbqlhen7arkxphtb@3jejbelji2ti/
> 
> Daniel.

