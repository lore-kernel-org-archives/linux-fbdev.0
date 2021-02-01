Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED644C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD6F64D9E
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Feb 2021 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhBAPWL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhBAPWG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 1 Feb 2021 10:22:06 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21792C06174A;
        Mon,  1 Feb 2021 07:21:26 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e70so16568341ote.11;
        Mon, 01 Feb 2021 07:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jo3Pe8+MXl1+0gBOWiSw5v0BJ545gQ4ZkTl4Ae472o=;
        b=C68l+shnh8CXf7Al768pOC3kGZUFoh1MAJFgWwa2Q+woCyTZ1UrASd8xMEzScrs0BP
         SFbseFeub+25gGn3TJ/fyxg8DK0bbeG0lYgXzPsAvqEaZFyRa9aufaTHGQuDG3/encaM
         ZXFLC9jZe17kgYq4ftgjL3Uy8HWdtDBvY3pJJwP6bVyfgR2Ie+6uUvPp2EGPSAwYqaoi
         i0GM1XPWHJrdudaHa6mqTFWLiQtcu4k1UnfMX0rsCnZcfcPaPc+NusSNvHqgt5uxPeDI
         pdSkSQWYzHQV5ehcosjOggSr778TR+yGgsILUsWlSmLQshMEeTxs4ceidv6Zr2D3EZhY
         jY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jo3Pe8+MXl1+0gBOWiSw5v0BJ545gQ4ZkTl4Ae472o=;
        b=q0VFClCUwEqQQyFv37gcZdMDH2CHrhST2c/006YHNwPNjQmYeita2yTVnC4vxlEDck
         qIuz3btzDXary+hyXNj+9ztoGodtmResJFNWS4EQ5EhFZ1A4WHE4RxxIwAUYdfFhEtV4
         A98GFkEW7bXrXwlJ8BM0RlhBo6lVB19yZtaGSFZHAaZdbLUed152gvCZUM1xHslrP8hW
         x5Sw2TCW3WrdSPmB8g4Gy111NAU6r0IQzjuGliPZ3enzSVTWLbeC8dGEF02fYCoa8yKN
         v0wO29Lc6J9xj4OAS36WwY0EpLq3tEI0DjLD9BjlutnfW/gpo2WP+Gqt9uTSXRbYv4jy
         Hizg==
X-Gm-Message-State: AOAM532xqhDk89EkbjBlViRAfJGoMRvhVHjNsb+urNSCo+J1t8DXxEpj
        sq4E7SAfY6c5UA5vJCBAkq56RMWV2ICfgFY9jyk=
X-Google-Smtp-Source: ABdhPJzOOQ7f1C42DXKVDkbqndJUWURkrsejZc9DtMgpfqIuaGu9nReoXOhqXkj4WP2KHTOx6gpq/LDW097hUb+B1M0=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr12721445otm.132.1612192885533;
 Mon, 01 Feb 2021 07:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20210129084327.986630-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210129084327.986630-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 1 Feb 2021 10:21:14 -0500
Message-ID: <CADnq5_MduzcezmAjEGK0X7bDiY98f68s8roXc6gOTWjcpNC9Rw@mail.gmail.com>
Subject: Re: [PATCH] efifb: Ensure graphics device for efifb stays at PCI D0
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     pjones@redhat.com, Hans de Goede <hdegoede@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 30, 2021 at 6:27 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> We are seeing root ports on some desktop boards support D3cold for
> discrete graphics card. So when efifb is in use while graphics device
> isn't bound to a driver, PCI and ACPI will put the graphics to D3cold
> when runtime suspend kicks in, makes efifb stop working.
>
> So ensure the graphics device won't be runtime suspended, to keep efifb
> work all the time.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/video/fbdev/efifb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index e57c00824965..19edd7206409 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
>  #include <linux/screen_info.h>
> +#include <linux/pm_runtime.h>
>  #include <video/vga.h>
>  #include <asm/efi.h>
>  #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
> @@ -575,6 +576,7 @@ static int efifb_probe(struct platform_device *dev)
>                 goto err_fb_dealoc;
>         }
>         fb_info(info, "%s frame buffer device\n", info->fix.id);
> +       pm_runtime_get_sync(&efifb_pci_dev->dev);
>         return 0;
>
>  err_fb_dealoc:
> @@ -601,6 +603,7 @@ static int efifb_remove(struct platform_device *pdev)
>         unregister_framebuffer(info);
>         sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
>         framebuffer_release(info);
> +       pm_runtime_put(&efifb_pci_dev->dev);
>
>         return 0;
>  }
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
