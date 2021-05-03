Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8DAC433B4
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A980661139
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 May 2021 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhECRL0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 May 2021 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhECRJW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 May 2021 13:09:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFECC06138D;
        Mon,  3 May 2021 10:08:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h20so3176024plr.4;
        Mon, 03 May 2021 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrRWmFjrLRqx+OLwKIC7R/uG9pdSkec2h+vi6VT8VLY=;
        b=Jp74gdkkTmgDo9v4VOfTpJWRqlLJFaozRUNlQT7QkD5ejT0wnbC50osv1BWfZqR/qq
         Ba4U5mUYkXkha4Z4pxqJ/CPZR7j7vcOZ4mOs7ks7D/OniKWFLQ0QeSVylaOnlHu3tFah
         PvZbNIVFG7qeMhr6zz6zSR2DL5LCjy3RnqNS+H9cmjYfR/27ZMkDmLv0fDyXAeFZvMD1
         WnVIGY76KEtZrqr4kaP+vXWQaQylfPx/bWxiYC7prQAnTPFDT8skawp6RHzJyuZAekxg
         92y+HljpwYO4uNzy9fGbUm5IYxIbSNIAzM5okopoBm5Cy8j3R4MjfanI+ReWGcJmwurM
         pAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrRWmFjrLRqx+OLwKIC7R/uG9pdSkec2h+vi6VT8VLY=;
        b=tgVCdfMPRWmpoND1fO3BjByeYjmCGCXaLaXkYfWkeXknMOwC4/KP8o8ttRhU5R2kQJ
         7YdEJyntouUp9yOuPqiwz7HxZJfjM7bbiJCxvS8MXWbKV3ifxtmC7AchdEe4OSG/ACJY
         frQfnWYhWZ/nhDROCuX5dtMLALs2Dr6U93b00IM/93Eap8NXh88+BdSraRQNTa/mGe1b
         gGN2NQ/zapNBekuFL6w39Cmalcti/sRn6vOvkUhLcA7W0ipVM4sS6V9s7XL3WoXUKHtL
         pq1AvrcD7lx8QzKNpBDblwA6/k7I3lv27FVhamoJ98p7MIHV9QK5CqIsI9nUrFPwluPN
         l7Kg==
X-Gm-Message-State: AOAM531/n5QUGA9udvwSK0LIFxCvvmg3/zmy8SiCLAFNPt0yj8U+nK0W
        M6/hGyzD0tKeVqWKVj7dCFpZz3XL07KV5ossgD4=
X-Google-Smtp-Source: ABdhPJxMSaqHagIBw/RaN/Jrt5UgDo95VR2FBt5AZ/JmWispzseF85caEUVyTm8/e3OxIIvge/eTA9e/CFlO1Lga2Yk=
X-Received: by 2002:a17:902:264:b029:eb:3d3a:a09c with SMTP id
 91-20020a1709020264b02900eb3d3aa09cmr21437040plc.0.1620061708582; Mon, 03 May
 2021 10:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210428130415.55406-1-andriy.shevchenko@linux.intel.com>
 <20210428130415.55406-2-andriy.shevchenko@linux.intel.com> <YJAm6D2LUtVz1YNa@kroah.com>
In-Reply-To: <YJAm6D2LUtVz1YNa@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 May 2021 20:08:12 +0300
Message-ID: <CAHp75VeBbjpczF0ggQ3STySnj15dthPNF_-=b9VXNeMyb_LY8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] staging: fbtft: Rectify GPIO handling
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.net>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 3, 2021 at 7:46 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 28, 2021 at 04:04:12PM +0300, Andy Shevchenko wrote:

> > Fixes: 92e3e884887c ("Staging: staging: fbtft: Fix GPIO handling")
> > Fixes: b918d1c27066 ("Staging: staging: fbtft: Fix reset assertion when using gpio descriptor")
> > Fixes: dbc4f989c878 ("Staging: staging: fbtft: Fix probing of gpio descriptor")
> > Fixes: c440eee1a7a1 ("Staging: staging: fbtft: Switch to the gpio descriptor interface")
>
> I get the following error when trying to apply this:

Argh, i replaced over all commit messages when added staging prefix.
Thanks for catching this!

> Please fix up for your next version of this series.

Will do!

-- 
With Best Regards,
Andy Shevchenko
