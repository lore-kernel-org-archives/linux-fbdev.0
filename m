Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7798C4742C
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 12:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99170223BE
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 12:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgKBMHb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 07:07:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32894 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgKBMHb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 07:07:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id i18so7634820ots.0;
        Mon, 02 Nov 2020 04:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWn+Kk/LR4CLIgSUL0WH6BKPKleAbhlLjsDWMUTt58o=;
        b=OGCGuNYsnF6bZQrmfnLloFoaLLQT6av28FbAsgTn8qBzsQsTEcxWJZGmVL+OoIlpfP
         F+sV7UVzjUoINI0g6B5OApgdZ2YWM6ArZem4UjchV63UMr/Nxvlau9WQDk7MaQVgACtq
         bgrNdhcsjEm79WyIR3YOvXtpqCXqIdbzO5t8Eze7iIKZqFz85pYvPJUHzGYuxKzUCYQA
         0hkiWHNr3oe+VAN979Kz3KNRNPTe6qyhGG1Wp7690SPuw9nZHK3uPwd6S54Mx64oHc58
         6mvngu0tyEwILufZ+FX6dfB26mQ6QrF6xVk2iLJOMDmMbsZJ7Ab2BYFXzmLJ3Sirjsd1
         9VIw==
X-Gm-Message-State: AOAM531KDxQgUauaq6QtJ1IAB/P1YhtRTIYyPSMZ94nCIn+kjLgMTzXR
        XpKhV6NTI6u40xS2AfoRm3B0PjVxBO+pjb3rMqc=
X-Google-Smtp-Source: ABdhPJyFypih8UMfOlykjPRwRHXVCVKB5c89XVgMwoQBxNZrG6+ay9sZCqu7sy7TriXcc4FKBnp9ZrBZI0G4QkAfnbY=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr11857209otb.250.1604318848768;
 Mon, 02 Nov 2020 04:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20201101102941.2891076-1-geert@linux-m68k.org>
 <20201101112915.GB1263673@ravnborg.org> <874km91by4.fsf@igel.home>
 <CAMuHMdUMF4R91Nt6mv9Tqz0zSaNh7AV8mghUoKL+uO-_PUH2aQ@mail.gmail.com>
 <87mu0014kn.fsf@igel.home> <CAMuHMdX4dferHsLJ_z7GOC3R=LxZMKUBvhE-ff+jtw2H8x2MtQ@mail.gmail.com>
 <87eelc127t.fsf@igel.home>
In-Reply-To: <87eelc127t.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Nov 2020 13:07:17 +0100
Message-ID: <CAMuHMdUUzkCzr+BG+=adMr6iU5zD6D-C=wcHJekBDN_8wL359A@mail.gmail.com>
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

On Mon, Nov 2, 2020 at 11:29 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Nov 02 2020, Geert Uytterhoeven wrote:
> > But 95 MHz sounds too low to me, and doesn't match the monitor docs.
> > Given the TT runs at 32 MHz, 32 * 4 = 128 MHz sounds reasonable.
>
> Since it is not programmable, the actual value doesn't matter anyway.

It does, to implement fbdev mode rounding rules.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
