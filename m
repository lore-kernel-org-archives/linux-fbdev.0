Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C27BC433EF
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Feb 2022 00:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352440AbiBFA4G (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 5 Feb 2022 19:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbiBFA4G (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 5 Feb 2022 19:56:06 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5EDC061348
        for <linux-fbdev@vger.kernel.org>; Sat,  5 Feb 2022 16:56:05 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id 35e49199-84bc-11ec-ac19-0050568cd888;
        Thu, 03 Feb 2022 06:40:43 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 52AFA194B3E;
        Thu,  3 Feb 2022 07:39:40 +0100 (CET)
Date:   Thu, 3 Feb 2022 07:39:37 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] fbdev: fbmem: Fix the implicit type casting
Message-ID: <Yft4qf3Hw7ntxc98@ravnborg.org>
References: <f3b28143-5f59-ad77-f2b8-6274a6edbfdc@roeck-us.net>
 <20220202235811.1621017-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202235811.1621017-1-yzhai003@ucr.edu>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

I assume you will take this.

Patch is:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

On Wed, Feb 02, 2022 at 03:58:08PM -0800, Yizhuo Zhai wrote:
> In function do_fb_ioctl(), the "arg" is the type of unsigned long,
> and in "case FBIOBLANK:" this argument is casted into an int before
> passig to fb_blank(). In fb_blank(), the comparision
> if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
> "arg" is a large number, which is possible because it comes from
> the user input. Fix this by adding the check before the function
> call.
> 
> Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
> ---
>  drivers/video/fbdev/core/fbmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 0fa7ede94fa6..13083ad8d751 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1160,6 +1160,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  		ret = fbcon_set_con2fb_map_ioctl(argp);
>  		break;
>  	case FBIOBLANK:
> +		if (arg > FB_BLANK_POWERDOWN)
> +			return -EINVAL;
>  		console_lock();
>  		lock_fb_info(info);
>  		ret = fb_blank(info, arg);
> -- 
> 2.25.1
