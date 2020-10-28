Return-Path: <SRS0=wnYw=ED=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6182DC388F7
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A41207BC
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F0MCnNXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgJ1WvE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732683AbgJ1Wse (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Oct 2020 18:48:34 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A7C0613CF
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Oct 2020 15:48:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v6so819251lfa.13
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Oct 2020 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=nMCdu9Rzb/ndcD48Tcjh9B2LFonFTQlfv9eH4WIE5/E=;
        b=F0MCnNXxvfO8m+8X6ysd9pz9RNST9ee2OunsJBFhJ1jACU0VNPR7jRqTcr42Em1B/N
         4RkfEXr/avMA+O9xcQ2WiJud6Px7h8GMje+np40dqlpRDSKXgimNhQtHUuAPltPhyb11
         5fbAF7gudEUJdH7kFcywq06bqCQv1F5USJd8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=nMCdu9Rzb/ndcD48Tcjh9B2LFonFTQlfv9eH4WIE5/E=;
        b=GoYggkyMwkHE+mRwOM2ZGWMGCL6ewHddaBZu4334e/kI3KSTFkKz3y2ASGo00dEo2X
         0rNAL/eS+L0ceTuGmYkPLKawt3u/OugNu2QAt//tlIDwfRt7IthvHt7/Ff8cPxzPnSzd
         KNIpYWDZu0zrXTKNT7ca49jqm4C9lRqiETL+Rh8eo9N3K4t7Rvarte009XI0rr8azLIR
         lbZLmsYzM7g+OIWhdAXc7ic3y/czC81ULc/PwZxv5Ict2fHVnN6CgiTORbXqHm2UCzLm
         QZmDWK9ikwbKsLxIJCmXvLTodK1AsU4NdvsYKakXHDveiYHprR1V0t/AeMOUnAnUhQX9
         Q3Zg==
X-Gm-Message-State: AOAM5307xVD7DkJoblEQjR/mpZ6CBPoykkMH5aKJdpxEhP428gFkLcjq
        1UGwdzupEC5SA/KHwDOQHTCzSctIvvY5e5Ot
X-Google-Smtp-Source: ABdhPJyrBDGD6E9I6oqu06SgLOB/cJ7qVsKtWh9rtNK4o2kg9zioPQMWZFyxGdfWYjPLun8Im926hQ==
X-Received: by 2002:adf:e685:: with SMTP id r5mr841525wrm.340.1603910429440;
        Wed, 28 Oct 2020 11:40:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f7sm597277wrx.64.2020.10.28.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:40:28 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:40:26 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-parisc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Fonts: Make font size unsigned in font_desc
Message-ID: <20201028184026.GX401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <20201028105647.1210161-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028105647.1210161-1-yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 28, 2020 at 06:56:47AM -0400, Peilin Ye wrote:
> `width` and `height` are defined as unsigned in our UAPI font descriptor
> `struct console_font`. Make them unsigned in our kernel font descriptor
> `struct font_desc`, too.
> 
> Also, change the corresponding printk() format identifiers from `%d` to
> `%u`, in sti_select_fbfont().
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Pushed to drm-misc-next, thanks for the patch.
-Daniel

> ---
> Change in v2:
>   - Mention `struct console_font` in the commit message. (Suggested by
>     Daniel Vetter <daniel@ffwll.ch>)
> 
>  drivers/video/console/sticore.c | 2 +-
>  include/linux/font.h            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
> index 6a26a364f9bd..d1bb5915082b 100644
> --- a/drivers/video/console/sticore.c
> +++ b/drivers/video/console/sticore.c
> @@ -502,7 +502,7 @@ sti_select_fbfont(struct sti_cooked_rom *cooked_rom, const char *fbfont_name)
>  	if (!fbfont)
>  		return NULL;
>  
> -	pr_info("STI selected %dx%d framebuffer font %s for sticon\n",
> +	pr_info("STI selected %ux%u framebuffer font %s for sticon\n",
>  			fbfont->width, fbfont->height, fbfont->name);
>  			
>  	bpc = ((fbfont->width+7)/8) * fbfont->height; 
> diff --git a/include/linux/font.h b/include/linux/font.h
> index b5b312c19e46..4f50d736ea72 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -16,7 +16,7 @@
>  struct font_desc {
>      int idx;
>      const char *name;
> -    int width, height;
> +    unsigned int width, height;
>      const void *data;
>      int pref;
>  };
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
