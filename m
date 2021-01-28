Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D1DC433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 12:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9416964DDD
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 12:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhA1M7J (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhA1M7I (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 07:59:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0770564D9D;
        Thu, 28 Jan 2021 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611838700;
        bh=C4qSykV9Ua8Po/5N13FLIU468aGWyLm2jJyx3ABSln4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz8HtbVrbtSfTv+ggNZOODBQQWdtWmHrkQ4XFzInDN4B6llxh8K2hJ5RG5O7rTw6I
         PQmQV0gSCm9jRUfrvDw0yUH+t+j/LJFJ4mHNbdTfUn26ZZqDLArhJHbv8+sV3z0Dg4
         NuKkWCYeOYZ4iKAlECxevvtTsd/XvYX4T74MV4qc=
Date:   Thu, 28 Jan 2021 13:58:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
Message-ID: <YBK06WnVg7xQ1H8a@kroah.com>
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 28, 2021 at 08:53:55PM +0800, Carlis wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
> 
> For st7789v ic,when we need continuous full screen refresh, it is best to
> wait for the TE signal arrive to avoid screen tearing
> 
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> ---
> v12: change dev_err to dev_err_probe and add space in comments start, and
>      delete te_mutex, change te wait logic
> v11: remove devm_gpio_put and change a dev_err to dev_info
> v10: additional notes
> v9: change pr_* to dev_*
> v8: delete a log line
> v7: return error value when request fail
> v6: add te gpio request fail deal logic
> v5: fix log print
> v4: modify some code style and change te irq set function name
> v3: modify author and signed-off-by name
> v2: add release te gpio after irq request fail
> ---
>  drivers/staging/fbtft/fb_st7789v.c | 116 +++++++++++++++++++++++++++++++++++++
>  drivers/staging/fbtft/fbtft.h      |   1 +
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 3a280cc..f08e9da 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -9,7 +9,11 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +
>  #include <video/mipi_display.h>
>  
>  #include "fbtft.h"
> @@ -66,6 +70,15 @@ enum st7789v_command {
>  #define MADCTL_MX BIT(6) /* bitmask for column address order */
>  #define MADCTL_MY BIT(7) /* bitmask for page address order */
>  
> +#define SPI_PANEL_TE_TIMEOUT	400 /* msecs */
> +static struct completion spi_panel_te;

Doesn't this structure have to be per-device?  How can it be global for
all devices in the system controlled by this driver?

thanks,

greg k-h
