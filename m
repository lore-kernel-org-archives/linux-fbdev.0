Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3978C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66539206D5
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 16:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgDEvNCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAQIk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgKAQIk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 11:08:40 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2292CC0617A6;
        Sun,  1 Nov 2020 08:08:40 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id f21so5556349plr.5;
        Sun, 01 Nov 2020 08:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ujqaNLZTDijEUF2WH6i+J3ZjLlaqzw6Z31jdKSaeZk=;
        b=WgDEvNCc6v7J3BuCABRlYis995Jsp1Wha9cp/pKVJQgCH5REDq1P+J61T73puqB4Yb
         tUTYgtpxT8KiAmzlTpxkgnDLSBT1j3C+nwk3UTIYMvud7MWvHhnl6PLeb3jobllhhlx1
         LtfjlBzM7kez9GfoR+bmQjfAOOFIZzcQ6fzfoAk0IqTJOnI8NlS5OypxBOUCjX4jZt1D
         er6SAT1ZWjlsNC0ENxQV/Mcbmy8plKp0LnAeJj1/pKErK+KWiR65zUdW7eiKOSPhUeFB
         TwKrK9SYUuOWRPMIMhU9QrMOe9RFTukJUbXjSWXacTZM2WMSnW3c4gwtvyNrIWwuDBkT
         DZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ujqaNLZTDijEUF2WH6i+J3ZjLlaqzw6Z31jdKSaeZk=;
        b=egvwx3Jmn11Px3biuNPVUuddXgBWOTPZ8PWUXU4/SnyBQfY0bryZ6ADqPTj/HjnKCA
         MMqZxu9h7HoMF7Zws7L6gHkgWCq1GAl21jCHt08P14DpltnuC2fzqlDQEJQRqcdKpDrh
         Qr6x2dRl2L39Kq2N3rsl5hRqX3qTK2bWQF0yh5c4nOaz4VQW8YvYFLsPXYCUSUQhCxOy
         Hdf3DiR1HUjANNXDapL6nB1fcZ3bdHMAoIwb39hzgrWdzGuqlJm3H1JEAHS6f4ekevEG
         4KawR52s1+Fw968L0nm/Z0t+Mlb2FtaQ4muIrCeX5rzbggAHJx/k6N9nbyRTZt96kdXM
         g7vQ==
X-Gm-Message-State: AOAM532KbIN0FNI1FBhrOqDCT8KXSSLT7etmTFGI8D+jCt807NWMnvak
        sB9h72d4j1tloqfMZwcuIw==
X-Google-Smtp-Source: ABdhPJw1hyry3WkSvNfiy0flw8faWsiqz2DnvqGWZQK98KPX+tzNklOTt9QdIjEQraS6KPvwrKIWcw==
X-Received: by 2002:a17:90a:5204:: with SMTP id v4mr12240028pjh.188.1604246919513;
        Sun, 01 Nov 2020 08:08:39 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id t15sm11459126pfq.201.2020.11.01.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 08:08:38 -0800 (PST)
Date:   Sun, 1 Nov 2020 11:08:30 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Replace printk() with pr_*()
Message-ID: <20201101160830.GA1526929@PWN>
References: <20201101094718.GD1166694@ravnborg.org>
 <20201101144904.1522611-1-yepeilin.cs@gmail.com>
 <20201101154113.GA41883@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101154113.GA41883@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 01, 2020 at 04:41:13PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 01, 2020 at 09:49:04AM -0500, Peilin Ye wrote:
> > Replace printk() with pr_err(), pr_warn() and pr_info(). Do not split long
> > strings, for easier grepping. Use `__func__` whenever applicable.
> > 
> > fbcon_prepare_logo() has more than one callers, use "fbcon_prepare_logo:"
> > instead of "fbcon_init:", for less confusion.
> > 
> > Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 42 +++++++++++++-------------------
> >  1 file changed, 17 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index cef437817b0d..a3e87ab0e523 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -659,8 +659,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
> >  
> >  	if (logo_lines > vc->vc_bottom) {
> >  		logo_shown = FBCON_LOGO_CANSHOW;
> > -		printk(KERN_INFO
> > -		       "fbcon_init: disable boot-logo (boot-logo bigger than screen).\n");
> > +		pr_info("%s: disable boot-logo (boot-logo bigger than screen).\n", __func__);
> 
> Shouldn't this be:
> 		dev_info(info->dev, "...");
> instead?
> 
> It's a driver, and you have access to the struct device that is being
> worked on, so always try to use the dev_* versions of these calls
> instead when ever possible.

Ah, I see. I'll fix them in v2, thank you!

Peilin

