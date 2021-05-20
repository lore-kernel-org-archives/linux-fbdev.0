Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD2FC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 May 2021 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBC260240
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 May 2021 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhETNmu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 May 2021 09:42:50 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21371 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbhETNmg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 May 2021 09:42:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621518051; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=g366NAyIOHGUnmU1H63NB1lXwhcYXHlezQIRprstNF8Wtjt9iC/dczA9RagvoEs5ys621mpiRDd7x/v4cWWmtwC8YR5FIfYIzMZYqsxQzEx9Wr6ijIUPpYZn8MS/NWnsQsi9ud+tpVhTbjPtR//y9Nq4ZmXI8g53oKfIGDvK5fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1621518051; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=7VNeDRXRLa85jo7cthDYXanGoVHoiLzcwRL2eJbBc4Q=; 
        b=NT/YbWWIGwaB810Ax5TA/0bAb/G3mAGqKXs617ByEW7UgVb0Ff5EAklvknryjULH2NGMpEWhvAKTXTRUVoIBgOKhAZkrCtu2CgqCUmCze3ct+H5S5HhGOzzkMDtx9/JZnBT4df4j+1dx//yaADH4EWzxa9DFs8qX13ehf5odse8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1621518051;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=7VNeDRXRLa85jo7cthDYXanGoVHoiLzcwRL2eJbBc4Q=;
        b=DhQR6BlcX/91j1pV697dRGRM60S+vbqLTUXQRJ257ZxRwhLgDvA6cXqImWdgFNPD
        VZuxjfxgplf/s9w/0voP/XSRUPvKd/oLZy36qHm3JLp+KQ9GlWeN4MryAWdaKMZEmSj
        xpOb2stWUt7eJQp8VED2Az3/0EMFGgWfZn2Ac05k=
Received: from anirudhrb.com (106.51.110.115 [106.51.110.115]) by mx.zohomail.com
        with SMTPS id 1621518046958980.6684477891203; Thu, 20 May 2021 06:40:46 -0700 (PDT)
Date:   Thu, 20 May 2021 19:10:39 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        kernel test robot <oliver.sang@intel.com>,
        stable <stable@vger.kernel.org>,
        linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mail@anirudhrb.com, igormtorrente@gmail.com,
        fero@drama.obuda.kando.hu
Subject: Re: [PATCH] video: hgafb: correctly handle card detect failure
 during probe
Message-ID: <YKZm17dj4R1c2ns/@anirudhrb.com>
References: <20210516192714.25823-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516192714.25823-1-mail@anirudhrb.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 17, 2021 at 12:57:14AM +0530, Anirudh Rayabharam wrote:
> The return value of hga_card_detect() is not properly handled causing
> the probe to succeed even though hga_card_detect() failed. Since probe
> succeeds, hgafb_open() can be called which will end up operating on an
> unmapped hga_vram. This results in an out-of-bounds access as reported
> by kernel test robot [1].
> 
> To fix this, correctly detect failure of hga_card_detect() by checking
> for a non-zero error code.
> 
> [1]: https://lore.kernel.org/lkml/20210516150019.GB25903@xsang-OptiPlex-9020/
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: dc13cac4862c ("video: hgafb: fix potential NULL pointer dereference")

Greg, this is one of the UMN fixes we did. So, do you want to take this
patch into your tree?

thanks!

	- Anirudh.

> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/video/fbdev/hgafb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index cc8e62ae93f6..bd3d07aa4f0e 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -558,7 +558,7 @@ static int hgafb_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	ret = hga_card_detect();
> -	if (!ret)
> +	if (ret)
>  		return ret;
>  
>  	printk(KERN_INFO "hgafb: %s with %ldK of memory detected.\n",
> -- 
> 2.26.2
> 
