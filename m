Return-Path: <SRS0=r1i4=D2=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9EFC433E7
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Oct 2020 15:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5BB222B9
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Oct 2020 15:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LauR/Atw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgJSP4Z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgJSP4Z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Oct 2020 11:56:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DEBC0613D0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2020 08:56:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n15so334027wrq.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2020 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ExyTIzaV0pr3Eai44qIOEkkWvYQoFZOO2NPesnlxaJg=;
        b=LauR/Atww+62lrIAoI0S2aXFYC3jXL8fwHGmpYG11gT0kpCJSlFHUFXzKtkFAV4O0P
         HgNhi4Xzc7LNZ86YW6xp2qpqxF9fUjmU3Sww/YmAaNfW8lzaxOhMfDssyPcFYnBMQloE
         zTbV1d/w/3aqdvChRUejuygCo/WdvsgMuPWKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ExyTIzaV0pr3Eai44qIOEkkWvYQoFZOO2NPesnlxaJg=;
        b=mSSqmTCtohbY/H9Uvrbu2ecJH7nHFYXmWhtsWG2o/mdwCMa+b42rJ9Dx3JFUga7Slg
         Ipdqrcq8ShAzkfA/iCQH/KcJe7XitVkAtkq9eBU43/rcATNy3qi9VybBfY1J6dKWpKU6
         X+YFmh3gMMOtxMm3hV/RMx8MO2fRN6/evHrtfAfRUxHF9/Na5ABx74gVeWp6faN4bm35
         nVch/7Z3T/z5Cx2wsuYmZ6IA7ObGNuZE+YrBEXKcCHaQxuiSQg+bUy+G/j1EX+y+2l6n
         /RHlt5FUcbhwp9sxmFc8Z0HkSnp7WLw+N+Gu6/xI+MERC/gc+NGySbAbohBnpT0eJvB+
         0gsQ==
X-Gm-Message-State: AOAM5322RY0qeFEFRy5PmLCGKZQ5HSF7bq2WMFjer0VjCgfJvrh9afCb
        i+89js/zzPcwG9u7vH5owYG4Tg==
X-Google-Smtp-Source: ABdhPJwXRObsL8ejRw2Heh5XRu+rRn4ydix5fTKFeZYFLvSwm2ojMD2la1MO54JxNhao+Rk9S4EHZg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr257359wrn.96.1603122982550;
        Mon, 19 Oct 2020 08:56:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w11sm191745wrs.26.2020.10.19.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:56:21 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:56:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 RESEND] docs: fb: Add font_6x8 to available built-in
 fonts
Message-ID: <20201019155619.GH401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
 <20201018205401.698242-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018205401.698242-1-yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201019155619.msqKKD0b-WuAbYC57BsB1Z7ioYnCQCaC4Qlh-6Vwl3U@z>

On Sun, Oct 18, 2020 at 04:54:01PM -0400, Peilin Ye wrote:
> Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
> font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
> list.
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Resending +Cc: dri-devel, sorry if I spammed.

Both this and patch 1/2 with the actual bugfix merged to
drm-misc-next-fixes, should still make it into the merge window before
-rc1.

Thanks, Daniel

> 
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index 9aad964b767c..57f66de2f7e1 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -81,7 +81,7 @@ C. Boot options
>  1. fbcon=font:<name>
>  
>  	Select the initial font to use. The value 'name' can be any of the
> -	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> +	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
>  	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  
>  	Note, not all drivers can handle font with widths not divisible by 8,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
