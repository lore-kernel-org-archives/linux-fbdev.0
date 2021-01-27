Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E92C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4274207B7
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhA0Nr6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 08:47:58 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:36986 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhA0Nr5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 08:47:57 -0500
Received: by mail-oo1-f47.google.com with SMTP id q3so531526oog.4;
        Wed, 27 Jan 2021 05:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQgqmYKIWC6RCQCPkaoQYniBmuiPu1Qb0bETCD5PFVs=;
        b=qFTxpqVIKb0XHFT38JCie4PbnxH7767xw7ub8+hlv64B3PK6v4sNm32dxaejRL8D45
         94Qb5BGXihMSQsADoPMp6T4t7oXqWaYpdQW1UYb1UU+qjjGJGjNawCcXAkUSg2Dsm4G4
         bK9H0NfXwx/A9+Xr7q4+rFoowWlnFVKOpDM2KOV7hIg9q7tA/SLgvSmZFNAxdmjk0CMO
         encZHvS+1eWTaveUGmJqc9pebIzLrYOda8F2b4S767A5bLvajn/T4bmMFJUO+bSTs/8q
         NYXK/5D1JmLSS6einzvRXXoIpPqzjQjwiEZV5QtZenYXne58AFRM34whgmCxgcWP5fpw
         M7Sw==
X-Gm-Message-State: AOAM530azFJp0TZVv50WYg5ai1Qc9wVmsYKTON/ukvB/PhXmKqYaT8Lx
        htoJrdtIGDE/dtxPyc9GNhCQZMKv7z0cOk8WY3o=
X-Google-Smtp-Source: ABdhPJwSBSRY8K8eRc/vVhWXi4XvsglGvFgh3RRklMjnRPma72wjmjskEwRrffFLt766yMz7sL3rrB5AlzghXmsbSPw=
X-Received: by 2002:a4a:96b3:: with SMTP id s48mr7749758ooi.11.1611755235898;
 Wed, 27 Jan 2021 05:47:15 -0800 (PST)
MIME-Version: 1.0
References: <1611752257-150851-1-git-send-email-zhangxuezhi3@gmail.com>
In-Reply-To: <1611752257-150851-1-git-send-email-zhangxuezhi3@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Jan 2021 14:47:04 +0100
Message-ID: <CAMuHMdV=dsLv0stGa8OThOYLz2xG0Gg7EOYuFcKBeu+T_wANuw@mail.gmail.com>
Subject: Re: [PATCH v9] staging: fbtft: add tearing signal detect
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, Stefano Brivio <sbrivio@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Carlis,

On Wed, Jan 27, 2021 at 2:03 PM Carlis <zhangxuezhi3@gmail.com> wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
>
> For st7789v ic,add tearing signal detect to avoid screen tearing
>
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> ---
> v9: change pr_* to dev_*

Thanks for the update!

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
> +#define SPI_PANEL_TE_TIMEOUT   400
> +static struct mutex te_mutex;/*mutex for tearing line*/
> +static struct completion spi_panel_te;
> +
> +static irqreturn_t spi_panel_te_handler(int irq, void *data)
> +{
> +       complete(&spi_panel_te);
> +       return IRQ_HANDLED;
> +}
> +
> +static void set_spi_panel_te_irq_status(struct fbtft_par *par, bool enable)
> +{
> +       static int te_irq_count;
> +
> +       mutex_lock(&te_mutex);
> +
> +       if (enable) {
> +               if (++te_irq_count == 1)
> +                       enable_irq(gpiod_to_irq(par->gpio.te));
> +       } else {
> +               if (--te_irq_count == 0)
> +                       disable_irq(gpiod_to_irq(par->gpio.te));
> +       }
> +       mutex_unlock(&te_mutex);
> +}
> +
>  /**
>   * init_display() - initialize the display controller
>   *
> @@ -82,6 +111,33 @@ enum st7789v_command {
>   */
>  static int init_display(struct fbtft_par *par)
>  {
> +       int rc;
> +       struct device *dev = par->info->device;
> +
> +       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0, GPIOD_IN);
> +       if (IS_ERR(par->gpio.te)) {
> +               rc = PTR_ERR(par->gpio.te);
> +               dev_err(par->info->device, "Failed to request te gpio: %d\n", rc);

This also prints an error in case of -EPROBE_DEFER.
dev_err_probe()?

> +               return rc;
> +       }
> +       if (par->gpio.te) {
> +               init_completion(&spi_panel_te);
> +               mutex_init(&te_mutex);
> +               rc = devm_request_irq(dev,
> +                                     gpiod_to_irq(par->gpio.te),
> +                                    spi_panel_te_handler, IRQF_TRIGGER_RISING,
> +                                    "TE_GPIO", par);
> +               if (rc) {
> +                       dev_err(par->info->device, "TE request_irq failed.\n");
> +                       devm_gpiod_put(dev, par->gpio.te);

No need to call devm_gpiod_put() here, as it's managed automatically.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
