Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571E7C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Mar 2022 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245176AbiCNU6L (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiCNU6K (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Mar 2022 16:58:10 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E6B3D1ED
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Mar 2022 13:57:00 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id f7so2063307qtk.1
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Mar 2022 13:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmG2yYfE0o7/L9fLZmp2P49FR3lsd0GCX3VrEQxdEUg=;
        b=wbEzKMS98gzc2B4uxO/PeDhm/nlvicmnu14Fun/mecy6DiP+OG2K29yEKrvj9VOdBg
         FdtbBiGw0ilsfX28LyCJWfY+zCyPGmCBCYmwzLssfuI66XFs/sqyxKI1CHxd0TNxKbYZ
         7ZyHIpg0TKnJ4VVonBXrYqK3qXZedWuWLPBy3hFRDb3cKiuc8ziC20OewPiDL/TAMS0H
         lwhzQnEq1Wl4VbgqRsdnjU9yTrjLTj5+wdofMDsjc3E5Ux4r3IBRxSD+gHyPUxxLLAL6
         j7Nuqo+/0X8WSnoc7qN9oC7oMDUQTNJiRj7SaPSRSoUvx69T5PNBsFUzxThFYecwO5m5
         Z3Jg==
X-Gm-Message-State: AOAM531WJydclc14XPsrc9IziBq/CZBxuSeKStH5bZGkj5JBNbV6WKQD
        t/rQT2ogH8yv9/3mefzkErQGfQkQnBiCYQ==
X-Google-Smtp-Source: ABdhPJySxo4m/gHKHdOJbTHc++EfDqC4VfkIhjL5/n+celkaBlqSNZNvBP54rUI6QMt5wIaXVCYheg==
X-Received: by 2002:a05:622a:138c:b0:2e1:d525:969 with SMTP id o12-20020a05622a138c00b002e1d5250969mr4977211qtk.154.1647291419312;
        Mon, 14 Mar 2022 13:56:59 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a111c00b0067d3b9ef388sm7873466qkk.98.2022.03.14.13.56.57
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 13:56:57 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j2so33439159ybu.0
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Mar 2022 13:56:57 -0700 (PDT)
X-Received: by 2002:a25:dc4:0:b0:629:2337:f9ea with SMTP id
 187-20020a250dc4000000b006292337f9eamr19641831ybn.6.1647291417430; Mon, 14
 Mar 2022 13:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220313192952.12058-1-tzimmermann@suse.de> <20220313192952.12058-2-tzimmermann@suse.de>
In-Reply-To: <20220313192952.12058-2-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Mar 2022 21:56:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqZ3HgUe1b3bpjWmFLKm4dTrfAioD2Hk8H5iDaY4C-yw@mail.gmail.com>
Message-ID: <CAMuHMdWqZ3HgUe1b3bpjWmFLKm4dTrfAioD2Hk8H5iDaY4C-yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: Fix sys_imageblit() for arbitrary image widths
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Sun, Mar 13, 2022 at 8:29 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Commit 6f29e04938bf ("fbdev: Improve performance of sys_imageblit()")
> broke sys_imageblit() for image width that are not aligned to 8-bit
> boundaries. Fix this by handling the trailing pixels on each line
> separately. The performance improvements in the original commit do not
> regress by this change.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for fixing! This was very valuable for hammering the bugs
out of ssd130xdrm and the xrgb888-to-mono conversion...

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
