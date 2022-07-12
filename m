Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B037C43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Jul 2022 08:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiGLIBf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Jul 2022 04:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGLIBc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Jul 2022 04:01:32 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6C62DD;
        Tue, 12 Jul 2022 01:01:31 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id a21so7628389qtw.10;
        Tue, 12 Jul 2022 01:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7/DBlyXRCka68EapZqh3ZBdGq51MlTs0yoakAMo94s=;
        b=PGm8fNJo3XtgaEMNP300/ijMkrEvjnsRQy14vRfGlA3Nnhg9UmK2rx4KikSqHspCbF
         0TD00RSrOgxLk/Gg0aiIgzcZXqaLyfeltSP7Ebcn4aNn5y0+4mst56H1OxDEjQoM2g2I
         iPtqT/wpXPk71lWCLc4ogyts7SxijMPqEC+uXlCfJNVi0M/C2+FkRqmSAsJLV1meowAA
         frWB238bHyAIIQO/TRkqbuXAxqBuHcss1Qvz8y3VHhiW3OxuHEdm00ZPksgbOswnJ4og
         7aKb9Jz4xoMFRKkKs6koFbS0DOiqQYHJmcY8ryne1IfJZZCcrBhgKERK1R2VOJQGdUyA
         QECg==
X-Gm-Message-State: AJIora88GhutZ08sv3nbrDb9rWvO+bE9HFMC5GzFG6otRQ5BXkKLPs6Z
        382Nla8mfXIbunGYviP493sF9VM+N07VBw==
X-Google-Smtp-Source: AGRyM1ueYjjouP6n1nnDB0LfiEp88nSoCrqxG3205qJF35qK4o27OabeDMDS13FY0NMRxP7jI0d9AQ==
X-Received: by 2002:a05:622a:14d0:b0:318:9744:842b with SMTP id u16-20020a05622a14d000b003189744842bmr16974943qtx.147.1657612890539;
        Tue, 12 Jul 2022 01:01:30 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a404400b006b1eb3a8364sm9165125qko.5.2022.07.12.01.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:01:29 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 136so12656733ybl.5;
        Tue, 12 Jul 2022 01:01:27 -0700 (PDT)
X-Received: by 2002:a05:6902:701:b0:66e:a06d:53d7 with SMTP id
 k1-20020a056902070100b0066ea06d53d7mr20423916ybt.604.1657612887543; Tue, 12
 Jul 2022 01:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657300532.git.geert@linux-m68k.org> <0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org>
 <96a87833-d878-dde9-e335-9ea51a4ba406@mailbox.org> <CAMuHMdUgdbZeoFLFL8+Hm-6fG9cg5Wzq++JED3KR5P9YZtRQ4A@mail.gmail.com>
 <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
In-Reply-To: <20220712074715.kopstlvz4q6npaye@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jul 2022 10:01:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
Message-ID: <CAMuHMdVrf7fgzumcSnZJ3OMGqA34YExXcF3O15YXYpA1ykgKyQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Gerd,

On Tue, Jul 12, 2022 at 9:47 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Jul 11, 2022 at 05:30:30PM +0200, Geert Uytterhoeven wrote:
> > > > Cirrus is the only driver setting quirk_addfb_prefer_host_byte_order
> > > > and supporting RGB565 or XRGB1555, but no one tried that on big-endian?
> > > > Cirrus does not support DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN
> > > > in cirrus_fb_create, so you cannot get a graphical text console.
> > > >
> > > > Do we need these definitions on little-endian platforms, too?
> > > > Would it be better to use "DRM_FORMAT_{XRGB1555,RGB565} |
> > > > DRM_FORMAT_BIG_ENDIAN" instead of "DRM_FORMAT_HOST_{XRGB1555,RGB565}" in
> > > > formats[]?
> > >
> > > The intention of DRM_FORMAT_HOST_* is that they are macros in
> > > include/drm/drm_fourcc.h which just map to little endian formats
> > > defined in drivers/gpu/drm/drm_fourcc.c. Since this is not possible
> > > for big endian hosts for XRGB1555 or RGB565 (or any other format
> > > with non-8-bit components), this isn't applicable here.
>
> It IMHO is not applicable to any physical hardware.  It's used by
> virtio-gpu where the supported format depends on the byte order
> (it is argb8888 in native byte order).  Only virtual hardware can
> have that kind of behavior.
>
> And we can probably drop the DRM_FORMAT_HOST_* variants for 1555 and
> 565, they are not used anywhere.

Atari DRM supports (big-endian) RGB565, so it uses
DRM_FORMAT_HOST_RGB565.

The alternative is to drop the quirk_addfb_prefer_host_byte_order
requirement on big-endian, and always use a little-endian RGB565
shadow frame buffer, at the expense of never being able to get rid
of the copying and byteswapping.

[Cirrus discussion removed]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
