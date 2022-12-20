Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249DC10F1E
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiLTJZt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiLTJZs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DD4BE9
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671528303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMFhZOuihLodO313fEA5R64i9CUhN9/n0ds4HavllAs=;
        b=gngBIQ7zUBhzzIIqKucjHvclR7o4PWQ3/726DmDRWDGZOM6mk2/YSoILD8ocMM7imtg8G6
        2CnBMyzNXJZHANGz9VzfIyhL8lgXQvWOtZiVLVz9KNl4SCR7WHloqevFWouugcH7bP5CSG
        W/In6c1pl2Eg44MnVu7mZjRSpxeojgQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-sUpwUkLePNO9K3zhkAn5aw-1; Tue, 20 Dec 2022 04:25:01 -0500
X-MC-Unique: sUpwUkLePNO9K3zhkAn5aw-1
Received: by mail-wr1-f69.google.com with SMTP id i13-20020adfa50d000000b0025f5084b95dso1149147wrb.5
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:25:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMFhZOuihLodO313fEA5R64i9CUhN9/n0ds4HavllAs=;
        b=h0+30DPoeWeVfvRXjVnv7cPqMjSSZsAYQq1tviSx9rbJPHzsbvzsoAfuuzdoFyUsin
         bjJQgKzyxlKnqmWBWFr02TWDVcFxp8VnQSKvzFdrpCZ9jAN9hpGY6WkAw9LeTsdsxp2Q
         u42Fs1ScUQNr0YI5ytdb4UMYjmAWbcTHDKclVqvS34WvIWnFm4jiGG4Ubun5ZM6i2CJy
         43EEBKIoxm5MuOYuW0St9L/HJFsJxcxbmhvYMHSGF+sTU7yNl5wwURS/X+A/9U+kRtVU
         HIVn1gXgjJGgi50Hu9X4U9N3iyDCwE4B7/77SdYrQYUU503x4s4KosppibCtw69g3x3P
         e86w==
X-Gm-Message-State: ANoB5pngOARAqeBr67ftS7B+FFFhvnASbdXSxPWPB19htbsqkPL8NaPd
        fv1ozEWtfAUWEeresRGl0oEsaGPFi/g4TCgJ7ZyR74zTt204YoJuIzKDjB+xGOg6ZainAXbXLkg
        iiJq2aTNJ3D/0WvTmqHvNXdc=
X-Received: by 2002:a05:600c:1d27:b0:3d2:27ba:dde0 with SMTP id l39-20020a05600c1d2700b003d227badde0mr25905734wms.33.1671528300460;
        Tue, 20 Dec 2022 01:25:00 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6s+ju9wPrh/cxmy7d4OakLICIinEdQttdoLSS+PoembSG//ZlaMVN/BK9U8/HRYjVObQWlOA==
X-Received: by 2002:a05:600c:1d27:b0:3d2:27ba:dde0 with SMTP id l39-20020a05600c1d2700b003d227badde0mr25905720wms.33.1671528300274;
        Tue, 20 Dec 2022 01:25:00 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003d220ef3232sm14440188wmp.34.2022.12.20.01.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:24:59 -0800 (PST)
Message-ID: <cc578fa7-31f0-8cfa-4cdd-981d7303412e@redhat.com>
Date:   Tue, 20 Dec 2022 10:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 08/18] fbdev/hyperv-fb: Do not set struct
 fb_info.apertures
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-9-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> Generic fbdev drivers use the apertures field in struct fb_info to
> control ownership of the framebuffer memory and graphics device. Do
> not set the values in hyperv-fb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

