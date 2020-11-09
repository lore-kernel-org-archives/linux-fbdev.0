Return-Path: <SRS0=iTl0=EP=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64CBC55ABD
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Nov 2020 08:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802C120719
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Nov 2020 08:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgKIIi3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Nov 2020 03:38:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44783 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgKIIi3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Nov 2020 03:38:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id f16so8160014otl.11;
        Mon, 09 Nov 2020 00:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mpl5z7jYy7tt5Nnzqwz9YOe8OadxKMgEiQDFvQkXiUc=;
        b=mOMCcwLxVLgtCaitpVPT20Ns61Pt+PDaZ8juYLHg2psFWqwGqInmBojNLO5U5XdJ7A
         qddGIdZRSLHBm64cVvR3vZV7pZ7HJu235ZSh8J1vd/YC4oXU8dIzX8w4z7aEY26AFTs0
         J47s/fPX3rLyxkw7AWqUWRrIT5te/eMRdpqghyik6tD6hqaTZR0B8BDOSDzYRnR4dHpO
         458fZ38JKAS4/++1x1NK/HbLfdvrwOxcoLfSsAZ0UkBd+i4hT3tmA7tjGxeFZwsRkkjt
         CWglcqM3t0zii/90gJLxjaf8Izit+zwcHOB695fZbmytd079wtfyKwSGopkbFIB6a+hm
         Buhw==
X-Gm-Message-State: AOAM532LYycG2sfKPevujvuXk4I2d48ySJDewm9s/f8cQeBlGA+Uz1vM
        Y8DQCjpZ0A261i/3hi9/iL5MpDYJu8cYwfqqt1ONFux2PQ5GJQ==
X-Google-Smtp-Source: ABdhPJztzqSlL0WXA+McVa1c5WLjfnlry5X7OjJ9ynRD1lUtJ8E5/oZWsMSMvuAqBoLB9pps/iYyuiC8KGSadZDVsVM=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr8991741oti.107.1604911108098;
 Mon, 09 Nov 2020 00:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20201101102941.2891076-1-geert@linux-m68k.org>
 <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
In-Reply-To: <874km91by4.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Nov 2020 09:38:16 +0100
Message-ID: <CAMuHMdWEJwd4mGUm4ycUx5dBg5Lbb3cG+X5QsJ-icwuvoLxx5w@mail.gmail.com>
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
> > I have a harder time understanding why the change of pixclock from 31041
> > to 7761 is correct. All other modes have a pixclock close to or equal
> > to 32000 - so it looks strange this one is off.
>
> According to the Profibuch the pixclock should be about 95000.

Please have a look at the paragraph on p. 1052, and realize that it
fails to take into account horizontal black/sync (the actual scan line
length is 1792 not 1280 pixels) (thanks, Michael!).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
