Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB0C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 Jan 2022 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbiANQ7E (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 Jan 2022 11:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243659AbiANQ7D (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 Jan 2022 11:59:03 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F801C06173E
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jan 2022 08:59:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o3so16601028wrh.10
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jan 2022 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=tg4oCMG6li+TDjSwe6u86VlYXa8liJ00jWszISs+oTI=;
        b=XEOBIwW/kQkclrF8e9c9xVwCab3wDlckLrQdSpSP8Q6g248n17tpuLNk/YrLR5DN5G
         polByyx+FxbcK+p4gvaiqo0wiHU6seMH9LcQqa7YxAMPHhQcjYrh6Vgp7B4/6dVr6OKN
         TU6gfhObqGnrBwxCL2NDWL66X4p7lARMmmf0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=tg4oCMG6li+TDjSwe6u86VlYXa8liJ00jWszISs+oTI=;
        b=5i5ZAQgQq4dBQRbukd2wft4ppilQggJUc9aPNh4Sbhx52ti4KuKk43G0BvsglnEaWj
         bsd37oNUA9PN9bIZPn7iLFcGeTgwfYlnBZ/TsJyIAzyJfJ8a6KDtIqzZLJVOvNb379Nx
         X9KHy18f4HfJqHDKkhjIj+5d7k9ZHCivBUrzv9nwoVIHSY5vzvTArLb9La4W/udVEoFN
         j29OwJoWgRrtUccqQSdT2njK0zob5gGnkXaUXnLXa86uuJVElUq8TvRHe9clraKaset6
         tDUxjQFN28lIs7vBxf4Kti7LcJazmdwwn/DPtprDiE/X8TL+HduSCg9fA7kbT5+CfjSp
         kXeg==
X-Gm-Message-State: AOAM530z/qjXwPj4hTJ7OROOJgWObpV9F4P9hY5D3gLgVZ3hJ2UsRhlz
        Px+1BDpDenYAu9s9YXz3Bq/Lwg==
X-Google-Smtp-Source: ABdhPJyKiq9MKoMx2tCGoLdeoS50UBy5IjTi4zD8ToVwJYkKEf3eHDu/vOLA1ET+NX5npL0uE0wh8w==
X-Received: by 2002:a5d:6903:: with SMTP id t3mr8826258wru.353.1642179541790;
        Fri, 14 Jan 2022 08:59:01 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm1549490wrt.37.2022.01.14.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:59:01 -0800 (PST)
Date:   Fri, 14 Jan 2022 17:58:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: s3c-fb: remove redundant initialization of
 pointer bufs
Message-ID: <YeGr01WGTSy+PYXr@phenom.ffwll.local>
Mail-Followup-To: Colin Ian King <colin.i.king@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211230160626.404072-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230160626.404072-1-colin.i.king@gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Dec 30, 2021 at 04:06:26PM +0000, Colin Ian King wrote:
> Pointer bufs is being initialized with a value that is never read, it
> is being re-assigned with a different value later on. The assignment
> is redundant and can be removed. Cleans up clang-scan warning:
> 
> drivers/video/fbdev/s3c-fb.c:492:16: warning: Value stored to 'buf'
> during its initialization is never read [deadcode.DeadStores]
>         void __iomem *buf = regs;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Both of your dead store fixes queued up in drm-misc-next for 5.18.
-Daniel

> ---
>  drivers/video/fbdev/s3c-fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
> index 3b134e1bbc38..68408c499627 100644
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -489,7 +489,7 @@ static int s3c_fb_set_par(struct fb_info *info)
>  	struct s3c_fb_win *win = info->par;
>  	struct s3c_fb *sfb = win->parent;
>  	void __iomem *regs = sfb->regs;
> -	void __iomem *buf = regs;
> +	void __iomem *buf;
>  	int win_no = win->index;
>  	u32 alpha = 0;
>  	u32 data;
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
