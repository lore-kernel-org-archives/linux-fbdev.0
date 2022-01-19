Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0804CC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jan 2022 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355825AbiASPjI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355749AbiASPjI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jan 2022 10:39:08 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103EC06173E
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 07:39:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso456681wmh.4
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jan 2022 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37g4UuiXO6if6O4jKw433Ctu3fSZBlrCPlzA7Fzx8js=;
        b=gK7HKEh4pEJNXBWO6n5GiHnZxfjl/Vu1FBTKM0IfTGemrzfmeB/Uhe79b0okiTixUi
         nr+K+Lgm31TIFsfOya6ZteoMxbGY2ZOnr4Jl8IF2FHd8lIPpoUramdITYWzPCJ7hbmrr
         +P1RrkQ8g/EjvR41Avz3poNagvVQfMxo5HGQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37g4UuiXO6if6O4jKw433Ctu3fSZBlrCPlzA7Fzx8js=;
        b=fiG58LDU3TBwc3bnAD1vzgc2KXtyG65Ba6bKhRNbGn9s/jsRHCncoIngfA+M3lZjCl
         IyQM40Su1u7UAEGpD6nl1fmmQgQvB/G+4OYTXB8tGNX9DvIScAnPciJaNp3mxgsVOQRn
         kcNyoOaMOElDkCd1tVGlWafoEx14xzwafGsATiDRvND41n/PD+J58WIc5pLCKe3TB72z
         I1+2zggvRuIorNn2bFml2IfmywuAYw6LHjQ3UfIMki6R8e53Wd7kUs74X2aQ93BNFlWp
         JJDltmqiRYhY72vzngyDw0ErByaFdfMteLK9ptWni+m/5A2lL+8chvwfwxdhm+ixjmLv
         LDRA==
X-Gm-Message-State: AOAM530fiM0Ns6zcUM8fWt8pIcAYhIxPViL4tD2f4Oq0P6a1JX1ZZm/1
        AYeko9s5WYOnxXLDBnk2Z/buRw==
X-Google-Smtp-Source: ABdhPJy72r4B7yan+nxdt7FSI1SKVo07bVD5jhVNqztRvBA1fBMhkfG6WrkFf25ELM9tXG36OYArHg==
X-Received: by 2002:adf:fbd1:: with SMTP id d17mr4928145wrs.626.1642606746468;
        Wed, 19 Jan 2022 07:39:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n10sm1057896wmr.25.2022.01.19.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:39:05 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:39:03 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: fbdev: Garbage collect fbdev scrolling acceleration
Message-ID: <Yegwl/rwRhjROxcy@phenom.ffwll.local>
References: <feea8303-2b83-fc36-972c-4fc8ad723bde@gmx.de>
 <87zgnz71ic.fsf@x1.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgnz71ic.fsf@x1.stackframe.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 13, 2022 at 10:46:03PM +0100, Sven Schnelle wrote:
> Helge Deller <deller@gmx.de> writes:
> 
> > I may have missed some discussions, but I'm objecting against this patch:
> >
> > 	b3ec8cdf457e5 ("fbdev: Garbage collect fbdev scrolling acceleration, part 1 (from TODO list)")
> >
> > Can we please (partly) revert it and restore the scrolling behaviour,
> > where fbcon uses fb_copyarea() to copy the screen contents instead of
> > redrawing the whole screen?
> >
> > I'm fine with dropping the ypan-functionality.
> >
> > Maybe on fast new x86 boxes the performance difference isn't huge,
> > but for all old systems, or when emulated in qemu, this makes
> > a big difference.
> >
> > Helge
> 
> I second that. For most people, the framebuffer isn't important as
> they're mostly interested in getting to X11/wayland as fast as possible.
> But for systems like servers without X11 it's nice to have a fast
> console.

Fast console howto:
- shadow buffer in cached memory
- timer based upload of changed areas to the real framebuffer

This one is actually fast, instead of trying to use hw bltcopy and having
the most terrible fallback path if that's gone. Yes drm fbdev helpers has
this (but not enabled on most drivers because very, very few people care).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
