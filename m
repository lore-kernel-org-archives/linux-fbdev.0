Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5971DC388F9
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E0022275
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgKBKLx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:11:53 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37878 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKLx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 05:11:53 -0500
Received: by mail-ot1-f45.google.com with SMTP id l36so4102627ota.4;
        Mon, 02 Nov 2020 02:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+MK4cFxcECMw6HaQcTaXJfFnCrPJFtRRdKUxORfYzc=;
        b=tuuSg2xw6VJiD8eBpp5YtdfzXdJco2kxK0S4T47rt+HI2DzJdO2wdyHQV3DNEAIGy8
         Xpayg0eEwBZqawatrQ1Mr6Pj3tCxESLjpi1DGg+siKQukP5HIGovrKcGxt5zPnqVkFh2
         HHqu3wtbVn8Xd+5k6NmO/hxyTx2peYfJxfGhAdFo/p+QDN1OJYRhX39+ilMO2iLdjIcD
         9JqvDuIgkfssZSd7xDbbsQV9CpiwElptdmyJqfoxYbqIxHwZB8cIXuECC5lQ1bMyjF0e
         r91Cd8CAVM4NZ+/EaSH8eCg8KLLa8umsp2y0f8pasDiNabTieW53U1cqT90RHzn92aQa
         iNYQ==
X-Gm-Message-State: AOAM533oLvvWT+P2j3QxooFVOL++XSWSymZaFp69TyY5R666y4Wd5yMn
        shSsO1zEiapRXidMkPoBfJsglMRWBeCz8+TMT3c=
X-Google-Smtp-Source: ABdhPJzvdcaJ88yitcdsElFUGOylbc5E2IpVL1qwbM9iBFgIynaN/FqgPkOQGBCqi1JIhXlcQqWWbP0FRWoNl3xLToY=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr11375849otc.145.1604311911293;
 Mon, 02 Nov 2020 02:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20201101102941.2891076-1-geert@linux-m68k.org>
 <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
 <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com> <87mu0014kn.fsf@igel.home>
In-Reply-To: <87mu0014kn.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Nov 2020 11:11:39 +0100
Message-ID: <CAMuHMdX4dferHsLJ_z7GOC3R=LxZMKUBvhE-ff+jtw2H8x2MtQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Andreas,

On Mon, Nov 2, 2020 at 10:38 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 02 2020, Geert Uytterhoeven wrote:
>
> > 95 ns?
>
> No, 95 MHz.

http://alive.atari.org/alive6/tt3.php agrees with you

But 95 MHz sounds too low to me, and doesn't match the monitor docs.
Given the TT runs at 32 MHz, 32 * 4 = 128 MHz sounds reasonable.

Michael?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
