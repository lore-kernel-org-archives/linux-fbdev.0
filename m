Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A4C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 May 2022 13:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiEENGG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 May 2022 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiEENGF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 May 2022 09:06:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAF532D0
        for <linux-fbdev@vger.kernel.org>; Thu,  5 May 2022 06:02:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so8587756ejb.8
        for <linux-fbdev@vger.kernel.org>; Thu, 05 May 2022 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOm9C+H5cCzRKeEZrFMRYiRqzZ6UOwUcjZY2tv0sRpc=;
        b=Kxw8nwKJ8DvGjh9azZysybfe83qaqPbJNMBImiHRRShDE9cAQIVUPwpNRzMYyqJDWn
         dsRQVs0f6iLibcVuVSZkqpqhNIFiDlD3wJgApXaHgV2OLHQUNm6UMFbpquj9a984Ath2
         YYzt5AvkVS0kW+QS7oh5lGjcn6amGHjvw2cFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BOm9C+H5cCzRKeEZrFMRYiRqzZ6UOwUcjZY2tv0sRpc=;
        b=7nWAQNs4zlny4Zqp7a1IXQy7zLlmCe1k85mEox/IkJ+Dett7cG9zkjTs8yq6qMCePK
         xbtVXOc7UgwgDAkR2/a3MFnfSc3XulDPFDqglFdcZGIdCsMXXZAoDbJunvJyKC0CJsgV
         vGJfxKi2/oMoIAJy4GBaB8jz3x/8e5RFAo1ZnmsnFvEaNzyyJlujCECMUCNs7bbbA7yN
         0kg8Y3p7LI2GHUMQaEPC4hs6sRIzLNeXLmAhnJ8mx1stRULY7MwmXx7+yvPBFdBPYtsp
         3lj6pLp9AmG0a8DexwvZsfs07xw96wfen6RbSy5ranoJ8IG9B+7sh1x/MTB42zXEdMe3
         X/HQ==
X-Gm-Message-State: AOAM531xdW9d7jVG6Px779WRVflthm+Le0r4HLo6kOal9UZBFmTAE/FI
        otCgRLgke6UIbD39+V2X9mf5oNVyuhqptA==
X-Google-Smtp-Source: ABdhPJztrJUrelAEmEd/ZSyj3JbJlOid+Hsdae80sL28sjz9o0jSUsQ4xsro3xCtUCPLNWG8pnxaUA==
X-Received: by 2002:a17:907:3f86:b0:6db:b745:f761 with SMTP id hr6-20020a1709073f8600b006dbb745f761mr25395823ejc.610.1651755744294;
        Thu, 05 May 2022 06:02:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b006f3ef214da4sm767144ejl.10.2022.05.05.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:02:23 -0700 (PDT)
Date:   Thu, 5 May 2022 15:02:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy
 rather than .remove
Message-ID: <YnPK3RLPdtvFze+8@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220505113128.264963-1-javierm@redhat.com>
 <20220505113128.264963-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505113128.264963-5-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, May 05, 2022 at 01:31:27PM +0200, Javier Martinez Canillas wrote:
> The driver is calling framebuffer_release() in its .remove callback, but
> this will cause the struct fb_info to be freed too early. Since it could
> be that a reference is still hold to it if user-space opened the fbdev.
> 
> This would lead to a use-after-free error if the framebuffer device was
> unregistered but later a user-space process tries to close the fbdev fd.
> 
> The correct thing to do is to only unregister the framebuffer in the
> driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
> Changes in v2:
> - Also do the change for vesafb (Thomas Zimmermann).
> 
>  drivers/video/fbdev/vesafb.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index df6de5a9dd4c..1f03a449e505 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -179,6 +179,10 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
>  	return err;
>  }
>  
> +/*
> + * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
> + * of unregister_framebuffer() or fb_release(). Do any cleanup here.
> + */
>  static void vesafb_destroy(struct fb_info *info)
>  {
>  	struct vesafb_par *par = info->par;
> @@ -187,7 +191,13 @@ static void vesafb_destroy(struct fb_info *info)
>  	arch_phys_wc_del(par->wc_cookie);
>  	if (info->screen_base)
>  		iounmap(info->screen_base);
> +
> +	if (((struct vesafb_par *)(info->par))->region)
> +		release_region(0x3c0, 32);

This move seems rather iffy, so maybe justify it with "makes the code
exactly as busted before 27599aacbaef ("fbdev: Hot-unplug firmware fb
devices on forced removal")"

Also same comments as on v1 about adding more details about what/how this
fixes, with that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
>  	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
> +
> +	framebuffer_release(info);
>  }
>  
>  static struct fb_ops vesafb_ops = {
> @@ -484,10 +494,8 @@ static int vesafb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  
> +	/* vesafb_destroy takes care of info cleanup */
>  	unregister_framebuffer(info);
> -	if (((struct vesafb_par *)(info->par))->region)
> -		release_region(0x3c0, 32);
> -	framebuffer_release(info);
>  
>  	return 0;
>  }
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
