Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1467AC4167D
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Jan 2022 03:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383610AbiAYDek (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 22:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415027AbiAYAzT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 19:55:19 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E4C05485B
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 14:41:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id j2so25367681ejk.6
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=uXDJy29KRa4aADLFl/N15nh7M0VaTORTTf56QaN1/D8=;
        b=efqbMukuNMqUuks37174gIM5nhm8Gen4FtY57CdK2tEi3BfMZzBFRqgmzNeBtajT3i
         UZq7JOvZGrjgXK8khxabKMnqG4WwKYAL5FfmYg5D5IlXAexyxMaYdHuaAYUREX+N3TCU
         Opdh+/jMhD1bB9/57dSGaCBHcnH2ZUCSK+LbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=uXDJy29KRa4aADLFl/N15nh7M0VaTORTTf56QaN1/D8=;
        b=6gK8lFCtdDsegbprd8CpNZIBEtNLI+C7PW1I+9wV3hMBJ2fFhktE7gSv7sqxIxkPnY
         G14UY7wq4toymAs/oR1AbD3+aWy8vdp61hSsVeZeFZRpw+HRfVrTSxh/FqOw3WFN8GXo
         KDla4guHnR4gqBpuJB724R/6MlE+Pt8jDpiX1aIHGeklT8mM9h2D+VozZr1HaNwqsA4d
         pwBNsVHrDG1bekvkxWhs33vidNiVf+XJd44RFxcfX3hV9i9Fnszw6J7eRKNG49T0nrh7
         ASaFXdoOlT8vytR2LWj4FV9Am38lcMvzDkyXutxdYhZpc8luvUO2maHwOBAgVmb0l1TK
         XDiw==
X-Gm-Message-State: AOAM5322+PsFQrwHiemKgatamw8vBUrbc29kT5Pj9fq/mOxgjAhliUTw
        /ACNRDuqz8Dg1ANAFWvfQFk4Ow==
X-Google-Smtp-Source: ABdhPJwEBu82CanT1FE6tnzaZiKu217V/6ZzbRSjWilrwERD5ltPGeNXbEtdzOWx5lKLMTP+U507fQ==
X-Received: by 2002:a17:907:e8d:: with SMTP id ho13mr3105265ejc.169.1643064084993;
        Mon, 24 Jan 2022 14:41:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z4sm5364919ejd.39.2022.01.24.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:41:24 -0800 (PST)
Date:   Mon, 24 Jan 2022 23:41:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] Fix regression introduced by disabling
 accelerated scrolling in fbcon
Message-ID: <Ye8rElg/lANVos2Q@phenom.ffwll.local>
Mail-Followup-To: Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Schnelle <svens@stackframe.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>, Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220124210319.325512-1-deller@gmx.de>
 <Ye8mDFcWSiXoRJbD@phenom.ffwll.local>
 <16884bfd-36ca-dd2e-43e4-4977861f8fa1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16884bfd-36ca-dd2e-43e4-4977861f8fa1@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 24, 2022 at 11:37:03PM +0100, Helge Deller wrote:
> On 1/24/22 23:19, Daniel Vetter wrote:
> > On Mon, Jan 24, 2022 at 10:03:17PM +0100, Helge Deller wrote:
> >> This series reverts two patches which disabled scrolling acceleration in
> >> fbcon/fbdev. Those patches introduced a regression for fbdev-supported graphic
> >> cards because of the performance penalty by doing screen scrolling by software
> >> instead of using existing 2D hardware acceleration.
> >>
> >> This series has been discussed on linux-fbdev, dri-devel and linux-kernel
> >> mailing lists. The consensus is that they will be reverted, but in addition
> >> it's being worked on to find a solution which allows to disable parts of the
> >> classic fbdev hardware acceleration code which isn't needed in DRM-only
> >> configurations.
> >
> > That's not my take at least.
> 
> Which is?
> Didn't we discussed about introducing something like
> CONFIG_FBCON_LEGACY_ACCELERATION ?

Yeah, as part of the reverts. Or at least that's what I meant to say.
-Daniel
> 
> >> The patchset is planned to be kept in fbdev's for-next git branch and later
> >> pushed into kernel v5.18 if no issues are found until then.
> >
> > Neither this. I don't think we've resovled maintainership of fbdev core
> > code and fbcon yet. That is the part that drm folks very much still
> > maintained, as a quick git shortlog will show.
> >
> > Maintaining these parts outside of drm trees just doesn't make sense,
> > since none of the other graphics relevant development happens outside of
> 
> I have no objections if you are willing to take those two patches through
> the drm tree.
> 
> Helge
> 
> >> ---
> >> Changes in v2 compared to v1:
> >> - adjusted the stable tags (one v5.10+, the other v5.16+)
> >> - moved the analysis and reasoning why those should be reverted into
> >>   the commit message. That simplifies to analyze later why they were
> >>   reverted.
> >> - resorted the To an Cc mail recipient lists
> >>
> >> Helge Deller (2):
> >>   Revert "fbdev: Garbage collect fbdev scrolling acceleration, part 1
> >>     (from TODO list)"
> >>   Revert "fbcon: Disable accelerated scrolling"
> >>
> >>  Documentation/gpu/todo.rst              |  24 --
> >>  drivers/video/fbdev/core/bitblit.c      |  16 +
> >>  drivers/video/fbdev/core/fbcon.c        | 540 +++++++++++++++++++++++-
> >>  drivers/video/fbdev/core/fbcon.h        |  59 +++
> >>  drivers/video/fbdev/core/fbcon_ccw.c    |  28 +-
> >>  drivers/video/fbdev/core/fbcon_cw.c     |  28 +-
> >>  drivers/video/fbdev/core/fbcon_rotate.h |   9 +
> >>  drivers/video/fbdev/core/fbcon_ud.c     |  37 +-
> >>  drivers/video/fbdev/core/tileblit.c     |  16 +
> >>  drivers/video/fbdev/skeletonfb.c        |  12 +-
> >>  include/linux/fb.h                      |   2 +-
> >>  11 files changed, 703 insertions(+), 68 deletions(-)
> >>
> >> --
> >> 2.31.1

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
