Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26344C48BE5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Jun 2021 17:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112F0613E7
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Jun 2021 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhFQRpy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFQRpx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Jun 2021 13:45:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0957C061574
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Jun 2021 10:43:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z8so7676830wrp.12
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Jun 2021 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwAc1yJsU7uwawBw0jrP48508Sb+GisUBuf8mUw0CSQ=;
        b=GHO/YGfyYyqABj7MtIl2Wu+QGpEAaK9gSOyMEBLNUmZuKIoPtNcNpaudIKwcLpYNwq
         v9yErUT7CVuhhu7WS69FNtnv6SfOcLPFdEPbOuwWHMX3IkFPjoPqlR+nw3M+e8XdPImB
         fyvTLKdD9PlteoBOzvL3i7bIoZXW972HX8tfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lwAc1yJsU7uwawBw0jrP48508Sb+GisUBuf8mUw0CSQ=;
        b=e8qeBNdMrs8rkjx/IjzzzDE2eP8bcVGMD0aJ7p7nCyh3T6SBsAdH8g03LqUQKbS5ab
         x5iN32U2zYInpjdo4WwI9fo9LWaaryVucNA2qJFaA4HDM5xYoyMUY9KuAPojehMZqgCZ
         53JaRGa3M00q7EenGsd3VSrLtSQeascuIFSmyeoE+RfVnesFKErjtoIKOwKbK+C1a7m0
         DVWCkdjx0c2gZxkqDEB1O4JFz6Mzkx6V/UODCumQuo8SlObHHdfmBXSQhNozY87QxC6k
         7YAOmrG+ywqaX3zB5DFEOzpTULBPavpDWBKJ50Knwyw2C/Z7Jd5GgB6fhdJBwaCSaMSP
         W2ww==
X-Gm-Message-State: AOAM530Fdq5o4oTnQ4z6QruIyzvc82dEiudy3hAS2JR7v67FSP7WMZ/k
        n0qeiVfIe8V2O1/jGoi6ZYQGTA==
X-Google-Smtp-Source: ABdhPJy8rMAYADtfeD34I2hGI8dldj1XQ3SPJhezGzk35Mij40UgqvDBe673mzz+rNw00QZ0B4G+Cg==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr7390981wrw.389.1623951823445;
        Thu, 17 Jun 2021 10:43:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z18sm3195872wmf.18.2021.06.17.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 10:43:42 -0700 (PDT)
Date:   Thu, 17 Jun 2021 19:43:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yu Jiahua <yujiahua1@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] apply: use DEFINE_SPINLOCK() instead of
 spin_lock_init().
Message-ID: <YMuJzDxblPNkpFjH@phenom.ffwll.local>
Mail-Followup-To: Yu Jiahua <yujiahua1@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210616031713.24959-1-yujiahua1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616031713.24959-1-yujiahua1@huawei.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 15, 2021 at 07:17:13PM -0800, Yu Jiahua wrote:
> From: Jiahua Yu <yujiahua1@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Jiahua Yu <yujiahua1@huawei.com>

Stuffed into drm-misc-next. The subject looked a bit strange, so I fixed
that up.
-Daniel

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/apply.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/apply.c b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
> index c71021091828..acca991c7540 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/apply.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
> @@ -108,7 +108,7 @@ static struct {
>  } dss_data;
>  
>  /* protects dss_data */
> -static spinlock_t data_lock;
> +static DEFINE_SPINLOCK(data_lock);
>  /* lock for blocking functions */
>  static DEFINE_MUTEX(apply_lock);
>  static DECLARE_COMPLETION(extra_updated_completion);
> @@ -131,8 +131,6 @@ static void apply_init_priv(void)
>  	struct mgr_priv_data *mp;
>  	int i;
>  
> -	spin_lock_init(&data_lock);
> -
>  	for (i = 0; i < num_ovls; ++i) {
>  		struct ovl_priv_data *op;
>  
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
