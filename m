Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC417C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 17:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC9A233CE
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbhAGRFo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jan 2021 12:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbhAGRFn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jan 2021 12:05:43 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E7CC0612F5
        for <linux-fbdev@vger.kernel.org>; Thu,  7 Jan 2021 09:05:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w5so6317688wrm.11
        for <linux-fbdev@vger.kernel.org>; Thu, 07 Jan 2021 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zLnCWpPPvy/Q2BKsyRUE0qo8CRuhGn1b+7gTtV+G0js=;
        b=jlVx+c4AaJsyjqQKi6vma2OsGoU6btW31JlVhaIwj760DLlEXYC+KtAXzYJ/bTYCvu
         BRuJDMZhQjmtReA03Of4XX+2qiUYZeeTj1qfcelsjTx9TDZNNcu/pXK7KjIfoOAdn+t9
         If3DkYXNGn4P3r7U3W9rKeoAwvaZ95uqyNEB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLnCWpPPvy/Q2BKsyRUE0qo8CRuhGn1b+7gTtV+G0js=;
        b=UkH25XqX1Du+tD0gbleFg3k9kF4NpFMK0Ya2+4e3Twf+ZzliioSEz/OJv4W8jeGyHD
         e/EfUBGarvFsUAME+2NDMJqhm6ryWTQkzpyW2a5G9CRnNj8AMH9tD+tFUiOKgHJno5h4
         db+QmIe2QozEolTOW1pb0/gsD0IA04NPhi1IF36T7/ejIMSVMqW9zFHsYpZAzMN8McLy
         Ln3+8TclOwHawOI/37NHWhGQpSKGlgHvJ7PCgvMGHbgbmnwIYGK+JlWZh3xBZarvyMk/
         KffWBLVvczMi4W6kelDPxIO7orQGBwsgI+Ycoj9sVAAwnA/M79ylqOf9RXwrWuY7K1LI
         JMJA==
X-Gm-Message-State: AOAM532mLmj+50KK8iHoSEyZ9U8tJF6nLbw2ytS7bCIVt+6oVDSk5y2A
        vAtpJqaA8NSJz9OkmSXbmwbu4A==
X-Google-Smtp-Source: ABdhPJwhE8K9ob3KgXOwnmPZM85AMzlHCjP20ZEoxesuE4u0Op1MroHtDmHDI2Gpnj8ZwN2hg0BFgw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr10125162wrt.396.1610039102286;
        Thu, 07 Jan 2021 09:05:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f7sm14469121wmc.1.2021.01.07.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:05:01 -0800 (PST)
Date:   Thu, 7 Jan 2021 18:04:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: simplefb: Fix info message during probe
Message-ID: <X/c/OwqdMtmqzOZq@phenom.ffwll.local>
References: <20201228183934.1117012-1-pbrobinson@gmail.com>
 <b00bd27c-70b5-9ef1-85a1-11e733af78da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00bd27c-70b5-9ef1-85a1-11e733af78da@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Hans,

On Tue, Dec 29, 2020 at 02:02:30PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 12/28/20 7:39 PM, Peter Robinson wrote:
> > The info message was showing the mapped address for the framebuffer. To avoid
> > security problems, all virtual addresses are converted to __ptrval__, so
> > the message has pointless information:
> > 
> > simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes, mapped to 0x(____ptrval____)
> > 
> > Drop the extraneous bits to clean up the message:
> > 
> > simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes
> > 
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Since you have commit rights for drm-misc I'm assuming you're also going
to push this one?

Thanks, Daniel

> 
> Regards,
> 
> Hans
> 
> > ---
> >  drivers/video/fbdev/simplefb.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> > index 533a047d07a2..62f0ded70681 100644
> > --- a/drivers/video/fbdev/simplefb.c
> > +++ b/drivers/video/fbdev/simplefb.c
> > @@ -477,9 +477,8 @@ static int simplefb_probe(struct platform_device *pdev)
> >  	simplefb_clocks_enable(par, pdev);
> >  	simplefb_regulators_enable(par, pdev);
> >  
> > -	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
> > -			     info->fix.smem_start, info->fix.smem_len,
> > -			     info->screen_base);
> > +	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
> > +			     info->fix.smem_start, info->fix.smem_len);
> >  	dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
> >  			     params.format->name,
> >  			     info->var.xres, info->var.yres,
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
