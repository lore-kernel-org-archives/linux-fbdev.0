Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC963396E0
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Jan 2026 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532360; cv=none; b=ChEhsoaPoGm7rar2EFtWxv5TkWybvkR27MjkXI8dbO1RJxYKs3WPG+MVZzPHcAvIbVTiWf+mrMop1GItFk8h1Hd73BmDBShQE00mjDAV5+JjhoqxFncBRGAwy4NxNfde3wOL27dH3z5FszwA/K74SHYMzX3imlItM9Uy4FrA4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532360; c=relaxed/simple;
	bh=4vXjT4pufQZ8GEEfVkUbEIsUSFVQkYmCOXpSadZmlbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNFH+aM+oaoQhUhnOPhXG9MAESr8ksV/UoXNcSdVvFLKQFW87VbN8uTUXaFPy3ZvcL7kinV8tmC5/ix9BLZVXszBBNSZTu2RH2OcQZcjXabufQ+XAX9n2cILlWhZQNdNal8cVzuRilVft3dmLF8TpLEueGk3tfOyaqGqLlZuyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEHcGjpQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEHcGjpQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0fe77d141so11614575ad.1
        for <linux-fbdev@vger.kernel.org>; Thu, 15 Jan 2026 18:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768532358; x=1769137158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBXP1VuxQoMfLKXTRMl7z4tgIk8pmLomI71jMyiZNEM=;
        b=QEHcGjpQ33dKJ+Rp6xOdm9L6/UiYsLmaI2nC2vlel7Zu6aL0DtxEuhSY+deZ+rzIZT
         flbu1T2L4hHLzhwDFulhsByauozha7gU0OfZjKnCZofdi1/a75E7qzN/vncAlXLnaOrq
         vbVY/3q3Alj+WbTOuQz64SuC6dDZKTrpvv/FSxo1P0JcYVjiXKAIjSxrIFvGnBHs+s4k
         InrkIqhNj6r3BKLl28mEE4PVYCpzt7JxhvD/6UEyZXJgVdUwhVUlSqHR1GShpEVNFGd0
         foM4c9PgmOVSr0RrIjvqZhX+U6yt5r4d1fD6aJlieGN1zl2aacIt1qIHb6RFhYquQfLP
         /izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768532358; x=1769137158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBXP1VuxQoMfLKXTRMl7z4tgIk8pmLomI71jMyiZNEM=;
        b=uBJM8Ehhk863BddJDlt2msPFwA4oJ8BtHsVmrLjIjPc5YnFyzmPlG4c4mrmDktlsUZ
         zgxF9j/qFbYhmmoVI/zd1iQMhmq96QZIXQqowehZhy1s1r1pteaFT6PRnByzatPGuiZa
         56ch0CZTtiRPPrbXiGPq8f7g1QiFPyMTMbtdW29a/qiHZqs6Zin5DoQN8GHLFr/QPDvq
         kIxlJ8aqMzowadJnq2HL4BuyyYPMDmPn1LpuYBncyBYriKksAlivl9/liaRYfyp3+/Zp
         VZ5MDFPEBn5iSqG+g0nR5PTLOc0L7ulmwrm2tPAfIG0fc0CguPbK42BppHzb5VSWAkxn
         0gzA==
X-Forwarded-Encrypted: i=1; AJvYcCWk2RdVlk073HBPhwJMvK93NT5af2O7xFQq7GDCoAEpYZ36DNEiU7L6+Tm+xojdmnN3s0ezDO+6ydPRRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRSsI8QXCGHo4KoK17PH5HGzPUH6hNYMWT9fjH234EnCo2TwL
	eoIyVL03P5rU41GK6x8pHcxnY0ssylBUm85AJl9dKfw6GfAdSEk3P5fC
X-Gm-Gg: AY/fxX54JMd4Ui5e5nFjwCatLjwPLKsExRm/FIF3G3apT9Qy1l0ziTFPc2kJEecNmzJ
	h4E3/Ms+2iAI/AwXvFdpaqJnKX4kr8wWCs3dysDwV57zeh5mYlB+hbE0oKFf3d/PKWKsrpcXWfi
	X3d7omosVrTPiSnLJbnSISJg82OM9oNW4sLxtydj/yp2scs6IrDOl4xvkP1wcA5TH1sdIkpn7FD
	hnMTddyd9zqwuO2EzlDwJZZ7b1qIb+OnK1grLdMXBNv3y0I8pZYzSKGdAscKGNgzkhPBvsIa+Ub
	skdyhn/ONGz9kseSGuvKhUpI9eHpO7hyNp4GpVOk3qbxJ8xeSFecPIs0+h6sOUsyRg0C0kke/Ow
	vHWvXUmTKAc2+5DHEXXdqfiFErqCQETvI6jd/l6btfmxqMlLo15lFOkQj60ipGiNackPUUn2hUU
	qaXu5KF8/6aFiRRMObDKeC1vKp9V4vyqGHTsBo1mhnfM4jOuPKfBAfEZWwalhD
X-Received: by 2002:a17:902:d503:b0:267:a5df:9b07 with SMTP id d9443c01a7336-2a7175189a1mr15351925ad.12.1768532358494;
        Thu, 15 Jan 2026 18:59:18 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:2698:b2e5:53ba:f374? ([2601:1c0:5780:9200:2698:b2e5:53ba:f374])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fc8d9sm5947415ad.79.2026.01.15.18.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 18:59:18 -0800 (PST)
Message-ID: <c7e6fe1c-ff46-4541-ab6c-6dd776924f95@gmail.com>
Date: Thu, 15 Jan 2026 18:59:16 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] staging: fbtft: Use fbdev logging helpers when
 FB_DEVICE is disabled
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 andy@kernel.org, deller@gmx.de, gregkh@linuxfoundation.org,
 kernel test robot <lkp@intel.com>
References: <20260113045909.336931-1-chintanlike@gmail.com>
 <1b83803a-b51f-4cc0-a836-b4417bfd6537@suse.de>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <1b83803a-b51f-4cc0-a836-b4417bfd6537@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/14/26 23:55, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.01.26 um 05:59 schrieb Chintan Patel:
>> Replace direct accesses to info->dev with fb_dbg() and fb_info()
>> helpers to avoid build failures when CONFIG_FB_DEVICE=n.
>>
>> Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency 
>> optional")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN- 
>> lkp@intel.com
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>>
>> Changes in v6:
>> - Switch debug/info logging to fb_dbg() and fb_info()(suggested by 
>> Thomas Zimmermann)
>> - Drop dev_of_fbinfo() usage in favor of framebuffer helpers that 
>> implicitly
>>    handle the debug/info context.
>> - Drop __func__ usage per review feedback(suggested by greg k-h)
>> - Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE 
>> dependency optional")
>>    (suggested by Andy Shevchenko)
>>
>> Changes in v5:
>> - Initial attempt to replace info->dev accesses using
>>    dev_of_fbinfo() helper
>> ---
>>   drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/ 
>> fbtft/fbtft-core.c
>> index 8a5ccc8ae0a1..1b3b62950205 100644
>> --- a/drivers/staging/fbtft/fbtft-core.c
>> +++ b/drivers/staging/fbtft/fbtft-core.c
>> @@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, 
>> unsigned int red,
>>       unsigned int val;
>>       int ret = 1;
>> -    dev_dbg(info->dev,
>> -        "%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
>> -        __func__, regno, red, green, blue, transp);
>> +    fb_dbg(info,
>> +           "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
>> +           regno, red, green, blue, transp);
>>       switch (info->fix.visual) {
>>       case FB_VISUAL_TRUECOLOR:
>> @@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct 
>> fb_info *info)
>>       struct fbtft_par *par = info->par;
>>       int ret = -EINVAL;
>> -    dev_dbg(info->dev, "%s(blank=%d)\n",
>> -        __func__, blank);
>> +    fb_dbg(info, "blank=%d\n", blank);
>>       if (!par->fbtftops.blank)
>>           return ret;
>> @@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info 
>> *fb_info)
>>       if (spi)
>>           sprintf(text2, ", spi%d.%d at %d MHz", spi->controller- 
>> >bus_num,
>>               spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
>> -    dev_info(fb_info->dev,
>> -         "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>> -         fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
>> -         fb_info->fix.smem_len >> 10, text1,
>> -         HZ / fb_info->fbdefio->delay, text2);
>> +    fb_info(fb_info,
>> +        "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>> +        fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
>> +        fb_info->fix.smem_len >> 10, text1,
>> +        HZ / fb_info->fbdefio->delay, text2);
> 
> As discussed before, this should become fb_dbg().  Drivers should not 
> print status reports unless they do not work as expected.

Agree - I will send 2 patches(series) as per feedback 1) a patch focused 
purely on fixing the compilation issue by avoiding info->dev 
dereferences (using fb_dbg() where logging remains), and
2) a follow-up cleanup that downgrades the framebuffer
     registration message to debug level.

> Best regards
> Thomas
> 
>>       /* Turn on backlight if available */
>>       if (fb_info->bl_dev) {
> 

