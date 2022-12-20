Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE590C4167B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Dec 2022 09:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiLTJSR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Dec 2022 04:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiLTJSP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Dec 2022 04:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB342B7C9
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671527847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8TwpXV0XnYsgvagPag9L7MpjXeefLJTkMJCGh9V7pg=;
        b=HUKxeEe/NQ/7x/sMkaAuGBSclBSx+N8Sk2siij16PkayDl/RrfDxowt0mcgQGXTuDGkaQL
        j3EIJzcO4QTMVomAbTALtfCIQBikU38/e90T25U043YmAwozoraOLHUofUAKjEko+GbWA+
        UvTSIplJwSrGoIExdDb+Co7xWCQFeW8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-JJhEsuaFOQ2RiOlKwj7YrQ-1; Tue, 20 Dec 2022 04:17:26 -0500
X-MC-Unique: JJhEsuaFOQ2RiOlKwj7YrQ-1
Received: by mail-wm1-f71.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so174664wmq.5
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Dec 2022 01:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8TwpXV0XnYsgvagPag9L7MpjXeefLJTkMJCGh9V7pg=;
        b=Nk1Cm28nVLLhraf/Wz+rob5N41b6akG2xnEqxgB7rP6c7LtLCkeo3LIVigg2ctlVGd
         1d89bqX2ZqnkrWefYGAnGArQjBYWQOoIgrvmUO9n+oyU6QUzbsEC6JbE/ao71FHUiA/V
         c8/RxZxtEHYM1xOQj8mW/yeS1jf+5AvVv+BjcdFHltftFIooAY27GS+igIrH0g3va2/M
         CTMdvdoBAL4KXjzeda4YSOcDeu8r+gkrr3RRjF7WBw6YRLj2d/ahIwSppNnwa0nUe4ML
         /JTj5wl9BqezGeiVMLHzFOBxEz/Di7dIUAC7aRbo7YmHui6f7vThLjX+s09SGEuSJCde
         bCeg==
X-Gm-Message-State: AFqh2krhKOGKdDouOFxZQyApBRv70qGiTwcukv03D8FGoL0mFbA3/TUz
        2oexIJqAVepQZWsTsvwB30V5Jb6MGK+4GJiJWXe8rudiP3tIg9LKYCqoAhdrvH14IeF6U5nJ5pJ
        mrglzoqvQDaR7tvT5QD/KfWA=
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id z12-20020a05600c220c00b003d23831e5c4mr995464wml.40.1671527845214;
        Tue, 20 Dec 2022 01:17:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuuo6HgeH5yLW955AXoTEHdpszfHBedFCr5hOSv462STXosZPN5E6XN8VtP9mnawtIRXA48sQ==
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id z12-20020a05600c220c00b003d23831e5c4mr995452wml.40.1671527845031;
        Tue, 20 Dec 2022 01:17:25 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003c71358a42dsm30460043wmq.18.2022.12.20.01.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:17:24 -0800 (PST)
Message-ID: <4bb928f8-ee2c-7b3c-9390-7efb53c23b80@redhat.com>
Date:   Tue, 20 Dec 2022 10:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/18] Revert "fbcon: don't lose the console font across
 generic->chip driver switch"
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@gmail.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-3-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 12/19/22 17:05, Thomas Zimmermann wrote:
> This reverts commit ae1287865f5361fa138d4d3b1b6277908b54eac9.
> 
> Always free the console font when deinitializing the framebuffer
> console. Subsequent framebuffer consoles will then use the default
> font. Rely on userspace to load any user-configured font for these
> consoles.
> 
> Commit ae1287865f53 ("fbcon: don't lose the console font across
> generic->chip driver switch") was introduced to work around losing
> the font during graphics-device handover. [1][2] It kept a dangling
> pointer with the font data between loading the two consoles, which is
> fairly adventurous hack. It also never covered cases when the other
> consoles, such as VGA text mode, where involved.
> 
> The problem has meanwhile been solved in userspace. Systemd comes
> with a udev rule that re-installs the configured font when a console
> comes up. [3] So the kernel workaround can be removed.
>
> This also removes one of the two special cases triggered by setting
> FBINFO_MISC_FIRMWARE in an fbdev driver.
> 
> Tested during device handover from efifb and simpledrm to radeon. Udev
> reloads the configured console font for the new driver's terminal.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=892340 # 1
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1074624 # 2
> Link: https://cgit.freedesktop.org/systemd/systemd/tree/src/vconsole/90-vconsole.rules.in?h=v222 # 3
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

