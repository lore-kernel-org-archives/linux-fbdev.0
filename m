Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C71C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B43960551
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 16:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhKLQPP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhKLQPO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 12 Nov 2021 11:15:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D9C061766
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Nov 2021 08:12:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y196so8127499wmc.3
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Nov 2021 08:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=twurRhba5qgXRpgexuSI57Dp4Y9u2cq2aOPi/t5IpCg=;
        b=P5AJMChoaTUh2v8lFArlEIxhsCWAkMxOmfTMhbkQvQDPp4rJAdPEpg5fljtJxT16r1
         Vl1X1fTWPLWfziVxg2uS2EQxFUqItRjnMV7PX/rvoynchtAeMIhH/o6qCVyZcKW9MpgF
         6C4zjXegh05Rxg9jEX8zfB35njzKFfOkhs2DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=twurRhba5qgXRpgexuSI57Dp4Y9u2cq2aOPi/t5IpCg=;
        b=HKYWo89OujHrug7afscUc1fvcsU++Jwd8+lnIVEzI03k+4k4Ud2bBvzEKXh/W0ewjm
         fYccDU7eI0IbsrqKQla+5xJwSO8eL1o5W/3Hlvk45TuWmmtFAo9eglPGW3VpKqwtykEH
         drKQqhytyMw47oJdyqy9dA/oZjUjQBVcQkxlBuv2s6pyzqp8QNoqY2ZVKRrcjTEGUQ85
         T4UA5pLI9JGXCoiGSkiHipAHaDOM6ZRrX6ZoYRwK3T0IRNsr3eRxzW40G3qUvxGBmTEp
         qBGFRJZDO6vPhFvhjSJstcoGkAOzuHdhkIkR4brZVCboqY/IlOR9gux86H3ZjkVqcsk0
         kQGQ==
X-Gm-Message-State: AOAM533xwq+mdPmuwNtOw/8C4zjHOliGw+BTCkPJk08HsaNEV09fubQi
        Yn32KcVMY9Hksm9qwaV1otDYvw==
X-Google-Smtp-Source: ABdhPJyEP4m/8kd4jlKweTPP4u7zakHKKjuN/yJDukwgCYB58zUMCs0ErybOgSz0h1SjnM9VGwNqyA==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr36546315wml.20.1636733542549;
        Fri, 12 Nov 2021 08:12:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o2sm6374468wrg.1.2021.11.12.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:12:22 -0800 (PST)
Date:   Fri, 12 Nov 2021 17:12:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
Message-ID: <YY6SZJM8nDDCAzXU@phenom.ffwll.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>
References: <20211111111120.1344613-1-javierm@redhat.com>
 <YY0A8LOVhs5JbMXW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY0A8LOVhs5JbMXW@kroah.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 11, 2021 at 12:39:28PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 11, 2021 at 12:11:20PM +0100, Javier Martinez Canillas wrote:
> > The efifb and simplefb drivers just render to a pre-allocated frame buffer
> > and rely on the display hardware being initialized before the kernel boots.
> > 
> > But if another driver already probed correctly and registered a fbdev, the
> > generic drivers shouldn't be probed since an actual driver for the display
> > hardware is already present.
> > 
> > This is more likely to occur after commit d391c5827107 ("drivers/firmware:
> > move x86 Generic System Framebuffers support") since the "efi-framebuffer"
> > and "simple-framebuffer" platform devices are registered at a later time.
> > 
> > Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/
> > Fixes: d391c5827107 ("drivers/firmware: move x86 Generic System Framebuffers support")
> > Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> > 
> > Changes in v2:
> > - Add a Link: tag with a reference to the bug report (Thorsten Leemhuis).
> > - Add a comment explaining why the probe fails earlier (Daniel Vetter).
> > - Add a Fixes: tag for stable to pick the fix (Daniel Vetter).
> 
> That does not mean that it will make it into the stable tree.  Please
> read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Defacto your auto-picker is aggressive enough that just Fixes: is actually
good enough to get it into stable :-)

But yeah explicit cc: stable can't hurt.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
