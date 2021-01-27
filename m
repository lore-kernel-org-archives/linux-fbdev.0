Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D53C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0ED207B7
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhA0OGX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhA0OEW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 09:04:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B710C061574;
        Wed, 27 Jan 2021 06:03:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e9so1430278pjj.0;
        Wed, 27 Jan 2021 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Rm0ICr4+gWtimOBm/Mxt0G53NyPrN1eFZSwJiNK3hWs=;
        b=KEQUBMhMDJ9TfyDfOif7F0kRrW9aEPKZIr8D8LhjegOZu7ZflSg0kfzCl+pPeA0L0m
         bpxBsRWWkvx3jGY1eg6Ejx7eSvjsd2UP6PLLTpWqAvYlS1irAc8DpR0FTC89F1O+Rrvx
         kiZlGg0m80oVkQZ3L9e3oPnU+05vjunleQIeeDPXpdddVrlDTzcsuzrvSgEEkwd7GoEZ
         ywhhCwBHkoXhiSIQJbYng9UhePzUxH3jWhafmEXpr/t7qpNYD3dslMUxS7IqmQWZfwJI
         PybZJBnjFbmikkGLL5NELmObI8d93WGh9c0QVix51YF3LLj8Lr1P8KIMhlzAxlZ1LzUZ
         VgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Rm0ICr4+gWtimOBm/Mxt0G53NyPrN1eFZSwJiNK3hWs=;
        b=Ucfe71sFHngTT5HOAa7w4uYtPQFWkduNlkA0nq2NRol1xoriguFC19hMphnshzQ8oU
         ACXIfZCYr2xvHD8TSZRZSTvzZtB5dP0JV5MJzXxG/FFj6qS3782njxwJvQH3CC5xAOXi
         tNUN6U6jh8FGyKHYcvYyA0NIOSIOm81v66rq/bFxJoIDKW/DNcU0MU7VxzZDqeEkbUYR
         ZskOFzMUo7ntIDmIu69rKX4CPNirOrc8rzgbKNEd8AiCN2Wi3XTleVf8HBBhMkLZRAJY
         g0hMzAleGKbS/TiMlKPePfqAf3jWx+/a64ZyUq9iVcsE7fZBiZkqVHajBFYIDXApayRs
         P8ZA==
X-Gm-Message-State: AOAM533gT9DHkWd/zYQm6ISJSaRjlORmytQO1vZm8FEWQi8POHZ9eZ2r
        iCzDhPXF7klaMCzYCmroLDQ=
X-Google-Smtp-Source: ABdhPJydrXhdwuBTn7I8gPbvmJ5xFHq43eHnRQMEk6NQOg682yGlA8XRBj0RwNK2AJvIMbbllFSEYQ==
X-Received: by 2002:a17:90a:bc49:: with SMTP id t9mr5880493pjv.95.1611756209669;
        Wed, 27 Jan 2021 06:03:29 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 6sm2615255pgo.17.2021.01.27.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:03:28 -0800 (PST)
Date:   Wed, 27 Jan 2021 22:03:23 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        mh12gx2825@gmail.com, Stefano Brivio <sbrivio@redhat.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9] staging: fbtft: add tearing signal detect
Message-ID: <20210127220323.00007922@gmail.com>
In-Reply-To: <CAMuHMdV=dsLv0stGa8OThOYLz2xG0Gg7EOYuFcKBeu+T_wANuw@mail.gmail.com>
References: <1611752257-150851-1-git-send-email-zhangxuezhi3@gmail.com>
        <CAMuHMdV=dsLv0stGa8OThOYLz2xG0Gg7EOYuFcKBeu+T_wANuw@mail.gmail.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 14:47:04 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Carlis,
> 
> On Wed, Jan 27, 2021 at 2:03 PM Carlis <zhangxuezhi3@gmail.com> wrote:
> > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> >
> > For st7789v ic,add tearing signal detect to avoid screen tearing
> >
> > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> > ---
> > v9: change pr_* to dev_*  
> 
> Thanks for the update!
> 
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -9,9 +9,12 @@
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> > +#include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
> >  #include <linux/module.h>
> >  #include <video/mipi_display.h>
> > -
> > +#include <linux/gpio/consumer.h>
> >  #include "fbtft.h"
> >
> >  #define DRVNAME "fb_st7789v"
> > @@ -66,6 +69,32 @@ enum st7789v_command {
> >  #define MADCTL_MX BIT(6) /* bitmask for column address order */
> >  #define MADCTL_MY BIT(7) /* bitmask for page address order */
> >
> > +#define SPI_PANEL_TE_TIMEOUT   400
> > +static struct mutex te_mutex;/*mutex for tearing line*/
> > +static struct completion spi_panel_te;
> > +
> > +static irqreturn_t spi_panel_te_handler(int irq, void *data)
> > +{
> > +       complete(&spi_panel_te);
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static void set_spi_panel_te_irq_status(struct fbtft_par *par,
> > bool enable) +{
> > +       static int te_irq_count;
> > +
> > +       mutex_lock(&te_mutex);
> > +
> > +       if (enable) {
> > +               if (++te_irq_count == 1)
> > +                       enable_irq(gpiod_to_irq(par->gpio.te));
> > +       } else {
> > +               if (--te_irq_count == 0)
> > +                       disable_irq(gpiod_to_irq(par->gpio.te));
> > +       }
> > +       mutex_unlock(&te_mutex);
> > +}
> > +
> >  /**
> >   * init_display() - initialize the display controller
> >   *
> > @@ -82,6 +111,33 @@ enum st7789v_command {
> >   */
> >  static int init_display(struct fbtft_par *par)
> >  {
> > +       int rc;
> > +       struct device *dev = par->info->device;
> > +
> > +       par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > GPIOD_IN);
> > +       if (IS_ERR(par->gpio.te)) {
> > +               rc = PTR_ERR(par->gpio.te);
> > +               dev_err(par->info->device, "Failed to request te
> > gpio: %d\n", rc);  
> 
> This also prints an error in case of -EPROBE_DEFER.
> dev_err_probe()?
> 
> > +               return rc;
> > +       }
> > +       if (par->gpio.te) {
> > +               init_completion(&spi_panel_te);
> > +               mutex_init(&te_mutex);
> > +               rc = devm_request_irq(dev,
> > +                                     gpiod_to_irq(par->gpio.te),
> > +                                    spi_panel_te_handler,
> > IRQF_TRIGGER_RISING,
> > +                                    "TE_GPIO", par);
> > +               if (rc) {
> > +                       dev_err(par->info->device, "TE request_irq
> > failed.\n");
> > +                       devm_gpiod_put(dev, par->gpio.te);  
> 
> No need to call devm_gpiod_put() here, as it's managed automatically.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

hi,i will fix in patch v11
regards
zhangxuezhi1


