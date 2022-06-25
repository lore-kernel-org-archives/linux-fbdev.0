Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C01C43334
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 12:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiFYM4u (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiFYM4r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 08:56:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E551836F
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 05:56:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ej4so6936424edb.7
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hkKJBvAKbR3BnoO9kk6/tqR9cWYvLJ3iSW/K1h/KF1E=;
        b=RHHKT+fXGjhwpRyX6AHgXDATSzGDIT/vgxg9YVeJMXQ8IxgLGuE7q6B46HZpw0a2eA
         tJgQyWkMzLxUfMEtcKcmYGM3QwwsTeH0jSTcnY7OvSn3EOxZhCHluRGy+za/ipDRWk3M
         628rBJifSeraDGtLOaqu8EGctLUsfAoCgS3qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkKJBvAKbR3BnoO9kk6/tqR9cWYvLJ3iSW/K1h/KF1E=;
        b=X8i9oT9hHvchaV2mw/nA7u8+04A5we797Kr3dZnk2XF+0Q3a5q2xyu5HAcjI/ZpfHb
         CVXPC3arrNbAjIRTIuxZEX0D/FCQPCsKyVrYuRZ/ZzspxeHqw9Vy1lHlUXSODmAw00kl
         NAeymxsDKPS+w+RaeJgkfXGLFcU5zeZyXS4eq0AWXIfhVTrGLIpNjm//SjOmm+PI3TMK
         zYntvU5Qqs7vfxMdmdb8cZ09wQ4EiKZKEEBy65ektGGNSJswv3YK08/P8hr3leNmKVMV
         Q5dM18kFF8sNoM8XV/h1fVPHVRaDDU8r7TO/9ueykt5oh+F/+xHulXejr41WC5v1g7t+
         H2Ng==
X-Gm-Message-State: AJIora8aA49HYS7KgjKGqoNl2pJ3H3I1e4sg/nke0d6hOmqLN/h1ZM55
        KTzgu9fQtKmHpJgLQoks3/4f2w==
X-Google-Smtp-Source: AGRyM1uSAAamV4LD6qgErK2aTyULcJd7bFHRZNBzNi3jWmOUJzxiN5iHdDWB45PCqN31cGuZ0fu2kQ==
X-Received: by 2002:a05:6402:4244:b0:437:726c:e1a with SMTP id g4-20020a056402424400b00437726c0e1amr2257718edb.107.1656161805069;
        Sat, 25 Jun 2022 05:56:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m18-20020a170906235200b006fee16142b9sm2568993eja.110.2022.06.25.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 05:56:44 -0700 (PDT)
Date:   Sat, 25 Jun 2022 14:56:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 3/4] fbmem: Fix input parameter checks for
 user-provided screen resolution changes
Message-ID: <YrcGCkHuWHv3I6Fx@phenom.ffwll.local>
References: <20220625122502.68095-1-deller@gmx.de>
 <20220625122502.68095-4-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625122502.68095-4-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jun 25, 2022 at 02:25:01PM +0200, Helge Deller wrote:
> Enhance the checks in the FBIOPUT_VSCREENINFO ioctl handler to verify
> the user-provided new screen size for:
> 
> a) virtual screen size >= physical screen size, and
> 
> b) new screen size is bigger than currently configured console font size.
> 
> Return -EINVAL on invalid input.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Imo squash this into the previous one please. Doesn't make sense to split
the patch which adds a function from it's callsite.
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index afa2863670f3..50fb66b954d6 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1106,7 +1106,13 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			return -EFAULT;
>  		console_lock();
>  		lock_fb_info(info);
> -		ret = fb_set_var(info, &var);
> +		if (var.xres_virtual < var.xres ||
> +		    var.yres_virtual < var.yres)
> +			ret = -EINVAL;
> +		if (!ret)
> +			ret = fbcon_modechange_possible(info, &var);
> +		if (!ret)
> +			ret = fb_set_var(info, &var);
>  		if (!ret)
>  			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
>  		unlock_fb_info(info);
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
