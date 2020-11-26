Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB41C63777
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5B20872
	for <linux-fbdev@archiver.kernel.org>; Thu, 26 Nov 2020 08:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgKZI35 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:29:57 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:34970 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgKZI35 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 26 Nov 2020 03:29:57 -0500
Received: by mail-oo1-f65.google.com with SMTP id y3so237662ooq.2;
        Thu, 26 Nov 2020 00:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/vBBElAksTvt4HjurCYnxT73LNYVZ5qmRqRKKnCoNw=;
        b=SBDUNm3+NYqZ7dOowcbPhy3YJbjDU+cyirOt7w0EkG8uBm4EpeOwLx/6g7IdT76HT0
         vGFFqRKqms2cKwRLwHd5uzLNP4mzV6WLf4rohuyuim1JFyeOQQet2unlWEdUPsK02Xh8
         g3XAEiVBLtqtVxHLj1NC5AgacpAh5BHW2wmP82wmdomvdAJ3g4sA289up8s2Eze0mg8m
         6HCRQ/rt3HNoI/vYmY+krIBPRPNSf37oKQue4ClAalsHB854gmh8OyGSFRfSCbVjTA3A
         /VGfTT45V9/9uCFAQlD+TuJ8b5CS/2o3gcRUzO83dE9PbFzuy6ZbiflOZSC/lKnwYQ3T
         n0xA==
X-Gm-Message-State: AOAM530RJn4uQXQSH6k4fMXhz3ZUWJlrA33IK36tMnm7iUbYASEHWisG
        J81WCjcMfHYbuY6IpcHYmoPi3lmEi/Sy8sRfCHA=
X-Google-Smtp-Source: ABdhPJwPulrHQWSHcYoomf4Z7RDCXvKABZRXcws/8ZD9MXQyBQxa3HrEjaME+FqCdHcKa4kGkfEeLCOXS4eDYfiorh4=
X-Received: by 2002:a4a:abc9:: with SMTP id o9mr1291425oon.1.1606379394915;
 Thu, 26 Nov 2020 00:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20201126003957.19604-1-rdunlap@infradead.org>
In-Reply-To: <20201126003957.19604-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Nov 2020 09:29:43 +0100
Message-ID: <CAMuHMdVpcLc9enskSBJobmHXy3GU5ULdt78ArAr522VXRmty5w@mail.gmail.com>
Subject: Re: [PATCH] fbdev: aty: SPARC64 requires FB_ATY_CT
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Randy,

On Thu, Nov 26, 2020 at 1:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> It looks like SPARC64 requires FB_ATY_CT to build without errors,
> so adjust the Kconfig entry of FB_ATY_CT so that it is always 'y'
> for SPARC64 && PCI by disabling the prompt for SPARC64 && PCI.
>
> As it currently is, FB_ATY_CT can be disabled, resulting in build
> errors:
>
> ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
>
> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
> +++ linux-next-20201124/drivers/video/fbdev/Kconfig
> @@ -1277,7 +1277,7 @@ config FB_ATY
>           module will be called atyfb.
>
>  config FB_ATY_CT
> -       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
> +       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support" if !(SPARC64 && PCI)
>         depends on PCI && FB_ATY
>         default y if SPARC64 && PCI
>         help

What about letting FB_ATY select FB_ATY_CT if SPARC64 && PCI, and
dropping the "default y"-line, instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
