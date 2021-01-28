Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D60C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B160B64D9D
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 09:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhA1Jpu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jan 2021 04:45:50 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35615 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhA1Jnr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jan 2021 04:43:47 -0500
Received: by mail-oi1-f180.google.com with SMTP id w8so5403564oie.2;
        Thu, 28 Jan 2021 01:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UQD5rzLUItAad2Pj4MS3WUwxXLDc49HJgM9YhC9w4E=;
        b=th6kE6AmrlkBPLYE5c7JauhzVY93ox9Qb/Hb6aSZSJKOFXxA/0HZLCMJXMV2lPWawk
         jAEMS+A2tukNzwFMMLxl8n7DwoN+fJyYkuZHQj/0qxttIA8n3fwAzCkaA5fKCwymssBj
         t43hs2W878P7U2Oh/9fAx/PLBC9nT0oeZPZm35l+9pAzhyKUtaIaRBLumwKv1Mdvaggs
         3iRe+WZ75vcqaWdoTZO82oeJbFrOkPtsrhs1exPi7SJHn2uhIHNorknlH5spclL2jdKu
         VbhTeTY7jbed3WUUledG4VhVgRM8PvJ6UE8WbniRZtp4lA7LciZzhzTR1IUe30rLpM4p
         pPRw==
X-Gm-Message-State: AOAM532eUGrJh75Jf+vurCdiwoNcBCE78ay9Mw/QIKKcOlxcRTPk9iuu
        L/PQDbs8UOAjswnldt/i2fPraCM5OZ6HWbsp3xI=
X-Google-Smtp-Source: ABdhPJxoZOzI4xZTWdYHcsO/prgFXGQqxvTaD/BSBKbTP3NgRRBKa973/1xtxNzdsgrR5mdE52PMmLLYLmNTUlRGhEM=
X-Received: by 2002:aca:1219:: with SMTP id 25mr6108127ois.54.1611826986355;
 Thu, 28 Jan 2021 01:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
 <20210127223222.3lavtl3roc4cabso@kari-VirtualBox> <20210128094258.000012c3@gmail.com>
 <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
In-Reply-To: <20210128065233.ji4b7ea54ihyu2l5@kari-VirtualBox>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Jan 2021 10:42:54 +0100
Message-ID: <CAMuHMdWK0wbMVJNwSW=pafsyjDVg14h2AX=haJeAkyivehP=JQ@mail.gmail.com>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     carlis <zhangxuezhi3@gmail.com>,
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

Hi Kari,

On Thu, Jan 28, 2021 at 7:53 AM Kari Argillander
<kari.argillander@gmail.com> wrote:
> On Thu, Jan 28, 2021 at 09:42:58AM +0800, carlis wrote:
> > On Thu, 28 Jan 2021 00:32:22 +0200
> > Kari Argillander <kari.argillander@gmail.com> wrote:
> > > >  #include "fbtft.h"
> > > >
> > > >  #define DRVNAME "fb_st7789v"
> > > > @@ -66,6 +69,32 @@ enum st7789v_command {
> > > >  #define MADCTL_MX BIT(6) /* bitmask for column address order */
> > > >  #define MADCTL_MY BIT(7) /* bitmask for page address order */
> > > >
> > > > +#define SPI_PANEL_TE_TIMEOUT     400 /* msecs */
> > > > +static struct mutex te_mutex;/* mutex for set te gpio irq status
> > > > */
> > >
> > > Space after ;
> > hi, i have fix it in the patch v11
> > >
>
> Yeah sorry. I accidentally review wrong patch. But mostly stuff are
> still relevant.
>
> > > > @@ -82,6 +111,33 @@ enum st7789v_command {
> > > >   */
> > > >  static int init_display(struct fbtft_par *par)
> > > >  {
> > > > + int rc;
> > > > + struct device *dev = par->info->device;
> > > > +
> > > > + par->gpio.te = devm_gpiod_get_index_optional(dev, "te", 0,
> > > > GPIOD_IN);
> > > > + if (IS_ERR(par->gpio.te)) {
> > > > +         rc = PTR_ERR(par->gpio.te);
> > > > +         dev_err(par->info->device, "Failed to request te
> > > > gpio: %d\n", rc);
> > > > +         return rc;
> > > > + }
> > >
> > > You request with optinal and you still want to error out? We could
> > > just continue and not care about that error. User will be happier if
> > > device still works somehow.

devm_gpiod_get_index_optional() returns NULL, not an error, if the
GPIO is not found.  So if IS_ERR() is the right check.

And checks for -EPROBE_DEFER can be handled automatically
by using dev_err_probe() instead of dev_err().

> > You mean i just delete this dev_err print ?!
> > like this:
> >       par->gpio.te = devm_gpiod_get_index_optional(dev, "te",
> > 0,GPIOD_IN);
> >         if (IS_ERR(par->gpio.te))
> >               return PTR_ERR(par->gpio.te);
>
> Not exactly. I'm suggesting something like this.
>
> if (IS_ERR(par->gpio.te) == -EPROBE_DEFER) {
>         return -EPROBE_DEFER;
>
> if (IS_ERR(par->gpio.te))
>         par-gpio.te = NULL;
>
> This like beginning of your patch series but the difference is that if
> EPROBE_DEFER then we will try again later. Any other error and we will
> just ignore TE gpio. But this is up to you what you want to do. To me
> this just seems place where this kind of logic can work.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
