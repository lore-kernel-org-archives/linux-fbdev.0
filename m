Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D259C07E9B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4779F60FEA
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 07:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhGTGwp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:52:45 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:37447 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbhGTGwo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 02:52:44 -0400
Received: by mail-ua1-f42.google.com with SMTP id w6so7770829uaq.4;
        Tue, 20 Jul 2021 00:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcwwIKXkcen+cASiKX8dxRt5ZT8ziwWwN38CXX7LydU=;
        b=dTHtdYxMC99ojL9KB6M8ky4NXxZPfUZc33CcpVXyJWvmpMuYN7iw+nInCfh/a86opD
         /f6FPCPsQwvshIdQTK9DymGaz9PK0c7o0UNI+tKQVV4SsmMosbzL+xjicVzy7t8Ovjon
         eyf8kVxDiFxeb32E+tcU3dnf0I/hJxM534aMvM4T3HjCRFvExHlqcANuu8aZbwZTy7UI
         OWbYXXE2fGVmKuFgoiXzho1axvwIJbYbtjIx2diPFDlUrtg9wlUl96av1EjbCAf5ChA6
         YKcVw4pe8lbysryrQKxCB5ZcHsFEe7o7h4kknttjOTozZNKyhEbt6XcK5lcwBEW+f6WN
         SEgA==
X-Gm-Message-State: AOAM532X4WmHahO/+aG+xwAr496sngMm+PblkJOjvRb8NBIog6arCbZ8
        tXEobtEjcNzV0Q5aqxpu/LaGgqdie/A0s5huydUYlfMc
X-Google-Smtp-Source: ABdhPJwPDX91aff2YPV7tV6BcHro69P/gJKxmT+erTLAbtVlBy5/BOX9Kb3TXYB1oJJEukohKoWiib/KNNVZ8lXCc/c=
X-Received: by 2002:ab0:6710:: with SMTP id q16mr6956039uam.106.1626766402335;
 Tue, 20 Jul 2021 00:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210714145804.2530727-1-geert@linux-m68k.org> <YPXRMXQxCW+Agaz8@ravnborg.org>
In-Reply-To: <YPXRMXQxCW+Agaz8@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Jul 2021 09:33:11 +0200
Message-ID: <CAMuHMdXK5X5Zawgp=SivGQSvOi=p_PwarYUR4QikGuB+f_d6YQ@mail.gmail.com>
Subject: Re: [PATCH resend 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Sam,

On Mon, Jul 19, 2021 at 9:23 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jul 14, 2021 at 04:57:59PM +0200, Geert Uytterhoeven wrote:
> > This patch series optimizes console operations on ssd1307fb, after the
> > customary fixes and cleanups.
> >
> > Currently, each screen update triggers an I2C transfer of all screen
> > data, up to 1 KiB of data for a 128x64 display, which takes at least 20
> > ms in Fast mode.  While many displays are smaller, and thus require less
> > data to be transferred, 20 ms is still an optimistic value, as the
> > actual data transfer may be much slower, especially on bitbanged I2C
> > drivers.  After this series, the amount of data transfer is reduced, as
> > fillrect, copyarea, and imageblit only update the rectangle that
> > changed.
> >
> > This has been tested on an Adafruit FeatherWing OLED with an SSD1306
> > controller and a 128x32 OLED, connected to an OrangeCrab ECP5 FPGA board
> > running a 64 MHz VexRiscv RISC-V softcore, where it reduced the CPU
> > usage for blinking the cursor from more than 70% to ca. 10%.
> >
> > Thanks for your comments!
> >
> > Geert Uytterhoeven (5):
> >   video: fbdev: ssd1307fb: Propagate errors via
> >     ssd1307fb_update_display()
> >   video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
> >   video: fbdev: ssd1307fb: Extract ssd1307fb_set_address_range()
> >   video: fbdev: ssd1307fb: Optimize screen updates
> >   video: fbdev: ssd1307fb: Cache address ranges
>
> A few comments left for a couple of patches.
> The remaining patches are:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Thank you!

> Do you have commit rights to drm-misc-next?

No I have not (and I don't think I should).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
