Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46921C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Nov 2021 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbhK3IRS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Nov 2021 03:17:18 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:45030 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhK3IRR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Nov 2021 03:17:17 -0500
Received: by mail-ua1-f49.google.com with SMTP id p2so39590773uad.11;
        Tue, 30 Nov 2021 00:13:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9TvqAb2dbPQyUlV58mO9YTh/iv9wO/YMHLV7b29cnQ=;
        b=MXgna4NA14LqLIGEmBKtDbgt+FbXddtya56WNgp5S8pIFOjP9lwzHGZXMOdawWe3eA
         m8LmqOZHs/CbzRKSjKhFhbmnwsiUVWhl/GpE5M2iqqKK3bcRRfYuEDZ07BR6RgswmoTz
         UnunyuvdHFyCxR4G/UBnBUlOYTXcZwHQLqUAqdvPKQOrxY9oYaMYqvLvx0EJB5HiTdnL
         eixHWF7gQBAjjdCa4akmULq9bZ1oVoU+xfni20xWfjLpZuFUXaQLnqeCuhsLIepVDt3E
         gsKMKZCH/eL6uN68KKNzxPPy7XfWI7eYe68aoG4InGviuJsvvzCfaeRwtlXKgDEKbKea
         LuSQ==
X-Gm-Message-State: AOAM533ATsxunpnPQIvnTq8SI4DyE81ICYIvGNNu7CjpBeWRpVy+TypS
        YvWz+qUPYllhwqzWde4mFvnR+4BEKAB1VQ==
X-Google-Smtp-Source: ABdhPJwOzdxFVSvcscdkZs7Yx7wDK4ztOjFR+Svhdold1XibDsmZZM150HjeKuCnJXx8t+WWrVYoCw==
X-Received: by 2002:a05:6102:11e3:: with SMTP id e3mr38127910vsg.29.1638260037575;
        Tue, 30 Nov 2021 00:13:57 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id u20sm9627679vke.0.2021.11.30.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 00:13:57 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id f7so13000735vkf.10;
        Tue, 30 Nov 2021 00:13:56 -0800 (PST)
X-Received: by 2002:a1f:4641:: with SMTP id t62mr25229885vka.0.1638260036796;
 Tue, 30 Nov 2021 00:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20211124150757.17929-1-noralf@tronnes.org> <eba23198-5c52-6520-079b-d2d41f71dc25@lechnology.com>
 <20211129093946.xhp22mvdut3m67sc@houat>
In-Reply-To: <20211129093946.xhp22mvdut3m67sc@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Nov 2021 09:13:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKcOuTjSOQmEywXWJtK+15jPD5jfxXx06JJG1f1U+fog@mail.gmail.com>
Message-ID: <CAMuHMdUKcOuTjSOQmEywXWJtK+15jPD5jfxXx06JJG1f1U+fog@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/tiny/st7735r: Match up with staging/fbtft driver
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Maxime,

On Mon, Nov 29, 2021 at 11:17 PM Maxime Ripard <maxime@cerno.tech> wrote:
> The problem that fbtft (and this series) wants to fix is completely
> different though: it wants to address the issue the users are facing.
> Namely, you get a cheap display from wherever, connect it to your shiny
> new SBC and wants to get something on the display.
>
> In this situation, the user probably doesn't have the knowledge to
> introduce the compatible in the kernel in the first place. But there's
> also some technical barriers there: if they use secure boot, they can't
> change the kernel (well, at least the knowledge required is far above
> what we can expect from the average user). If the platform doesn't allow

If you can change the DT, you can introduce a vulnerability to change
the kernel ;-)

> access to the DT, you can't change the DT either.

How do people connect a cheap display from wherever to their shiny
new SBC and make it work, without modifying DT?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
