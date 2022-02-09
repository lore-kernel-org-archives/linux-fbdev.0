Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4734C4321E
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Feb 2022 18:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiBIS53 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbiBIS4e (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Feb 2022 13:56:34 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D901C02B672
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Feb 2022 10:54:36 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id decf265d-89d9-11ec-ac19-0050568cd888;
        Wed, 09 Feb 2022 18:55:38 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 962EC194B52;
        Wed,  9 Feb 2022 19:54:28 +0100 (CET)
Date:   Wed, 9 Feb 2022 19:54:25 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     cgel.zte@gmail.com
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org, ducheng2@gmail.com,
        penguin-kernel@i-love.sakura.ne.jp, daniel.vetter@ffwll.ch,
        Zeal Robot <zealci@zte.com.cn>, deng.changcheng@zte.com.cn,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        cssk@net-c.es, geert@linux-m68k.org, svens@stackframe.org
Subject: Re: [PATCH] fbcon: use min() to make code cleaner
Message-ID: <YgQN4WXXjSHVDiBK@ravnborg.org>
References: <20220209084810.1561184-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209084810.1561184-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 09, 2022 at 08:48:10AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use min() in order to make code cleaner.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I had preferred in minmax.h was included, but it has an indirect include
so shrug.

I assume Daniel or Helge will pick it up.

	Sam

> ---
>  drivers/video/fbdev/core/fbcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index f36829eeb5a9..61171159fee2 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -602,7 +602,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  		save = kmalloc(array3_size(logo_lines, new_cols, 2),
>  			       GFP_KERNEL);
>  		if (save) {
> -			int i = cols < new_cols ? cols : new_cols;
> +			int i = min(cols, new_cols);
>  			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
>  			r = q - step;
>  			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
> -- 
> 2.25.1
