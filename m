Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DF2ECAAD8
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Sep 2022 07:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiIWHOm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIWHOj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 23 Sep 2022 03:14:39 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303B31DA42
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:14:38 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id g23so7899426qtu.2
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=S3UyUtioqiLswQVfydApgd1DWgeD5a9i4NJMAx10xfU=;
        b=NeKhEcUtotdcZlH7wKvtCg//Z6LZyK+6cNHW2DbF2kRhW0GWPFHgaMyBMDgNLo0xe2
         56RfhCBTCgTh/XlvpVUkJHXN6HHQl+zvWewfq309gbgXMX9O9hPBNYrAP8VsDqXUnPbX
         ryMQ17+MsPnWIFBNwXRAtAA6VSxg2j+xfxYSsLqnoi3Msk68aLbKw9kMTgitKW2nJ4cA
         z7vY2kRBFOTdXdMSaU3nohV6Zq9oh3gAdpOgsoK+dP4qYrQfE3HpY6o9N4qXgSIdXJZw
         Wjn/VKuXG1XiA7tpiVW5YCRPi7Cb/b3DVC4AhppZ7N2DrF37XMBRQj5JxjA9zIKPHkpy
         9YcQ==
X-Gm-Message-State: ACrzQf3xIE2Y0b313qyQ8PHsMGyRk2rclyuBVatqN7aTWZcY4VGyx2R0
        S7sx6VTZIMbl6tWIziCsIaxe0XTIPfBTyw==
X-Google-Smtp-Source: AMsMyM7hNPefdAwvR3jjtbnWjDtksisl6gB+Lp5O60GW8vlt7LpD7/sn3/lyN3mNV1lgWDaKuPijAw==
X-Received: by 2002:ac8:5801:0:b0:35c:dc46:1a50 with SMTP id g1-20020ac85801000000b0035cdc461a50mr5944776qtg.216.1663917277138;
        Fri, 23 Sep 2022 00:14:37 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id h8-20020a05620a244800b006ce813bb306sm5149686qkn.125.2022.09.23.00.14.36
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 00:14:36 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3452214cec6so123456357b3.1
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:14:36 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr6762932ywe.283.1663917276015; Fri, 23
 Sep 2022 00:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220922113306.11251-1-tzimmermann@suse.de> <20220922113306.11251-2-tzimmermann@suse.de>
In-Reply-To: <20220922113306.11251-2-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Sep 2022 09:14:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1echz6wc6Y2cfjrkPa2vZW+X4s83rXo7VebJ0E+qaqg@mail.gmail.com>
Message-ID: <CAMuHMdW1echz6wc6Y2cfjrkPa2vZW+X4s83rXo7VebJ0E+qaqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/ofdrm: Add ofdrm for Open Firmware framebuffers
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mark.cave-ayland@ilande.co.uk,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Thu, Sep 22, 2022 at 1:33 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Open Firmware provides basic display output via the 'display' node.
> DT platform code already provides a device that represents the node's
> framebuffer. Add a DRM driver for the device. The display mode and
> color format is pre-initialized by the system's firmware. Runtime
> modesetting via DRM is not possible. The display is useful during
> early boot stages or as error fallback.
>
> Similar functionality is already provided by fbdev's offb driver,
> which is insufficient for modern userspace. The old driver includes
> support for BootX device tree, which can be found on old 32-bit
> PowerPC Macintosh systems. If these are still in use, the
> functionality can be added to ofdrm or implemented in a new
> driver. As with simpledrm, the fbdev driver cannot be selected if
> ofdrm is already enabled.

Thanks for your patch!

> The driver has been tested on qemu's ppc64le emulation. The device
> hand-over has been tested with bochs.

Oh, tested on little-endian only ;-)

> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ofdrm.c
> +static const struct drm_format_info *display_get_validated_format(struct drm_device *dev,
> +                                                                 u32 depth)
> +{
> +       const struct drm_format_info *info;
> +       u32 format;
> +
> +       switch (depth) {
> +       case 8:
> +               format = drm_mode_legacy_fb_format(8, 8);
> +               break;
> +       case 15:
> +       case 16:
> +               format = drm_mode_legacy_fb_format(16, depth);
> +               break;
> +       case 32:
> +               format = drm_mode_legacy_fb_format(32, 24);

Shouldn't all of these use drm_driver_legacy_fb_format() (and the
driver set drm_mode_config.quirk_addfb_prefer_host_byte_order) to have
a chance of working on traditional big-endian PPC?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
