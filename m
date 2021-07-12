Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A3C07E9C
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 11:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAB460FF1
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 11:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhGLLVV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:21:21 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:37721 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbhGLLTR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 07:19:17 -0400
Received: by mail-vs1-f48.google.com with SMTP id bf5so2649668vsb.4;
        Mon, 12 Jul 2021 04:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wb2gUE9RppEYjBtkun4RSMhw4ORgLmf2nLZuAw7U5rs=;
        b=StPlbCjAFgQdBd0aTM1bWpS0OvScsaQmYapsRIMhn174Fud8LhKNm+u71Zlg9DqEs8
         64GRj+RyaOXTeCOKUmnpxgSE03ayMzuqO0NxjEH0zzXJwP8634yn9siQaw/7MqDa4LmD
         SMUMcD//lUlzGhfbYOw1qWQJtON/202hr/owRoU//gh0QBp7z5Nzij8+8Gr2xtumA6BO
         ZIqv57XLia74g8srgrg9Kmz4Nwqn3qesWKLrr7XKyOByuk+nwQCJC7Vrfas27IbFVGf7
         a1vAcCBXeQCzilFtYoepkS8en5iABu6668OUezUbjXnEl8m+LPRcNWQd01g6FrALdn71
         9pXw==
X-Gm-Message-State: AOAM531mdFxOMVLfommr9UjjDsUGAC71n7tBwld6xrvkCQOrsRr6ggCN
        1bzsJsCkOiputudnHKII2xmNM0fP0QleRFAwRew=
X-Google-Smtp-Source: ABdhPJz0UtKPrQqYn0Fh3Lvo66wMSx+CxMp4eWOcF50Zng7y+eFTenh5uXzhQL0cCTFvRF5k0AF5lklpAfR2sB4/kAY=
X-Received: by 2002:a67:f98c:: with SMTP id b12mr47329347vsq.40.1626088588696;
 Mon, 12 Jul 2021 04:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210709010055.86663-1-someguy@effective-light.com>
 <CAMuHMdWhs4en-yR9ic+d4V9M_0BUFX40rP0M=tZRGMaUy2wv3g@mail.gmail.com> <UBYZVQ.O83H1QJFD7TX@effective-light.com>
In-Reply-To: <UBYZVQ.O83H1QJFD7TX@effective-light.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Jul 2021 13:16:17 +0200
Message-ID: <CAMuHMdUpGDarCkvAxe1V0c4kn68dHZozdDOq+Tyx9qsCWWZU6w@mail.gmail.com>
Subject: Re: [PATCH] fbcon: garbage collect fbdev scrolling acceleration
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Hamza,

On Fri, Jul 9, 2021 at 11:28 PM Hamza Mahfooz
<someguy@effective-light.com> wrote:
> On Fri, Jul 9 2021 at 09:49:02 AM +0200, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Bummer, more code to revert to re-enable acceleration in the _56_
> > fbdev drivers using acceleration (some of them unusable without),
> > despite commit 39aead8373b3 claiming "No other driver supportes
> > accelerated fbcon"...
> Should they be refactored to DRM drivers? (I don't mind looking into it
> if you believe it's worthwhile.)

Probably some of them can be converted.
Others must wait for DRM to gain e.g. more "low color" support
(plus whatever other dead bodies to be found during the conversion).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
