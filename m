Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B8BC43334
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 22:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiFYWd6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWd6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 18:33:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A99BF56
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:33:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so11588155ejc.10
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hBhJptopoTkt6ik5tFgrjRtOgxZF1EOY7K3onbFGODg=;
        b=GcpGUjyJt1mtMIbKTGYeFOq/rVS+KwFN1oIuATyVxolgJPEy8jQPYDVWF7CWKGw97d
         xj5k/eRTfEGGIdTtY1iSEGivgMB+dgY22CM3KH8g7shKuz2obeWpqeu96+dVhMpADsvo
         m+/513CeU+rqE2GI/2JEsRiKzAPZeZQGGe46o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hBhJptopoTkt6ik5tFgrjRtOgxZF1EOY7K3onbFGODg=;
        b=qiQJm/uxCI7xQoSMQ3xFWzI2G+CBXk7RXU3QmYyEeds5jTLfdH2ZhMn8BrOlbW5Bbd
         xoh8FUos6zAwpDKB7pJQX5ooKYFlEFc63DIzZX3hbH2d7utRJEiUZ0CLXIdI6w9L7zsE
         vofYbsvrk+GPJe22IAXz/eMSImQwfU2qNUImA5BiVd2fEt/P1ZSucDhGK176xQ4UIP7m
         +be2b3odhqd/gSKatyp2ZRgK2bFec3X6kLvmMaABLEVGHekkCTR7pzlvant2tjqOINPn
         a7lKOIiipdwcAlzxfjkuSHULQWFg4M9jZDvhNbtyXue3C/uAe8eZ5de6r/frViW+a3mE
         AhEw==
X-Gm-Message-State: AJIora9gqTLVTmWxnpDY5PqwafzsrAeNB4ksQ8k/YgNKpxwGHagfxxP/
        Ww/QLGlCjqrAxJpCAagtG91Dow==
X-Google-Smtp-Source: AGRyM1trmZhTJbRK7mEkbfjEoaY4QE+COls9DqPPUCbjYE+dWCi5Kcc0m5DUpCVAadzHrUeBy/u+4g==
X-Received: by 2002:a17:906:7a0e:b0:722:e8ce:8c7f with SMTP id d14-20020a1709067a0e00b00722e8ce8c7fmr5684755ejo.405.1656196435810;
        Sat, 25 Jun 2022 15:33:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p27-20020a1709060ddb00b00722e559ee66sm3023824eji.62.2022.06.25.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:33:55 -0700 (PDT)
Date:   Sun, 26 Jun 2022 00:33:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fbmem: Check screen resolution change against
 font size
Message-ID: <YreNUfv8d9QeJT8C@phenom.ffwll.local>
References: <20220625220630.333705-1-deller@gmx.de>
 <20220625220630.333705-4-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625220630.333705-4-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 12:06:29AM +0200, Helge Deller wrote:
> Enhance the check in the FBIOPUT_VSCREENINFO ioctl handler to verify if the
> user-provided new screen size is bigger than the current font size.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org # v5.4+

Please squash with previous patch. You might also want to add a note there
that on older kernels backporters need to open-code
fbcon_info_from_console instead, since it only exists since 
409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup")

With these two nits: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbmem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index afa2863670f3..160389365a36 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1106,7 +1106,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			return -EFAULT;
>  		console_lock();
>  		lock_fb_info(info);
> -		ret = fb_set_var(info, &var);
> +		ret = fbcon_modechange_possible(info, &var);
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
