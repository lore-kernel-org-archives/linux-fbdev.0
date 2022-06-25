Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F71CCA479
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 22:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiFYWhG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiFYWhF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 18:37:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26C4BE31
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:37:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q6so11557455eji.13
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJINAh+SGkc8vWd5Li1rj+KiuqIn+stbSsKpfUxM85o=;
        b=OG0cEsIKldUt6OHBZOkrHqhWP4/9Zw393OW32MSgG25xqO7li94raRoxrpU8BVUXlW
         f85KURoa3KgtO7J1wpCi/THKCkFE95N9dMp4aCqRmzvuMqr3CczhlQmrE7DQ1xmPWHY+
         sr0eeKFWUzMrGOp4R1Qzm1+X3mcrLOwcEXRUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJINAh+SGkc8vWd5Li1rj+KiuqIn+stbSsKpfUxM85o=;
        b=KtMlMx1/IVP+kAHF9eIzHXusrcZahsbKgnPEVHgXbcNQ1uCd90jBGs31nQMCftY+qk
         8IQglbrxnU5e7YW09Ir0nTcSUSd029H0QjW7F4QDhrxFBqT+rFVnNIu35OEU43+dZZfc
         YEGF2Tv7o4W59Nq2C7jCDyBqBLwRL+qGBgYexvNbOTiVgfoqjAyvI83qXQ3RjI9u8zpw
         S31ICg7DELlUEegSPeW7pw0WtgXvDqsNbhqdYL1ryQ8epZsyBRW3/lV4TZyq/qLte7BB
         J4DSQmgqQAWuYv8kyPXLT0NvJbAHGvvdODU2a5nFm3HkDPRwK5YYwrMU12ZrwxyvNDyg
         SukQ==
X-Gm-Message-State: AJIora9EwFuS4FZPuYZkjWjDZs23YrS9n4dw1sO/RvjaE6d+fd0MhIoT
        UjbSYcB8+URloWsBJSOdnaV1rA==
X-Google-Smtp-Source: AGRyM1tz6BcxEx+1rLxjnJilyDz4vyILX/H11JDKFW9vW6/NLDF+F0lHzjtHnoCgRfhirJeDNNQJyQ==
X-Received: by 2002:a17:906:5344:b0:712:3c7e:cf58 with SMTP id j4-20020a170906534400b007123c7ecf58mr5889772ejo.679.1656196623250;
        Sat, 25 Jun 2022 15:37:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906444d00b00722eeb368cesm3092150ejp.64.2022.06.25.15.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:37:02 -0700 (PDT)
Date:   Sun, 26 Jun 2022 00:37:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fbmem: Check screen resolution change against
 font size
Message-ID: <YreODaSXhAhipJKa@phenom.ffwll.local>
References: <20220625220630.333705-1-deller@gmx.de>
 <20220625220630.333705-4-deller@gmx.de>
 <YreNUfv8d9QeJT8C@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YreNUfv8d9QeJT8C@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 12:33:53AM +0200, Daniel Vetter wrote:
> On Sun, Jun 26, 2022 at 12:06:29AM +0200, Helge Deller wrote:
> > Enhance the check in the FBIOPUT_VSCREENINFO ioctl handler to verify if the
> > user-provided new screen size is bigger than the current font size.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > Cc: stable@vger.kernel.org # v5.4+
> 
> Please squash with previous patch. You might also want to add a note there
> that on older kernels backporters need to open-code
> fbcon_info_from_console instead, since it only exists since 
> 409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup")

Maybe easier would be to include that patch in the backports instead of
open coding. I think that's what Greg generally prefers at least, less
divergence between stable kernels.
-Daniel

> 
> With these two nits: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index afa2863670f3..160389365a36 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1106,7 +1106,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >  			return -EFAULT;
> >  		console_lock();
> >  		lock_fb_info(info);
> > -		ret = fb_set_var(info, &var);
> > +		ret = fbcon_modechange_possible(info, &var);
> > +		if (!ret)
> > +			ret = fb_set_var(info, &var);
> >  		if (!ret)
> >  			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >  		unlock_fb_info(info);
> > --
> > 2.35.3
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
