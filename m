Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F1C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Feb 2022 11:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiBALbt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Feb 2022 06:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbiBALbs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 1 Feb 2022 06:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643715108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGRcgirIP4zYqgSlhOvvY2QNMhMYpFLin8cREeYj74w=;
        b=d2B9ItjQsMP7Kln2iapAxILEP/4/XmqojpX/mIKKlfxPz1drqkLv+wfMXz6L4OlhAYsKki
        uBrQdoVWCC1gp0baKxMmrqe7kPT3s/nsGUtNNkhUE2D03EoRW6J03KAVMgMIizGEfeYMAv
        knaHGD3cs/lTxy6BSiFXHJ13oXElDic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-o67f0tgSPfu7K6QWZuUVZw-1; Tue, 01 Feb 2022 06:31:47 -0500
X-MC-Unique: o67f0tgSPfu7K6QWZuUVZw-1
Received: by mail-wm1-f69.google.com with SMTP id o194-20020a1ca5cb000000b00350b177fb22so1430325wme.3
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Feb 2022 03:31:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XGRcgirIP4zYqgSlhOvvY2QNMhMYpFLin8cREeYj74w=;
        b=uhjp+uMgSbEbzGfJ+CuMMDNRULsMms1jpKPLV0v6slss+v2ftGOyprYHvEVlfTggdQ
         3l1GJr5YiYo86+O2VL/C33J/L5D31Lplk6arginGfm0XgfiISCFXv8Xfsc9IusLdvLHs
         pLydHx5jmBrOZNwJEWrGUzF9bd25ONGLpJQtx2LclGgHCE7lJjcE2Gy/i1OEypexxSKa
         1Ye8jxyu2vJlaMvBCwFzM0Zniw7tyi2RFYhB6IdIx/dpqk4+8Np0jDRhwyR7vfG0kR16
         Amw49+SGf1dcFNogiv/cQiARO/ShqpXoKT8lY+wfVwOXpo6efWOpwvV5nknCN59ui7ja
         to8g==
X-Gm-Message-State: AOAM530ZeFZ4Jh+0cpp5mfj6+2xr+7qyj45PCJHGsqNThWIzvdDFTmIt
        2cQS7xZ3thuPJ6/O8J9wdZdykYyjOMJdcyF9v/P3tA5UBWiX6aJhHOPWMj9TnmuuYMch7V7lMbH
        9JN5ycOGK0051ho8VngspnwQ=
X-Received: by 2002:a05:600c:4618:: with SMTP id m24mr1382125wmo.16.1643715106074;
        Tue, 01 Feb 2022 03:31:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9dtgfmrio2wkiWGZX/AXacBC0IvydqtGX9/B6UswdRdmI3taa4PHdBSJzQZpcsZ/B5jNs5A==
X-Received: by 2002:a05:600c:4618:: with SMTP id m24mr1382099wmo.16.1643715105832;
        Tue, 01 Feb 2022 03:31:45 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13sm1866913wms.8.2022.02.01.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 03:31:45 -0800 (PST)
Message-ID: <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
Date:   Tue, 1 Feb 2022 12:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org> <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/1/22 10:37, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 09:56:23PM +0100, Sam Ravnborg wrote:
>> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
>>> (which would be more accurate) to avoid confusion for users who want to
>>> migrate from the existing ssd1307fb fbdev driver.
>> Looking forward the name ssd130x would make more sense. There is only so
>> many existing users and a potential of much more new users.
>> So in my color of the world the naming that benefits the most users
>> wins.
> 
> It depends if the binding is going to be preserved. Also this series doesn't
> answer to the question what to do with the old driver.
>

I don't plan to remove the old driver (yet). My goal here is to have an answer
for Fedora users that might complain that we disabled all the fbdev drivers.

So I wanted to understand the effort involved in porting a fbdev driver to DRM.

> If you leave it, I would expect the backward compatibility, otherwise the
> series misses removal of the old driver.
> 

I don't see how those two are correlated. You just need different compatible
strings to match the new and old drivers. That what was usually done for DRM
drivers that were ported. To give an example, the "omapfb" vs "omapdrm".

Since the current binding has a compatible "ssd1305fb-i2c", we could make the
new one "ssd1305drm-i2c" or better, just "ssd1305-i2c".

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

