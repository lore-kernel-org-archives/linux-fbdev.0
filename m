Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF6C432BE
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 07:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F46E6108E
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Sep 2021 07:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242519AbhIAHNy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Sep 2021 03:13:54 -0400
Received: from mail-vk1-f178.google.com ([209.85.221.178]:35711 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbhIAHNx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Sep 2021 03:13:53 -0400
Received: by mail-vk1-f178.google.com with SMTP id ay16so654562vkb.2;
        Wed, 01 Sep 2021 00:12:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OIZaaJOxzSwlBAyVUTzzSJStZdPh3eIjP+iaY26uus=;
        b=FHXuojNTTpC+ZyjBVdhvYEHNzW/PCMoIvyGyU5Excw/vlwxtwlfeQnDBDULuku+jtr
         81Qo2w5pc201jqXkDXQY10+3nBtGDke+MM5zSyBpTsq8m2pHJ/CmoAZq+kugjX1xCUvT
         R7egXRToay0PDzytwqyGaKcEMTRd92/2QixFhFVlCtrwEYC4jvZ9RqRuCZFsO/UQmYPP
         zD8henrwJ8xfxYggxsGS42JMI2UMx7Cv2midoKj1BSipmZygtSKsfqCdSiAhG5igSMcn
         uHz6wXNtBqfyg6UpBR9FVtbxM/94e8UeaWWI3HVOQxfLCVRnAvMDWvuHLxfpFdl5w//r
         AY4Q==
X-Gm-Message-State: AOAM531wMcwQEG/grPCwMO9f2u9g114kLUVk4fcNNSS7l2TIr1LPEl5D
        iWkUQkT5SdGhxzDHF012Y3XlPJ76pG5cZ02Bmbu5LvYg
X-Google-Smtp-Source: ABdhPJwQRLNOZObA78mZsGR2waDSEdFHfN+IPMckzWjh/Ic7JlwZtxoUt2HD8opLWAKvAPdjb/g3GaV+9/HP/TK9CG8=
X-Received: by 2002:a1f:2c97:: with SMTP id s145mr20725423vks.24.1630480377050;
 Wed, 01 Sep 2021 00:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000815b9605c70e74f8@google.com> <131b24e5-ee31-6f7b-42b4-c34583711913@infradead.org>
 <2fccb5d3-191c-924e-159f-1c9d423e282f@i-love.sakura.ne.jp>
 <339bfb21-8e80-c7d9-46dd-c416f87c50c0@infradead.org> <535e404d-03bf-8e7a-b296-132a2a98c599@i-love.sakura.ne.jp>
 <CAMuHMdWX7s63X_zR9329canbQkPGBVxZNG4O+_=jUut60aGR9g@mail.gmail.com>
 <5c6d2b95-31d7-0d59-5e62-2593d9a0e1fe@i-love.sakura.ne.jp>
 <CAMuHMdWbSUGRGAVi-17C3hyDBZnGLAsmbAs+wXPHiCNWWLbMpA@mail.gmail.com>
 <CAKMK7uF1cnen2UVWeOL164z1CCqOuRMC5SmM+5GvRvi7C-UOTw@mail.gmail.com>
 <CAMuHMdWNYaZxZB0Td4PFb76rrtQMumKu6cJgLi2aNnW-9NmG8A@mail.gmail.com>
 <CAKMK7uHuOQWUnsiH00QFbHKgTdjjryK0ra9We2stojXMiAVgJA@mail.gmail.com> <750ed1ae-de80-b232-4aea-79d60c212fab@i-love.sakura.ne.jp>
In-Reply-To: <750ed1ae-de80-b232-4aea-79d60c212fab@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Sep 2021 09:12:45 +0200
Message-ID: <CAMuHMdX_AM4Dg-5d9D5M=7V-PjGQZ6hYWWMmhTc4tvuq_PcdDg@mail.gmail.com>
Subject: Re: [PATCH v2] fbmem: don't allow too huge resolutions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin King <colin.king@canonical.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Sep 1, 2021 at 3:15 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot is reporting page fault at vga16fb_fillrect() [1], for
> vga16fb_check_var() is failing to detect multiplication overflow.
>
>   if (vxres * vyres > maxmem) {
>     vyres = maxmem / vxres;
>     if (vyres < yres)
>       return -ENOMEM;
>   }
>
> Since no module would accept too huge resolutions where multiplication
> overflow happens, let's reject in the common path.
>
> Link: https://syzkaller.appspot.com/bug?extid=04168c8063cfdde1db5e [1]
> Reported-by: syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>
> Debugged-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
