Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77321C43334
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Jun 2022 16:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245087AbiFHQGZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Jun 2022 12:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbiFHQGX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Jun 2022 12:06:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BDC157E9A
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Jun 2022 09:06:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so2727627wra.5
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jun 2022 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f70pptS+xBg2CCCgan9PBj/rQScjEyEBNBHzw4u7T+M=;
        b=G8dainAqSuOzPpJ0LR2ObVifZj+zgdtQvoc9b6KW4tzLjS/TuALChyR6jn/l+/AJ2k
         4qG4pWjFRjQTX68/VMC2PJcjFXvsDg/ad9qBAl7R2iXZI5p/DF8wj1h1Ymzkwv0PA7op
         oDXWQmZDciozgT5/sYW47/o6q3aWv45yJrA48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f70pptS+xBg2CCCgan9PBj/rQScjEyEBNBHzw4u7T+M=;
        b=ON4vAMAHLinFEQEzeXq3hanYXwitZt5n/DU7DDkOtgZ9g0rw0UW3WAXNod6Xjj92Xn
         aeq9u9iwRK4Enr309qY6w5tOPb1hq1nV5i2dszv+PpHU6Vs7EmMB0YyeB8LLu87mDaDk
         kvrF70auXGUjEham8dhDdjS3k8G16lLefAuQW+Q+SyD4KTir8JbXuMiBhQhvDHvQCgTG
         4cwHeiOY/xDerSRxZ6Av5jieefbUFEBLiWijbL7xFhH61EbUj0KeRsiEgUFi0y9dqq7o
         B5GKxbhlf2jWU42Q7qJ8Qnu1jx7Hak0OgkGKp92IF1+vDYrEqY47n5R+49GAJxc7OORS
         U/UA==
X-Gm-Message-State: AOAM533lWusYyqsVcH24XQ/WbD8njtQ8aWofiVERFNbrUaqLUWMZUYGG
        L1h7SnUq86rAV26lc1e87YdaU/3JfAAyJQ==
X-Google-Smtp-Source: ABdhPJx0LLxtq0K5T1lDWAZYUIb+TL9w1aQT7edWeF2JevtQ3nbfvXxsk2DorEaIlat83geLiaoWPw==
X-Received: by 2002:adf:d222:0:b0:213:7fbe:5f58 with SMTP id k2-20020adfd222000000b002137fbe5f58mr31189264wrh.220.1654704367685;
        Wed, 08 Jun 2022 09:06:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4483000000b0020fcc655e4asm21834684wrq.5.2022.06.08.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:06:06 -0700 (PDT)
Date:   Wed, 8 Jun 2022 18:06:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: Fix boundary checks for fbcon=vc:n1-n2 parameters
Message-ID: <YqDI7XpDSS6hc2L1@phenom.ffwll.local>
References: <YpkYRMojilrtZIgM@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpkYRMojilrtZIgM@p100>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jun 02, 2022 at 10:06:28PM +0200, Helge Deller wrote:
> The user may use the fbcon=vc:<n1>-<n2> option to tell fbcon to take
> over the given range (n1...n2) of consoles. The value for n1 and n2
> needs to be a positive number and up to (MAX_NR_CONSOLES - 1).
> The given values were not fully checked against those boundaries yet.
> 
> To fix the issue, convert first_fb_vc and last_fb_vc to unsigned
> integers and check them against the upper boundary, and make sure that
> first_fb_vc is smaller than last_fb_vc.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 2fc1b80a26ad..c2f9e5711c39 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -115,8 +115,8 @@ static int logo_lines;
>     enums.  */
>  static int logo_shown = FBCON_LOGO_CANSHOW;
>  /* console mappings */
> -static int first_fb_vc;
> -static int last_fb_vc = MAX_NR_CONSOLES - 1;
> +static unsigned int first_fb_vc;
> +static unsigned int last_fb_vc = MAX_NR_CONSOLES - 1;
>  static int fbcon_is_default = 1;
>  static int primary_device = -1;
>  static int fbcon_has_console_bind;
> @@ -464,10 +464,12 @@ static int __init fb_console_setup(char *this_opt)
>  			options += 3;
>  			if (*options)
>  				first_fb_vc = simple_strtoul(options, &options, 10) - 1;
> -			if (first_fb_vc < 0)
> +			if (first_fb_vc >= MAX_NR_CONSOLES)
>  				first_fb_vc = 0;
>  			if (*options++ == '-')
>  				last_fb_vc = simple_strtoul(options, &options, 10) - 1;
> +			if (last_fb_vc < first_fb_vc || last_fb_vc >= MAX_NR_CONSOLES)
> +				last_fb_vc = MAX_NR_CONSOLES - 1;
>  			fbcon_is_default = 0;
>  			continue;
>  		}

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
