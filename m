Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CBFC47080
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 16:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2154613CE
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 16:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFAQOP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhFAQOO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Jun 2021 12:14:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7EC061574
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Jun 2021 09:12:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c3so14926300wrp.8
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jun 2021 09:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+MnKSQdNE7K12Vo7bfXlH+u3+rwSbIwzZ/MH9R+hCU=;
        b=fXDfQLMj2a92S7LqF0+bJGD4ntsRpYtD+5eL7xdUED43yXcmpRM5EUYebILLUi4Pyp
         51tYm3ksYSnW/wqBfdt0v3sbGQl2ddGEEbax05rm6Vxxfx4ZcrMQFehscnJO/mxZdMlF
         yyJuQUqs3PYqhHpIODFRhzRD28vePHZ6eGk90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=A+MnKSQdNE7K12Vo7bfXlH+u3+rwSbIwzZ/MH9R+hCU=;
        b=nS5tZXVMXFv/xoRW3pcF+n3m547xG0N8G1GYS2LNrU5tuYAbRqREgV0fbEQtL7ut4e
         N3Axa21wOe9WfPZTd5VTa59WZzJNyAeQvlKfxtxPbTQnO7c3ksxmyhEa3mbgWHsL88C0
         rJ7WjoLZLiXh6g3MyzQkFKMP3fkCRyW1gRVkIUvV6XakhE5d+f4RtIyui88+/TloeNkZ
         K3NfRW3Xv/1HGZpFFDuuyY+i1YX/xX3Ozu5GX2BA3w3tX4ZlgFRVsG9MQ1XFsMVV2qQy
         +VtodfY0SWnEWOdMwb9LYtv+LvH7mjStAVDBGrZ8/QT0X/7LysbI3KO8UAsThNV0Ve+V
         aCDg==
X-Gm-Message-State: AOAM532K+TTcDvhLTFOdqIKO9rVrIwb775J4XeGY7h0G9iMPRKnycMdE
        mN2OJddD8qh5W4lx5f4lZ2FGfg==
X-Google-Smtp-Source: ABdhPJz05k0XhNrh1QSM0xrnZ9oif/CUuRvsxGK5dEIUsHJY4nwc/OA0AP5fRzpDHCNc7AElGuGyEQ==
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr1257166wrn.292.1622563951262;
        Tue, 01 Jun 2021 09:12:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h15sm18874800wmq.1.2021.06.01.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:12:30 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:12:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "Signed-off-by : Wolfram Sang" <wsa@the-dreams.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] video: fbdev: mb862xx: use DEVICE_ATTR_RO macro
Message-ID: <YLZcbZVXnYBQM3n+@phenom.ffwll.local>
Mail-Followup-To: Zhen Lei <thunder.leizhen@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "Signed-off-by : Wolfram Sang" <wsa@the-dreams.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210601090852.10531-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601090852.10531-1-thunder.leizhen@huawei.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 01, 2021 at 05:08:52PM +0800, Zhen Lei wrote:
> Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR, which makes the
> code a bit shorter and easier to read.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> index 52755b591c1489f..63721337a37787b 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -542,8 +542,8 @@ static int mb862xxfb_init_fbinfo(struct fb_info *fbi)
>  /*
>   * show some display controller and cursor registers
>   */
> -static ssize_t mb862xxfb_show_dispregs(struct device *dev,
> -				       struct device_attribute *attr, char *buf)
> +static ssize_t dispregs_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
>  {
>  	struct fb_info *fbi = dev_get_drvdata(dev);
>  	struct mb862xxfb_par *par = fbi->par;
> @@ -577,7 +577,7 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
>  	return ptr - buf;
>  }
>  
> -static DEVICE_ATTR(dispregs, 0444, mb862xxfb_show_dispregs, NULL);
> +static DEVICE_ATTR_RO(dispregs);
>  
>  static irqreturn_t mb862xx_intr(int irq, void *dev_id)
>  {
> -- 
> 2.26.0.106.g9fadedd
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
