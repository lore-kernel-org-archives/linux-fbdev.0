Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93871C0015E
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Aug 2023 19:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbjHOTJm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Aug 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbjHOTJl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Aug 2023 15:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20645213A;
        Tue, 15 Aug 2023 12:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E24861633;
        Tue, 15 Aug 2023 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB3AC433C7;
        Tue, 15 Aug 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692126552;
        bh=drMk97XVyKCReqvo0twNj8qWYEWg10p1ckwl8tzVNBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4yhcg4O90wKEMrx6eDICyuJ5FVGKESOwrgPDmJj7h5k8Dt9xumIm45W4HXOP+sKe
         FYo8uYUywe2h0MILLpYTJ5sY4N1Fnh5X85ru4Y7BqmBnDcPJ1rY2Dj6upC9+xcm9XN
         eRZsx67reSsMDkSu8sY4d/q5n4mylCql0Vn1t0ts5rLlobMDdQ/SlN5Zys5KCNMQyu
         NMx8HSJdPxQqvNTApHOngRa5KEjLcYUYT1AfvOB9j5Il7SxI2I1oL7eNYjMihrzzCd
         IW3k2zJoJEhZUzsAQo6+QlXFg6KCT/N47znNx3zabXs+TZiMxTuqfSbWz0DF7K9JGK
         JzxYRrZ9C+Drw==
Date:   Tue, 15 Aug 2023 12:09:10 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] backlight: lp855x: Drop ret variable in brightness
 change function
Message-ID: <20230815190910.GA2908446@dev-arch.thelio-3990X>
References: <20230809114216.4078-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114216.4078-1-aweber.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Aug 09, 2023 at 01:42:16PM +0200, Artur Weber wrote:
> Fixes the following warning:
> 
> drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Fixes: 5145531be5fb ("backlight: lp855x: Catch errors when changing brightness")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308091728.NEJhgUPP-lkp@intel.com/

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/video/backlight/lp855x_bl.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index 61a7f45bfad8..da1f124db69c 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -241,19 +241,17 @@ static int lp855x_bl_update_status(struct backlight_device *bl)
>  {
>  	struct lp855x *lp = bl_get_data(bl);
>  	int brightness = bl->props.brightness;
> -	int ret;
>  
>  	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
>  		brightness = 0;
>  
>  	if (lp->mode == PWM_BASED)
> -		ret = lp855x_pwm_ctrl(lp, brightness,
> +		return lp855x_pwm_ctrl(lp, brightness,
>  				      bl->props.max_brightness);
>  	else if (lp->mode == REGISTER_BASED)
> -		ret = lp855x_write_byte(lp, lp->cfg->reg_brightness,
> +		return lp855x_write_byte(lp, lp->cfg->reg_brightness,
>  					(u8)brightness);
> -
> -	return ret;
> +	return -EINVAL;
>  }
>  
>  static const struct backlight_ops lp855x_bl_ops = {
> 
> base-commit: 21ef7b1e17d039053edaeaf41142423810572741
> -- 
> 2.41.0
> 
