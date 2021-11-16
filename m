Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD7C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 09:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0F161C14
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 09:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhKPJrL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:47:11 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:35510 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhKPJrI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 04:47:08 -0500
Received: by mail-ua1-f43.google.com with SMTP id l24so36774073uak.2;
        Tue, 16 Nov 2021 01:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QboxZaD2WJSCfrRwQW0wjmUeNXv+y+DA5Jn72gGB79E=;
        b=jmx7G8u+L3uZB3wuBsEDGWUMhqi9oqi+7M8g+IPTKPv95s5mgK1hkjsq4bn1yUEt9Z
         NYA56zkkyy+5tqe5uO2STcvgTcN0Aq3vX2Gqa/ng38SR1bi7qe+FZcGv8gd3gb5omLv0
         Pn2FJwLnbe71TAxetiN5AhcgUuczqMxME7Ef9JDjo2zRnxxyZQwe51z0eCbDl+wFAOUX
         22EgAwpvfRp5qIKLJUKU1fB1S8F8ZxQ2pBjHMER7JihEeVDPLOYemF63bJqHe7ElCTIv
         QoVrHMGzhYYqgmyaEetA0qZvsTmEKzTICBhxcCyJvYJGLTOhxxyFUM+3w/sCCp6LKcwu
         Q9bQ==
X-Gm-Message-State: AOAM531Za4e1AY94ertMvmkB4croDXy2Liemso4G4O8ZD7wlEWPtOZGH
        5EIkr/QZjcDd4p2dlq3G+7wUq9s7sD4gvQ==
X-Google-Smtp-Source: ABdhPJwtBbPmsN3gIDmjfj3yhbqvfc1IEcwMu18gH0i4OB4kixCL1Iv0799Owg8gKx95m1ugI/OALw==
X-Received: by 2002:a67:d491:: with SMTP id g17mr53613125vsj.41.1637055851212;
        Tue, 16 Nov 2021 01:44:11 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id g187sm10445120vsc.10.2021.11.16.01.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:44:10 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id d130so10843850vke.0;
        Tue, 16 Nov 2021 01:44:10 -0800 (PST)
X-Received: by 2002:a05:6122:50e:: with SMTP id x14mr71391026vko.7.1637055850664;
 Tue, 16 Nov 2021 01:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20211111111120.1344613-1-javierm@redhat.com> <CAMuHMdWA2V_KDpcpMw3yRKmN+6YDjmysJoz6D-6JjJs-3+XYTQ@mail.gmail.com>
 <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
In-Reply-To: <579a584a-68af-d5c9-0547-30cb1592d46f@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Nov 2021 10:43:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
Message-ID: <CAMuHMdWotEN1TtTr7douLkQPkpXE-rQgamM3GOYO1XNHbUiguw@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev: Prevent probing generic drivers if a FB is
 already registered
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Peter Jones <pjones@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Javier,

On Tue, Nov 16, 2021 at 10:30 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 11/15/21 17:20, Geert Uytterhoeven wrote:
> >> @@ -351,6 +351,17 @@ static int efifb_probe(struct platform_device *dev)
> >>         char *option = NULL;
> >>         efi_memory_desc_t md;
> >>
> >> +       /*
> >> +        * Generic drivers must not be registered if a framebuffer exists.
> >> +        * If a native driver was probed, the display hardware was already
> >> +        * taken and attempting to use the system framebuffer is dangerous.
> >> +        */
> >> +       if (num_registered_fb > 0) {
> >
> > Who says this registered fbdev is driving the same hardware as efifb?
> > This might be e.g. a small external display connected to i2c or spi.
> >
> >> +               dev_err(&dev->dev,
> >> +                       "efifb: a framebuffer is already registered\n");
> >> +               return -EINVAL;
> >> +       }
> >> +
>
> That's true, although I wonder if the {efi,simple}fb drivers should even be
> probed in that case. As I see it, these are always a best effort that are
> only useful for earlycon or if there isn't another display driver supported.
>
> Since there may be other conditions needed in order for these to work. For
> example, when using the u-boot EFI stub in most cases the unused clocks and
> power domains can't be gated or otherwise the firmware frame buffer could go
> away (e.g: will need to boot with "clk_ignore_unused" and "pd_ignore_unused").
>
> Same for the simplefb driver, if the DT node is missing resources that are
> needed by the display controller to continue working (clocks, regulators,
> power domains), the firmware setup framebuffer will go away at some point.
>
> So this is already a fragile solution and $SUBJECT doesn't make things worse
> IMO. Since not having something like this can lead to issues as reported by:
>
> https://lore.kernel.org/all/20211110200253.rfudkt3edbd3nsyj@lahvuun/
>
> We could probably do some smarter here by providing a function that checks
> if the registered fbdev drivers matches the aperture base. But I'm unsure
> if that's worth it. After all, fbdev drivers are likely to be disabled by
> most distros soon now that we have the simpledrm driver.

Checking the aperture base is what was done in all other cases of
preventing generic (fbdev) drivers from stepping on specific drivers'
toes...

But as you're only impacting efifb and simplefb, thus not crippling
generic fbdev support, I don't care that much.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
