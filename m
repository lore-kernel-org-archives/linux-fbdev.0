Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8455CC433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A1264DA1
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 11:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhA1LQW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 06:16:22 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36173 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhA1LQV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 06:16:21 -0500
Received: by mail-oi1-f179.google.com with SMTP id d18so5626586oic.3;
        Thu, 28 Jan 2021 03:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd5PNi4LgX7OKjGEh2rWr1MKY8PE+Pg7m1CEP8sv6GY=;
        b=YUM9daOipxYUjY+aerlJwoLOSeCjDta4mgRXvJR0U2sW9WGI3KIl7hjfpxET5hhOuQ
         Lmi2PKdYEYv82hGN0H/8TS1j8NLlvmvhVg3Py/h3esMmuzCctfPQIvnkD5DW2NkT8QCF
         pSf/IGkrrv/iOSZizDoZAthyqxYQRih/+oIpfPEsYkkDVfwqe7jYlLUKMKohidvKvUnn
         XBLCiVMcza3Fu+4uo9BhA92gm5hm8VUm+IWxiDN0qix7Kgel0+8ONZYl+AW/BcZjN4O0
         1k8HcRzLfrUDf0RiwLLpEjXpGSUxsN4hfqELQk5AO2Dpb+r6mp+trZ70PAkAEY/1Px3e
         dh2Q==
X-Gm-Message-State: AOAM532LCTc7FgDW62jUFA9DOoyc8xgGp1CotwzlgNyYohOF9Nvz8JsW
        uP5Fcrfu0zBBzQXK/1z1vIB3xG1W76sRabYHV3M=
X-Google-Smtp-Source: ABdhPJyZxo7oaV1z7wTWsc6iUF4z5GhFU+GNZ7f4+addjArPHWz87F5g7De+F5c7WDnpI8dzJr3s11uSeCtqxFL4kZw=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr6107548oiy.148.1611832540494;
 Thu, 28 Jan 2021 03:15:40 -0800 (PST)
MIME-Version: 1.0
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
 <20210127223222.3lavtl3roc4cabso@kari-VirtualBox> <20210128094258.000012c3@gmail.com>
 <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox> <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
 <20210128190301.00007ebe@gmail.com>
In-Reply-To: <20210128190301.00007ebe@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jan 2021 12:15:28 +0100
Message-ID: <CAMuHMdX50YJ6_=maJveDk=dh+suFeCEtarWrqoP_gNMP9k922Q@mail.gmail.com>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
To:     carlis <zhangxuezhi3@gmail.com>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Thu, Jan 28, 2021 at 12:03 PM carlis <zhangxuezhi3@gmail.com> wrote:
> On Thu, 28 Jan 2021 10:42:54 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 28, 2021 at 7:53 AM Kari Argillander
> > <kari.argillander@gmail.com> wrote:
> > > On Thu, Jan 28, 2021 at 09:42:58AM +0800, carlis wrote:
> > > > On Thu, 28 Jan 2021 00:32:22 +0200
> > > > Kari Argillander <kari.argillander@gmail.com> wrote:
> > > > > >  #include "fbtft.h"
> > > > > >
> > > > > >  #define DRVNAME "fb_st7789v"
> > > > > > @@ -66,6 +69,32 @@ enum st7789v_command {
> > > > > >  #define MADCTL_MX BIT(6) /* bitmask for column address order
> > > > > > */ #define MADCTL_MY BIT(7) /* bitmask for page address order
> > > > > > */
> > > > > >
> > > > > > +#define SPI_PANEL_TE_TIMEOUT     400 /* msecs */
> > > > > > +static struct mutex te_mutex;/* mutex for set te gpio irq
> > > > > > status */
> > > > >
> > > > > Space after ;
> > > > hi, i have fix it in the patch v11
> > > > >
> > >
> > > Yeah sorry. I accidentally review wrong patch. But mostly stuff are
> > > still relevant.
> > >
> > > > > > @@ -82,6 +111,33 @@ enum st7789v_command {
> > > > > >   */
> > > > > >  static int init_display(struct fbtft_par *par)
> > > > > >  {
> > > > > > + int rc;
> > > > > > + struct device *dev = par->info->device;
> > > > > > +
> > > > > > + par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > > > > > GPIOD_IN);
> > > > > > + if (IS_ERR(par->gpio.te)) {
> > > > > > +         rc = PTR_ERR(par->gpio.te);
> > > > > > +         dev_err(par->info->device, "Failed to request te
> > > > > > gpio: %d\n", rc);
> > > > > > +         return rc;
> > > > > > + }
> > > > >
> > > > > You request with optinal and you still want to error out? We
> > > > > could just continue and not care about that error. User will be
> > > > > happier if device still works somehow.
> >
> > devm_gpiod_get_index_optional() returns NULL, not an error, if the
> > GPIO is not found.  So if IS_ERR() is the right check.
> >
> > And checks for -EPROBE_DEFER can be handled automatically
> > by using dev_err_probe() instead of dev_err().
> >
> hi, i fix it like below!?
>         par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
>         GPIOD_IN); if (IS_ERR(par->gpio.te)) {
>                 rc = PTR_ERR(par->gpio.te);
>                 dev_err_probe(par->info->device, rc, "Failed to request
>         te gpio\n"); return rc;
>         }
>         if (par->gpio.te) {
>                 init_completion(&spi_panel_te);
>                 rc = devm_request_irq(dev,
>                                       gpiod_to_irq(par->gpio.te),
>                                      spi_panel_te_handler,
>         IRQF_TRIGGER_RISING, "TE_GPIO", par);
>                 if (rc) {
>                         dev_err(par->info->device, "TE request_irq
>         failed.\n"); return rc;

dev_err_probe()

>                 }
>
>                 disable_irq_nosync(gpiod_to_irq(par->gpio.te));
>         } else {
>                 dev_info(par->info->device, "%s:%d, TE gpio not
>                 specified\n", __func__, __LINE__);
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
