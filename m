Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6448C63777
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E885D206D4
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LSlo/fVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgK3VHO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 16:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgK3VHO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 16:07:14 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A443C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 13:06:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so1246671wmf.3
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT7uPFeQMsAOh9Sd//UU7R2KkQGwvueFKx1XYJ4p2Yg=;
        b=LSlo/fVYM5h4ECABLCXa0dD+Q/XxoscjrHpe4ddnaxDmRGpH/PzcrB5bS0fzzUuc0P
         Iu0vMD21RP0OpgBu2BM5grfhbppcx0FbcKadAhKd8zpUoTZ5dd47YzEU/tbFe1AzLNWS
         q/+/kKM3uOdO6LkDmjoEtz+mIJrLxHIUzGlLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OT7uPFeQMsAOh9Sd//UU7R2KkQGwvueFKx1XYJ4p2Yg=;
        b=JtBIgw/FeeTcqNDwZCLHMtv90U0vJ/lObDoeGsxGNpKdtgni/v3i2uaAZZhb0jKC6X
         DtvsAAKtn5gYI/eAQWz3WoMIA9GAEfhaeQZUdv61Zm3oK0lHqvoyYA/QbVwNogvWwFb6
         X34afxx4tqWmtXY+hUYoNoQKYRze83S0Wb8vKH/mDlS1HLwT4fQAOHWOUzB4HqqhHLAg
         WMrrdhfAdo+ikxuu72Qvt8QoETq/u4geWROZr0XLeRqqQTRAT5e2qcFhUWa2Q3ZXPhf4
         217sSyEp6Tde04NvdMWNBzrc1LPgZjcVvwaIbEkoGEeb3uAHuI3F6ZHH1hZHske9Kljx
         VBLw==
X-Gm-Message-State: AOAM532PgRmN70bKXbeY9FPEVGvfKhzmXhaXeFzC0yDsLBO6bxcX2hJ4
        0vNcFMesonqzhzgd9lfPk7YbSQ==
X-Google-Smtp-Source: ABdhPJy23PBUPd4raJiEfRyGjC2Eq9Gqvqz2JKpb4jnGq5ksSVVgLRxlDrW19AsWsJJ6USmdjJ8i+Q==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr808911wmf.38.1606770392851;
        Mon, 30 Nov 2020 13:06:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i11sm30197597wrm.1.2020.11.30.13.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:06:31 -0800 (PST)
Date:   Mon, 30 Nov 2020 22:06:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, geert+renesas@glider.be,
        corbet@lwn.net, daniel.vetter@ffwll.ch, linux-doc@vger.kernel.org,
        bernie@plugable.com, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
Message-ID: <20201130210629.GY401619@phenom.ffwll.local>
References: <20201130125200.10416-1-tzimmermann@suse.de>
 <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
 <20201130154147.GT401619@phenom.ffwll.local>
 <alpine.LRH.2.02.2011301241470.21432@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2011301241470.21432@file01.intranet.prod.int.rdu2.redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 30, 2020 at 01:39:17PM -0500, Mikulas Patocka wrote:
> 
> 
> On Mon, 30 Nov 2020, Daniel Vetter wrote:
> 
> > On Mon, Nov 30, 2020 at 09:31:15AM -0500, Mikulas Patocka wrote:
> > > 
> > > The framebuffer driver supports programs running full-screen directly on 
> > > the framebuffer console, such as web browser "links -g", image viewer 
> > > "fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl", 
> > > movie player "mplayer -vo fbdev". The DRM driver doesn't run them.
> > 
> > Hm this should in general work on drm drivers. Without that it's clear the
> > switch-over isn't really ready yet.
> 
> I fixed it with this patch two years ago: 
> https://lists.freedesktop.org/archives/dri-devel/2018-June/179023.html
> 
> But the patch never went through and the fb_defio feature was removed in 
> the kernel 5.6 (commit d0c4fc5a4814e431c15272935c8dc973c18073aa).

The generic fbdev emulation still has a defio implementation. We could try
to make it more efficient maybe, but it should be all there. The module
option disappeared since you now should always get it by default.

> Without fb_defio, the only other possibility how to update the screen is 
> the ioctl DRM_IOCTL_MODE_DIRTYFB. But this ioctl requires master mode, so 
> user programs like "links -g" can't issue it.

Now I'm confused, I thought you wanted to use fbdev /dev/fb* nodes? Those
should support defio. And if you want your applications to use drm
modesetting natively, they have to be drm master anyway. You can't use the
DIRTYFB ioctl to upload fbdev contents. So I'm a bit confused.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
