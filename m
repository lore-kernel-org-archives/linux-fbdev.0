Return-Path: <SRS0=BHHc=DY=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BA1C433E7
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB632073A
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436852AbgJQG2y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:28:54 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:60696 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436851AbgJQG2y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 17 Oct 2020 02:28:54 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B2E4480575;
        Sat, 17 Oct 2020 08:28:51 +0200 (CEST)
Date:   Sat, 17 Oct 2020 08:28:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     timur@kernel.org, b.zolnierkie@samsung.com, gustavoars@kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] video: fbdev: fsl-diu-fb: remove unneeded variable 'res'
Message-ID: <20201017062850.GH2242298@ravnborg.org>
References: <20200910140558.1191423-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140558.1191423-1-yanaijie@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=0y_l-WQFCCuusZHaQSsA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201017062850.GTd9ex-dlCkVq0bd7N1ePh6h6RwAYqGEzozeXYHJEDg@z>

On Thu, Sep 10, 2020 at 10:05:58PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
> 
> drivers/video/fbdev/fsl-diu-fb.c:1428:5-8: Unneeded variable: "res".
> Return "0" on line 1450
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Hi Jason,

applied to drm-misc-next too.

	Sam

> ---
>  drivers/video/fbdev/fsl-diu-fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
> index a547c21c7e92..e332017c6af6 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -1425,7 +1425,6 @@ static int fsl_diu_open(struct fb_info *info, int user)
>  static int fsl_diu_release(struct fb_info *info, int user)
>  {
>  	struct mfb_info *mfbi = info->par;
> -	int res = 0;
>  
>  	spin_lock(&diu_lock);
>  	mfbi->count--;
> @@ -1447,7 +1446,7 @@ static int fsl_diu_release(struct fb_info *info, int user)
>  	}
>  
>  	spin_unlock(&diu_lock);
> -	return res;
> +	return 0;
>  }
>  
>  static const struct fb_ops fsl_diu_ops = {
> -- 
> 2.25.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
