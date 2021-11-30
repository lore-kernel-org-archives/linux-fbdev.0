Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B6FC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Nov 2021 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhK3IUJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Nov 2021 03:20:09 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:37779 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhK3IUJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Nov 2021 03:20:09 -0500
Received: by mail-ua1-f51.google.com with SMTP id o1so39695242uap.4
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Nov 2021 00:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tvLL9kOtzMPDSDABpyDexTlx7DFRm6dXyi4fSUyw0k=;
        b=A80dWB+hY5PgWpc+3sb2uQtfCf+kiaguSAOsYZkk9W2jpF+tSlcyKy8qmH66DLYJ29
         nKcAXNzf2TUiMRI3GMxf2guw3cC6FzT8NWJf45GCRbI5EJKR7rmvMp/sZHwv3hBNKGDz
         zBLJPpdiu4hspWyehxjv2M044E4jdnD1TNYWtDWy9nmUftxrjh8g86hGp24OO81MawQx
         s5JJZLZtk/cGc+Vb/93yF/1LHxdmS+95hft2YG5fl6LgV+CL20crBbGJhS45toUrmVfT
         MMi41QQAwu6c/ftcSg6UGVJ1eBWZ34xjvfCz5lvKU9X/j0bNdFrGJXAAQ37Jhz9ZOJfM
         L1tA==
X-Gm-Message-State: AOAM530rxekeEtkjmf3nK1ubu8ArA8dL34gy191MtxI2ujBCBjoTbiVs
        Pa2kb/eCWfdaOYcJeDlXMXmCG013W7npLA==
X-Google-Smtp-Source: ABdhPJz5PLZCQXiKcMZ0PCpQBLLVDJD+uqzIrKMLk3a86rSxHzJFBgSjqR/r2aGxuI6XNoCBuGNiyw==
X-Received: by 2002:a67:ff1a:: with SMTP id v26mr38849800vsp.25.1638260209725;
        Tue, 30 Nov 2021 00:16:49 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id u145sm10580677vsu.25.2021.11.30.00.16.49
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 00:16:49 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id j14so39584752uan.10
        for <linux-fbdev@vger.kernel.org>; Tue, 30 Nov 2021 00:16:49 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr37823915vst.5.1638260209223;
 Tue, 30 Nov 2021 00:16:49 -0800 (PST)
MIME-Version: 1.0
References: <aadbd32c-c0ab-4c8a-c590-3334f736f224@gmail.com>
In-Reply-To: <aadbd32c-c0ab-4c8a-c590-3334f736f224@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 09:16:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_90XdFZM6kVA78XUX+7+Jm1WqjBmBN7irVOY3k-Gcfg@mail.gmail.com>
Message-ID: <CAMuHMdU_90XdFZM6kVA78XUX+7+Jm1WqjBmBN7irVOY3k-Gcfg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: add spi_device_id table
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Heiner,

On Mon, Nov 29, 2021 at 10:12 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> After 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> compatible") we need the following to make the SPI core happy.
>
> Works for me with a SH1106-based OLED display.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for your patch!

> --- a/drivers/staging/fbtft/fbtft.h
> +++ b/drivers/staging/fbtft/fbtft.h
> @@ -307,12 +307,19 @@ static const struct of_device_id dt_ids[] = {                              \
>                                                                            \
>  MODULE_DEVICE_TABLE(of, dt_ids);                                           \
>                                                                            \
> +static const struct spi_device_id spi_ids[] = {                            \
> +       { .name = _compatible },                                           \

Shouldn't this be the part of _compatible after the "<vendor>," prefix?

> +       {},                                                                \
> +};                                                                         \
> +                                                                          \
> +MODULE_DEVICE_TABLE(spi, spi_ids);                                        \
>                                                                            \
>  static struct spi_driver fbtft_driver_spi_driver = {                       \
>         .driver = {                                                        \
>                 .name   = _name,                                           \
>                 .of_match_table = dt_ids,                                  \
>         },                                                                 \
> +       .id_table = spi_ids,                                               \
>         .probe  = fbtft_driver_probe_spi,                                  \
>         .remove = fbtft_driver_remove_spi,                                 \
>  };                                                                         \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
