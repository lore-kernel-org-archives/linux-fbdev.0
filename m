Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4664AC636CA
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Jul 2021 19:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1822E61073
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Jul 2021 19:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGRTqR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Jul 2021 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGRTqR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Jul 2021 15:46:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292E0C061762;
        Sun, 18 Jul 2021 12:43:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bt15so10058638pjb.2;
        Sun, 18 Jul 2021 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7exFBskhTjXcI0G1jQYaweC6zi6nB0YxhW9GhW8QVJk=;
        b=hTAqgsHvvgfNcEagZtVOoEg9FPZ1K7swFoeQE74LVxhVPjWe4cMJ36z1icfI5N90l0
         Q5NEeHaePN4cZlD/CHtW4Q3HajTJXac5NUjQ3Tfn2qYdk7cJOxD93QiuahCUEOdvoYan
         yWAQXjAMKElZboyb3fVwi3x1JZL/sJ6Kaf4cbOmJ4HWzjIM7H5CRcv+C/ovoiTK5KLZO
         MewH468+Xkk/Jq2ehDT+j7bKEfHjqYerJXYXfL+fUWicAa9dKBPN3mXL6A41iuyJcvu0
         q699wJgigkj4sMp84K14HXfLRz4drOEqjzlqLQhWSBDA6e5vjBNH9oe/EgXH+w0RCd+7
         LXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7exFBskhTjXcI0G1jQYaweC6zi6nB0YxhW9GhW8QVJk=;
        b=hzXQQjqBS0Dn4fcomJyCxdw5jlUTqkBv7NNsLWVST38focPuLioFLiv39VW7D2xDT3
         U86rtZtpcNuNJwPPRchhD54vpO5K89FUpr4Wnr/NtUdis/SQVXveaHnv7ITBxSWY1Ix4
         LeILry6BiLyVOILgsQLL5bT+imfUV8iUPQPx4zj10Ab0jV+IZlp95rofNGF9e69R0CEA
         Ttp6BlOg3mC/ZuARw/n59Ip8yFJVjcC7J7Xt2kPLmY7RD1aG0RzxBTsiFF84/RsWAHnW
         b73xbCQwwHC0ZHzs5at4lTbo0zNbjZcobfKJ4jgI20Qbp2izi1CD86lCncL9qLqxuHff
         X1sg==
X-Gm-Message-State: AOAM531FSTCXOaSqt7UbuJwxC+lz1d/Wl3G0M/SieLiC6nZErNQ+dHl8
        ISGzI7P6PZ1uL2KdfmZ8yJxtzuyLyOrje/xm6aw=
X-Google-Smtp-Source: ABdhPJxzjFnbQny4tL/Gtmd96c7VmxuNdY93ug+tJ2p9Dj5gOXvWXiaA+eeh1wWvAvNR+4wesFTmw2sp9FFlCmRM9oI=
X-Received: by 2002:a17:902:b198:b029:11b:2246:e374 with SMTP id
 s24-20020a170902b198b029011b2246e374mr16552094plr.17.1626637398478; Sun, 18
 Jul 2021 12:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210718133920.15825-1-len.baker@gmx.com>
In-Reply-To: <20210718133920.15825-1-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Jul 2021 22:42:42 +0300
Message-ID: <CAHp75VeEA0=KFsfdjCnBm-b9+F+NnFWJ38nkh+qtb85XdXVWog@mail.gmail.com>
Subject: Re: [PATCH] staging/fbtft: Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jul 18, 2021 at 4:43 PM Len Baker <len.baker@gmx.com> wrote:
>
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy() but in
> this case it is simpler to add NULL to the first position since we want
> to empty the string.

> This is a previous step in the path to remove the strcpy() function.

Any document behind this (something to read on the site(s) more or
less affiliated with what is going to happen in the kernel) to read
background?

...

>                 case -1:
>                         i++;
>                         /* make debug message */
> -                       strcpy(msg, "");
> +                       msg[0] = 0;

Strictly speaking it should be '\0'.

>                         j = i + 1;
>                         while (par->init_sequence[j] >= 0) {
>                                 sprintf(str, "0x%02X ", par->init_sequence[j]);


-- 
With Best Regards,
Andy Shevchenko
