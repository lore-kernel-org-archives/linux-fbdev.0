Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE68C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 21 Jul 2022 14:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGUORP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiGUORO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 21 Jul 2022 10:17:14 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5E5FAF
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:17:13 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id n2so1355692qkk.8
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlgcF/GK95Rjt3bgvSjXlIF1TgHRln+uJln/ZYG0UwI=;
        b=Yb5N9X/0lT7xwlypHgpm1bM2xsmeKIcrRQOhWjq2HA5h0Oi7Uyvj1pE1pyUFACIUje
         Z2kNWaV+sQ+FIukkBYOLSgouYh8nBsLh2+5Ouxcr6GfNJVQ4QkhZj7wgcS6olH3dGaSl
         DVe+uSqKfdDMhW/VdkfBk+cEBsXSuykD21wxk98bC5S7v9dplO+u9uQEmV1dT3jlyCpE
         lnHHWb/NyQVyty514bkm6UNX53PcYfMzCSDE3tD69oNrK4BdlTvdOQZcu8uzzwXiNkYG
         RO3ukyn++224RtNcMP+dc+hFUPXqqtTFXUdtEKhAfCxR7rxM0UwZjkh95NrJwRHhmYV6
         oKAQ==
X-Gm-Message-State: AJIora+dKxG/f3rQ6kf04OyD7360+G4PzPhjfviV1RtlamuxJ2zi2+lo
        8Kr6N2vZHLvPxpPPLPJiPa7Gqo3WnZCScA==
X-Google-Smtp-Source: AGRyM1tanwxjSXjtZmYFcq82P7nKcrBt6ePhbfWYY0SO/0qpYwcEhTdsn5MtEs3VPvLLjRyi55symQ==
X-Received: by 2002:a37:b384:0:b0:6b5:5b78:a655 with SMTP id c126-20020a37b384000000b006b55b78a655mr27087916qkf.769.1658413032528;
        Thu, 21 Jul 2022 07:17:12 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id y11-20020a05622a004b00b003051f450049sm1475214qtw.8.2022.07.21.07.17.11
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:17:12 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-31e1ecea074so18552187b3.8
        for <linux-fbdev@vger.kernel.org>; Thu, 21 Jul 2022 07:17:11 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:31e:79fd:3dfa with SMTP id
 u130-20020a816088000000b0031e79fd3dfamr4529972ywb.47.1658413031348; Thu, 21
 Jul 2022 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220718072322.8927-1-tzimmermann@suse.de> <20220718072322.8927-7-tzimmermann@suse.de>
In-Reply-To: <20220718072322.8927-7-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 16:17:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnZDu2jZyUsuCG_Z+NRUoJ_0bK2zxezo92V2XTuRgzdQ@mail.gmail.com>
Message-ID: <CAMuHMdVnZDu2jZyUsuCG_Z+NRUoJ_0bK2zxezo92V2XTuRgzdQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] fbdev: Remove conflicting devices on PCI bus
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Mon, Jul 18, 2022 at 9:24 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Remove firmware devices on the PCI bus, by calling
> aperture_remove_conflicting_pci_devices() in the probe function of
> each related fbdev driver. iSo far, most of these drivers did not
> remove conflicting VESA or EFI devices, or outride failed for
> resource conflicts (i.e., matroxfb.) This must have been broken
> for quite some time.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!

> --- a/drivers/video/fbdev/tgafb.c
> +++ b/drivers/video/fbdev/tgafb.c
> @@ -12,6 +12,7 @@
>   *  more details.
>   */
>
> +#include <linux/aperture.h>
>  #include <linux/bitrev.h>
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
> @@ -106,6 +107,12 @@ static struct pci_driver tgafb_pci_driver = {
>  static int tgafb_pci_register(struct pci_dev *pdev,
>                               const struct pci_device_id *ent)
>  {
> +       int ret;
> +
> +       ret = aperture_remove_conflicting_pci_devices(pdev, "tgafb");
> +       if (ret)
> +               return ret;
> +
>         return tgafb_register(&pdev->dev);
>  }

I am wondering which driver could possibly conflict with TGA?

Probably there are a few other drivers in the same category (tdfxfb?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
