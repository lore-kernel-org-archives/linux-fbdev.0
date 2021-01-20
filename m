Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B6C43603
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jan 2021 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0FC23340
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jan 2021 12:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbhATMoA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbhATL1j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Jan 2021 06:27:39 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9186AC061794
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Jan 2021 03:26:58 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id o5so5695113oop.12
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Jan 2021 03:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bF3kJZOcFi9epN2Ju/OMLYe+R+7Hhk1D0YWcdHI0mig=;
        b=izVJ/aoMWHJbBtduNtBlv80fvfk4AMOqCR1fVP89sgP4r1KzlitBLQVhei6IdNwC0b
         n139tWO/jSeG5PB6CmVmJY/ngiDl4uSYqzvBe3JTIqv/BXJAvevrNxctX/wuVegCPkIT
         q/Vce9FeMPEifc1MdK3IfX/Pwv9tpaXjf7bEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF3kJZOcFi9epN2Ju/OMLYe+R+7Hhk1D0YWcdHI0mig=;
        b=fACHXHVX1QbYzUfizggkOPxJOHxidsr8bW5O3vS3EA5glIuATAT43I4zqke4Xwsckd
         kSO3wu1fO9XDRoDN1pQgrhdW0Lp3mLRKWYw7Ufe5z4lU6zCwWutl7gR4+57lYDjwH1Ol
         PDX+sX9M4EzwwBO2eqm+0hA8iCQSYbQy31vxxSwmBiBvG057qQfwAz/ErTAcUgGzsVx/
         VKnY7ORsgaA5zNM4sjOvDis3oUEOlnW4Eakksver9XX411wRScMJngXt7NllMHm/wSXg
         ldhbOyruN5HPKFXcjCP+8E8MxsNr7vvzoueyOnemxXRf+V2dDpGhiczkEsiZ6M/z+eWW
         g2hw==
X-Gm-Message-State: AOAM531mhGNfeDZiougmSBG9FFlnE9wSmyGQwecj4g9KZ0nhrN6VIlJA
        TZHTIJvH2RhRXX4glvNlR1qEi2F6f6Wf0FRotZ+VI1xYb0XRog==
X-Google-Smtp-Source: ABdhPJzNf7GDDsKuO2fEPJuRtbJE2LbjunBUPbWEIL8J3gYPW9q007/lCbZ0N5RfnJfLcLzge73Xp86JPERY/PFsHNs=
X-Received: by 2002:a4a:11c2:: with SMTP id 185mr5917268ooc.85.1611142017564;
 Wed, 20 Jan 2021 03:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20201228183934.1117012-1-pbrobinson@gmail.com>
 <b00bd27c-70b5-9ef1-85a1-11e733af78da@redhat.com> <X/c/OwqdMtmqzOZq@phenom.ffwll.local>
 <1acc822f-b7a5-b0be-5533-32528080850a@redhat.com>
In-Reply-To: <1acc822f-b7a5-b0be-5533-32528080850a@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jan 2021 12:26:46 +0100
Message-ID: <CAKMK7uHX3C8Dmb8wyypJkOXZQgdrF8P1PxJB4e4mnSm12n68Bg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: simplefb: Fix info message during probe
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 20, 2021 at 12:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/7/21 6:04 PM, Daniel Vetter wrote:
> > Hi Hans,
> >
> > On Tue, Dec 29, 2020 at 02:02:30PM +0100, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 12/28/20 7:39 PM, Peter Robinson wrote:
> >>> The info message was showing the mapped address for the framebuffer. To avoid
> >>> security problems, all virtual addresses are converted to __ptrval__, so
> >>> the message has pointless information:
> >>>
> >>> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes, mapped to 0x(____ptrval____)
> >>>
> >>> Drop the extraneous bits to clean up the message:
> >>>
> >>> simple-framebuffer 3ea9b000.framebuffer: framebuffer at 0x3ea9b000, 0x12c000 bytes
> >>>
> >>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> >>
> >> Thanks, patch looks good to me:
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Since you have commit rights for drm-misc I'm assuming you're also going
> > to push this one?
>
> I knew there was some discussion about using drm-misc for drivers/video/fbdev stuff
> but I missed that it was decided to go ahead with that.
>
> Good to know that this is handled through drm-misc now.

This is official since a while:

commit 6a7553e8d84d5322d883cb83bb9888c49a0f04e0
Author: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Fri Aug 9 15:46:40 2019 +0200

   MAINTAINERS: handle fbdev changes through drm-misc tree

Cheers, Daniel

>
> I've pushed this patch to drm-misc-next.
>
> Regards,
>
> Hans
>
>
>
> >>> ---
> >>>  drivers/video/fbdev/simplefb.c | 5 ++---
> >>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> >>> index 533a047d07a2..62f0ded70681 100644
> >>> --- a/drivers/video/fbdev/simplefb.c
> >>> +++ b/drivers/video/fbdev/simplefb.c
> >>> @@ -477,9 +477,8 @@ static int simplefb_probe(struct platform_device *pdev)
> >>>     simplefb_clocks_enable(par, pdev);
> >>>     simplefb_regulators_enable(par, pdev);
> >>>
> >>> -   dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
> >>> -                        info->fix.smem_start, info->fix.smem_len,
> >>> -                        info->screen_base);
> >>> +   dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes\n",
> >>> +                        info->fix.smem_start, info->fix.smem_len);
> >>>     dev_info(&pdev->dev, "format=%s, mode=%dx%dx%d, linelength=%d\n",
> >>>                          params.format->name,
> >>>                          info->var.xres, info->var.yres,
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
