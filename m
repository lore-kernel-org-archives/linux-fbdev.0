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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F042C433ED
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Apr 2021 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DE613B8
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Apr 2021 18:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbhDMSC1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhDMSCY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 13 Apr 2021 14:02:24 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B80C061574;
        Tue, 13 Apr 2021 11:02:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so16891461otb.7;
        Tue, 13 Apr 2021 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHA8s5MMieO6Snjywal6xJCUm0gIgD+1eKzza+J7cuM=;
        b=s7ZAufZAYNKjblQOw+B+4z2MCYxMr9kFplVRO/ZQIj1G9z3WTuYel2cCIHAB7oQmCB
         OOqe9agLj5w9L/ftEhVsCphhVUEQDNr+UpqOJngNkXrCuUFCEcxsy+j8rOA+ESro2qPH
         W3G4MaAV8FaCK7hMsCOXRj6sJ9hgZWaWEEu72E9lDvE0tEgms4e26FxgkTV8MtiaBnfr
         2Ic+4/37kZ/VmK7zGkB+WxEpbrUktfv0qidCemRuN/K0XgpqDU1xkU8JKJpoHbfMCHOG
         vtw8MSsCYUTWQs2ey3nM2k8OTq4/62xFq9R9LvcRYwwwa8O+mJbTBx3GgO66KySxhvNk
         oEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHA8s5MMieO6Snjywal6xJCUm0gIgD+1eKzza+J7cuM=;
        b=Gk9S9u0222H5dyMs4gFT5xEw6mvhipA57DSuB+iwJp1PZMLEvPS+yQ2IHYVJWAy4Uq
         lU3hemQoVM80xTYZzxa8nNTpcbtAUNEWmHAogHHVSDs77r1RNlSmA0jFuJvDjhSMHwCd
         x2LwftlSaUMtR4EluvXpIC7lCS0VNBtPodgQeKOF94UxNmduHuI2OI//sfytQnj2joUf
         a+cBHcv0DkfsbMrigkx3lRekgAYo93WNmnFW2v5VgC/sgRDQ7f9yHIDn0/xDOOmWiy+V
         tUfGGUf/PtwPfPMNRLlaOYi1wgiCX0kTSUoLNHr73w2oh/F9jr2WkfX7MXYBru2WNb8p
         CmGw==
X-Gm-Message-State: AOAM531Gk16WHJln2ijRvqWg0ciJzmMC70WjLVHTkSLl+VGaVlsGzzs3
        US6O/QZJk6F1+ml501aDgbEDUoffVycHhg2egpA=
X-Google-Smtp-Source: ABdhPJwKp9kx8LCCHYYOObQkm6QFG7ycSzZPJLrD86v6pdphkyvlQTitF2UXqG5zbwz7GgkxeHX2UQfr8QowmSbhmVw=
X-Received: by 2002:a9d:663:: with SMTP id 90mr29429927otn.311.1618336924138;
 Tue, 13 Apr 2021 11:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210413170508.968148-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210413170508.968148-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:53 -0400
Message-ID: <CADnq5_P7_7jOZWTo+KCj3jOpmyDPN8eH3jNTgg3xLC4V9QM7kQ@mail.gmail.com>
Subject: Re: [PATCH] efifb: Check efifb_pci_dev before using it
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     pjones@redhat.com,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 13, 2021 at 1:05 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On some platforms like Hyper-V and RPi4 with UEFI firmware, efifb is not
> a PCI device.
>
> So make sure efifb_pci_dev is found before using it.
>
> Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> BugLink: https://bugs.launchpad.net/bugs/1922403
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/video/fbdev/efifb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index f58a545b3bf3..8ea8f079cde2 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
>                 goto err_fb_dealoc;
>         }
>         fb_info(info, "%s frame buffer device\n", info->fix.id);
> -       pm_runtime_get_sync(&efifb_pci_dev->dev);
> +       if (efifb_pci_dev)
> +               pm_runtime_get_sync(&efifb_pci_dev->dev);
>         return 0;
>
>  err_fb_dealoc:
> @@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
>         unregister_framebuffer(info);
>         sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
>         framebuffer_release(info);
> -       pm_runtime_put(&efifb_pci_dev->dev);
> +       if (efifb_pci_dev)
> +               pm_runtime_put(&efifb_pci_dev->dev);
>
>         return 0;
>  }
> --
> 2.30.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
