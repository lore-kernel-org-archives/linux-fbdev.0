Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D895AC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 14:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiBHONF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 09:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiBHONB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 09:13:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A5C03FED0
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 06:13:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e3so17044871wra.0
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5R9+MBEvDpMW00Dte4+/rEEsFi5DtKUaBzOD4MXCXtQ=;
        b=Jc79PGraKQ5s6L/P+SLK07eOBNmq7ee8b1jOmNuDLMvHSGeWysmyOpNAzy8Au2OwGJ
         S4bEVN2W/Kj9ydurocslXTyX0C4c//GnnjcwRcVOyUerHb2D22oLssPL8ECZDuF4F+WJ
         Yvx5THUgRzzMqElW/OQKovVf/OMDvdRVnm9rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5R9+MBEvDpMW00Dte4+/rEEsFi5DtKUaBzOD4MXCXtQ=;
        b=AL0FwsxshZTSYpIaQFak4P8w881xrNnqea6ifWjAWZzWHD+pTysblxlWj5ZgPIKeXA
         lH1PWxtk0GpTnTre9f9EXfW0Ma8ND60BwUc0kpMC4U4CWjiQTlB9FR7WZfiPsKXYUK7J
         HVxcBXKDJUAnvb0VRVM06nD1w2mQ5QEcvaQ8zvm69lt/ONNcuwaG9Vl9PqO05LOqwEZZ
         KbSmxCkNUzYPYijVH66A+PEB7bsfRik/7fwocCHHrhh8r84p3y0wWyqODi+ph6fB7/Ga
         eoQ0qgJuWevgrs8nv8g4KygzGhdyvX2GCs9QKud+00dUVZNjaUBPJTQsLNH1xXcBlA49
         7RDA==
X-Gm-Message-State: AOAM531aE1s1FLkmfPvvrOCWeKy1K+zNmoi2jQj2BW5Nq2SfAmQSyx9b
        fQ8MS1utcaNt0y83nglLpLd3WQ==
X-Google-Smtp-Source: ABdhPJw+sMlSVd/afjYxQMHqe/E6uF3RGqFVH/7HQ+ZCHFj6dyRrBozPKFtxGDVDOD1tAPw8D+QNOA==
X-Received: by 2002:adf:edc9:: with SMTP id v9mr3665385wro.135.1644329579332;
        Tue, 08 Feb 2022 06:12:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id az21sm2187601wmb.11.2022.02.08.06.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 06:12:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:12:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Message-ID: <YgJ6aKxFXbdX6toP@phenom.ffwll.local>
Mail-Followup-To: DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Sam Ravnborg <sam@ravnborg.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Claudio Suarez <cssk@net-c.es>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sven Schnelle <svens@stackframe.org>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:32PM +0100, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
> 
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
> 
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
> 
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.
> 
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Merged to drm-misc-fixes with all the acks added.
-Daniel

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..49809eaa3096 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7573,6 +7573,12 @@ S:	Maintained
>  W:	http://floatingpoint.sourceforge.net/emulator/index.html
>  F:	arch/x86/math-emu/
>  
> +FRAMEBUFFER CORE
> +M:	Daniel Vetter <daniel@ffwll.ch>
> +F:	drivers/video/fbdev/core/
> +S:	Odd Fixes
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  FRAMEBUFFER LAYER
>  M:	Helge Deller <deller@gmx.de>
>  L:	linux-fbdev@vger.kernel.org
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
