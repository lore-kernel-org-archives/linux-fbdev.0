Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7146C4338F
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Aug 2021 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5D1610A6
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Aug 2021 11:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhHALl0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Aug 2021 07:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHALl0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Aug 2021 07:41:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77959C0613CF;
        Sun,  1 Aug 2021 04:41:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q2so16428598plr.11;
        Sun, 01 Aug 2021 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7CbcU24c2EcgEh6gPwl360Lbo6a4Vh6iTk5nFSY/dA=;
        b=qZkxBAhluE0p43cVISH+ol5q1lT+cnqxEql+NIpY08L6/PwowG/tSK7brsoB2dM+g4
         IsHCS42s3dWQ01GIdqQ2VK4IM4bOGJ/yx24/hAOvNqWJwbxbsCpKnF2rkFffMdNgwFrC
         6NjZdCRVEFlKZINxUnEFV2Xkrte76bs6chq7lWN6s9gbkliRtcbETJiv3JjWBY+ROuau
         7QBHcX8eOM8aLEoJRqNtPiQlkpD6wYCOuSCf3CNuwnvCF9AIupQzAS+CZdWu+b/WV2XR
         qiQPlqwMe4USOYxSrqo6WEDk1pAoQV5dne9UdThjajtzvP3R06+MzqdQCnGXvELPeNu9
         9QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7CbcU24c2EcgEh6gPwl360Lbo6a4Vh6iTk5nFSY/dA=;
        b=rhjN0+cvtH1UbHxWwBoo4DUYT1LYbmoJd7jraURwRnyWJp26Mc9BPpG2sUqWUG3WMs
         CS+7hXp1nx0mN4iraqBxAD++mM5z9Zu7xByYOoo0VJs2m4XBIMafzYRIBUe7L9cvKCed
         G86+QjIMPpvoKWKYtHdLALaNnOmzIsIm0M9ph5btjCrQRcFqauT6rIAYbj5nDMTdI89K
         aexxV2P5ojENbanlU1L5H7hObCPkz7w0le2fYzGz229iRPFN+ERe4F49khxqph3jSf0S
         GRTep5l1FVyb6dBiuP8lc0OwdomAkiwKFc4NfRZEGxadHKXSmaEKeGdrbMZVqdLdBexB
         Qihg==
X-Gm-Message-State: AOAM532J3joKURSTds1NX5+pVGQvJJXtiaSSF4MjkbxvTcOivszjBkcU
        fkRvVwvbQGaoLVXiRMTjuXddqT+1IZz/Jsc2DYc=
X-Google-Smtp-Source: ABdhPJydhwxZ12g/won3lYfp7ROJMWycWxQ5X9RiPATUxhjXxXP+UgIyRIZYxpjob21kv49ZmMn2kBq09Ob2FCmxc98=
X-Received: by 2002:a63:1457:: with SMTP id 23mr1761825pgu.203.1627818076930;
 Sun, 01 Aug 2021 04:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210801085155.3170-1-len.baker@gmx.com>
In-Reply-To: <20210801085155.3170-1-len.baker@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Aug 2021 14:40:40 +0300
Message-ID: <CAHp75VcD_Kqedpkw-Pj+uQbWqdu_9FhXqJS5TuGUPoVv2x45-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove all strcpy() uses
To:     Len Baker <len.baker@gmx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Reid <preid@electromag.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Aug 1, 2021 at 11:53 AM Len Baker <len.baker@gmx.com> wrote:
>
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. So, this serie removes all strcpy uses
> from the "staging/fbtft" subsystem.
>
> Also, refactor the code a bit to follow the kernel coding-style and
> avoid unnecessary variable initialization.

I don't see patch 3 (even on lore.kernel.org).

Greg, Geert, does it make sense to move this driver outside of staging?
I would volunteer to maintain it there.

> Changelog v1 -> v2
> - Add two new commits to clean the code.
> - Use the "%*ph" format specifier instead of strscpy() function (Geert
>   Uytterhoeven)
>
> Changelog v2 -> v3
> - Change the initialization of the "j" variable in the "for" loop and
>   update the code accordingly (Andy Shevchenko).
> - Improve the commit message to inform that the "%*ph" replacement
>   won't cut output earlier than requested (Andy Shevchenko).
> - Don't remove the braces in the "if" statement due to the presence of
>   the comment (Geert Uytterhoeven).
>
> Len Baker (3):
>   staging/fbtft: Remove all strcpy() uses
>   staging/fbtft: Remove unnecessary variable initialization
>   staging/fbtft: Fix braces coding style
>
>  drivers/staging/fbtft/fbtft-core.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
