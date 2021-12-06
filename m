Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD44BC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Dec 2021 08:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbhLFI5I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Dec 2021 03:57:08 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:41488 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhLFI5B (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Dec 2021 03:57:01 -0500
Received: by mail-ua1-f41.google.com with SMTP id p37so18049427uae.8;
        Mon, 06 Dec 2021 00:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fa88EzZGCDt/on2PK9adyVtAB10G/5IDqGLBZHmYHC8=;
        b=KwokwK+RWxPJONzaBX8LW92uSZYvFMvjms4fcn7b8sY+Vxxf30fX1uUtUChrcTL3Y8
         BcZBtuAVWRFFlBDzaQbR4v3arKPEPVKikf6GrMCwGxMuaB4aX+AwyfqkKw/ghwHRS1hA
         v7Rxv8aMIqbDJQ4kt4SixOGAp+TUCXKePJeNfWlsfmaWf9c2SusvdkprF8GquokCX4bc
         nzZ54yWFGqVOY8wlHpo3hTm7QNBmub1YkdbMAVFZZKLuPkyk5xL5HcUbS/JYhNvHfhAn
         LYVwmzsYx5vD9R03oAlOZX4fgp0Zt1allNSvPmh0TO7e7KiCp/BqMwNy+w1ewPsD2GcB
         a9eA==
X-Gm-Message-State: AOAM531hTxCdQE2WPJZSoXtjHpfX8yyvUvikFCqrQsEf8XBwceNWonfq
        76teORUolKYynP0+6F1sF5NgHCIKk5faig==
X-Google-Smtp-Source: ABdhPJx7TrOfwq0LRXcD21wSqv37jDZ2rzVbRdyhdz+0sZFakCyNOnds9WaOmZhrI2bipq90C/Zswg==
X-Received: by 2002:a67:6741:: with SMTP id b62mr34771718vsc.59.1638780812702;
        Mon, 06 Dec 2021 00:53:32 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id b11sm3694883vsp.6.2021.12.06.00.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 00:53:32 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id t13so18046140uad.9;
        Mon, 06 Dec 2021 00:53:32 -0800 (PST)
X-Received: by 2002:a9f:3e01:: with SMTP id o1mr37900038uai.89.1638780812238;
 Mon, 06 Dec 2021 00:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20211124150757.17929-1-noralf@tronnes.org> <20211124150757.17929-2-noralf@tronnes.org>
In-Reply-To: <20211124150757.17929-2-noralf@tronnes.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Dec 2021 09:53:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUhtwXVFNCzijdtXtuRD=VeHQm2sEQ8WZfin6uBmY0QHg@mail.gmail.com>
Message-ID: <CAMuHMdUhtwXVFNCzijdtXtuRD=VeHQm2sEQ8WZfin6uBmY0QHg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: display: sitronix,st7735r: Fix backlight
 in example
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        David Lechner <david@lechnology.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 25, 2021 at 4:17 PM Noralf Trønnes <noralf@tronnes.org> wrote:
> The backlight property was lost during conversion to yaml in commit
> abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema").
> Put it back.
>
> Fixes: abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema")
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>

Mea culpa
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
