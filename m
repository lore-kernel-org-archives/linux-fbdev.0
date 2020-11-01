Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8AC55178
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6447D20870
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 11:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKAL3V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 06:29:21 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44430 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgKAL3T (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 06:29:19 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EFCBD80477;
        Sun,  1 Nov 2020 12:29:16 +0100 (CET)
Date:   Sun, 1 Nov 2020 12:29:15 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
Message-ID: <20201101112915.GB1263673@ravnborg.org>
References: <20201101102941.2891076-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101102941.2891076-1-geert@linux-m68k.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=tBb2bbeoAAAA:8 a=01v-Q2eNbSkilRediCoA:9
        a=CjuIK1q_8ugA:10 a=h95a96m6yT8A:10 a=Oj-tNtZlA1e06AYgeCfH:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert.

On Sun, Nov 01, 2020 at 11:29:41AM +0100, Geert Uytterhoeven wrote:
> The horizontal resolution (640) for the TT High video mode (1280x960) is
> definitely bogus.  While fixing that, correct the timings to match the
> TTM195 service manual.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Untested on actual hardware, hence the RFC.
> 
> v2:
>   - Use correct base.
> ---
>  drivers/video/fbdev/atafb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index f253daa05d9d3872..5ecf3ec9f94cb720 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -495,8 +495,8 @@ static struct fb_videomode atafb_modedb[] __initdata = {
>  		"tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
>  		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
>  	}, {
> -		/* 1280x960, 29 kHz, 60 Hz (TT high) */
> -		"tt-high", 57, 640, 960, 31041, 120, 100, 8, 16, 140, 30,
> +		/* 1280x960, 72 kHz, 72 Hz (TT high) */
> +		"tt-high", 57, 1280, 960, 7761, 260, 60, 36, 4, 192, 4,
>  		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP

Well-spotted. The change of 640 => 1280 is surely right.
I have a harder time understanding why the change of pixclock from 31041
to 7761 is correct. All other modes have a pixclock close to or equal
to 32000 - so it looks strange this one is off.

You know a tons more about all this than I do so it is properly right
but I was left wondering so please enlighten me.

	Sam
