Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B886AC77B7C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Apr 2023 15:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjDZPVy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjDZPVx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Apr 2023 11:21:53 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09D63AA5
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:21:52 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-555e853d3c5so55772297b3.2
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682522512; x=1685114512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNU02MgisC2DVRfyuqUz0GaaJRwku9M+1H+Ra/NSpEw=;
        b=g63HN8Qt4tb82thwOdIxyHnZMTI7PBUEXVjXs0bTO2UssOilhvyjtdMpPUhVg35sTQ
         zqADnY+x8Atq5r0NLnaQWNldVmB1D6+YHcn2wZe3R+9GCAhDuy2g5C9vumKZefONcCJI
         saaSYtUYWbxz4khM5A0bHKaam+2XPavmFFINH41Ad0BdQ0GoH/KOxpecAT8uGTAtPiT/
         ND1xd8FPIpDckT+Rmi57vvtLpSmxcdwnZ3tFG2IQyFBWXvYwwFdTb2WHVG42CAgKUEML
         3FG4QQDM8UFayFxMYO3hmY0xGIH5EaytFD/T6BUOpAjG5QX1DhIgwwh3vzbwegDwi5hK
         b7fw==
X-Gm-Message-State: AC+VfDw1Bi7/fNIMGJ4NaZi23EZCKxx5d818cmF2oKJHDyGovWSkeK0Q
        RetK9kdAclWelO+Cu2QtirMhoATgNvJ4BA==
X-Google-Smtp-Source: ACHHUZ6eOyOKI4yGaNjHY+ikgkgVKn5QtI+b9Mts9sTzMaxAzwQA8bUXVOcyWKdl5aSaWIluFP20pw==
X-Received: by 2002:a81:89c5:0:b0:556:b029:e101 with SMTP id z188-20020a8189c5000000b00556b029e101mr5976362ywf.19.1682522511823;
        Wed, 26 Apr 2023 08:21:51 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id k187-20020a816fc4000000b00545a08184b9sm4234606ywc.73.2023.04.26.08.21.50
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:21:50 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54f9e41dfa7so55813037b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Apr 2023 08:21:50 -0700 (PDT)
X-Received: by 2002:a0d:c606:0:b0:54f:e33d:f1d1 with SMTP id
 i6-20020a0dc606000000b0054fe33df1d1mr12872900ywd.13.1682522510366; Wed, 26
 Apr 2023 08:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230425142846.730-1-tzimmermann@suse.de> <20230425142846.730-6-tzimmermann@suse.de>
 <CAMuHMdU-_w9yQHYhOCD3cz4CEY6ag-dTXjuHSLnzty0hAMBbXw@mail.gmail.com> <1d81e4cc-5079-12a7-4cf5-c31879396e56@suse.de>
In-Reply-To: <1d81e4cc-5079-12a7-4cf5-c31879396e56@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Apr 2023 17:21:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDyabYxtRHtvuNZy8BjoukRdycAMK2jX+qmgc51HU5Xw@mail.gmail.com>
Message-ID: <CAMuHMdWDyabYxtRHtvuNZy8BjoukRdycAMK2jX+qmgc51HU5Xw@mail.gmail.com>
Subject: Re: [PATCH 5/6] fbdev: Move CFB read and write code into helper functions
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Wed, Apr 26, 2023 at 5:06 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 26.04.23 um 17:01 schrieb Geert Uytterhoeven:
> > On Tue, Apr 25, 2023 at 4:28 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Move the existing CFB read and write code for I/O memory into
> >> the new helpers fb_cfb_read() and fb_cfb_write(). Make them the
> >> default fp_ops. No functional changes.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> ---
> >>   drivers/video/fbdev/core/Makefile      |   2 +-
> >>   drivers/video/fbdev/core/fb_cfb_fops.c | 126 +++++++++++++++++++++++++
> >>   drivers/video/fbdev/core/fbmem.c       | 113 +---------------------
> >>   include/linux/fb.h                     |  10 ++
> >>   4 files changed, 139 insertions(+), 112 deletions(-)
> >>   create mode 100644 drivers/video/fbdev/core/fb_cfb_fops.c
> >
> > While the general idea is fine, please do not call any of this "cfb",
> > as it is not related to chunky color frame buffer formats.
> > All of these operate on the raw frame buffer contents.
>
> Shall I call it fb_raw_() or fb_io_()?

Given fb_memcpy_fromfb() is mapped to memcpy_fromio() on
most architectures, I'd go for fb_io_*().

> CFB is used by the drawing helpers, which are usually used together with
> this code. Hence the current naming.

That's because your drawing helpers operate (only) on chunky color
frame buffer formats ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
