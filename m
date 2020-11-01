Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E8C2D0A3
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 09:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234D920853
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 09:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKAJrX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 04:47:23 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40198 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgKAJrX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 04:47:23 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 39BD020022;
        Sun,  1 Nov 2020 10:47:20 +0100 (CET)
Date:   Sun, 1 Nov 2020 10:47:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        b.zolnierkie@samsung.com, jirislaby@kernel.org,
        gustavoars@kernel.org, peda@axentia.se, jingxiangfeng@huawei.com,
        natechancellor@gmail.com, george.kennedy@oracle.com,
        yepeilin.cs@gmail.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video/fbdev/core: Mark debug-only variable as
 __maybe_unused
Message-ID: <20201101094718.GD1166694@ravnborg.org>
References: <20201021121512.17774-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021121512.17774-1-tzimmermann@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=2p3zRRVL11vTGQ8z29QA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas.

On Wed, Oct 21, 2020 at 02:15:12PM +0200, Thomas Zimmermann wrote:
> Compiling fbcon.c gives
> 
> ../drivers/video/fbdev/core/fbcon.c: In function 'fbcon_exit':
> ../drivers/video/fbdev/core/fbcon.c:3358:7: warning: variable 'pending' set but not used [-Wunused-but-set-variable]
>  3358 |   int pending = 0;
>       |       ^~~~~~~
> 
> The variable pending is only used for fbcon debugging. It's unused
> otherwise. Mark it accordingly.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

A better fix would be to replace the few uses of DPRINTK() with
pr_dbg(). pr_info() is alread in use.

ofc, the next step would be to replace all prink() with their pr_
counterparts.

Peilin, maybe this is one for your nice cleanups in fbcon?

	Sam
