Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E7C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7202764F03
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 22:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhBXWIR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 17:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhBXWIR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 17:08:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC40C061756
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Feb 2021 14:07:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d24so5414752lfs.8
        for <linux-fbdev@vger.kernel.org>; Wed, 24 Feb 2021 14:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eCdoHCVRW6Uw+htUzuKdKcryTZrIcnlOlaF3QBuNtPI=;
        b=pnfdAvL37lGRaGRydf12E8mxjbnYckr76o9iZqqwKGNIYqAxxNGTM2JCpBpoBS//2K
         BMsPbSlUCyBzB3Rob93WRFdo4i3ks0QUBkLGtf7oZ7SPl7eU/YHpQjSVZeSsc7ZYNStM
         23Wr6q1e4LcQQ4mONp2zzbsjODwEsL+LFrJWuLQQRW7x/d03v6bEe8CJvP0T3HuaUysm
         zCxzjoF2LdHmtzHjKpEuWY5sxmnhqDSORb8iZ3Mm9bO9jXNrjBTffIUjCiW1e0qO3Rkf
         lHF+n6QAknb+Z59FZvhdxmuHMZ0khMOf9GFzp68cPvCSxb1pPeoyalzTPVeXJN0e+wH0
         /Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eCdoHCVRW6Uw+htUzuKdKcryTZrIcnlOlaF3QBuNtPI=;
        b=RvvH9xggRb8n9fGoascgXoULY4aDbLxeCwkroi74aLaWFpY+YJJRVUQuGV2ZEbyL/9
         3Ft7HQgYv6Mq3GKe8sYWSqagohbhLaR5q6i6M+yizlxlYqkoL/iyiXxJdIb4+wTVh+l9
         YzFK69Q6eCE38GQm/iXfEU9fhv2jbD5G3Mqq4GeWvlBCl2cx4jmGalsxnDmS2B+xVdkG
         abo0atAk793EDS4PdCEXc+bUd8VL+BGpHMOtGy12fyHDfjDqO8YDNCYF2oyCSosAPAiw
         EpwXvAoQss32EVSS3d0PezBQw3hjfHSqY+imv3GlhFjBIloHdmoO/aq1fRFZj++Mpmbw
         I09A==
X-Gm-Message-State: AOAM5335zacZPRhFdXYXy28diPaZhfEiUriI4k3kdRnvJMVwhM91EfGT
        7wZszdu8k/bK50gLTM1Eyq3mGNwf28YO5DzYaLgiDg==
X-Google-Smtp-Source: ABdhPJz4YqzngUtUWoxP68nx2sq4pyb8wRaKvHohcg8WvubxikscM+3Aju23zh4SaSvsKF9losKLM8y7MOnikkOAKIY=
X-Received: by 2002:ac2:515c:: with SMTP id q28mr33504lfd.297.1614204454807;
 Wed, 24 Feb 2021 14:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20210224215528.822-1-rdunlap@infradead.org>
In-Reply-To: <20210224215528.822-1-rdunlap@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Feb 2021 14:07:23 -0800
Message-ID: <CAKwvOdn5mF4UQ9F1h-ZSRKUk3Yq8QS4AExV6kCFY88W3KsK72g@mail.gmail.com>
Subject: Re: [PATCH -next] fbdev: atyfb: always declare aty_{ld,st}_lcd()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 24, 2021 at 1:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> The previously added stubs for aty_{ld,}st_lcd() make it
> so that these functions are used regardless of the config
> options that were guarding them, so remove the #ifdef/#endif
> lines and make their declarations always visible.
> This fixes build warnings that were reported by clang:

Yes, though I think GCC would warn similarly with W=1 builds as well,
which was set for the 0day bot report.

>
>    drivers/video/fbdev/aty/atyfb_base.c:180:6: warning: no previous prototype for function 'aty_st_lcd' [-Wmissing-prototypes]
>    void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>         ^
>    drivers/video/fbdev/aty/atyfb_base.c:180:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>
>    drivers/video/fbdev/aty/atyfb_base.c:183:5: warning: no previous prototype for function 'aty_ld_lcd' [-Wmissing-prototypes]
>    u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>        ^
>    drivers/video/fbdev/aty/atyfb_base.c:183:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    u32 aty_ld_lcd(int index, const struct atyfb_par *par)
>
> They should not be marked as static since they are used in
> mach64_ct.c.

Probably don't need to be marked extern either (since that's the
implicit default), but I don't feel strongly about it.

Thanks for sending a cleanup for this.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: bfa5782b9caa ("fbdev: atyfb: add stubs for aty_{ld,st}_lcd()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
>  drivers/video/fbdev/aty/atyfb.h |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb.h
> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb.h
> @@ -287,11 +287,8 @@ static inline void aty_st_8(int regindex
>  #endif
>  }
>
> -#if defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || \
> -defined (CONFIG_FB_ATY_BACKLIGHT)
>  extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
>  extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
> -#endif
>
>      /*
>       *  DAC operations



-- 
Thanks,
~Nick Desaulniers
