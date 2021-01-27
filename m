Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA16C433E9
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 09:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA5822078E
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 09:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbhA0Ja5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 04:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhA0J1e (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 04:27:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F5C0613D6;
        Wed, 27 Jan 2021 01:26:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so1175732pgj.4;
        Wed, 27 Jan 2021 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VlZoZLBDHB4T/YMJIRvfZ215W20PBGmlP7rUa/kbeTE=;
        b=Rx6L/dzb+PTIyI7DqI/ktCHUMBm59DVOBMgR7YEtBRsitAiGP0B3mtvfCX5iqklZhq
         VXzl1QYGhSzgyS3d1UER9u9RkDlvCMnyGb0Z5wJKnXiBqh4pTGhN/E28k/apx6Z9imhW
         c95BvtjoreLkwhzwlCPSurK+3AVgYTsvqT7/24d6ProSzBX+FM4w3DhX5ni4/r9yKq44
         4ONeHfdbfLjPvWivYr0EP8gKpMebu2NmDwHyYnnKCLrt1QJK3eSmtGr7OcdxwmIrPBKG
         OtSaLuaUZxmyHalSyJEP/bn/Uuw4+pIdhdWyORK2s7NmPPRTqIa9NxVY02LrEX3jCrbS
         5sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VlZoZLBDHB4T/YMJIRvfZ215W20PBGmlP7rUa/kbeTE=;
        b=Vk/NwHEKPua9JsXE5ilRfDsMNbKBteCTbWJsAb5xDbHswwQ6XSmxaLZiOhnNp+TG5c
         s9gxzwyLklh2tPowN+4+Gb+RuRyO/icLJvwhOyH5zVU8kkCxPspP5vKsD22+KFnTYcfY
         sZSrTTDTmoP42jNXBKckNqkj2thljDayM47cFkw29UfHHNGMRE+bw/1NCpsHsoQdr2zu
         +jZ65TPl0r2sJlpAhusYyoqgLOVpXs7XhyKC9Wam1BEFkas0ygKNngBenAadcWq8o+zh
         rzQbGeNRcKvQUBde5I4xahhGG+OfjOc8FtQckRFUDHhNO+L8uVtJ3uy5HKNFuVc7q8Ak
         TCeg==
X-Gm-Message-State: AOAM533+1OB36gA4sThMfGdNz7waORUfunnY21RrcuLluCh6Uemz8JVe
        bLqqWkhIAqb9YlPYJc19Vb4=
X-Google-Smtp-Source: ABdhPJxk9kiZWo3vZgXC5SEmEnufwVt5fJXqLZTuie25SOyDno9HYRBGpqPOmD+gQGQ5rRynQeJcsw==
X-Received: by 2002:a65:4385:: with SMTP id m5mr10413483pgp.296.1611739597098;
        Wed, 27 Jan 2021 01:26:37 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id a21sm1829002pgd.57.2021.01.27.01.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 01:26:36 -0800 (PST)
Date:   Wed, 27 Jan 2021 17:26:31 +0800
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
Subject: Re: [PATCH v6] fbtft: add tearing signal detect
Message-ID: <20210127172631.00001846@gmail.com>
In-Reply-To: <CAMuHMdV5VxNBNV-UMswKKZmQRFUvG+pnBbOOW8XJT8pbbvmp5Q@mail.gmail.com>
References: <1611732502-99639-1-git-send-email-zhangxuezhi3@gmail.com>
        <CAMuHMdV5VxNBNV-UMswKKZmQRFUvG+pnBbOOW8XJT8pbbvmp5Q@mail.gmail.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 10:00:13 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Carlis,
> 
> On Wed, Jan 27, 2021 at 9:52 AM Carlis <zhangxuezhi3@gmail.com> wrote:
> > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> >
> > For st7789v ic,add tearing signal detect to avoid screen tearing
> >
> > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>  
> 
> Thanks for your patch!
> 
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c  
> 
> > @@ -82,6 +111,34 @@ enum st7789v_command {
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
> > +               pr_err("Failed to request te gpio: %d\n", rc);
> > +               par->gpio.te = NULL;  
> 
> Errors (e.g. -EPROBE_DEFER) should be propagated upstream,
> not ignored.
> 
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
> > +                       pr_err("TE request_irq failed.\n");
> > +                       devm_gpiod_put(dev, par->gpio.te);
> > +                       par->gpio.te = NULL;  
> 
> Errors (e.g. -EPROBE_DEFER) should be propagated upstream,
> not ignored.
> 
> > +               } else {
> > +
> > disable_irq_nosync(gpiod_to_irq(par->gpio.te));
> > +                       pr_info("TE request_irq completion.\n");
> > +               }
> > +       } else {
> > +               pr_info("%s:%d, TE gpio not specified\n",
> > +                       __func__, __LINE__);
> > +       }
> >         /* turn off sleep mode */
> >         write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
> >         mdelay(120);  
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

hi,i will fix in the patch v7
