Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E0C433EF
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Jun 2022 09:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiFZJ7J (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZJ7J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Jun 2022 05:59:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E7E0F2
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 02:59:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o9so9170773edt.12
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ba2A2LUzBT/BXK5YWoAonhgXhHOBit1X/l8wGNO4e5o=;
        b=aBeuPpI0SggqA/KaJcJ7Q+aPU6VYyfRMpHsrQ6rA/iTyRFLgiFkn/k2z6xtbJIC98U
         iKt2O35MsfRW7dGjd19S7xHb3m1C5WclzK6eZeZ/9YWqELUMsEXcaUhU4OxP9mOSTTlz
         k2ObNHN6+AHPNa7eYKINo9HV/cfIfgl7T7PNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ba2A2LUzBT/BXK5YWoAonhgXhHOBit1X/l8wGNO4e5o=;
        b=2o9ijmbas2yKpCsHEH7k6wkR+uzUN9sG1fXjtFTiQwyuAB4sm3D23uTsX3Q2oynaGB
         sl3q54Mf83Edkv60qZW76gIyMIcAjT+61uzfso0ghF/9grrLBr/yNZTN4zEHxblEaoVG
         /SOWxxPKUliOlA/olV/2HJIjwCa4eOE9cwy7klYfUyll7Ir8GYWA18uKkHxknYOqPNxF
         dYPExZhIYIWiWxV+YyMZFfkae9XPW9Fw4w3n/ViPVC4xdoU80cmYRnquAzSCht3XDwAQ
         WnXBdquWzrHvMXNx2W8AM2Aqi6DIu5PilHYe5pZybMIfbXPYOGgk2lqQonfuupUG8YL7
         rUhQ==
X-Gm-Message-State: AJIora8Kj4ScLpj8mLi+xcE1o3KEObUd1pKH1vrNRq6tQBYV/Wo6YOG7
        a0u5CprCU1JnGR5MkkftpW0qeDCRLt1JvA==
X-Google-Smtp-Source: AGRyM1soovyaHhL8DMkp9YxG+GVp54YnlsbV4N628bbSUrne9pRBo3a/ANnKNLheNmWKfpXiRRCYFg==
X-Received: by 2002:a05:6402:3511:b0:437:7eec:c44c with SMTP id b17-20020a056402351100b004377eecc44cmr3948744edd.11.1656237547002;
        Sun, 26 Jun 2022 02:59:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id rl19-20020a170907217300b00722df6db8f3sm3536367ejb.115.2022.06.26.02.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 02:59:06 -0700 (PDT)
Date:   Sun, 26 Jun 2022 11:59:04 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 4/4] fbcon: Use fbcon_info_from_console() in
 fbcon_modechange_possible()
Message-ID: <Yrgt6PIyHz3dzJIk@phenom.ffwll.local>
References: <20220626085615.53728-1-deller@gmx.de>
 <20220626085615.53728-5-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626085615.53728-5-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 10:56:15AM +0200, Helge Deller wrote:
> Use the fbcon_info_from_console() wrapper which was added to kernel
> v5.19 with commit 409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup").
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 69c7261ac334..2ab7515ac842 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2751,7 +2751,7 @@ int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *va
>  	/* prevent setting a screen size which is smaller than font size */
>  	for (i = first_fb_vc; i <= last_fb_vc; i++) {
>  		vc = vc_cons[i].d;
> -		if (!vc || registered_fb[con2fb_map[i]] != info)
> +		if (!vc || fbcon_info_from_console(i) != info)
>  			continue;
> 
>  		if (vc->vc_font.width  > FBCON_SWAP(var->rotate, var->xres, var->yres) ||
> --
> 2.35.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
