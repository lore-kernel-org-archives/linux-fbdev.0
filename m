Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10304C433E9
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AD464DF3
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 14:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhA1Opq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhA1Oo7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 09:44:59 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB2C061574;
        Thu, 28 Jan 2021 06:44:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u15so3454361plf.1;
        Thu, 28 Jan 2021 06:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avzsR9HHm+QL99Sb8COQafM2D/UB+zvy2SDex57jg+0=;
        b=eXPiZkGMap/Z5070F49FN5G/JWvZTAyrzydO7aluQ4YdPKVTMjqoQAhTijEoidHgT2
         gnL3A6lvV0vgnmsdRENwEFqU8LUBpyg2T8tQHJy2qGiFpfIl7jLZcutY6shsYVDK1iO3
         +i9wott36RmTUX7SUEKypiTDIHvZ55/OB6SeO9y3vV4hHz9r5SjGS/9aU8qzp6Y6FTMZ
         4tuvoUXs5SA5d0C42SQWInTx1fbKvT+Qf6gNOPXoT8J0QVmqhB7kzXifklcnxn8PO8fB
         VZeVpLHbKWU2xliR4ivEVyUe+jkg2zFjJpRdFzq9LlNzj9m57aj/pB07yjhPr1qg3Yio
         xLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avzsR9HHm+QL99Sb8COQafM2D/UB+zvy2SDex57jg+0=;
        b=QyIv8eztMyZq9gSKM9csKq2Ymcmim+W+oxUqsSLuDAFuz39Frc/Ey2HBM51FTnJUmC
         YI8BbgoJj4N6xppqDFXfwz/6alMNPclQEdY65cWn1kxreUMN4qBi+LzD8Ysj4h9rfO1g
         mzziySmeoGaS7ufnhx7f+OuXt1KkIymZyLFh/gGEPHLd+P1J+I1/z7PzonKXhcW/CSkF
         X/o+zlOyRgndC1BOOBIdg1KKyzBEcSIPkqDDMW5llqy/Ph6+bfjOcIglBNmJk2+wqcMU
         ZMFvMgXHMHJHBHuZ7AYrXpeN41VhxQHzBorK6D8oZnUfvHR638kOLqxLt2ay3UYthRZX
         /sfg==
X-Gm-Message-State: AOAM530Sq4px6u9dDmWZRAqG7BD7YNI0OzCB9lxmt0e2KMX4HfLV7z3x
        Cbj9GA+hbF5Vf0tc5NVUtakXFDKQhx+cQTQKeug=
X-Google-Smtp-Source: ABdhPJxdWZlfKzAXL6EI4mZXjZ6Qyag0y/Kfcll/RaipN/m7rOKpPNtVy7DUEFkxq10YSC0k4n+LayvZfsvZxen34VA=
X-Received: by 2002:a17:902:758b:b029:df:d1f6:9af9 with SMTP id
 j11-20020a170902758bb02900dfd1f69af9mr16603032pll.21.1611845058615; Thu, 28
 Jan 2021 06:44:18 -0800 (PST)
MIME-Version: 1.0
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com> <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
In-Reply-To: <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jan 2021 16:44:02 +0200
Message-ID: <CAHp75VcRxPVs0KHwaY8QZima489D2_hntuW0eUqdfK8HJ-gnKA@mail.gmail.com>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 28, 2021 at 4:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jan 28, 2021 at 2:58 PM Carlis <zhangxuezhi3@gmail.com> wrote:

...

> Taking all together you probably need to create a helper and use it
> inside init_display(), like
>
> static int init_tearing_effect_line(struct fbtft_par *par)
> {
>   struct device *dev = par->info->device;
>   struct gpio_desc *te;
>   int irq, rc;
>
>   te = gpiod_get_optional(dev, "te", GPIOD_IN);
>   if (IS_ERR(te))
>            return dev_err_probe(dev, PTR_ERR(te), "Failed to request
> te GPIO\n");

Sorry, here I missed the following:

  /* Absence of TE IRQ is not critical */
  if (!te)
    return 0;

>   irq = gpiod_to_irq(te); // this value you have to save in the
> driver's (per device) data structure.
>
>   /* GPIO is locked as an IRQ, we may drop the reference */
>   gpiod_put(te);

...and here:

  if (irq < 0)
    return irq;

>   init_completion(&spi_panel_te); // should be in the (per device)
> data structure
>   rc = devm_request_irq(dev, irq,  spi_panel_te_handler,
> IRQF_TRIGGER_RISING, "TE_GPIO", par);
>   if (rc)
>                 return dev_err_probe(dev, rc, "TE IRQ request failed.\n");
>   disable_irq_nosync(irq);
>   return irq;
> }

-- 
With Best Regards,
Andy Shevchenko
