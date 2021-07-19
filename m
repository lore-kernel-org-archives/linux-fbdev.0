Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B345C12002
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060FF61164
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Jul 2021 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhGSIJr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:09:47 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:40919 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbhGSIJn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Jul 2021 04:09:43 -0400
Received: by mail-ua1-f43.google.com with SMTP id r9so6490479ual.7;
        Mon, 19 Jul 2021 01:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8I5GR8j5EB13OmhGDxaQ/eMHgskRO2Z8XPEh2y9oGGs=;
        b=RTcKO6VaRWbwv1FVJnmrIxGEyeicVGtC4KXlX4gDBB08h+/dIUmrHzpZ8qmVo8YBkZ
         L+7HvX3uG5LeUNGxSG8ufL6WK1fAp0HHAZ+3UhkeCc12VFwI6LHQVAX00e5ZmT3DQuQJ
         bFIdhdaO4LLBkmXgqwpW2FbgYeTqBp0F7/zxgX+0E1O7NpSVb0zbbYAIC2OoNK6IWFpd
         nuCXPTnOOxKZZ3xF+mnbpgooLlAFnaOW3Ge+L9VjhSbzj3WhxelSO7aik0mZsfONJm/Z
         qLuVQHDU/8qt8ckyFaQQA3yM8TiwWKgvtZvanuJ4mJxr3a5HD3AlRlGg4NlOvocHDCen
         g37Q==
X-Gm-Message-State: AOAM533SCK+QE/fW5LraRErzjX4E5cmOTSWzC2ky4ZoO/lIctwxQhxRf
        53GKyZTWHHWABrZd7GQaN9WdB2BammqKOke/KiI=
X-Google-Smtp-Source: ABdhPJxEfdNR8WTLBETJ8aBjqwssc4hSfq24N1pgWQfVOrc0KFFptPwJOXDTHaVHfXQK6vdKb7jXURZfe/QBqX3k8nc=
X-Received: by 2002:ab0:6710:: with SMTP id q16mr1934879uam.106.1626682001086;
 Mon, 19 Jul 2021 01:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210719023327.17039-1-rdunlap@infradead.org>
In-Reply-To: <20210719023327.17039-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Jul 2021 10:06:29 +0200
Message-ID: <CAMuHMdUtTzgnP4GR5phFcVnFVCrU1J87sner-XN6Koc_eZ7Zhg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: simplefb: limit its use to DRM_SIMPLEDRM=n
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Randy,

On Mon, Jul 19, 2021 at 4:34 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> When DRM_SIMPLEDRM=m, all of FB_CFB_{FILLRECT,COPYAREA,IMAGEBLIT} are =m,

Why does that happen?
FB_SIMPLE does select FB_CFB_*, so all of the latter should be builtin?
Do I need my morning coffee? I'm about to fetch it...

> causing undefined references in fbdev/simplefb.o.
>
> By restricting FB_SIMPLEFB to be set only when DRM_SIMPLEDRM is not set,
> the FB_CFB_* symbols are =y and the build completes without these
> undefined references.
>
> IOW, really "disable simplefb if simpledrm has been selected".

That does make sense, regardless of my question above ;-)

> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
> or1k-linux-ld: drivers/video/fbdev/simplefb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

> --- linux-next-20210716.orig/drivers/video/fbdev/Kconfig
> +++ linux-next-20210716/drivers/video/fbdev/Kconfig
> @@ -2192,7 +2192,7 @@ config FB_HYPERV
>
>  config FB_SIMPLE
>         bool "Simple framebuffer support"
> -       depends on (FB = y) && !DRM_SIMPLEDRM
> +       depends on (FB = y) && DRM_SIMPLEDRM=n
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
