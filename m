Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC4C07E9B
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 06:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCE2610F7
	for <linux-fbdev@archiver.kernel.org>; Tue, 20 Jul 2021 06:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhGTGFK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 20 Jul 2021 02:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbhGTGFF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 20 Jul 2021 02:05:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D5EC061574;
        Mon, 19 Jul 2021 23:45:39 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so1049038otu.12;
        Mon, 19 Jul 2021 23:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnlclGx2H59akXwZYD6azkaNZJHqKAqqdcjQ+BfTMl0=;
        b=EOriryfrZ2broDhPz9Rod56TA0R/dMqA1FgkTHBiSvm/zwHcoHuQnQbSTPUplzgMqE
         6NGE1tuTNxY5k5rSiaH03Vq6oPn716sjjDEWQL64kuDx968CDuL3h+tCZ9a0DJtiFxKf
         gmzCRr7/+UJCvCnKebfcy0owVygXkPGaBVGMxLE+Z60JpF14wVmZsa3BQ7JRqhimPRRh
         ab3atrUiJdBnOd9yJKckKZyyCsJ4rdcNyyZZzMLSaItwbwYPA/UBsbN0vV9GDuFeUFsw
         qwNgyU8Vl/n6OHt+jnOcLNplJRenDHUEpK0gNQaUK91RX00WVaTo1YOnpLTXSQhgq3j8
         zNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnlclGx2H59akXwZYD6azkaNZJHqKAqqdcjQ+BfTMl0=;
        b=gR2KCvqlXT+mUM8O2nw99vOq724HW0R17DzMKwp57+p+MUO2RdkeBmdKu6mgHVJFg5
         cbcJVtwYKawewO5pt7mGqHjUkzNJ5jiGumeLlOU/W5axd/NJsNVDwEwwiDR6cWr2Zq1J
         ULjUVdyrZAkmzBOV5dStmIi2H2Ufv8xUtF5Ll6DsVr8hFu78BT+ev3MEiAhQ3gDSmppZ
         +DPjnxWnuQ56UnbGZECUQcLVyDfpA0sUJEHRDTMZ8IHjYDg7lFNpQBXm0fXC6XdzkqLU
         Tf1eRyO19+629zgiUk6BFoqM741KJYm2DGJkG2/SImATviUk/Otr4N9fwjcGA19eZMoz
         9S2g==
X-Gm-Message-State: AOAM531v8+QZCyyLs5TpnKXfV8Cn5IOU0ziHofIfbY7WunmiYRYJmKW9
        P/xZBovAtmZ9XrWDjhp7OjKrDUr4c4AYGlhafzLEnzdhBC6aLcI=
X-Google-Smtp-Source: ABdhPJy4rXeOXr3aSDOKhPbHWEJWZV7pqAFvI/x6R1yMP1VISKGJ65cl5P0jd+oum/KevJu9IRS+OvfbNiRipMNR3lY=
X-Received: by 2002:a05:6830:1dfc:: with SMTP id b28mr21199807otj.282.1626763538753;
 Mon, 19 Jul 2021 23:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <1626235762-2590-1-git-send-email-zheyuma97@gmail.com> <YPXJW9N66U2gm2CD@ravnborg.org>
In-Reply-To: <YPXJW9N66U2gm2CD@ravnborg.org>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Tue, 20 Jul 2021 14:45:27 +0800
Message-ID: <CAMhUBjmjncenfiaH55NYRNVZOaWQXNjyaBBnudLfpz+GnGP6Nw@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: kyro: fix a DoS bug by restricting user input
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jul 20, 2021 at 2:50 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Zheyu,
> On Wed, Jul 14, 2021 at 04:09:22AM +0000, Zheyu Ma wrote:
> > The user can pass in any value to the driver through the 'ioctl'
> > interface. The driver dost not check, which may cause DoS bugs.
> >
> > The following log reveals it:
> >
> > divide error: 0000 [#1] PREEMPT SMP KASAN PTI
> > RIP: 0010:SetOverlayViewPort+0x133/0x5f0 drivers/video/fbdev/kyro/STG4000OverlayDevice.c:476
> > Call Trace:
> >  kyro_dev_overlay_viewport_set drivers/video/fbdev/kyro/fbdev.c:378 [inline]
> >  kyrofb_ioctl+0x2eb/0x330 drivers/video/fbdev/kyro/fbdev.c:603
> >  do_fb_ioctl+0x1f3/0x700 drivers/video/fbdev/core/fbmem.c:1171
> >  fb_ioctl+0xeb/0x130 drivers/video/fbdev/core/fbmem.c:1185
> >  vfs_ioctl fs/ioctl.c:48 [inline]
> >  __do_sys_ioctl fs/ioctl.c:753 [inline]
> >  __se_sys_ioctl fs/ioctl.c:739 [inline]
> >  __x64_sys_ioctl+0x19b/0x220 fs/ioctl.c:739
> >  do_syscall_64+0x32/0x80 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> > Changes in v2:
> >     - Validate the inputs on a higher level
>
> Much better, thanks.
> When a line is continued like here the statement shall aling with the
> opening brace. I fixed it up when applying the patch to drm-misc-next so
> no need to do anything this time.

Thanks for your kind reminder, I will pay attention next time.

Regards,
Zheyu Ma
