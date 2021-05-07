Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B70C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 16:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786016144F
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 May 2021 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhEGQfj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 May 2021 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbhEGQfi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 May 2021 12:35:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D2C061574
        for <linux-fbdev@vger.kernel.org>; Fri,  7 May 2021 09:34:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x5so9878767wrv.13
        for <linux-fbdev@vger.kernel.org>; Fri, 07 May 2021 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O99QLS/XuXmi5sOenN2CFxQz7Q5z0xeHfl0XAzi4THc=;
        b=U+IByuCcxULK3nxRVkk7JSImKY8trLGHWZcfLZTgiCNxRgComAbd5SB0Cfj6jYZ996
         9lS6uV6uHIiiE4JuSIZxyPiEFBQLgBWjXWWpjAxbl8UM05Asr4O0C2J4hfCVuPJJkeXk
         Lp1lfV5LSbB4AJ6q9iEoC6lTzRO2xg0DHZElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=O99QLS/XuXmi5sOenN2CFxQz7Q5z0xeHfl0XAzi4THc=;
        b=uZ90FzBbAuLvXjTJcxjtNvJiA5O+XPcAqWNt6ZXwkpCd+dCD+G8gaHROvG44qqflWG
         A63Hh2oE0f9B6A3k8Rokf8+SfPsltebZqsiiPATvsUVmd5TWrlfxpX0tkcFuYJpNKTrP
         CSaqq8LK/f4Z3iLSR+x1/Zycsf68yOHrh4iTjGJ1OoV8YVSmnQ/kjOmaWDPjXFGOcjN1
         ChqbDiOL54rFH0HH2/R2mB0xt16Od5XJDXwi11hui13cFWjHQc0rcIfMdNwJZbFo0xcT
         SX+5Diip2NmHNhJ3AE8A/QgEfr+QyHoI13sK+aR7vSNxDgpu7nNFdIdHIoupZgim5VZs
         uPRg==
X-Gm-Message-State: AOAM533lW2qWmi0dhLIxJUNPYo4RAkSrLfhJ7AsQe+I8NfM+IxwpfKJX
        g+NH0JU83TIrMOo+DEHsO+onrQ==
X-Google-Smtp-Source: ABdhPJz9eV+VjyShaXPfAx4WvqHMrnt9SIWVOMU/ZLtthyBfUy5zg6ri6iuFlihrahEEp1TfX0GW8g==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr13620583wru.16.1620405276947;
        Fri, 07 May 2021 09:34:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r2sm8702898wrt.79.2021.05.07.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:34:36 -0700 (PDT)
Date:   Fri, 7 May 2021 18:34:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
        krzysztof.h1@poczta.fm, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, j.beisert@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] video: fbdev: imxfb: Fix an error message
Message-ID: <YJVsGn4+rbh0+b+I@phenom.ffwll.local>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel-janitors@vger.kernel.org,
        krzysztof.h1@poczta.fm, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, j.beisert@pengutronix.de,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <d7b25026f82659da3c6f7159eea480faa9d738be.1620327302.git.christophe.jaillet@wanadoo.fr>
 <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507050503.iwrcis2xzhjjthmp@pengutronix.de>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 07, 2021 at 07:05:03AM +0200, Uwe Kleine-König wrote:
> Hello Christophe,
> 
> On Thu, May 06, 2021 at 08:57:05PM +0200, Christophe JAILLET wrote:
> > 'ret' is known to be 0 here.
> > No error code is available, so just remove it from the error message.
> > 
> > Fixes: 72330b0eeefc ("i.MX Framebuffer: Use readl/writel instead of direct pointer deref")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/video/fbdev/imxfb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > index 7f8debd2da06..ad598257ab38 100644
> > --- a/drivers/video/fbdev/imxfb.c
> > +++ b/drivers/video/fbdev/imxfb.c
> > @@ -992,7 +992,7 @@ static int imxfb_probe(struct platform_device *pdev)
> >  	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
> >  					   &fbi->map_dma, GFP_KERNEL);
> >  	if (!info->screen_buffer) {
> > -		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
> > +		dev_err(&pdev->dev, "Failed to allocate video RAM\n");
> >  		ret = -ENOMEM;
> >  		goto failed_map;
> >  	}
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for patch& review, queued for 5.14 in drm-misc-next.
-Daniel

> 
> Are you using this driver, or did you find that problem using some
> static checker?
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
