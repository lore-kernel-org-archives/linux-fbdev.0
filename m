Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CBC388F9
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B3E222E8
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 08:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgKBIkA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 03:40:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34605 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgKBIj7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 03:39:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id j14so1691548ots.1;
        Mon, 02 Nov 2020 00:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edOywJaljR8HIGA2ZPpwBj7Ix9fGqxtdv2rXnAS0A2I=;
        b=akoY9Ibvd4qAnWIZMSHxmBQ8qctfhauuLPRb4i9th9zDmm1A/a63PXCoF/uf78bVNJ
         4mWiMDZCyf6GBNnzBN2o2ghJiwq9RTcwt/ExuHBOi9NlOIY9lSRwEWrj8TKcZiitCH0L
         vdMM6J3XNK+wu+8aN4oPSPfIdBKGHTRFa0BvpLlv/4cmwWZSCQ+YbNDXmuWSahUr+267
         hm7zXLqwYcmYOC7EcCoejRly1rX5kX1fsWYZ46wd6rqK+5l9s5QTnTg5Zio/OhkqtBo0
         6ZRC3k7TOuLNSHs1YCnZ5JeWRfOx8x5+WbuQ3Kd4rep2NIly4WorY5i+QVAQ4jioHQ9E
         3Juw==
X-Gm-Message-State: AOAM531L9NP7QD2YqKbr/avtpFQ8yMJ9+jVcmhBjf1VGwvTBBWNRrwSV
        TRwGiIc3fkb8IhDDuw7BmJm1U96RXoYUUXsWEVo=
X-Google-Smtp-Source: ABdhPJxixL/W9coUjK0WIKR7AyvX0X5bfFMwaljlbBusyYNayvFnYK30bPFzgnwupFzPGT6nUtUDX1d2XURjFNnZMWY=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr11345222otb.250.1604306398694;
 Mon, 02 Nov 2020 00:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20201101102941.2891076-1-geert@linux-m68k.org>
 <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
In-Reply-To: <874km91by4.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Nov 2020 09:39:47 +0100
Message-ID: <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Andreas,

On Sun, Nov 1, 2020 at 1:47 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 01 2020, Sam Ravnborg wrote:
> > On Sun, Nov 01, 2020 at 11:29:41AM +0100, Geert Uytterhoeven wrote:
> >> The horizontal resolution (640) for the TT High video mode (1280x960) is
> >> definitely bogus.  While fixing that, correct the timings to match the
> >> TTM195 service manual.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> ---
> >> Untested on actual hardware, hence the RFC.
> >>
> >> v2:
> >>   - Use correct base.
> >> ---
> >>  drivers/video/fbdev/atafb.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> >> index f253daa05d9d3872..5ecf3ec9f94cb720 100644
> >> --- a/drivers/video/fbdev/atafb.c
> >> +++ b/drivers/video/fbdev/atafb.c
> >> @@ -495,8 +495,8 @@ static struct fb_videomode atafb_modedb[] __initdata = {
> >>              "tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
> >>              0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
> >>      }, {
> >> -            /* 1280x960, 29 kHz, 60 Hz (TT high) */
> >> -            "tt-high", 57, 640, 960, 31041, 120, 100, 8, 16, 140, 30,
> >> +            /* 1280x960, 72 kHz, 72 Hz (TT high) */
> >> +            "tt-high", 57, 1280, 960, 7761, 260, 60, 36, 4, 192, 4,
> >>              0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
> >
> > Well-spotted. The change of 640 => 1280 is surely right.

TBH, I spotted that 7 years ago, but never got to looking up and calculating
the other values...

> > I have a harder time understanding why the change of pixclock from 31041
> > to 7761 is correct. All other modes have a pixclock close to or equal
> > to 32000 - so it looks strange this one is off.

32000 ps is 31.25 MHz. Looks like these are bogus, too, and only
the VGA and Falcon video modes are correct?

> According to the Profibuch the pixclock should be about 95000.

95 ns? That's a 10.5 MHz pixel clock? Definitely too low.
The TTM195 manual says 128.85 MHz.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
