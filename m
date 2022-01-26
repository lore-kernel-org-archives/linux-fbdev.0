Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4209EC28CF5
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 13:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiAZNoR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240994AbiAZNoR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 08:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643204656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HO8OojRGDxiniZjv6SrW57XV+ZtoIr3bX0tnTNyRlq8=;
        b=RDkWD/Tk08hyfSBlCF3GFQp4ub3SduL52vmneWASFiJ7gGqLIux25sbbyXn32kJBxFKfrZ
        RPpPiWkAF84KNz5ow90pu7Fb0MYceHyU9ql8DoVo290OJuRmZu/vaHm2Bs8fp+uAck0X3t
        fGpP1NwdzvtVVH/AoFwr3DV6HhY2fUo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-igoukvHyNGWRYE1FrpZLmg-1; Wed, 26 Jan 2022 08:44:15 -0500
X-MC-Unique: igoukvHyNGWRYE1FrpZLmg-1
Received: by mail-wr1-f71.google.com with SMTP id t13-20020adfa2cd000000b001d09443ee4fso4324702wra.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 05:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HO8OojRGDxiniZjv6SrW57XV+ZtoIr3bX0tnTNyRlq8=;
        b=UcEf9hlGcWYiTz+Tl5030OcOmATNlWXyBttfGjhYucf+8VEUBp+m0JBc/k38pzSyZy
         /mk3KYOAJSKOSduPxF+7/72YV1zxdtyFa5ImDN+C2OAjVNTfOEJZFBnDvE23W4Qwph9r
         mwXYv86vzL0S/DJv2nrCY9q57G2b/c99S/4dRn0IOED7umVp7zc0Dw8nGh6PkQAWivvj
         8f2CgoFRXu0+1Tzk2yIzx0IXxXpS+nsBzdhmqM6RtIrLI2vQAYsPuJchaz9XSrJIjWBK
         1p2pVs1lDjE7E5V0VkRCZAC0BCUn80lJIoDjdlqzYaChjwjp5pQPeuuuqfgCg6t3NKhk
         xENw==
X-Gm-Message-State: AOAM531zEb/OG0OtvfVbicXP51yi5yIWphMErq6N4uFf0QQp65x8E8y1
        P+D1ZIXxS2Jc5ZHGWoIkZpN/8yS0fJ7pKVQ+CcVSwIzPLd3HPM6PyEQMgAyXXZd6SG43cE5agNJ
        iWqlrKCWlQyarflMi3Oa7HQI=
X-Received: by 2002:a5d:588d:: with SMTP id n13mr553777wrf.690.1643204654460;
        Wed, 26 Jan 2022 05:44:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybzQqjbMputeacc2RjhaPfXtnrHwBB3Q4bMgXV2bO3BAQz7ZnwzmTspSR3f1GLZrNkoUbXJg==
X-Received: by 2002:a5d:588d:: with SMTP id n13mr553763wrf.690.1643204654263;
        Wed, 26 Jan 2022 05:44:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 11sm902476wrb.30.2022.01.26.05.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:44:13 -0800 (PST)
Message-ID: <9b426301-bf41-0312-c34e-856938b196fd@redhat.com>
Date:   Wed, 26 Jan 2022 14:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <CAHp75Vd7oaYPKx6bxjCqNnm6fieeQFrtq5K4YYrxYbXoXFy=+Q@mail.gmail.com>
 <20220126102858.GX1951@kadam>
 <1b665bb8-7acb-519b-0a02-ef0f2dd4b524@redhat.com>
 <YfFE61IQus3SMQRZ@kroah.com> <YfFKLfSKUdo1UVfF@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFKLfSKUdo1UVfF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/26/22 14:18, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 01:56:11PM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Jan 26, 2022 at 01:37:00PM +0100, Javier Martinez Canillas wrote:
>>> On 1/26/22 11:28, Dan Carpenter wrote:
> 
> ...
> 
>>>    fb_hx8347d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>>>    fb_hx8357d.c (DRM driver in drivers/gpu/drm/tiny/hx8357d.c)
>>>    fb_ili9163.c (DRM driver in drivers/gpu/drm/tiny/ili9163.c)
>>>    fb_ili9341.c (DRM driver in drivers/gpu/drm/tiny/mi0283qt.c ?)
>>>    fb_ili9486.c (DRM driver in drivers/gpu/drm/tiny/ili9486.c)
>>>    fb_st7735r.c (DRM driver in drivers/gpu/drm/tiny/st7735r.c)
>>>    fb_st7789v.c (DRM driver in drivers/gpu/drm/panel/panel-sitronix-st7789v.c)
>>
>> I'll gladly take a patch that deletes the fb_* files that are already
>> handled by a DRM driver like you list here.
> 
> None of the DRM driver supports parallel interface for these devices.
> 

Thanks for the info. Then we can't remove any of these drivers indeed.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

