Return-Path: <SRS0=BHHc=DY=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547F2C433E7
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D872074A
	for <linux-fbdev@archiver.kernel.org>; Sat, 17 Oct 2020 06:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436776AbgJQG2M (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:28:12 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:60566 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409904AbgJQG2M (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 17 Oct 2020 02:28:12 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BDB6780575;
        Sat, 17 Oct 2020 08:28:09 +0200 (CEST)
Date:   Sat, 17 Oct 2020 08:28:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     thomas@winischhofer.net, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] video: fbdev: sis: remove unneeded semicolon
Message-ID: <20201017062808.GG2242298@ravnborg.org>
References: <20200910140536.1191150-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140536.1191150-1-yanaijie@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=7hbD3mbysdTtokiVcH4A:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201017062808.N9EQ4v2JVWpO_nmR-wP5UFIBXtifuqHMcylDVOOsxj4@z>

On Thu, Sep 10, 2020 at 10:05:36PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
> 
> drivers/video/fbdev/sis/sis_accel.h:143:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:144:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:145:72-73: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:273:75-76: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:274:75-76: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:275:73-74: Unneeded semicolon
> drivers/video/fbdev/sis/sis_accel.h:276:75-76: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next.
checkpatch was not happy with the patch - but I ignored these warnings
as this is an old code base.

	Sam
