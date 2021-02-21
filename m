Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52616C433E6
	for <linux-fbdev@archiver.kernel.org>; Sun, 21 Feb 2021 02:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2435864E44
	for <linux-fbdev@archiver.kernel.org>; Sun, 21 Feb 2021 02:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBUCfI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 Feb 2021 21:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBUCfI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 Feb 2021 21:35:08 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDD1C061786;
        Sat, 20 Feb 2021 18:34:27 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p15so7910140ilq.8;
        Sat, 20 Feb 2021 18:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DSCLn/PrHDgQxuXaE9iO1VKgiKTdkzQgivDM+i6TiI=;
        b=pAsC6+Nu9a+OFTwOmiQl0T1fUtPEtgE0JiOVylivL1IqigBvp6aXavQiufg+QSz60K
         5XeHZFu0+pKNTdenU/SWYmuan+YW6/Xc7VARY86ABYThRCUtkTDaDDHVxZHPE/R6lyMe
         U9OxWYGtfZN/i9NOGm8dWxMd1siFxMiRiNy6yPxHYwzz7dBcFETxWYHCRtyb8erBAvdt
         5mpFsoxFPkgF41+3cKLval8A45uasutmCShKNtViBCWbnSo8tTFj2fzcyrfAs8xxatMQ
         t+4JIbFD7i9QcpJpyBZfSIzqkNGu2XL4/oVcFiFnpyN9Ye/wid7m8okgBmAYomS3AfFU
         CRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DSCLn/PrHDgQxuXaE9iO1VKgiKTdkzQgivDM+i6TiI=;
        b=AeXCLH4RSJwhJ23uv7Y1Plj79M4OBrHS/pIESVXF8yUJJAfSdI9FKr4SI59v3piKas
         x+lkSD0MPflC/IDsaHxGJSYLUyTy+RBeESywa4RyXpn15UleGZ7fKqDt52MSAJQWGLvX
         spodMkJNjIbfIPSHdpWcR5P+BrZHbmhlxjsP5OFGvw3cGVOrtV2UOprTXZbWCHTOFReJ
         AssvKAKvBIA7/auWB+glxZouhCL2c+r39wA/o2mo6D26lEJv/GRu1CYTDUiW9lEJseYM
         JHUkvoL6K402YUcnIbbe0dmo+Y7py13uF7z0vy2NtwxNN3sQyhGpx1T4NnPempI1gadK
         acpQ==
X-Gm-Message-State: AOAM532lueYUv+GwW5fZYK4YZG1i+PqBEYb4W+5nNCdUwPavI4KRfuHF
        FpjzZy48whR50EXuA/fdUcRVcg2RMKlpmKkhHEj5ii02oh0=
X-Google-Smtp-Source: ABdhPJwG+0K4EODqfAlqMTm/5GEyPnFdfmjXvnUOJN4piYZOl8vsrMYOyU2L9/r60HIKWsURrPXhKN0aFjQnXCVu8dc=
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr9438794ili.260.1613874867390;
 Sat, 20 Feb 2021 18:34:27 -0800 (PST)
MIME-Version: 1.0
References: <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
 <20210221000024.358772-1-ztong0001@gmail.com> <6b35b3b2-a746-9524-3a19-82ee73427ead@infradead.org>
In-Reply-To: <6b35b3b2-a746-9524-3a19-82ee73427ead@infradead.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sat, 20 Feb 2021 21:34:16 -0500
Message-ID: <CAA5qM4A4Ckcw7R2spuKEUg_xxqyxifgaYvj=Sqo2p04KzSD2Sw@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: pm2fb: avoid stall on fb_sync
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Feb 20, 2021 at 7:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> I suppose the rest of the patch is OK since it works for you.
>
> I don't know any of this code. It would be nice to know what some
> of those pm2_RD(par, SOME_REG) mean so that I could sort of
> understand what it is doing, but don't go spending time on it
> just for me. It's not worth doing that IMO.
>
>
> --
> ~Randy

Thank you Randy. I have sent another revision.
I am also curious about those registers -- but it is hard to
accurately figure it out without datasheet --
my speculation is that it calls the device to do some sort of frame
buffer synchronizations here
Thanks,
- Tong
