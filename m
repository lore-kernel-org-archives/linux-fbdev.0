Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED0C43217
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347746AbiEDJvn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbiEDJvk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 05:51:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF55F26562
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 02:48:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq17so1830446ejb.4
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YZq9atGlvwHL4dEwvj0CopnhgDQAd2ZXRzQtho9D+5A=;
        b=WFGXkkMXffbA0qaSs2B1o7KhHe69J7OK8AO7HEqxqma2bxjtuy7uFumM7kW0j8qb6f
         YCqSmuDHJ3DBZ/x1l5suMvMcBLzdFlDMru7ZL4S85Pftc04ka3blyXccxtWM/P4MaanM
         5W3KFYRc/7w5EsXKQiEz49k7ou2n3UlIBD61A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YZq9atGlvwHL4dEwvj0CopnhgDQAd2ZXRzQtho9D+5A=;
        b=Kvmsq76xN47isA8aySP6dVyMHkbB1kEQJwvdYgLlhb69X5tFeDvrNsPRwIG5SBZJaZ
         TaB6Kp5SToJ5SGhOImCnrBroii+DW3BgYPFlI7Ev7HdDIJ/Gk2t7fA+lwHqz231nSpHE
         0wwu4omGtJ62Aj7+5yDRyZjH3nQuL1qtuMMeak9zSdzFuvfLy4wIYYeGtHNgxh0rv0tH
         jmRV+ly30X9X1zI7JqciJp4CSAAAMC3otkEm8WatCWKZGoMzjcDVrqbOFFF4PtyPS+L+
         m3yiAeuCTbuu+2dVLnE5YOaPHrNIj3tAYoPadmMcxdBe/qjuwIOLuSpW0ZsxD1uAqGqo
         Ih1g==
X-Gm-Message-State: AOAM531vec9w1I/2YxA7vhG2/Qle2PLUkpXiUQBHealo3m1LjLcPq+vY
        IKKdwkiR8H51d++yVlCjekw/6A==
X-Google-Smtp-Source: ABdhPJzqAWkhy8NRWylyo9UZc1cM9O+xCPSTXudw+0/AIIaP29QmmUWuYV9rEXWaQnyQMurfR+nxZA==
X-Received: by 2002:a17:907:97c9:b0:6db:ab53:1fdf with SMTP id js9-20020a17090797c900b006dbab531fdfmr20024148ejc.406.1651657680230;
        Wed, 04 May 2022 02:48:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l24-20020a056402029800b0042617ba63a7sm9006631edv.49.2022.05.04.02.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 02:47:59 -0700 (PDT)
Date:   Wed, 4 May 2022 11:47:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Message-ID: <YnJLzY7Yiax/AwMx@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502130944.363776-3-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 02, 2022 at 03:09:44PM +0200, Javier Martinez Canillas wrote:
> A reference to the framebuffer device struct fb_info is stored in the file
> private data, but this reference could no longer be valid and must not be
> accessed directly. Instead, the file_fb_info() accessor function must be
> used since it does sanity checking to make sure that the fb_info is valid.
> 
> This can happen for example if the fbdev driver was one that is using a
> framebuffer provided by the system firmware. In that case, the fbdev core
> could unregister the framebuffer device if a real video driver is probed.
> 
> Reported-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Doesn't this mean we just leak the references? Also anything the driver
might refcount in fb_open would be leaked too.

I'm not sure what exactly you're trying to fix here, but this looks a bit
wrong.

Maybe stepping back what fbdev would need, but doesn't have (see the
commit reference I dropped on the previous version) is drm_dev_enter/exit
around hw access. the file_fb_info check essentially provides that, but
with races and everything.

But drm_dev_enter/exit should not disable sw side code, especially not
refcount cleanup like fb_release does here.
-Daniel

> ---
> 
>  drivers/video/fbdev/core/fbmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 20d8929df79f..d68097105f93 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1439,7 +1439,10 @@ fb_release(struct inode *inode, struct file *file)
>  __acquires(&info->lock)
>  __releases(&info->lock)
>  {
> -	struct fb_info * const info = file->private_data;
> +	struct fb_info * const info = file_fb_info(file);
> +
> +	if (!info)
> +		return -ENODEV;
>  
>  	lock_fb_info(info);
>  	if (info->fbops->fb_release)
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
