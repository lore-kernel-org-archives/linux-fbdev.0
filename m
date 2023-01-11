Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905AC46467
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAKQzi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbjAKQzX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 11:55:23 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB3192AD
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 08:55:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so13186842wms.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMoQMQhB38nbcNla/KRz3O4QJ9q27t1i15WWEcz2Jmc=;
        b=lTrSYN/ycOKVefSYiUDi6rK+4awRhhWIhuFjdWOga20RotqekO7XjOtokkqEJCvg9v
         Xcn87Ryk2HVfq3p3V9ddCYllP50/GrSiJAeMHykifo1QFmrmYRSphjLsV644SMkKHF7S
         V9yG3sIPpDnILXz/ROfoIYQRSz0/XXefn1bF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMoQMQhB38nbcNla/KRz3O4QJ9q27t1i15WWEcz2Jmc=;
        b=vWatUjRDLsoVqWX+8RdC0NOV/EgsVUGucvB8nlj2+LEae4DitRk/mUZij1wi8CE+SC
         f37gXsLPjwy3EQ0xN3+9v4uRGtkYTIUbX/emrHmPmDybSQTwE9UZPGDCTLucxjThOz2z
         OXXatk/HTkfjGqdwuCkr3oKEHx721fIUSXBCjr7SWZC0z7SUseUEAnBdf3l52ueb7HbG
         nbtarLhPRA8g773wthESnWEyyV6ONTHlm07JZT/TwN+gNYHyh4XvmCWRCf2JDDXDi8J9
         jdGuDy0vdjA6gutMeSkRHq57cvgGl5cdczv4EeX9CcRmrJibBoBneXp21tUC7jCOigHj
         JJHw==
X-Gm-Message-State: AFqh2ko2Jwre2hB7LMlG0C0FEhSPHwFOIWlH9TNVmfC1nPGsu3IITxgQ
        pddQf1bFK1Len0kZ8oUHK5/b7Q==
X-Google-Smtp-Source: AMrXdXuH7F9Jvj2+GETMGkAU0b7SbfHCnmR86roP9bKzjfJPv40Q7aMZVHJzMhtfaFtf2sj6v3u0eA==
X-Received: by 2002:a05:600c:4fcc:b0:3d9:f91c:4bfc with SMTP id o12-20020a05600c4fcc00b003d9f91c4bfcmr5276949wmq.31.1673456120900;
        Wed, 11 Jan 2023 08:55:20 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm23259500wmb.14.2023.01.11.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 08:55:19 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:55:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 05/11] video/aperture: Only kick vgacon when the pdev is
 decoding vga
Message-ID: <Y77p9rTAX2IG6WaY@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
 <20230111154112.90575-5-daniel.vetter@ffwll.ch>
 <87119376-2813-f155-a2e1-006ffa382f12@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87119376-2813-f155-a2e1-006ffa382f12@suse.de>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 11, 2023 at 05:03:02PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.01.23 um 16:41 schrieb Daniel Vetter:
> > Otherwise it's bit silly, and we might throw out the driver for the
> > screen the user is actually looking at. I haven't found a bug report
> > for this case yet, but we did get bug reports for the analog case
> > where we're throwing out the efifb driver.
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=216303
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> >   drivers/video/aperture.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
> > index 3d8c925c7365..6f351a58f6c6 100644
> > --- a/drivers/video/aperture.c
> > +++ b/drivers/video/aperture.c
> > @@ -341,6 +341,9 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
> >   			return ret;
> >   	}
> > +	if (!primary)
> > +		return 0;
> > +
> 
> The original code from fbdev didn't do this, so this code didn't either.
> 
> It appears more to be a special case than an early-out branch. So can we
> write it as

Yeah I think this was a mistake going way back to when I added this to
i915 originally. It is a real change, but also I guess the people who have
machines without efifb or vesafb are ... really not many :-) Iirc you had
some very funny kernels going way back when vgacon was considered the only
safe choice to even hit this stuff.

> if (primary) {
>   // kick_vgacon
> }

Yeah, but next patch adds the vga aperture, and then I think it makes a
bit more sense.
-Daniel

> 
> ?
> 
> Best regards
> Thomas
> 
> >   	/*
> >   	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
> >   	 * otherwise the vga fbdev driver falls over.
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
