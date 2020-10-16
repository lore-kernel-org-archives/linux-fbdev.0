Return-Path: <SRS0=YZMy=DX=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75DC433DF
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Oct 2020 21:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDB4214DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Oct 2020 21:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgJPVoZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:44:25 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:40856 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgJPVoY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Oct 2020 17:44:24 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B77118058D;
        Fri, 16 Oct 2020 23:44:21 +0200 (CEST)
Date:   Fri, 16 Oct 2020 23:44:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] fbdev: nvidia: use for_each_child_of_node() macro
Message-ID: <20201016214420.GC1962741@ravnborg.org>
References: <20200916062123.190636-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062123.190636-1-miaoqinglang@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=e5mUnYsNAAAA:8
        a=tj93dU6F_355QJNGr64A:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201016214420.WtXVfGBnFQm2Am3C6olzv2AAepNdbR-up4WZL4zOY1M@z>

Hi Qinglang Miao

On Wed, Sep 16, 2020 at 02:21:23PM +0800, Qinglang Miao wrote:
> Use for_each_child_of_node() macro instead of open coding it.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/nvidia/nv_of.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/nvidia/nv_of.c b/drivers/video/fbdev/nvidia/nv_of.c
> index 5f3e5179c..d20b8779b 100644
> --- a/drivers/video/fbdev/nvidia/nv_of.c
> +++ b/drivers/video/fbdev/nvidia/nv_of.c
> @@ -42,8 +42,7 @@ int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
>  		const char *pname;
>  		int len;
>  
> -		for (dp = NULL;
> -		     (dp = of_get_next_child(parent, dp)) != NULL;) {
> +		for_each_child_of_node(parent, dp) {
>  			pname = of_get_property(dp, "name", NULL);
>  			if (!pname)
>  				continue;
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
