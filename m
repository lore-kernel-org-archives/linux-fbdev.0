Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99988C433FE
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Apr 2022 12:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiDMMyf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Apr 2022 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDMMyf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Apr 2022 08:54:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2B53B4C;
        Wed, 13 Apr 2022 05:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A11B82460;
        Wed, 13 Apr 2022 12:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9591DC385B0;
        Wed, 13 Apr 2022 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649854330;
        bh=+sQUQHAMr60oibMcSb+X1heh23Rmrdns5Ug52FcWZis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nHieiynxTKUOZ+/GgQbKN0LsqKZRjZxrh+7eXt+9WJEEf0DBzz444TIxgXoEmaaiK
         Yfu4UbnumxFYrMTZ3ph2I6cgbNCCp0yGYxuwqOjPZUkbKTSW08ESSg0sReURKkhkBP
         XAdCHi7MbsUHELaQYQ0Kp4wHWHxR1gBwDs+3i8rIXouiK4Up6BFCX205c0q++YQOTj
         aO+1X5DE/GJo/1vfeeSWKErbxW9tU78sAKxqz3SR76bqdA8qTrBwZU9G7Bcnkm813T
         4s3b16NSarLsZbNM8OPIvzYSIOJy58BrXj0cTAIgpXRB9DiZtYKhZPGnEdfqTQsSvO
         A19loAMfcGwBg==
Received: by mail-il1-f182.google.com with SMTP id h4so1020359ilq.8;
        Wed, 13 Apr 2022 05:52:10 -0700 (PDT)
X-Gm-Message-State: AOAM530UeaUVWThezQYqcim5BE6Xwg/hWxm9lmBgDEJizwSqzt6uZTTf
        tDudAlKIw3PBXKytImi2d6aXi7hnW6szMeE5rA==
X-Google-Smtp-Source: ABdhPJwbRYO1nv4ZLeWNM6dbn6sh8AG/4Kjt3a50tl385H2g3r9fNB8qWeSivwG1d+EYScK/dc9o6SVMic7J4HVFBnU=
X-Received: by 2002:a92:dd86:0:b0:2bc:805c:23c7 with SMTP id
 g6-20020a92dd86000000b002bc805c23c7mr17319621iln.279.1649854329414; Wed, 13
 Apr 2022 05:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220413092454.1073-1-tzimmermann@suse.de> <20220413092454.1073-2-tzimmermann@suse.de>
In-Reply-To: <20220413092454.1073-2-tzimmermann@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Apr 2022 07:51:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4oT47Q=XFTZ0a=g3-DiB1JsW7_j9M1qRzpeahhz0muA@mail.gmail.com>
Message-ID: <CAL_JsqK4oT47Q=XFTZ0a=g3-DiB1JsW7_j9M1qRzpeahhz0muA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Create platform devices for OF framebuffers
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 13, 2022 at 4:24 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Create a platform device for each OF-declared framebuffer and have
> offb bind to these devices. Allows for real hot-unplugging and other
> drivers besides offb.
>
> Originally, offb created framebuffer devices while initializing its
> module by parsing the OF device tree. No actual Linux device was set
> up. This tied OF framebuffers to offb and makes writing other drivers
> for the OF framebuffers complicated. The absence of a Linux device
> prevented real hot-unplugging. Adding a distinct platform device for
> each OF framebuffer solves both problems. Specifically, a DRM drivers
> can now provide graphics output with modern userspace.
>
> Some of the offb init code is now located in the OF initialization.
> There's now also an implementation of of_platform_default_populate_init(),
> which was missing before. The OF side creates different devices for
> either OF display nodes or bootx displays as they require different
> handling by the driver. The offb drivers picks up each type of device
> and runs the appropriate fbdev initialization.
>
> Tested with OF display nodes on qemu's ppc64le target.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/of/platform.c      | 73 ++++++++++++++++++++++++++--
>  drivers/video/fbdev/offb.c | 98 +++++++++++++++++++++++++-------------
>  2 files changed, 134 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index a16b74f32aa9..4c63b9a73587 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -447,6 +447,60 @@ int of_platform_bus_probe(struct device_node *root,
>  }
>  EXPORT_SYMBOL(of_platform_bus_probe);
>
> +static int __init of_platform_populate_framebuffers(void)
> +{
> +       struct device_node *boot_display = NULL;
> +       struct device_node *node;
> +       struct platform_device *dev;
> +       int ret;
> +
> +       node = of_get_compatible_child(of_chosen, "simple-framebuffer");
> +       of_platform_device_create(node, NULL, NULL);
> +       of_node_put(node);
> +

The rest is PPC only, so bail out here if !PPC.

> +       /* Check if we have a MacOS display without a node spec */
> +       if (of_get_property(of_chosen, "linux,bootx-noscreen", NULL)) {
> +               /*
> +                * The old code tried to work out which node was the MacOS
> +                * display based on the address. I'm dropping that since the
> +                * lack of a node spec only happens with old BootX versions
> +                * (users can update) and with this code, they'll still get
> +                * a display (just not the palette hacks).
> +                */
> +               dev = platform_device_alloc("bootx-noscreen", 0);
> +               if (WARN_ON(!dev))
> +                       return -ENOMEM;
> +               ret = platform_device_add(dev);
> +               if (WARN_ON(ret)) {
> +                       platform_device_put(dev);
> +                       return ret;
> +               }
> +       }
> +
> +       /*
> +        * For OF framebuffers, first create the device for the boot display,
> +        * then for the other framebuffers. Only fail for the boot display;
> +        * ignore errors for the rest.
> +        */
> +       for_each_node_by_type(node, "display") {
> +               if (!of_get_property(node, "linux,opened", NULL) ||
> +                   !of_get_property(node, "linux,boot-display", NULL))
> +                       continue;
> +               dev = of_platform_device_create(node, "of-display", NULL);
> +               if (WARN_ON(!dev))
> +                       return -ENOMEM;
> +               boot_display = node;
> +               break;
> +       }
> +       for_each_node_by_type(node, "display") {
> +               if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
> +                       continue;
> +               of_platform_device_create(node, "of-display", NULL);
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * of_platform_populate() - Populate platform_devices from device tree data
>   * @root: parent of the first level to probe or NULL for the root of the tree
> @@ -541,9 +595,7 @@ static int __init of_platform_default_populate_init(void)
>                 of_node_put(node);
>         }
>
> -       node = of_get_compatible_child(of_chosen, "simple-framebuffer");
> -       of_platform_device_create(node, NULL, NULL);
> -       of_node_put(node);
> +       of_platform_populate_framebuffers();
>
>         /* Populate everything else. */
>         of_platform_default_populate(NULL, NULL, NULL);

I'm pretty sure it's just this call that's the problem for PPC though
none of the above existed when adding this caused a regression. Can we
remove the ifdef and just make this call conditional on
!IS_ENABLED(CONFIG_PPC).


> @@ -551,6 +603,20 @@ static int __init of_platform_default_populate_init(void)
>         return 0;
>  }
>  arch_initcall_sync(of_platform_default_populate_init);
> +#else
> +static int __init of_platform_default_populate_init(void)
> +{
> +       device_links_supplier_sync_state_pause();
> +
> +       if (!of_have_populated_dt())
> +               return -ENODEV;
> +
> +       of_platform_populate_framebuffers();
> +
> +       return 0;
> +}
> +arch_initcall_sync(of_platform_default_populate_init);
> +#endif
>
>  static int __init of_platform_sync_state_init(void)
>  {
> @@ -558,7 +624,6 @@ static int __init of_platform_sync_state_init(void)
>         return 0;
>  }
>  late_initcall_sync(of_platform_sync_state_init);
> -#endif
>
>  int of_platform_device_destroy(struct device *dev, void *data)
>  {
