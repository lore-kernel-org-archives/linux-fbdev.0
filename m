Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B359AC6FA86
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Sep 2022 07:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiIWHTF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiIWHSq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 23 Sep 2022 03:18:46 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8490912B4A9
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:18:31 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id d1so8555599qvs.0
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6vg6B8D/hQyHxlC2HaS8TXm7SR0b9itjbd+F1YgR9rg=;
        b=n7FMKRzpdAK+FWNu/WFJw+0yRuDOr2B5PsNipqDlanhHbR274PNyu6KaL/QzhGMtHW
         O8ubl0wrmTORaognxAXbwM8R6s+dWPUxaIfj1MlFW4enehiS3EspI/voAefQWUoExJAR
         toAUaXSTpE3+jizhR6L5asZluRIJuCJoJOkd3AmsCXIEkwKPoe6Yt1HUaQ1U5QR4hNPe
         tl5Hpv+cdqPICMDli15FiHleGeuQaOn4Gn5+E84es2MwUoMqH8BfEP8aAe1KIP6198Lg
         JdTQjKfFuXyqMy5tGcZZQiOqiCRmUVu3TsAJe+py2jPULNZIfmUGMmzbVdmeCDxyTQL3
         BSGA==
X-Gm-Message-State: ACrzQf1SZ7gsMjDIkGGj2sSqs7TPCguJCMy3Bqgsr3SznOpygtw6PqIY
        cv96y+bEniI4i1URkX462j5uMGJ8j3wLSQ==
X-Google-Smtp-Source: AMsMyM7VlvB/RDAtBYhBkpsppiVQuigNDYdORRScCo7E75WGQ4cMHtuNvoaGzpptT0V1BeCddVV0ZA==
X-Received: by 2002:a05:6214:21ee:b0:4aa:b123:816b with SMTP id p14-20020a05621421ee00b004aab123816bmr5795995qvj.83.1663917510313;
        Fri, 23 Sep 2022 00:18:30 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u11-20020ac8750b000000b0035a6b89412bsm4825262qtq.46.2022.09.23.00.18.28
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 00:18:29 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3454b0b1b6dso123381537b3.4
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Sep 2022 00:18:28 -0700 (PDT)
X-Received: by 2002:a81:78f:0:b0:34d:74c0:1110 with SMTP id
 137-20020a81078f000000b0034d74c01110mr7049955ywh.383.1663917508700; Fri, 23
 Sep 2022 00:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220922113306.11251-1-tzimmermann@suse.de> <20220922113306.11251-5-tzimmermann@suse.de>
In-Reply-To: <20220922113306.11251-5-tzimmermann@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Sep 2022 09:18:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXM2JmnVAgCjSAAf2swX=2T7h5wtFcfWZ5uJEbs5GCvqg@mail.gmail.com>
Message-ID: <CAMuHMdXM2JmnVAgCjSAAf2swX=2T7h5wtFcfWZ5uJEbs5GCvqg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/ofdrm: Support color management
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
> Support the CRTC's color-management property and implement each model's
> palette support.
>
> The OF hardware has different methods of setting the palette. The
> respective code has been taken from fbdev's offb and refactored into
> per-model device functions. The device functions integrate this
> functionality into the overall modesetting.
>
> As palette handling is a CRTC property that depends on the primary
> plane's color format, the plane's atomic_check helper now updates the
> format field in ofdrm's custom CRTC state. The CRTC's atomic_flush
> helper updates the palette for the format as needed.
>
> v3:
>         * lookup CRTC state with drm_atomic_get_new_crtc_state()
>         * access HW palette with writeb(), writel(), and readl() (Ben)
>         * declare register values as u32
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for your patch!


> --- a/drivers/gpu/drm/tiny/ofdrm.c
> +++ b/drivers/gpu/drm/tiny/ofdrm.c

> +static void __iomem *ofdrm_qemu_cmap_ioremap(struct ofdrm_device *odev,
> +                                            struct device_node *of_node,
> +                                            u64 fb_base)
> +{
> +#ifdef __BIG_ENDIAN
> +       static const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
> +#else
> +       static const __be32 io_of_addr[3] = { 0x00000001, 0x0, 0x0 };
> +#endif

You can easily get rid of the #ifdef:

    static const __be32 io_of_addr[3] = { cpu_to_be32(0x01000000), 0x0, 0x0 };

And probably sparse ("make C=2") will complain about the plain zeros,
so "cpu_to_be32(0x0)" as well.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
