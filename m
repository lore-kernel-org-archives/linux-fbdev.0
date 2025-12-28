Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6B5464D
	for <linux-fbdev@vger.kernel.org>; Sun, 28 Dec 2025 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766892966; cv=none; b=P1LHxMcvIber1R5onvFx/9K2MiP6jeV+u98bWlxZ3zsmAXmtDbBXhoZ1HJiGmxcc+OR3hr5j7txXDakMamS3oTXEbzhMcsLhzRwCA8awocRCmBBDB3MhpQ8vR2MG7qsdnwtnbvmWuca7fIwKrSWqeUs05zT43bTXAEstmf850vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766892966; c=relaxed/simple;
	bh=7y9+JG1YQScaKpsvlkoSJnucnQXf3X7/A1e5+m7XKHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uelQz2dNY6bjm8qq+XCTpCiET2mibkqEEqi4mhLr1M8szgv6NPRh/hDqlmNTUNQlY6GVROPp0QCvso93pwLtdHop5gvlP7p87vdk+cqerFjekFYgV/KY0grSAKLFGHa4XPQKfebOF3SdP/BGsQd8A+KvyO2pyE2gq73YwLzdIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxtdmndS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxtdmndS"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so9159898b3a.1
        for <linux-fbdev@vger.kernel.org>; Sat, 27 Dec 2025 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766892964; x=1767497764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GYMWvgynMfX2fSBNVCofj8NHTkRdY3lznnd4Y2OMfk=;
        b=HxtdmndS1Noqr2WeL7zWCJ/WqexmSiZ+Mgm/vU8W/AYYcdCEHhhLnn7rBoVPgCIgBq
         S8wf2TgjHslZZuq5rKD24OpxbYa5wEeS/nUgl3Rg2eUTUISkTDKicrB2oNI4Gguz2Nqr
         e/a1CiS7NV02dyvz+ALCFSy75+mYulsNB4XMDVjqq5q+KfbmOKF4cqLjXjQMZUUMGQ42
         eF0faNdCeYsIHNwhW7IoHU+zHPn6r3+hc7x/5aSZS8LhEQkNHWQCY/gg/xb24ljuGshY
         FyzSSrf6B43PgvRcBE4GZ2JimG98QpQvzl/ATly1TWt8dkku20TxyqHdKSdlcU+1qYTJ
         2eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766892964; x=1767497764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GYMWvgynMfX2fSBNVCofj8NHTkRdY3lznnd4Y2OMfk=;
        b=Gn45+yNHiz44GXxz3/IJuPM6kcUP5xodK9IreXusjTzwVsPxKaxsXJy8HTYMdRLrfa
         EOp8Ww1tfBziD8xx94jGSFesAIX8zM9f8FYfKMI0bm7kW6iABhL8zEu6cVpn37ETuHlX
         X+/4UZi9TVV5EFQ4tAcOGvw+sU3g7EY+rGXkX98RYH6gZjADtkrsJ+HCW+TxI3VaGST1
         V0hRGR9JEYQKUS9lJLmMHi63dpbulEaBoimeffC1TTJBEm3ufr14393GndcOdG7JPvyk
         OL9iTo8jPBUM2daEgHiK822aXlpTDBK4IYvV1nQTpP0pNT02tu0/TnA8eVgtPSCM1zXZ
         X07Q==
X-Gm-Message-State: AOJu0YwYAh2Zmass8Wuv8tByIokzE2rbGRc5UqXKwj5hmopYu5DorC+t
	MkSbLyU4AU7CbTAEU+nf7mggMWjKr7Hz+eTcLkJG9KZP29Zsw+Ids28K
X-Gm-Gg: AY/fxX7NupUrGq8+KClhadHZKqL0RWwvCmG4BTZHRP7wgsFP/QqMC1rIq7YEhwUYFyh
	2OIiWlRNvXl7lUNzcGRJDl78Rhme5uOVZPEsjqeKLD/iGRZ1loYkUY/8R3OS+fo4zC0t5OTqn0o
	h+D9JyLj3Lcj2bbZXSBc59kzqkkHpoCb9fKMQv+2hdBPpurJxp6yP9WpFlCoYE/jDq6AgYhYJR6
	fWJ7ZihX/PCMv4abouPvZVNKrB5VnTEorLatl4cigT3LugCtTIRdagq9L/nOgz9EZHGrWDnDERx
	6aLcaH9gmHvL6y1auKlsvpBidz0WBK5rYhK1ws02G0HbXSRWccKxZzbu7Hh/I5dEqhYE94KVsR3
	UFHXlCT3qIbG+BD5KRZC+z01MgSmbKMWEQUD4RjZWEft9FYw3c694HAZB12tVUNaC04cfrdzUvM
	4YjQaRRHMCFxTRkkdU0SmZnbpaX326a2WoceJQIe6zDvZa353QA2GPRvLObXI8BvXGk7xlaWo=
X-Google-Smtp-Source: AGHT+IHTWL3q8c+FeXaSOBHPaw/cADChxlI8DiI1o2Cg5IPCvZurA0tG1OaDi1zTnHTBCrTFoMuu6w==
X-Received: by 2002:a05:6a00:6caa:b0:7e8:450c:61c2 with SMTP id d2e1a72fcca58-7ff66679603mr21673397b3a.50.1766892964131;
        Sat, 27 Dec 2025 19:36:04 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:a91e:86e3:6d78:53d4? ([2601:1c0:5780:9200:a91e:86e3:6d78:53d4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e797aadsm25834180b3a.61.2025.12.27.19.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 19:36:03 -0800 (PST)
Message-ID: <ec86f093-8fe8-4fc8-b330-dc7ee8a01de9@gmail.com>
Date: Sat, 27 Dec 2025 19:36:03 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] staging: fbtft: Make FB_DEVICE dependency optional
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org,
 deller@gmx.de, gregkh@linuxfoundation.org
References: <20251219054320.447281-1-chintanlike@gmail.com>
 <20251219054320.447281-3-chintanlike@gmail.com>
 <CAHp75VeLF8nd-JiPFnxJ2H43ZS=oYgW4=BTZjR_GuUuj03gyRg@mail.gmail.com>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <CAHp75VeLF8nd-JiPFnxJ2H43ZS=oYgW4=BTZjR_GuUuj03gyRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

On 12/27/25 06:19, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 7:43 AM Chintan Patel <chintanlike@gmail.com> wrote:
>>
>> fbtft provides sysfs interfaces for debugging and gamma configuration,
>> but these are not required for the core driver.
>>
>> Drop the hard dependency on CONFIG_FB_DEVICE and make sysfs support
>> optional by using dev_of_fbinfo() at runtime. When FB_DEVICE is disabled,
>> sysfs operations are skipped while the code remains buildable and
>> type-checked.
> 
>> v2:
>> - Replace CONFIG_FB_DEVICE ifdefs with runtime checks
>> - Use dev_of_fbinfo() to guard sysfs creation and removal
> 
> The place for the change log is either a cover letter, or...
> 
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Suggested-by: Helge Deller <deller@gmx.de>
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>> ---
> 
> ...a comment block here. It's not so important to be in the Git
> history since we have a lore.kernel.org archive.

Thank you for suggestion! Will move to coverletter.

>>   drivers/staging/fbtft/Kconfig       |  5 ++++-
>>   drivers/staging/fbtft/fbtft-sysfs.c | 18 ++++++++++++++----
> 
> ...
> 
>>   void fbtft_sysfs_init(struct fbtft_par *par)
>>   {
>> -       device_create_file(par->info->dev, &debug_device_attr);
>> +       struct device *dev = dev_of_fbinfo(par->info);
>> +
>> +       if (!dev)
>> +               return;
> 
> 
> The better way is to decouple the definition and the assignment in the
> cases when it's followed by a conditional (validation check). In this
> case any new code added in between doesn't affect readability and
> maintenance efforts.
> 
>         struct device *dev;
> 
>         dev = dev_of_fbinfo(par->info);
>         if (!dev)
>                 return;
> 
>> +       device_create_file(dev, &debug_device_attr);
>>          if (par->gamma.curves && par->fbtftops.set_gamma)
>> -               device_create_file(par->info->dev, &gamma_device_attrs[0]);
>> +               device_create_file(dev, &gamma_device_attrs[0]);
>>   }
> 
> Ditto for the rest.

Will do v3 and re-send. Thanks for reviews!


