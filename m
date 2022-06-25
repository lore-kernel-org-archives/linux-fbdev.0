Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF68C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 13:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiFYNDh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiFYNDg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 09:03:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A104186D2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 06:03:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so6983976eda.2
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6iZZ7vb8HcEclFbDefWv18SEXCTkKAWPzBSVLelIquE=;
        b=UBpQsJdQuBZF3cvPGaLHk6leljCnA04lkmNNRyvk0G3d9Bl6WG5ZiIL0LB4p9SZuu3
         5VQIYOC+r2VaPb9yKd9sj674XlhWIXLc5jl90nGv6sph5eftwmDx4hqCBFPmIZqPfsKw
         XwzNirZyxqJFewfmhGBBHxAILcew7ZCD8Wd4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6iZZ7vb8HcEclFbDefWv18SEXCTkKAWPzBSVLelIquE=;
        b=cDY7agtrby52xYRCCf2uMR1nn3FI+29vfyGgwF5FMDmBoLB9+RXlsvQTTe33kIBpaQ
         R0+6J9DxlYhdO+mQf2q1Z7CCIYfvC1MP3+1Y4xUyw2vcx9vSAxxmDjYaqa8LliHfUB6F
         hxEMkSTBm6NT2LQVk0xA1T5ymaVfpgLuSppjgufde/u2mA4pt23sVuZN7Pfu8hPSZd6b
         bWkdsSDiRs8HIspcJjWq3dNBKTlg0KUxu1BnvgeflnjFJ0R8dz5cNcABeMB+3o6CeR5R
         dfLRcPi6V2gs6h67q99cuY1Ycpy9XUHucglTJlvdZ8axU+MuRIP6KgqBHmckBeHybVD5
         I0hg==
X-Gm-Message-State: AJIora9d/pqGjELqreQm7IKF28KAsDjd/yKHFzs4GTrL4YCcmprHCJqI
        1wajHplo0+jhlNIP5hUNxNHZ5A==
X-Google-Smtp-Source: AGRyM1uVnMKCKS1HZvDVMswZ6auQuPGJdfTvzPlFdW+2PYBnqkccdaaS3FXem8EGY9KlnhJkYTma9w==
X-Received: by 2002:aa7:c352:0:b0:435:7fbd:90b9 with SMTP id j18-20020aa7c352000000b004357fbd90b9mr5032745edr.139.1656162213948;
        Sat, 25 Jun 2022 06:03:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id op23-20020a170906bcf700b0070aaad0a173sm2586212ejb.192.2022.06.25.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 06:03:33 -0700 (PDT)
Date:   Sat, 25 Jun 2022 15:03:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] fbmem: Catch possible driver bugs regarding too
 small virtual screen size
Message-ID: <YrcHo5dEaROdWMjo@phenom.ffwll.local>
References: <20220625122502.68095-1-deller@gmx.de>
 <20220625122502.68095-5-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625122502.68095-5-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jun 25, 2022 at 02:25:02PM +0200, Helge Deller wrote:
> Make sure that we catch, report and fix up fbdev and drm graphic drivers which
> got the virtual screen resolution smaller than the physical screen resolution.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

No cc: stable for this, it's not fixing any bugs just helps validate
driver code.

Also if you just move the check from the ioctl code to here we don't need
to duplicate anything (and drivers which don't check their set_var are
kinda busted no matter what).
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 50fb66b954d6..6d262e341023 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1006,6 +1006,12 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
>  	if (var->xres < 8 || var->yres < 8)
>  		return -EINVAL;
> 
> +	/* make sure virtual resolution >= physical resolution */
> +	if (WARN_ON(var->xres_virtual < var->xres))
> +		var->xres_virtual = var->xres;
> +	if (WARN_ON(var->yres_virtual < var->yres))
> +		var->yres_virtual = var->yres;
> +
>  	/* Too huge resolution causes multiplication overflow. */
>  	if (check_mul_overflow(var->xres, var->yres, &unused) ||
>  	    check_mul_overflow(var->xres_virtual, var->yres_virtual, &unused))
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
