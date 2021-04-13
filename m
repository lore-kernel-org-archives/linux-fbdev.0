Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBE9C433ED
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Apr 2021 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1235611AD
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Apr 2021 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbhDMWgv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 13 Apr 2021 18:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhDMWgu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 13 Apr 2021 18:36:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB9C061574;
        Tue, 13 Apr 2021 15:36:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b3so3843865oie.5;
        Tue, 13 Apr 2021 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bx5OLW8AWrAh5PTyuugkoe6octVcCySAbvj9ENbK5Ns=;
        b=pE5DEZWx2/TgQcqpVnC47cDiHqpbpHEx3wfvwgCrfwNr7R/bLilrcJDDue2dXX2RjA
         D/0muFx+lzBn13XJcGXSSKtsEhir59A5FBXLm/HA5Nu6t6/V29Y+zo8mOdN6gb9iIQKi
         ICwuDkxX2l4GWZAz4YkkavoOkH267GJgizrOCEbfy8+Hwye8rZcOprHw7CNV7snC1gnt
         ricEEjBzUOHfOxJDwbNMQsdL2DkpoGyFtdf2I1mI/MYFZMBbBoEjHvdqZFLV8/C9ecoh
         t9/aO5e6fJlFYM+A4966q/LM+8PUa9iUqmePdfcoDJbAYvH8bEUDdQM+qnEzhnvs87ZN
         Z2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bx5OLW8AWrAh5PTyuugkoe6octVcCySAbvj9ENbK5Ns=;
        b=AZbMbfM5xU7LKEOBoZG0yHoYIEcZWD+CHRViBMKpPp1ZT/CBvbx78JwM4JVR1dQz4i
         8v0liviU223DTSF4tH5/DxLfAhEPHncwwMHj0XMniU8rmX/6vbYd7XebvifBfojkpv22
         mzsGDMarNClNUlDTXZNXodxGl82XJQUHZAOlqXSKZiCdTJe1uwlCkwoxqF32RYO/LBEq
         BkOLBK3eWHY3WF0+VUybmu6RoF7F8e0J/bRY/qTvvuOy6yYAks5G9SKMFzpbyUMrEPUQ
         5k3mSjHl1/xZBAXPrxOMKiFYrsR6ANnc80A31hSoBwegUh/2t18rz6I0ohfm/LdW2a+o
         Ifhg==
X-Gm-Message-State: AOAM532mp24tqyTsUVB6K/xOKwG+wdetddHlPM1jB9777cZbIFGsnznm
        QnvM69dvTu710Ey3jCmma1h1tibjDBAf/AtkqG8=
X-Google-Smtp-Source: ABdhPJwEdmwr7xDJd0k+ned0ruUp46LLigHsDmi5gLJyYlfy/iFttzbyPoczsn+KdUL9vH5TG82e74jcUuhNg4IXTTo=
X-Received: by 2002:aca:c08a:: with SMTP id q132mr2359oif.5.1618353388627;
 Tue, 13 Apr 2021 15:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210413170508.968148-1-kai.heng.feng@canonical.com>
 <CADnq5_P7_7jOZWTo+KCj3jOpmyDPN8eH3jNTgg3xLC4V9QM7kQ@mail.gmail.com> <CAKMK7uHR0VDk=C+u1d5qiiqQP+3ad5_gXQwvmPbJ56mG=3RjpQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHR0VDk=C+u1d5qiiqQP+3ad5_gXQwvmPbJ56mG=3RjpQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Apr 2021 18:36:17 -0400
Message-ID: <CADnq5_MpDz9myx8HiKihq-6_Ud48sN=NXN1_ga7WZa9LguzSjA@mail.gmail.com>
Subject: Re: [PATCH] efifb: Check efifb_pci_dev before using it
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        pjones@redhat.com, Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 13, 2021 at 2:37 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Apr 13, 2021 at 8:02 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 1:05 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > On some platforms like Hyper-V and RPi4 with UEFI firmware, efifb is not
> > > a PCI device.
> > >
> > > So make sure efifb_pci_dev is found before using it.
> > >
> > > Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > > BugLink: https://bugs.launchpad.net/bugs/1922403
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> fbdev is in drm-misc, so maybe you can push this one too?

Yes, pushed.  Thanks!

Alex

> -Daniel
>
> >
> > > ---
> > >  drivers/video/fbdev/efifb.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > > index f58a545b3bf3..8ea8f079cde2 100644
> > > --- a/drivers/video/fbdev/efifb.c
> > > +++ b/drivers/video/fbdev/efifb.c
> > > @@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
> > >                 goto err_fb_dealoc;
> > >         }
> > >         fb_info(info, "%s frame buffer device\n", info->fix.id);
> > > -       pm_runtime_get_sync(&efifb_pci_dev->dev);
> > > +       if (efifb_pci_dev)
> > > +               pm_runtime_get_sync(&efifb_pci_dev->dev);
> > >         return 0;
> > >
> > >  err_fb_dealoc:
> > > @@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
> > >         unregister_framebuffer(info);
> > >         sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
> > >         framebuffer_release(info);
> > > -       pm_runtime_put(&efifb_pci_dev->dev);
> > > +       if (efifb_pci_dev)
> > > +               pm_runtime_put(&efifb_pci_dev->dev);
> > >
> > >         return 0;
> > >  }
> > > --
> > > 2.30.2
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
