Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75087C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 12:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiFYMqB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiFYMp7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 08:45:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E3E167D8
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 05:45:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 189so2223473wmz.2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y70bEuRHOkxxUZ0wqjxpIYT5Q0JSpCuiukC2RrSqg7g=;
        b=Tcu42CE0/ZmVde99u1BY1z0/lJj5YDCMHJuRQRaMVPM8qJesrGmAuwBa9861K6OM5G
         89k1V/goOLRzO0rzXGVFPve8x1FEwQar2kVCLWCxos005889+K5jRuc0apg0MJ8OJcWw
         FhRsfeiKKjuy2q9H5NNAQOzZUYSXR/1YpDwAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y70bEuRHOkxxUZ0wqjxpIYT5Q0JSpCuiukC2RrSqg7g=;
        b=SrNOlwvN2TezaRHNaJgaxtI+zohVeHgiJ4Fg/JXjG823rasSZIaBJnhyT3zYmRMP8e
         xB3eRg0F9k0TMLwL1frnHuRUoGku8r+IeJkFLPidf3cNDmz908GeWNnYXAFzAfHC8H6a
         CQb1aIdaYFqHsnoqnSRnip05LWTSoHqdDupwtPiRfqx/hh1j3GOCvjlXj/OgO3CjQSoy
         tVZlO0CcxfpfsZlhrIT5iZy6R6DJPeBbRBEv+xdbyY3KQ/fVk5/5NuW3+0aqGbXK0xn6
         Gc/20VXVV4Tjn7MK0TBThayUxwaEKMO34C10zAxwI1TY1MG8MCXjdainuQXUJXIiAuUN
         OQ2w==
X-Gm-Message-State: AJIora++nb66mvBXmMiBSSEbaXQBzudyBoFnRBxS3AlM1sXmJ4LdTIf/
        qzCOKmF++cQw6g8Snx9cG79XGpzpBoRXLQ==
X-Google-Smtp-Source: AGRyM1v6xW+A+MlXOW5DqxzeePWfJRGMwxlPH88PAxgwKhE6ciVzFhoxZsjPPO+UKQum8gYyezWRHA==
X-Received: by 2002:a7b:c017:0:b0:3a0:355d:a965 with SMTP id c23-20020a7bc017000000b003a0355da965mr9003857wmb.173.1656161156433;
        Sat, 25 Jun 2022 05:45:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003942a244f40sm10736813wmq.25.2022.06.25.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 05:45:55 -0700 (PDT)
Date:   Sat, 25 Jun 2022 14:45:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/4] fbcon: Disallow setting font bigger than screen
 size
Message-ID: <YrcDgjpgeqSZtSOE@phenom.ffwll.local>
References: <20220625122502.68095-1-deller@gmx.de>
 <20220625122502.68095-2-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625122502.68095-2-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jun 25, 2022 at 02:24:59PM +0200, Helge Deller wrote:
> Prevent that users set a font size which is bigger than the physical screen.
> It's unlikely this may happen (because screens are usually much larger than the
> fonts and each font char is limited to 32x32 pixels), but it may happen on
> smaller screens/LCD displays.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v4.14+
> ---
>  drivers/video/fbdev/core/fbcon.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c4e91715ef00..e162d5e753e5 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2469,6 +2469,11 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
>  	if (charcount != 256 && charcount != 512)
>  		return -EINVAL;
> 
> +	/* font bigger than screen resolution ? */
> +	if (font->width  > FBCON_SWAP(info->var.rotate, info->var.xres, info->var.yres) ||
> +	    font->height > FBCON_SWAP(info->var.rotate, info->var.yres, info->var.xres))
> +		return -EINVAL;

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Maybe as a safety follow up patch, we have a few copies of the below:

	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
	cols /= vc->vc_font.width;
	rows /= vc->vc_font.height;

Might be good to extract that into a helper and also add

	WARN_ON(!cols);
	WARN_ON(!rows);

to make sure we really didn't screw this up and give syzkaller et all an
easier time finding bugs - it doesn't need to discover the full exploit,
only needs to get to this here.

Also maybe even check that cols/rows is within reasons, like smaller than
BIT(24) or so (so that we have a bunch of headroom for overflows).

Anyway just an idea.
-Daniel

> +
>  	/* Make sure drawing engine can handle the font */
>  	if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
>  	    !(info->pixmap.blit_y & (1 << (font->height - 1))))
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
