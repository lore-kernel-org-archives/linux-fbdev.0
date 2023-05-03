Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646EC77B78
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 May 2023 15:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjECPCT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 May 2023 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjECPCS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 3 May 2023 11:02:18 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D349F9
        for <linux-fbdev@vger.kernel.org>; Wed,  3 May 2023 08:02:17 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-55a1462f9f6so40050067b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 03 May 2023 08:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683126136; x=1685718136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOlHKfxuJYPRynZEw9AN6Z+6KcLUXuz7CAX0Jz+d/Q8=;
        b=dzN1iRCzT9Zc3025bSkKnoS3o2fgWzjwUo2fiG5LG1mHmoe3/ei9jD4yElrxIMASw8
         w8iApCUXxa6FMOMQjShJfYjofdFCYObI0LhMB9BjgfkbdEXH03ty2J+dolKnytNRtkBL
         YQrQYwRwcAavXUlRP8UgM3cxM9cN6wCAQizAJM+QCrchxxBKZdkQFyReI9fsEdBMGyx2
         1Ib3h8x81MR4IjwDaum6GJpPGr7WvcjrvRwfU04HG/KF7sUS1wCEFiJ8TxgXmoubkgxf
         JOqoJXHYjZj0+0zIIU7tV00gnRz/FvRrpT+fAnuPV7DpZDYAmiLyIYbIU1+fqr0IncVh
         chbw==
X-Gm-Message-State: AC+VfDyqvFf2YDwn91ThTbujXJwiqLQB8AqWyxp1jOszIXbqwBE9joFz
        JQ63oCVjlQic5n06Gq8Yn03AKkFu8XQr8Q==
X-Google-Smtp-Source: ACHHUZ7pyynixsVFqMXSRrJ9ZgtpIGrmNha8covUTUZr3HSx/Z9ZhutIGrG5DqiQaGJQvG8yy8QLqw==
X-Received: by 2002:a81:52c5:0:b0:55d:6b67:f478 with SMTP id g188-20020a8152c5000000b0055d6b67f478mr173999ywb.4.1683126135653;
        Wed, 03 May 2023 08:02:15 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id a3-20020a818a03000000b00545a08184edsm176070ywg.125.2023.05.03.08.02.14
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 08:02:15 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b99489836aaso4448671276.0
        for <linux-fbdev@vger.kernel.org>; Wed, 03 May 2023 08:02:14 -0700 (PDT)
X-Received: by 2002:a05:6902:723:b0:b99:8359:b485 with SMTP id
 l3-20020a056902072300b00b998359b485mr23672462ybt.18.1683126134306; Wed, 03
 May 2023 08:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230428122452.4856-1-tzimmermann@suse.de> <20230428122452.4856-18-tzimmermann@suse.de>
 <CAMuHMdUgsUsNaCvSA+jUNrOvZU3O2xF0b=MnA_GyL-HvAeZy5Q@mail.gmail.com> <310b1de3-589d-189b-e6b7-1e146a86f185@suse.de>
In-Reply-To: <310b1de3-589d-189b-e6b7-1e146a86f185@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 May 2023 17:02:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD85QqpH5JN=-8bj-8Hsb_opiM1xF0Vu7Cc3_4r2kRAA@mail.gmail.com>
Message-ID: <CAMuHMdXD85QqpH5JN=-8bj-8Hsb_opiM1xF0Vu7Cc3_4r2kRAA@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] fbdev: Validate info->screen_{base,buffer} in
 fb_ops implementations
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        teddy.wang@siliconmotion.com, deller@gmx.de, javierm@redhat.com,
        dri-devel@lists.freedesktop.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Wed, May 3, 2023 at 4:30 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 03.05.23 um 11:51 schrieb Geert Uytterhoeven:
> > On Fri, Apr 28, 2023 at 2:26 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Push the test for info->screen_base from fb_read() and fb_write() into
> >> the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
> >> the driver operates on info->screen_buffer, test this field instead.
> >>
> >> While bothi fields, screen_base and screen_buffer, are stored in the
> >
> > both
> >
> >> same location, they refer to different address spaces. For correctness,
> >> we want to test each field in exactly the code that uses it.
> >
> > Not a direct comment for this patch: and later the union can be split
> > in two separate fields, to protect against misuse?
>
> No idea. Currently we have sparse that warns about mismatching address
> spaces if the fields are mixed up. That's good enough, as far I'm concerned.

The potential issue that is still present is that an fbdev driver uses
fb_info.screen_base, and configures the use of drawing ops that use
fb_info.screen_buffer (or vice-versa), which will happily use the wrong
type of pointer.  Sparse doesn't protect against that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
