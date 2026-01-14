Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E372F6903
	for <linux-fbdev@vger.kernel.org>; Wed, 14 Jan 2026 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768366083; cv=none; b=LOpGxrOgsluuqwqspx7r+epjLyifHA88A2CkBPk58TLmYuTs5I302Vw3Ia55kIVqdIg+d9lZDD6UhjkkmVPUuvIeF/f1+Oo09oI6vSjmd7b9ciJXttP80r57mWLyligl6cXgBwqSm7EFUPLGCrJTNQC/nHwuAfozFFBeiIayoME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768366083; c=relaxed/simple;
	bh=oeTWw/wWzUGbKLctFX+tsmOs0yR7460JiMwJcdOjAy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVIuMaitIyUYmdK9R5ynpb7NjEuoKyn/rXJ2SjlmQm9kd/irVSPhg/jKuHY70gW8XrT2+pgnu/Ry4QSigWk/PCfjFALogqYXWJHWoC5vVlqbjxb0h+pKiWFV5Tuclci/K98jkPBUp05MOm0tmeaKivp0x9/qx4Ls00pOyRenvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luRCe0iz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luRCe0iz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a2ea96930cso53082165ad.2
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 20:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768366076; x=1768970876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NFwjquWWIMR4Koo5/Xpv9KWDdiEv/zD2N0krq4V/fs=;
        b=luRCe0iztetSvNRQlIfBi6Qs0hpTWxCtMA13NSieC4wIJhUa0HQW+rJMMhLdkD4AO0
         JJKWJMYsxigROULxc/wxoM5dH5XY5MOupjQRe2agTW19W0W21CxJ3QToQ1IOFEFm5TcV
         U/Vk9tAUrl3TRzhjJ8ZtqGzA4tbV6fiQg2nPHT4+ADUx8dWQOFw/RbLzYiQVp27vvdsG
         jwjovK15lNDOFWX35hAvoGmEgMygkooAHkG6G3adHYtxBDIQFHy3OOb9YWKXOT+7ZH8T
         MTLhiHNWYCvtocyy/JmZwzShiizJSrAi9wNsIHfrdeSg65zU7+z2Zh9p2RzIhwzgFDjy
         UE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768366076; x=1768970876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NFwjquWWIMR4Koo5/Xpv9KWDdiEv/zD2N0krq4V/fs=;
        b=pzGkxRzvhnwmPfjstnI1HRw3ck6s3AO8aLHqhs/5nWm1FIhI9O4nGmIk45bBXeJIsi
         8xmPxtQheKAC1hX3rPYpO3gcvCZvWVPlOvUDwmk3QS3C14mVa3V6NyGP9nyB+IdcGcLB
         N8fCCg1LwPSsNe8SqY/DkFAVUejaGPs7SsoTaQaoe3p8Yn6MGBxkjZIi7HP9gfjwx6vV
         dxlFJ9mS2S74IUBJz6Z1+DPdd4ryIGE+pxjKixH146LyH+zXRm+ysHU6Y1bRuldtrLSr
         oOsLe0BhxHisUoI8SvXQrKBmGGxqGh2x5m42NUjO8RU/GfE+21YfrO70aSn0EBKxMagH
         lnYA==
X-Gm-Message-State: AOJu0YxtA+Q4cvk/w7p7Hcqw5bniWb6EFElkuhCGO5Dc6R9W5qN/RA8y
	hgxLeQBsRS9cCDQPZkGF1dCL0IXOCb1vnfZnd7AX5xgDv3L6EoBJSvLL
X-Gm-Gg: AY/fxX43zTpKqyulonZke1CBLc/9EPiNWi5dcayxccgllWhGS9wpzuO7qNXlkJI5pf4
	iQN3eJl6LSRbuvvxRdhhkx+Tiz9UrPj1LJrdYfPqI9dBebjsU+ZBBOoXbv2G76oL46Oy4/bt0YH
	uOHsivO4Z5hPqOqgf+CLh6sJtp3MZtV4Bkup6L4tlzEoVNXmodaDMjcg+pfUOzmjQaIstL/k1KT
	qdpD66R8ow5jFQblnNctvO3GtYIz4H0evr8e37Bt59+roPGWCUR4IMY0Pk4b4WD3tFEJh4PngYg
	tRAgVVXImsDVfY6s0axKJuh2l4vD/4LIRr7Z8AeweQ+6Tlid0KEthJ/sPUXwPDiwnE8HJrgguc2
	Sa2RnLci1EhXMqLAu1tqAWvN1V/BmCN8syoE37I4zMyxCSPY92dEI+94Bl5suuHBZ4TriA4EYlq
	T3fhYRNL4z8OzxzzUwhqcY/4oSYNEGUF/g9x7c4TQAXFQaXZ5evNJq2wRtviXC
X-Received: by 2002:a17:903:11c3:b0:2a0:c884:7f03 with SMTP id d9443c01a7336-2a59bc12d90mr8348595ad.44.1768366075547;
        Tue, 13 Jan 2026 20:47:55 -0800 (PST)
Received: from ?IPV6:2601:1c0:5780:9200:2c53:988c:79cd:8451? ([2601:1c0:5780:9200:2c53:988c:79cd:8451])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48931sm211402105ad.29.2026.01.13.20.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 20:47:55 -0800 (PST)
Message-ID: <0a90bd0a-cb74-43a3-a50b-4c83bc086556@gmail.com>
Date: Tue, 13 Jan 2026 20:47:54 -0800
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] staging: fbtft: Use fbdev logging helpers when
 FB_DEVICE is disabled
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, andy@kernel.org,
 deller@gmx.de, kernel test robot <lkp@intel.com>
References: <20260113045909.336931-1-chintanlike@gmail.com>
 <2026011341-chomp-protegee-6be5@gregkh>
Content-Language: en-US
From: Chintan Patel <chintanlike@gmail.com>
In-Reply-To: <2026011341-chomp-protegee-6be5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/12/26 22:16, Greg KH wrote:
> On Mon, Jan 12, 2026 at 08:59:09PM -0800, Chintan Patel wrote:
>> Replace direct accesses to info->dev with fb_dbg() and fb_info()
>> helpers to avoid build failures when CONFIG_FB_DEVICE=n.
> 
> Why is there a fb_* specific logging helper?  dev_info() and dev_dbg()
> should be used instead.


You’re correct that dev_dbg()/dev_info() are the standard logging APIs.

The reason I switched to fb_dbg()/fb_info() is not stylistic: direct
dereferences of info->dev / fb_info->dev are invalid when
CONFIG_FB_DEVICE=n, which causes compile-time errors.

fb_dbg() and fb_info() are framebuffer-specific helpers that handle
this case correctly, allowing logging without touching info->dev.

> 
>> Fixes: a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
> 
> Is this really a bug?

The build failure occurs when CONFIG_FB_DEVICE=n, where direct
dereferences of info->dev / fb_info->dev are not valid. This was 
reported by the kernel test robot.

That said, I’m fine dropping the Fixes tag if you don’t consider this a
regression.

>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202601110740.Y9XK5HtN-lkp@intel.com
>> Signed-off-by: Chintan Patel <chintanlike@gmail.com>
>>
>> Changes in v6:
>> - Switch debug/info logging to fb_dbg() and fb_info()(suggested by Thomas Zimmermann)
>> - Drop dev_of_fbinfo() usage in favor of framebuffer helpers that implicitly
>>    handle the debug/info context.
>> - Drop __func__ usage per review feedback(suggested by greg k-h)
>> - Add Fixes tag for a06d03f9f238 ("staging: fbtft: Make FB_DEVICE dependency optional")
>>    (suggested by Andy Shevchenko)
>>
>> Changes in v5:
>> - Initial attempt to replace info->dev accesses using
>>    dev_of_fbinfo() helper
>> ---
> 
> The changelog stuff goes below the --- line.

Ack.

> 
>>   drivers/staging/fbtft/fbtft-core.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
>> index 8a5ccc8ae0a1..1b3b62950205 100644
>> --- a/drivers/staging/fbtft/fbtft-core.c
>> +++ b/drivers/staging/fbtft/fbtft-core.c
>> @@ -365,9 +365,9 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
>>   	unsigned int val;
>>   	int ret = 1;
>>   
>> -	dev_dbg(info->dev,
>> -		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
>> -		__func__, regno, red, green, blue, transp);
>> +	fb_dbg(info,
>> +	       "regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X\n",
>> +	       regno, red, green, blue, transp);
> 
> I dont understand what is wrong with the existing dev_dbg() line (with
> the exception that __func__ should not be in it.
> 
>>   
>>   	switch (info->fix.visual) {
>>   	case FB_VISUAL_TRUECOLOR:
>> @@ -391,8 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
>>   	struct fbtft_par *par = info->par;
>>   	int ret = -EINVAL;
>>   
>> -	dev_dbg(info->dev, "%s(blank=%d)\n",
>> -		__func__, blank);
>> +	fb_dbg(info, "blank=%d\n", blank);
> 
> Same here, what's wrong with dev_dbg()?
> 

Same reason: dereferencing info->dev is invalid when CONFIG_FB_DEVICE=n. 
fb_dbg() handles this correctly without needing info->dev.

>>   
>>   	if (!par->fbtftops.blank)
>>   		return ret;
>> @@ -793,11 +792,11 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
>>   	if (spi)
>>   		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
>>   			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
>> -	dev_info(fb_info->dev,
>> -		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>> -		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
>> -		 fb_info->fix.smem_len >> 10, text1,
>> -		 HZ / fb_info->fbdefio->delay, text2);
>> +	fb_info(fb_info,
>> +		"%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>> +		fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
>> +		fb_info->fix.smem_len >> 10, text1,
>> +		HZ / fb_info->fbdefio->delay, text2);
> 
> When drivers work properly, they are quiet.  Why is this needed at all
> except as a debug message?

Agreed. The informational message during framebuffer registration is not
necessary. I will either remove it entirely or convert it to a 
debug-only message.

I’ll rework the patch accordingly and resend.

Thanks again for the guidance.


