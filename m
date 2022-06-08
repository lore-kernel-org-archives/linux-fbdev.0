Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDAC43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 16:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbiFHQlD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245582AbiFHQlC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 12:41:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD5F0717
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 09:41:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so18731218wra.1
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4KALtjBBT08O9f+W5oEVbO7yUQhwk75FRj0E2UhZnuc=;
        b=B5Zg3XIkQ6j/FDkQy1jOteslSh3gNT5GmdEr/237BWBZiVNNqq7D345YLl0kMTCNln
         P1n/8QmUhkUUmlyiQMLQbG+BPe5WZsml8SvuwUt6uv68QY7XiEVlBL6FlqA8cK0O9VOg
         M0l9SKxRQ2utlaPJgl9VpIJHEcmW+qRV/ueqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KALtjBBT08O9f+W5oEVbO7yUQhwk75FRj0E2UhZnuc=;
        b=iIxIN2LBAakCDkWMi6s6YN14vUOT0XX8DQQmLU7S4wVXBh2rIgxzHty0HctLpUcGXO
         a7l9/8zzd0SanWROuu7Uz/A3ifd4r5vTxerRGGT/KBOnDUoMXkjxOZXQGg6f8/+T84Rr
         5I7edgRA7po2IOJTn9YDkJI5XsYCk7lGJkBT2OQ2ML8pcixxMPolvksDIPBrsWtw7C2c
         ksMARJJuct4YY7G08k+RS4ttg+i+QZXafUQXTlNlN0voW6p+M3sspAsU+fncVf1Ij1jL
         KLBgfgw11LBaMjWf8Rn/Lm015cr/h2H1ZG1Ihofcq8CxRPlnTExF+xY9D8CIddiBoVON
         6jVg==
X-Gm-Message-State: AOAM532eYQYnuhdUkhoW3e8g9zYI/jFlqMu1rSc/kLYe6TyD4dY6LNnk
        ulHgwDizEPBzq+nZvBfjN50hnQ==
X-Google-Smtp-Source: ABdhPJySw0YXyJN2Dkkyfzo1EfPGQryvgBGuPdH2UDIEf43gsm4hA6IhEX0HCUAjxwSI2SpgTEnu1w==
X-Received: by 2002:adf:fa03:0:b0:210:dcda:ee82 with SMTP id m3-20020adffa03000000b00210dcdaee82mr33745633wrr.139.1654706459449;
        Wed, 08 Jun 2022 09:40:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003973ea7e725sm37090494wmq.0.2022.06.08.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:40:58 -0700 (PDT)
Date:   Wed, 8 Jun 2022 18:40:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: Remove obsolete reference to initmem_freed
Message-ID: <YqDRGRFbATkhhZFv@phenom.ffwll.local>
References: <b8b9147a48e233fe32e072f2085c7b413cd92a00.1654702835.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b9147a48e233fe32e072f2085c7b413cd92a00.1654702835.git.geert+renesas@glider.be>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jun 08, 2022 at 05:41:16PM +0200, Geert Uytterhoeven wrote:
> initmem_freed was removed in v2.1.124, and the underlying issue was
> fixed for good in commit 92b004d1aa9f367c ("video/logo: prevent use of
> logos after they have been freed").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

So I got totally lost in late_initcall_sync trying to figure out whether
there's any fun races against driver load, and I guess as long as you
don't manage to hotplug an usb display link at just the right time this
works.

But also that's all just the existing logo.c code, so pure distraction.

Thanks for your patch, pushed to drm-misc-next.
-Daniel

> ---
>  drivers/video/fbdev/core/fbcon.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 594650452afd14d8..1be8aa9f80747987 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2180,7 +2180,6 @@ static int fbcon_switch(struct vc_data *vc)
>  	if (logo_shown == FBCON_LOGO_DRAW) {
>  
>  		logo_shown = fg_console;
> -		/* This is protected above by initmem_freed */
>  		fb_show_logo(info, ops->rotate);
>  		update_region(vc,
>  			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
