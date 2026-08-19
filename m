Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57B26A08A
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103363; cv=none; b=K0n7VU7ovMGMZiHAdhpM655m5w1bgCANwNqP+IA4DF/lro9SCA6QePtNWYHLvhEmwd0MRTVlfFj07x60zpJ64cTHILpxYc3dU64rRqb8zlvGHj22gS+hsogdXV1/wHvpXuuyRnWNufFMReloLQuLAU0r5EJcgmuBg4iVT7MQ0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103363; c=relaxed/simple;
	bh=c4DgkPkL0O1RvnIC56+UnsEDbQXeHgXgajlT3dEacgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIY2hXTXQKyeRRgjn39me4EfKRAAjBhji+KxxkLq4ULKFOmaKovhRmY78oP6a8uV7szYph7CplO3icowBsiXuy3H+Z9FQQOI2jn/g5tCvFszAf2jrOmSuXkqv4SHTNGWGD4UZbYTloMVXTgPYjM23JHp+1gObR5ZMOtLHyM5s5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0pB2oht; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0pB2oht"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso6754745ad.0
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Aug 2026 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787103361; x=1787708161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owKCVUF/nyGQlzMiSHiL1o+6oXm0PiyeDQIC8x4f2D8=;
        b=E0pB2ohtfYc2UqPah4afWb1RL3xV7dFX1nmMqhne8VDjZYa8e9ikPhSyGKuEnMW3SE
         5tss4CEJzr423yG1zI4t13uAih1BnRUfrY7nqLeEMFKNfdK5Uhsu/4mJtieuNhCRM1tF
         yBIakn7fKJS47Irmd+WvPUj1esSQWrQVjO/SfLfsx2DjS43We4j9hG3QTIjIExlTKK9D
         C0Ts/l65vqyrp+UcW3bUbKEz+Qr/nxn6c6E9COupt2852yEuu7l2g7pQ8Vp0Fm2EsAr0
         +0189pFhCEvCW9U64sppCPpgkm6mebjmBrOmdBnPHW6Bi6/X7arpLV89AQMl3jQuRhpF
         dcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787103361; x=1787708161;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owKCVUF/nyGQlzMiSHiL1o+6oXm0PiyeDQIC8x4f2D8=;
        b=RyM9khG8ynX+dYp8Sk8wxQORzOeDK4RZwS/pZC66bAQB6o6M6le1jN7M8gGce/5F1G
         D3LkrYy8zFgcOM7uon9VXH9IkGOTZfwBWta8Go2QyqEZYMTqtQl0dKkgxO+W5GsJ4Ta9
         98aGBWtbP7o8+DYk7YkEW7qBFsIYFWERc+OCYn8Btq7mtv3ZzKENZS2fLmV7+YQcn28O
         IKgB3JUsmsGcFvc9SztQjPIv92UmfXn68OsY3z01tg6cXJ3xPQmtAYBdIYuaKZ4iYMlY
         OKxm8Csr8JGqbRMmyXLbWUncucqs/ipf8pbLmcQMwsBzCnDjjZd0OoGLBlkdEvfesZFf
         Cc9A==
X-Forwarded-Encrypted: i=1; AHgh+RrU+IiVbi6ntpXBWfJ+vu0d0CdOa5nbCs73GlpPkDmO8PhI7BKNFTXSvkxGo8kPj75G2UWZG0XOs/kCDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDOYPEfa6br20BtZS2n0w3INoRjEJ8DGRJ2s5h31P/I5u0g31
	CIyHQkyu94XxwuhHCapLbRuZ56FlBj0+YXj5nNILtQi+PkB+/sGpXn2q
X-Gm-Gg: AR+sD12vxhcea1Ez6hHVd/6HRkEbnMMC9f4TErVJmGnSSQakUKlEIzqeQYGKSdzNGKF
	6Yb5aU46fr7jVE10bBz8NnhoRRWdp4Tjs9wVVP32e8EmntUuRNvGwZ4bNWQ+NjoOVNP+Rup1Tmn
	m+xLhy+y6gRdt0sgpyZCcLVUdbwrmvFB7mdfMSJ6rLpkKHaVg6v3XytMcA0uEQwlwaVqg/Ae9a8
	qtGBc33uXdNPbajUNkIfUWqRQSvS/QZjvBMWxv1kSCUcBQ9qtH/jlfRiW9SsTBmCgvfZMb7Ra57
	X3K0X8LhzOgroz+SHRS5AL9Z62GafTGVZTaHNONwv9jZJObBkcAYLu7AGDbfs79abO27NTpdpA8
	LuTj8eo4wfgeewfTbeqKPDDEXOWPPmGGC/b8YUENGtUx7yp8q57ZLBdeune6ALW1DU5GoavRvsg
	deqb6/f7SYUZ3rVvjBsGNoPcRBMF7cQohkl41bfns4YdE6XuaGACtkkAX0iB93ux2Cod6W6qW3n
	ISnQ116HtEsoItHh3cpKsUxy9xZjndc0alHztslMnfkxHv01wMokcA7eBVtzYm66ytXPQ8p9MRE
	S9R6Jic=
X-Received: by 2002:a17:902:f687:b0:2d3:2e86:647a with SMTP id d9443c01a7336-2d5fd6b24camr18144275ad.5.1787103361348;
        Tue, 18 Aug 2026 18:36:01 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b984:9fe3:5dce:f291? ([2001:df0:0:200c:b984:9fe3:5dce:f291])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef77fc0sm1727889eec.8.2026.08.18.18.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 18:36:00 -0700 (PDT)
Message-ID: <6b9e3cc6-8534-4dde-b2cc-505f1576a7f2@gmail.com>
Date: Wed, 19 Aug 2026 13:35:54 +1200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fbdev: Give atafb proper parent
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org, Helge Deller <deller@gmx.de>
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260816073752.16656-1-schmitzmic@gmail.com>
 <20260816073752.16656-3-schmitzmic@gmail.com>
 <a486820d-8500-41b1-bc32-a23d908c9f86@suse.de>
 <5a2d0139-84db-cab8-c7fb-7806a71c53b2@gmail.com>
 <3347106a-f0f9-415a-94e4-94bc9b8182ef@suse.de>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <3347106a-f0f9-415a-94e4-94bc9b8182ef@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 17/08/26 19:57, Thomas Zimmermann wrote:
>
>>
>>> If so, could you also replace the hard coded fb_info with a call to
>>> framebuffer_alloc()?
>>
>> Can't see how that would work - fb_info isn't passed to all functions 
>> that need to use it, especially in the hardware detection phase 
>> (hence the use of a static fb_info struct)?
>
> You'd have to modify the driver to pass the allocated instance, of 
> course. It's not a trivial oneliner, but if this driver is still 
> relevant, it might be worth improving it.

Wasn't all that hard after all - do you want that patch on top of the 
current series or replacing Miro's patch 2, Helge?

Cheers,

     Michael


>
> Best regards
> Thomas
>
>>
>> Cheers,
>>
>>     Michael
>>
>>>>
>>>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>>>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>>> Cc: <linux-fbdev@vger.kernel.org>
>>>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>>>> ---
>>>>   drivers/video/fbdev/atafb.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>>>> index b8ed1c537293..3d540803dc2b 100644
>>>> --- a/drivers/video/fbdev/atafb.c
>>>> +++ b/drivers/video/fbdev/atafb.c
>>>> @@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct
>>>> platform_device *pdev)
>>>>   #endif /* ATAFB_EXT */
>>>>     //    strcpy(fb_info.mode->name, "Atari Builtin ");
>>>> +    /* Parent the fb device properly: without this fb0 registers as a
>>>> +     * virtual sysfs device with no /sys/class/graphics/fb0/device 
>>>> link,
>>>> +     * which makes Xorg's fbdevhw reject it ("No devices detected").
>>>> +     */
>>>> +    fb_info.device = &pdev->dev;
>>>
>>> Because this is supposed to happen in framebuffer_alloc() and 
>>> keeping it
>>> there would be preferable.
>>>
>>> Best regards
>>> Thomas
>>>
>>>>       fb_info.fbops = &atafb_ops;
>>>>       // try to set default (detected; requested) var
>>>>       do_fb_set_var(&atafb_predefined[default_par - 1], 1);
>>>
>>
>
