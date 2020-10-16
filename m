Return-Path: <SRS0=YZMy=DX=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58BC433E7
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Oct 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095AC205CB
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Oct 2020 21:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410559AbgJPVBV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:01:21 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34142 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410553AbgJPVBV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Oct 2020 17:01:21 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 10B9C20030;
        Fri, 16 Oct 2020 23:01:17 +0200 (CEST)
Date:   Fri, 16 Oct 2020 23:01:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernie Thompson <bernie@plugable.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: use kobj_to_dev()
Message-ID: <20201016210116.GC1496366@ravnborg.org>
References: <1600776867-24226-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600776867-24226-1-git-send-email-wangqing@vivo.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=S433PrkP c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=1WtWmnkvAAAA:8 a=e5mUnYsNAAAA:8
        a=S625N62x_EdrrIXL-UUA:9 a=4VdfB5lweFc2GgQk:21 a=SvyDWAbSgJdgMsRO:21
        a=CjuIK1q_8ugA:10 a=-_UHfarfsM-RsASml2Jt:22 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201016210116.vSmF9R0sDOf7uMEpzuXaERAidJ999ZxV8wdk5M0m4cU@z>

Hi Wang Qing

On Tue, Sep 22, 2020 at 08:14:24PM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks, applied to drm-misc-next. Patch will appear in -next in a few
weeks.

	Sam

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 4 ++--
>  drivers/video/fbdev/udlfb.c           | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 3fe509c..878c39a
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2200,7 +2200,7 @@ static ssize_t radeon_show_edid1(struct file *filp, struct kobject *kobj,
>  				 struct bin_attribute *bin_attr,
>  				 char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct fb_info *info = dev_get_drvdata(dev);
>          struct radeonfb_info *rinfo = info->par;
>  
> @@ -2212,7 +2212,7 @@ static ssize_t radeon_show_edid2(struct file *filp, struct kobject *kobj,
>  				 struct bin_attribute *bin_attr,
>  				 char *buf, loff_t off, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct fb_info *info = dev_get_drvdata(dev);
>          struct radeonfb_info *rinfo = info->par;
>  
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index 5b014b4..f9b3c1c
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1457,7 +1457,7 @@ static ssize_t edid_show(
>  			struct file *filp,
>  			struct kobject *kobj, struct bin_attribute *a,
>  			 char *buf, loff_t off, size_t count) {
> -	struct device *fbdev = container_of(kobj, struct device, kobj);
> +	struct device *fbdev = kobj_to_dev(kobj);
>  	struct fb_info *fb_info = dev_get_drvdata(fbdev);
>  	struct dlfb_data *dlfb = fb_info->par;
>  
> @@ -1479,7 +1479,7 @@ static ssize_t edid_store(
>  			struct file *filp,
>  			struct kobject *kobj, struct bin_attribute *a,
>  			char *src, loff_t src_off, size_t src_size) {
> -	struct device *fbdev = container_of(kobj, struct device, kobj);
> +	struct device *fbdev = kobj_to_dev(kobj);
>  	struct fb_info *fb_info = dev_get_drvdata(fbdev);
>  	struct dlfb_data *dlfb = fb_info->par;
>  	int ret;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
