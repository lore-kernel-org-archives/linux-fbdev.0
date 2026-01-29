Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A42E3AF1
	for <linux-fbdev@vger.kernel.org>; Thu, 29 Jan 2026 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665275; cv=none; b=rzPzE7+kN33f7iiHAJve2zI4C6l/Pgoed9QYyg6bSRY/mzJQzoRc7WKTooCor90+q0TRYJnGzfeM45sWDHo+Nv5RO8mAQ/P372yeH/5sO+1oUII1DfiRw9Sgtrcgy08TnKdF2SRUyDCJSTv/S9MHO7z6xOxbDOevPsrsb8wNNBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665275; c=relaxed/simple;
	bh=4wc/9uTW91spHNuobQOHMGnTUsN3Hz6YFyG5zPLrFXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuoffV4TIFxi484dyCzUhlALOL0WgHv/7hNfv52CFANHhk2qTmR4E1/tI63PniUg8GnJoYa37N6hniCYYQjJX4XmiXCYrkmW6qCHp26O0MeKYU80eq50uZVdq4KtqQvkUes88l65+ycVcSnmfriJ8vTTIkviWQug1yIBOdm6LQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bShjd3KD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bShjd3KD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a743050256so3209755ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 21:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665274; x=1770270074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RW4PLSqQ5HtXaekEHkGIndldtB+Y8vvs+MZLayxhY8Y=;
        b=bShjd3KDCNmy8VYQ+NGR9Z2Uv5X9dl65k0tkgh5PHwNNrkpoVIIvYtzoHNBhvD3cNg
         MEGpssE6jxJNG5f15CuUokfPgFc4GQBoxp1yxpGDQ8l3RbvgUqlr07CFiotHhuGjucCU
         vWGo+WQQoTN2HESjW+WkRll/S1MTDI9/RtMBj2MudWhq+wzbUvLTdHRMxbv8FhxtA17x
         yqw8N0rmwcvo9zeGLC32NHJ3wYqJT7hmj+OB/sEDezlgzRmZmlYPLfDNd2lCUSoyGFMT
         2gMDHyZBBfZICBmgB3ua42zER0PlxMYEjigrJ7fRLv1Ca0ys6jVUepgRe3MXQmJ/5ukp
         LYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665274; x=1770270074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RW4PLSqQ5HtXaekEHkGIndldtB+Y8vvs+MZLayxhY8Y=;
        b=R7f7A3C3LJ9LvLkt2kKziva4nvFhiWVJ2ta9JgV9reumX/7obNz3hNEdT9pkJQicQy
         v+4ymMzppq+srEBMfQ5Cmzjr1UMDMSENgThrkEB3B9c5x97p2mYsVifzmycoYUR0jl5s
         8x3X0zzgmHGQQmfo0/etTU6w1j0YcDGDlPlvOrYHr5ImmHoyr1mTmTZLH4E/rFzHiyNw
         rS7jYC0xaXG26OsTpW3slhUfHDlyXS9YzGUDNK/CzOSNCcIwi39p/dgpHgeLBkWB6HAJ
         JlibKl4WmkMdpb+sgeBvYkS0J8UpWUA0eXDwBFv4nyk7VEoK1YA3S6Utnv0qN2WA3u1X
         M4rg==
X-Forwarded-Encrypted: i=1; AJvYcCWOeEGUi5yWJ/5IEJGMKSUXHCI1u7OJTEVwiGDed8lcNmfwBn/FzUcuHTX3aijdOTnx73wDNhTp8J8JwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGCBLniFdQZWIESoqxtQvL5tuNearP98KMtlRdOX8+qAn+pOq
	85SST9Cn5YdlzbtMJUkliEpjQ+itK4tXwbXkHggDGuRCqq8bfz1ckwfR
X-Gm-Gg: AZuq6aI6IGEPx+7gJ/GoAcKHSr8qL965SYnL1MVnSno2fndSSDJQOZOHP3ziUMpQn/R
	AnRIe6+d1rZM5YdwsidG43J5nllgStuV+VSycx2SGHP7tzz5CJfsyGjbWvBxlZKYiuTCGamTRmB
	AS8tvvAm+UWeC+eXsWj7EvK3UmjIisSvZ450/K9oJatBiNJJe+UVmVOs3vdRlcfriRnXaM2I+YR
	IgaCNCWYjAhVrdeYthuwTHx5WosJ87bm+D+BWzSEcaBfIG85XBfmhIuoSI+kXZ+uTaZwUAtaS/G
	kFSJi2DLTlRbB5lPV4ZzSIUMK28fff+CZlKr3wezfz3tbXZx1GEWU+cdZ8c657/HYdcBd53ja5h
	6p+Sh8khZx/ZXz4eKm3wxGYes9PkP5RBmJ5UxTAMIQX3HXRclnBt3CaSLizXlVE3Iou8oLqS/cL
	bgMGf0esrW8n/2pUotw2yq2AEFTj09pGYMnQ==
X-Received: by 2002:a17:903:2c6:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a870d7a907mr79567955ad.7.1769665273978;
        Wed, 28 Jan 2026 21:41:13 -0800 (PST)
Received: from [172.16.20.12] ([136.226.253.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b7f7caasm38795695ad.101.2026.01.28.21.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 21:41:13 -0800 (PST)
Message-ID: <304ef935-e82b-4556-be3c-6ec4f57cf68c@gmail.com>
Date: Thu, 29 Jan 2026 11:11:34 +0530
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: gpio-backlight: allow
 multiple GPIOs
To: Daniel Thompson <daniel@riscstar.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260120125036.2203995-1-tessolveupstream@gmail.com>
 <20260120125036.2203995-2-tessolveupstream@gmail.com>
 <3f3c47ea-1660-4bd4-ab89-3bdf58217995@kernel.org>
 <54d156ba-e177-4059-a808-2505983b4e2e@gmail.com>
 <500b603d-5abc-4c45-8d56-bbc88fc85b83@kernel.org>
 <aXnxGPNtk5BwoJOu@aspen.lan>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <aXnxGPNtk5BwoJOu@aspen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28-01-2026 16:50, Daniel Thompson wrote:
> On Wed, Jan 28, 2026 at 11:11:33AM +0100, Krzysztof Kozlowski wrote:
>> On 23/01/2026 12:11, tessolveupstream@gmail.com wrote:
>>>
>>>
>>> On 20-01-2026 20:01, Krzysztof Kozlowski wrote:
>>>> On 20/01/2026 13:50, Sudarshan Shetty wrote:
>>>>> Update the gpio-backlight binding to support configurations that require
>>>>> more than one GPIO for enabling/disabling the backlight.
>>>>
>>>>
>>>> Why? Which devices need it? How a backlight would have three enable
>>>> GPIOs? I really do not believe, so you need to write proper hardware
>>>> justification.
>>>>
>>>
>>> To clarify our hardware setup:
>>> the panel requires one GPIO for the backlight enable signal, and it
>>> also has a PWM input. Since the QCS615 does not provide a PWM controller
>>> for this use case, the PWM input is connected to a GPIO that is driven
>>> high to provide a constant 100% duty cycle, as explained in the link
>>> below.
>>> https://lore.kernel.org/all/20251028061636.724667-1-tessolveupstream@gmail.com/T/#m93ca4e5c7bf055715ed13316d91f0cd544244cf5
>>
>> That's not an enable gpio, but PWM.
>>
>> You write bindings for this device, not for something else - like your
>> board.
> 
> Sudarshan: I believe at one point the intent was to model this hardware
> as a pwm-backlight (using enables GPIOs to drive the enable pin)
> attached to a pwm-gpio (to drive the PWM pin). Did this approach work?
> 

Yes, the original plan was to model this using pwm‑gpio, and that 
setup worked. But on the SOC there’s no actual PWM controller available 
for this path— the LED_PWM line is just tied to a GPIO that’s driven 
high (effectively a fixed 100% duty cycle). Because of that, describing 
it as a PWM in DT was flagged as incorrect.

As pointed out during the SoC DTS review, the correct path forward is 
to extend gpio‑backlight to handle multiple GPIOs, rather than 
representing them as multiple separate backlight devices.

> 
> Daniel.

