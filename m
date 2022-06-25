Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E1C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 13:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiFYNAl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiFYNAk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 09:00:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876A17E20
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 06:00:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eq6so6936748edb.6
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VBWosURA4p9FSVWkaJUPTAYtGobH5wsNuDxYO8bdKIk=;
        b=Rks2rWYqL4qVOsZ2q8H85MUeX5YG6UeBtwCGiIo+8uU1CqnWIryq5sPHIquIWHnJ+C
         re3sEFBKELPKQETrO3BOllCUh6BdgEjsIkLL4WOqVLBaeO8gsSs4QXzTlXWn87I/zSGa
         lOqWyIAXG+5R0BECuEmTtf8kG2PXxf5JL6+hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBWosURA4p9FSVWkaJUPTAYtGobH5wsNuDxYO8bdKIk=;
        b=s0ma0uztnPMzSEK86A3Z2wlYhvhBbQR9GOF5eBoFpCojgau94Ti+X5bPNSkPv8aIgC
         tmSIIIRyfrpshXXn3hiz8tUUN+JN/TgE04Kj14+DZ3rHfiCrzSrdGKBhtwnNzhp0bzsn
         diQyH8Wz2sbB0fsvEzPMVyF3H94xn96bggJ97w0WKCaMZWfBsNsz8D8yI1gwoQM8W0o1
         M/cs23CRs/5xpiKFI8yRSySHNp/C9JG7YsysZD0olq/AjM2CytD0HxR4ji6TVJ0Am17x
         TfcXpcvprlJKJjXv3E3RyA67Xwqy3kQ6jZKDx04z6DFaMODVaGEJ03NaPlmWRBTV2xk5
         6Ruw==
X-Gm-Message-State: AJIora+pCmmkPEQfdMNBmm46fQ/OUl+G/EjQYIfCZQNOuXamS26v7gis
        GCXCHtOmy2eiV/jBMJhqOr84AQ==
X-Google-Smtp-Source: AGRyM1vhFxqKmrXHoec0KD6CXixp1W42p0zc4Lb3rXJg82R38wo0Ujn0AQUfJkJEhs1EaC8I1rbJWQ==
X-Received: by 2002:aa7:d795:0:b0:435:7fc8:2d1b with SMTP id s21-20020aa7d795000000b004357fc82d1bmr4877488edq.201.1656162038025;
        Sat, 25 Jun 2022 06:00:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t17-20020a1709067c1100b00711d5baae0esm2621907ejo.145.2022.06.25.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 06:00:37 -0700 (PDT)
Date:   Sat, 25 Jun 2022 15:00:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] fbmem: Fix input parameter checks for
 user-provided screen resolution changes
Message-ID: <YrcG80jK2e44LCtb@phenom.ffwll.local>
References: <20220625122502.68095-1-deller@gmx.de>
 <20220625122502.68095-4-deller@gmx.de>
 <YrcGCkHuWHv3I6Fx@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrcGCkHuWHv3I6Fx@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jun 25, 2022 at 02:56:42PM +0200, Daniel Vetter wrote:
> On Sat, Jun 25, 2022 at 02:25:01PM +0200, Helge Deller wrote:
> > Enhance the checks in the FBIOPUT_VSCREENINFO ioctl handler to verify
> > the user-provided new screen size for:
> > 
> > a) virtual screen size >= physical screen size, and
> > 
> > b) new screen size is bigger than currently configured console font size.
> > 
> > Return -EINVAL on invalid input.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Cc: stable@vger.kernel.org # v5.4+
> 
> Imo squash this into the previous one please. Doesn't make sense to split
> the patch which adds a function from it's callsite.

Correction. The part to add the fbcon_modechange_possible call should be
squashed into the previos patch.

The check for x/yres_virtaul < x/yres should imo be moved into fb_set_var,
next to the other existing checks that have been added over time.
-Daniel

> -Daniel
> 
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index afa2863670f3..50fb66b954d6 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1106,7 +1106,13 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >  			return -EFAULT;
> >  		console_lock();
> >  		lock_fb_info(info);
> > -		ret = fb_set_var(info, &var);
> > +		if (var.xres_virtual < var.xres ||
> > +		    var.yres_virtual < var.yres)
> > +			ret = -EINVAL;
> > +		if (!ret)
> > +			ret = fbcon_modechange_possible(info, &var);
> > +		if (!ret)
> > +			ret = fb_set_var(info, &var);
> >  		if (!ret)
> >  			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >  		unlock_fb_info(info);
> > --
> > 2.35.3
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
