Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3869FC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BB16136A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbhDGHYq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349436AbhDGHYT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 03:24:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 711D761369;
        Wed,  7 Apr 2021 07:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617780250;
        bh=c8QTi+AIP6Z54tg+BWl56LNU1Ps+kKiQ9QeE1c64AQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K68BONJW/E2R6IZwwl554zQwgj3s+DXec55UZYBqa2SXacCDOQruQlxyydYqn65cN
         B5X3MHl8eHLUDrfP6XSpbLUC1o8779ITZb3/izkQxHngClEdT8xiBwxSyj+mkmT3s1
         gG4wh3mq23YM+XgeipmOLUb7x/ndJmlmX8vOFwCk=
Date:   Wed, 7 Apr 2021 09:24:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/49]  staging: sm750fb: Update enum values in dpms
 to snake case
Message-ID: <YG1eFxQDP6dITlXA@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <16693e7cc62f84ea1ec34b7d5cbd77c4cd1965e8.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16693e7cc62f84ea1ec34b7d5cbd77c4cd1965e8.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:16PM -0700, Pavle Rohalj wrote:
> Fix "Avoid CamelCase" checkpatch.pl checks for values in
> enum dpms.
> 
> Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
> index 7002567a47d2..4756db1ccb9c 100644
> --- a/drivers/staging/sm750fb/ddk750_power.h
> +++ b/drivers/staging/sm750fb/ddk750_power.h
> @@ -3,10 +3,10 @@
>  #define DDK750_POWER_H__
>  
>  enum dpms {
> -	crtDPMS_ON = 0x0,
> -	crtDPMS_STANDBY = 0x1,
> -	crtDPMS_SUSPEND = 0x2,
> -	crtDPMS_OFF = 0x3,
> +	CRT_DPMS_ON = 0x0,
> +	CRT_DPMS_STANDBY = 0x1,
> +	CRT_DPMS_SUSPEND = 0x2,
> +	CRT_DPMS_OFF = 0x3,
>  };

And the build does not break with this change?  If so, then why are
these here at all?

thanks,

greg k-h
