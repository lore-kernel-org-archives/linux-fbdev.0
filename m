Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD500C64E8A
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CFA2076E
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 15:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VwQzQyaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgK3Pmi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3Pmh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 10:42:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EB8C0613CF
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 07:41:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so16821083wrn.1
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Nov 2020 07:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5uwbd32nMoGasvv4Rb1SYFn9FAHpSeMQI2GqF7/ClB8=;
        b=VwQzQyaaaEAkhG0uP6JstBj0Ne46sEfpbP0AFJ3lWiA++4MlZwdX9VmPAP/xVurdUF
         qX4WHN6t+fCPaRR5ufvVvHLQKuKNE081OxBIgwTEwj5VvwIYDSzQKKh5FsGvpPpWEmKw
         0A++XINBdb/kUTZnGevAnk66MzpDarVS0veEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uwbd32nMoGasvv4Rb1SYFn9FAHpSeMQI2GqF7/ClB8=;
        b=I3/9jEmvm8TplpPJqWECmv5aZuvVIbpePjpi/aKYiZMEKUWCdVlZG8s6+qvNW0HUSU
         JG9pJBguo9V/IW28HcSBChuGUOlJLt2I4HPN7Bs8aTO9P/R5GH6o6Bn+YxptuSszpVeX
         l3C3OyI9EpKBApsvQM0LEv3n/DrR1LyrjvRzqDObaI5XttuvVEG303vPd42E8v2acppN
         85kUQes1QMJzygH7xjgT2vKUCNMLtuPXfPFpQw8OmQ/NcCcRmK1j+x+DvGkbvMlBDrqq
         uaBWs8rL7ix0bTvYIf9jvkOlzQmQMLtxwp8oi9BDXgKp/yj1v740WYdqtS0lMFRjaXbV
         DxWQ==
X-Gm-Message-State: AOAM532oXTttSSOcx42gaZRdBCpxA7c/1xQs1wATZpYzbtlKQF2ou9iL
        ciXrA6WR/JDD46qzNTtfIN0aSA==
X-Google-Smtp-Source: ABdhPJzbQ7wIr8vjKUp/Fu7xmk4z5hzYG4AZXWX3oC/JPVbzbr6768nAjbVpzfmu5NcRVdZ7xSbXYA==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr28887320wrv.191.1606750910237;
        Mon, 30 Nov 2020 07:41:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k11sm18921870wmj.42.2020.11.30.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:41:49 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:41:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, geert+renesas@glider.be,
        corbet@lwn.net, daniel.vetter@ffwll.ch, linux-doc@vger.kernel.org,
        bernie@plugable.com, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org
Subject: Re: [PATCH] fbdev: Remove udlfb driver
Message-ID: <20201130154147.GT401619@phenom.ffwll.local>
References: <20201130125200.10416-1-tzimmermann@suse.de>
 <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2011300843270.29199@file01.intranet.prod.int.rdu2.redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 30, 2020 at 09:31:15AM -0500, Mikulas Patocka wrote:
> 
> 
> On Mon, 30 Nov 2020, Thomas Zimmermann wrote:
> 
> > Udlfb has been superseded by DRM's udl. The DRM driver is better by
> > any means and actively maintained. Remove udlfb.
> 
> Hi
> 
> I am using udlfb and it's definitely better than the DRM driver. The DRM 
> driver will crash the kernel if you unplug the device while Xorg is 
> running. The framebuffer driver doesn't crash in this case. (I have a cat 
> and the cat sometimes unplugs cables and I don't want to reboot the system 
> because of it :-)

This should be a lot better in recent kernels, there's been tons of fixes
for drm hotunplug. Might be there's still bugs in the drm/udl driver.

> The framebuffer driver is faster, it keeps back buffer and updates only 
> data that differ between the front and back buffer. The DRM driver doesn't 
> have such optimization, it will update everything in a given rectangle - 
> this increases USB traffic and makes video playback more jerky.
> 
> The framebuffer driver supports programs running full-screen directly on 
> the framebuffer console, such as web browser "links -g", image viewer 
> "fbi", postscript+pdf viewer "fbgs", ZX Spectrum emulator "fuse-sdl", 
> movie player "mplayer -vo fbdev". The DRM driver doesn't run them.

Hm this should in general work on drm drivers. Without that it's clear the
switch-over isn't really ready yet.

> If you seach for someone to maintain the framebuffer driver, I can do it.

We're looking for people to port the missing features over to the drm
drivers. The problem is that fbdev is full of security bugs, and we're
fixing them by removing the features. So that's why there's some push to
sunset at much as possible.
-Daniel

> 
> Mikulas
> 
> 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >  CREDITS                      |    5 +
> >  Documentation/fb/index.rst   |    1 -
> >  Documentation/fb/udlfb.rst   |  162 ---
> >  MAINTAINERS                  |    9 -
> >  drivers/video/fbdev/Kconfig  |   17 +-
> >  drivers/video/fbdev/Makefile |    1 -
> >  drivers/video/fbdev/udlfb.c  | 1994 ----------------------------------
> >  7 files changed, 6 insertions(+), 2183 deletions(-)
> >  delete mode 100644 Documentation/fb/udlfb.rst
> >  delete mode 100644 drivers/video/fbdev/udlfb.c
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
