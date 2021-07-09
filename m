Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D9DC07E9C
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 07:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F5461396
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Jul 2021 07:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhGIHv6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Jul 2021 03:51:58 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:36709 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhGIHv6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Jul 2021 03:51:58 -0400
Received: by mail-vk1-f176.google.com with SMTP id h9so1400858vkp.3;
        Fri, 09 Jul 2021 00:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehlBa+HtjKV4+ykQO254b/PW48csECL6xnzySzLyqo8=;
        b=gObfKyggDkREeJNMs9B2nYQHQCO++VS4LVWB2LJ8AZXN6eb4uVR75bPyEdDDOeYCzw
         GqrOevPX3K+zl6K/8V62X3dFZtyhhhi5B0BVNB0/yBFsdyIxK5/9lzAR0xlF0/qznmf5
         zYk4WAG813/X+J5dh1rrOH6NWGU1qxiQPy/JZAGycpHdnlu85Pi8xfECYc6gqIQqaSqN
         oys5q6WW38BGnYdbKWkVdFA22sdrbVmi00+tTblCkaf3fyttispPuw+TZPazTqftRsFr
         eX9DWvv1iqw21jni4mg0c+kQrTGt5N/COskXavtzcRTZoYvQ3Y1oAkiKkYfMHE5eBIZ7
         csFQ==
X-Gm-Message-State: AOAM531NAatWibdFZGNgQapYufniG/GO5WJDEEtNNpLD95m3gPtkUeI4
        tsEy4bkASF7oyZWKiGOUPlQjD+rqltVVz7nH/0I=
X-Google-Smtp-Source: ABdhPJw2UDBcz9da1MB6qrpiT6AxAXFguCuHCKvYha65Fne8x78kJ+6SQYYVOOu55/IoqF0T6RhQj6eIUds0SfdAcrg=
X-Received: by 2002:a05:6122:588:: with SMTP id i8mr20230622vko.6.1625816953655;
 Fri, 09 Jul 2021 00:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210709010055.86663-1-someguy@effective-light.com>
In-Reply-To: <20210709010055.86663-1-someguy@effective-light.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jul 2021 09:49:02 +0200
Message-ID: <CAMuHMdWhs4en-yR9ic+d4V9M_0BUFX40rP0M=tZRGMaUy2wv3g@mail.gmail.com>
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

On Fri, Jul 9, 2021 at 3:04 AM Hamza Mahfooz
<someguy@effective-light.com> wrote:
> As per commit 39aead8373b3 ("fbcon: Disable accelerated scrolling"), we can
> now remove all of the code that was made redundant by disabling scrolling
> acceleration.

Bummer, more code to revert to re-enable acceleration in the _56_
fbdev drivers using acceleration (some of them unusable without),
despite commit 39aead8373b3 claiming "No other driver supportes
accelerated fbcon"...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
