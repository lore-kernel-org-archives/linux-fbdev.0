Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4551C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiBDKYf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 05:24:35 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:40466 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbiBDKYe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 4 Feb 2022 05:24:34 -0500
Received: by mail-ua1-f50.google.com with SMTP id w21so9995899uan.7
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 02:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neWYzNB/qmpg+/pe+fqv1a9W50LwNAnahFMV//r7xao=;
        b=YAF4IqX+Zprd+ZgCLNRPchvBj1nzWbZebAme2/aSIAHtd6Tkpa969ZB0SDNQtwH3kR
         GJm0fkW5a3fWc7FE6YXj8N2oMbNBxMYLPMmlHF6PZv+6lY6PNSECHR5vXR8pLpXwrmMB
         ++6ZhWpwxlgZf4FIi4u8oFeiFV7TbLrCDHOIEV0V7k5+n0Fis53iqLLKoS0grv5rhR8r
         /sHYoalhCUA2QIEqQkNGzJT2lXARxa49r+0h6jH2q7NNK2h+d3cm6G1/e+QPtZXGuqlj
         +xLYWXsh8hMElrlX8UNAZK6RebBnXuc84yQ/wuknq0NM5BZGwaGEk0YFKCcsf3vXW7/+
         7pDA==
X-Gm-Message-State: AOAM533IrLh/VlM8bUmSwr9KCG5BI9LXbeGwOtjnvidKt4/4VfqRzbMD
        ZHEiHSNOihLxyBraQuGgZwv+R3KOeILQQA==
X-Google-Smtp-Source: ABdhPJyBiOgv7rcEv+KMQpSOhewPz4apLdRP3LwIkJg7KwMCC5GKsAEtFYDLYlIQEEzb1kh+zCReBQ==
X-Received: by 2002:ab0:4d6d:: with SMTP id k45mr653265uag.55.1643970274146;
        Fri, 04 Feb 2022 02:24:34 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id x7sm363567vkg.31.2022.02.04.02.24.33
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 02:24:33 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id 35so1177349uau.3
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 02:24:33 -0800 (PST)
X-Received: by 2002:ab0:6f0d:: with SMTP id r13mr862763uah.114.1643970273615;
 Fri, 04 Feb 2022 02:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20220202135531.92183-1-deller@gmx.de> <20220202135531.92183-4-deller@gmx.de>
 <CAMuHMdWTuFt12faj58sLv3H9rN0xK-+CCTkFeEiKdLSQTU2Lmg@mail.gmail.com> <ee851128-1080-d0ae-6c55-e1816bc89e74@gmx.de>
In-Reply-To: <ee851128-1080-d0ae-6c55-e1816bc89e74@gmx.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Feb 2022 11:24:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAs9RC843oL0ME+yJSrSdVVM0Ua+T-KcrX1QTjsO1DZQ@mail.gmail.com>
Message-ID: <CAMuHMdWAs9RC843oL0ME+yJSrSdVVM0Ua+T-KcrX1QTjsO1DZQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fbcon: Add option to enable legacy hardware acceleration
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Helge,

On Fri, Feb 4, 2022 at 11:17 AM Helge Deller <deller@gmx.de> wrote:
> On 2/4/22 09:37, Geert Uytterhoeven wrote:
> > On Wed, Feb 2, 2022 at 8:05 PM Helge Deller <deller@gmx.de> wrote:
> >> Add a config option CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION to
> >> enable bitblt and fillrect hardware acceleration in the framebuffer
> >> console. If disabled, such acceleration will not be used, even if it is
> >> supported by the graphics hardware driver.
> >
> > Note that this also applies to vertical panning and wrapping.
>
> That's correct.
> Would you mind to send a patch which adds this info?

To add it where? "bitblt and fillrect" are only mentioned in the patch
description.

The Kconfig help entry just talks about "hardware acceleration",
which can mean any trick supported by the hardware.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
