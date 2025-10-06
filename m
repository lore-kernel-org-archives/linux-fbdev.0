Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB49280CC8
	for <linux-fbdev@vger.kernel.org>; Mon,  6 Oct 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758596; cv=none; b=U4pMcbuofpewxiGhLNjoxbJkA2BypdJZJ9iZa3myYSihqEsCY2fCtXlnZJZdlIesJRd+4B/BV5QW1lSxIWaJKtkp08L+VnC7oyWeTtHrWR4MOaWCbGjZtcRJq47bRpOTQzI9SvxjvsWiEyWqUXZphz+nMI/A9tXGkAD/36mNDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758596; c=relaxed/simple;
	bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB7kmLWSnHwTH57Q2A7bJLxTcUPe/8WZqo5KO+5BcVKVzXiwLP24Y5CGkLZ47OeDCWQDpxVSj+V/8qU5LfcoRj5zGwQQk46dXdgQLTDYIUfgw0vYvpal2L3HJPi2ONf+OB3Y8V+HxDR8mPjpbk6WmJxUtS5bEywAzTNGS4HVvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqKwDz69; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqKwDz69"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d603a269cso53034527b3.1
        for <linux-fbdev@vger.kernel.org>; Mon, 06 Oct 2025 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759758594; x=1760363394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
        b=kqKwDz69EMTkAiOT48gl3EkdLcxLEW+2AaLRD/FgOmZAGr/u0yS2tmwWJHaZO7bj7K
         PiK/mP38jF55AT7Mxh4XzJVd2gp+hwLaC9qm8n4ej5onsIzAFgV64zlUnumPgotrIdwE
         s1CXY8DOvfgebKMJT7Z3QZA53DtpAfONZiFnEK0Q/fDQDNdhr6gkvecpruyThzpVmq6L
         Z9h0Wjcgsed+JIhMVTkdnZZpVR26sq7QTbomXALfKcPommsgmLDtWE0UeYDBgARo8PEE
         sN5itGGBkMlm2mCHNBr0fBMgjestyv8SvwW/3dkaKByjrMm2/wyMdJuNlwsJNHWCSFEM
         IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758594; x=1760363394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
        b=ZGyn8OsNH1gQzkr6axcRvUChN5ko5A8ZlZaMjW4jA4BAz/5alsO5lgGXgL4uMO+zhT
         NJkDjRdgfDZWgsTv16CbE0jIqkBXEVPSCxs2MMZSH8k+zIcTGHNfJEZR8DBSLldy5IlE
         E3yzDtI5o6q+VLh6w7bJQB8PbG3dAPns4tZPMZ4wDmyNyNH3b47TcCerPxf6DJxTKnSI
         cCf31dennWZpdq7TpZ4kFvq6ihNTAxK1ywg/j09qU1bT9IxuoBdU1yvw+vgn4ZlPgFxp
         fAbTgvOfBnJaDMux3FHJctqaZsnKkwIMIepTCW4nz5fYBRQt7GInYbA5GC6mPrYV9w5w
         EFLA==
X-Forwarded-Encrypted: i=1; AJvYcCVVVRCBay2m2a4fBc9EIDlZVQhEC+CpgXKRXPViEUXI6w5yHPkO/jRUBjDJUANW9uPLj/COoyYtuXu6Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFs0yjcSgmx5ecFC0mkMiallmcB9oDZ/V0Dv/pwMABnRCcOSI
	j/aVWYK2ONzMIg/dfcy/JYkENq+DerXapC29/xk0te+cAV5gu79xycWI
X-Gm-Gg: ASbGnct5sHnaBLrkSMcp5wwHURoDJ4LTkO/Hf6PzjX+iCv8Pgx0u97plWmp2dpHZ3Ts
	mwzEjv1wvMcARhlhs080vd/a8FU5wyAgY1KCHeXQmC/D6uxiVE503t1QXDLm6U+3lnM2tXTrJcI
	Vv01PKvwBHFALVQq0XyUucKvBIW47ldBYcF6LDfMS85A/KsWMHsj/w95a/V9eaW2nVVNvTIOkx2
	3F8ZHDIThGs37bIFBKy07RrIX+/Hh/P4DNxc/mshnCfWcT1AA06l1semSYbeyqozlHIBwvbY9Yz
	uVmCXZDF32/lXqiZ/OrRmsaBAKqdd2Z0TuerCHm4lCthP5cMKtcZIFbDcmFk4JyKY4LYuSfOTZl
	3TNgERGVCdRagCn1VFGPlfUUlUs61jkx6FDmANqx5fwJO245rGGYK4LNcfPWPzdza6gDZVcfrpg
	LMEUjNfBgv5y2HIihW8dXgJPA6ZQxF9Q==
X-Google-Smtp-Source: AGHT+IF95I/GWMOy7K0yQH9P573Gh61Ga6VWxZPEu4GIRjFsPKAyfm6hJudD/c1aH+Spd7nOuM10XA==
X-Received: by 2002:a05:690c:f8f:b0:731:76db:a5e0 with SMTP id 00721157ae682-77f946a89e6mr163041287b3.25.1759758593563;
        Mon, 06 Oct 2025 06:49:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:6165:1c10:83e:4131:1b09:7d81? ([2600:1700:6165:1c10:83e:4131:1b09:7d81])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77fa19a7d6asm27562527b3.55.2025.10.06.06.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:49:53 -0700 (PDT)
Message-ID: <51030f00-48c6-49b6-a4be-0b4e238f71bd@gmail.com>
Date: Mon, 6 Oct 2025 09:49:48 -0400
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: sukrut heroorkar <hsukrut3@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Helge Deller <deller@gmx.de>,
 Bernie Thompson <bernie@plugable.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
 <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 02:35, sukrut heroorkar wrote:
>>> kernel test robot noticed the following build errors:
>>>
>> Did you compile and test this code before submitting this patch?
>>
>>
> Yes, I had compiled & loaded the udlfb module with no errors. Please
> let me know how to proceed
> in this case.

Hey Sukrut,

When you make code that deletes something from the kernel, you need to
make sure that all other code that references that code will still
function properly.

When you surround things in the #ifdev, depending on the config file,
the compiler strips those things out and compiles without them. That
means that you actually need to compile and test under two conditions.
Once when CONFIG_FB_DEVICE=y and another time when CONFIG_FB_DEVICE=n.

The test robot gave you a sample config file that you can use. Please
ensure that you have the proper version of Clang on your Host machine
for that particular config file, if you choose to use it.

Also, I strongly recommend that you run the code on a sufficient
hardware or emulator after you test it so that you can verify that the
code does what you think it does.

Thanks,
David Hunter



