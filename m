Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37AC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 12:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317012074A
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 12:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhA0M1w (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 07:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236296AbhA0MZw (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 07:25:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 336752070E;
        Wed, 27 Jan 2021 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611750310;
        bh=imd80gPIHbJE8uuSvdkKYNt06yTy9wGgnng4tuLO1bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSrfJ2+mqCpTL9w5GZtWEYar7eDEJWbgyU+G6jO/ZATY7Bj4zQm+RDJ6hyn1gdwz2
         EavnWQI6fK3FMdK1im06stlhsW35tDv3fwGIkQIytV7NsowOc1L1cvot9jKmfa71F8
         OU8jF+mvh41FerQOm7gCQaG/22YnGRMRuQyKPPoI=
Date:   Wed, 27 Jan 2021 13:25:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v8] fbtft: add tearing signal detect
Message-ID: <YBFbo3QEHF9eQBxy@kroah.com>
References: <1611743206-136112-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611743206-136112-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 27, 2021 at 06:26:46PM +0800, Carlis wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
> 
> For st7789v ic,add tearing signal detect to avoid screen tearing
> 
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> ---
> v8: delete a log line
> ---
>  drivers/staging/fbtft/fb_st7789v.c | 132 ++++++++++++++++++++++++++++++++++++-
>  drivers/staging/fbtft/fbtft.h      |   1 +
>  2 files changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 3a280cc..de7460c 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -9,9 +9,12 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/mutex.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <video/mipi_display.h>
> -
> +#include <linux/gpio/consumer.h>
>  #include "fbtft.h"
>  
>  #define DRVNAME "fb_st7789v"
> @@ -66,6 +69,32 @@ enum st7789v_command {
>  #define MADCTL_MX BIT(6) /* bitmask for column address order */
>  #define MADCTL_MY BIT(7) /* bitmask for page address order */
>  
> +#define SPI_PANEL_TE_TIMEOUT	400
> +static struct mutex te_mutex;/*mutex for tearing line*/
> +static struct completion spi_panel_te;
> +
> +static irqreturn_t spi_panel_te_handler(int irq, void *data)
> +{
> +	complete(&spi_panel_te);
> +	return IRQ_HANDLED;
> +}
> +
> +static void set_spi_panel_te_irq_status(struct fbtft_par *par, bool enable)
> +{
> +	static int te_irq_count;
> +
> +	mutex_lock(&te_mutex);
> +
> +	if (enable) {
> +		if (++te_irq_count == 1)
> +			enable_irq(gpiod_to_irq(par->gpio.te));
> +	} else {
> +		if (--te_irq_count == 0)
> +			disable_irq(gpiod_to_irq(par->gpio.te));
> +	}
> +	mutex_unlock(&te_mutex);
> +}
> +
>  /**
>   * init_display() - initialize the display controller
>   *
> @@ -82,6 +111,33 @@ enum st7789v_command {
>   */
>  static int init_display(struct fbtft_par *par)
>  {
> +	int rc;
> +	struct device *dev = par->info->device;
> +
> +	par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0, GPIOD_IN);
> +	if (IS_ERR(par->gpio.te)) {
> +		rc = PTR_ERR(par->gpio.te);
> +		pr_err("Failed to request te gpio: %d\n", rc);

You are a driver, always use dev_* calls, not pr_*.

This should be dev_err().

same for other pr_ functions you add in this patch.

Also, look at other commits for this file and make your subject: line
match them (i.e. you forgot "staging: ")

thanks,

greg k-h
