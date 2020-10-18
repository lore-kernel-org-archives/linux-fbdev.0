Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF01C433DF
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54E722269
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZWCwRmzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgJRUJS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgJRUJS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 16:09:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6195C0613CE
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2020 13:09:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t15so8517594otk.0
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2020 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTkIKpAXXUMsdDW0M0pmci3ckhN0Y57VkQTrzhAampI=;
        b=ZWCwRmzA1q9rUb7p8BjxAG+i4vhfm41OiL5T5ZG1GnAzhlOaxO4waXtz1aznqqxQm5
         /oy0veyH2tbq9YBXGF14heMaLwtJ2uC0ylKJ28Fv5bQAY4Xf9NljJvappbUUvvslOsUF
         n/y7UMXZeAkHNZVGiFW/izHWH2KpsQ+bkOwXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTkIKpAXXUMsdDW0M0pmci3ckhN0Y57VkQTrzhAampI=;
        b=llb1jv3YkYxFvItdjPk8poarOMVRiWbRym6YMCkZELYNqwgc+0Fxv4b1wIhGHUbTNo
         oZHrOHhO5Qj2hAkRI/wJnV+/XyUQAx+irCMtW32xXByvl19T7lJpgvk3AuJFTMkApo28
         ssVGOGmpGNR3JoofMgr2hWP4NR+XSH2Hj4RuNiy5M3BwwkGi5rdACJOT4tBtwzCtWJHc
         5WTBPXACPKg6WhtoJpD4THHdkE3gtogw2N0vOXJEKhEw0rly7y3aru8e6OA75Wr40ZhN
         xrnFfakXNgmc3hS/GZF8tqsyYJP/6R6Unp8J047Nh7GcMdQQ4nwMBEVaG0YMiaVHRXBd
         iTXw==
X-Gm-Message-State: AOAM532TuJagBF8ZIZWAbBSquvQA1dk+bruA/uT0Y92kQHr+o8D5nm2m
        fp94DWBEQrYeuePoL+3rLgBxIATwps+X2zQt2pH3Qw==
X-Google-Smtp-Source: ABdhPJxwCztnu8cd9eSC2rortQrG/hZH4mpTa2NjpeAnAc2MGwNccXKO+BizjvsWvItIcVTXrXUk+bHpiY8MDg2YKNU=
X-Received: by 2002:a05:6830:8b:: with SMTP id a11mr9517320oto.303.1603051757215;
 Sun, 18 Oct 2020 13:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200820082137.5907-1-s.hauer@pengutronix.de> <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
In-Reply-To: <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 18 Oct 2020 22:09:06 +0200
Message-ID: <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
To:     Peilin Ye <yepeilin.cs@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018200906.-1vXqc8qcvsavVKCiz8lZAJIGtXWsiDelw_dITujqNU@z>

Adding dri-devel too, not sure anyone is still listening on linux-fbdev.

On Sun, Oct 18, 2020 at 8:13 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> Recently, in commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros
> for built-in fonts"), we wrapped each of our built-in data buffers in a
> `font_data` structure, in order to use the following macros on them, see
> include/linux/font.h:
>
>         #define REFCOUNT(fd)    (((int *)(fd))[-1])
>         #define FNTSIZE(fd)     (((int *)(fd))[-2])
>         #define FNTCHARCNT(fd)  (((int *)(fd))[-3])
>         #define FNTSUM(fd)      (((int *)(fd))[-4])
>
>         #define FONT_EXTRA_WORDS 4
>
> Do the same thing to our new 6x8 font. For built-in fonts, currently we
> only use FNTSIZE(). Since this is only a temporary solution for an
> out-of-bounds issue in the framebuffer layer (see commit 5af08640795b
> ("fbcon: Fix global-out-of-bounds read in fbcon_get_font()")), all the
> three other fields are intentionally set to zero in order to discourage
> using these negative-indexing macros.
>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>

Patch looks good to me, but it says 1/2 and I can't find 2/2 anywhere,
not even on lore. Did that get lost?
-Daniel

> ---
>  lib/fonts/font_6x8.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/fonts/font_6x8.c b/lib/fonts/font_6x8.c
> index e06447788418..700039a9ceae 100644
> --- a/lib/fonts/font_6x8.c
> +++ b/lib/fonts/font_6x8.c
> @@ -3,8 +3,8 @@
>
>  #define FONTDATAMAX 2048
>
> -static const unsigned char fontdata_6x8[FONTDATAMAX] = {
> -
> +static struct font_data fontdata_6x8 = {
> +       { 0, 0, FONTDATAMAX, 0 }, {
>         /* 0 0x00 '^@' */
>         0x00, /* 000000 */
>         0x00, /* 000000 */
> @@ -2564,13 +2564,13 @@ static const unsigned char fontdata_6x8[FONTDATAMAX] = {
>         0x00, /* 000000 */
>         0x00, /* 000000 */
>         0x00, /* 000000 */
> -};
> +} };
>
>  const struct font_desc font_6x8 = {
>         .idx    = FONT6x8_IDX,
>         .name   = "6x8",
>         .width  = 6,
>         .height = 8,
> -       .data   = fontdata_6x8,
> +       .data   = fontdata_6x8.data,
>         .pref   = 0,
>  };
> --
> 2.25.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
