Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE0FC5DF9D
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A76B21707
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGGtiwD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902188AbgJ0Qa1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:30:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35632 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760746AbgJ0Qa0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:30:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id f38so1098621pgm.2;
        Tue, 27 Oct 2020 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYpVVa2HzoWSN3SBz42ImmD/sC2oukyTEj/vYph3n2U=;
        b=JGGtiwD26RZLnpx6yWtGjSdavx4m1/lbKn4+xZtXTR+oITifCFyWksbePNwPRLAo/K
         OuSem10v8zs01o5RNoD+4DIOB088wIP1aI49EGK+RwqFfaxrK9hGEAy7NPjTyPi1/gdu
         lZI+jjZt9yHOrOF7KYdNWzBa15UO87BPiEG+PilCwBVqmav9TWSGzeWd3Hd2FOBx6blq
         IM8kUIcF/MRnJkDsa6Hu66w6w5ZWVi1dJGct8syt5hOl1co2CHOEnBzQ4AwfuYHRK/1I
         lD6plgXtirHy9lyijxWmzciSgQrPffGU0bbf/xRJ1Fmq+i7HoJLtXlrn3Yu1Z1lCB78e
         P0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mYpVVa2HzoWSN3SBz42ImmD/sC2oukyTEj/vYph3n2U=;
        b=HPy0BcGxgFLZsIFW2hWuT0KoTd2Ss1BcmEU/VO1L2099kyU4/F78cdTgIb5Ed7Izdx
         AwT3d8waMk0YCZ+Jz1xp6xjpMvXxG2AZBWl/n5SMM6PXiduOH4yte0KC78bFn9oyjK++
         tl/D8XlK7G2egeBQPz+fPLFyo/Ml/obL7GSXqUZ6Pe342x0BQnZ+aaxihBggYeaDIbZ9
         PJ/K6wO0jTq9jpflgmb82tlNOZ+TfcORdArFQKzsDDKU4K7CJVu0VRMmaLtA2435ECPv
         K+y4fbMbOqPW8qL/sJIN377edcblaGDam0V4y+Rh1mhRid2UtGacCqYbFK0mBd6Mf7WL
         A5Uw==
X-Gm-Message-State: AOAM5320p9Q2wlLX1oF5FrV1jzn4BctHmTnjtKrXN8Ozjnp4oVJq1WW0
        vtrn8I1RUlBTmTs2RAF5g6QqYTXZ4jt2
X-Google-Smtp-Source: ABdhPJxeA+021hwLATilKLFtU3OwkB+EWBm1+Dk6H+nqoB1yaSG1CZvZPmQrqiRgmGwnQJ99kemqtw==
X-Received: by 2002:a63:354c:: with SMTP id c73mr2722208pga.315.1603816226234;
        Tue, 27 Oct 2020 09:30:26 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id e23sm2773147pfi.191.2020.10.27.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:30:25 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 0/5] Preparation work for using font_desc in vc_data
Date:   Tue, 27 Oct 2020 12:27:35 -0400
Message-Id: <cover.1603788511.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel, Hi Greg, Hi all,

We are planning to use `font_desc` instead of `console_font` in `vc_data`,
and this is just some prep work for it. It doesn't do much, but at least
it removes two "FIXME"s in fbcon.c :)

Peilin Ye (5):
[1/5] fbdev/atafb: Remove unused extern variables

  Searching for `fontdata` gave me this in fbdev/atafb.c:

  extern unsigned char fontdata_8x8[];
  extern unsigned char fontdata_8x16[];

  ...which freaked me out, since in 6735b4632def ("Fonts: Support
  FONT_EXTRA_WORDS macros for built-in fonts") I changed them from char
  arrays to structures, in lib/fonts/. Fortunately it turns out these
  extern variables have nothing to do with lib/fonts/, and are not being
  used anywhere, so remove them for less confusion.

  m68k cross-compiled.

[2/5] Fonts: Make font size unsigned in font_desc

  Our goal is to use `font_desc` "everywhere" in the kernel, and signed
  `width` and `height` is inappropriate.

  Also, change some printk() format identifiers in console/sticore.c from
  `%d` to `%u`. parisc cross-compiled.

[3/5] Fonts: Add charcount field to font_desc

  Add `unsigned int charcount` to `font_desc`, and update each of our 13
  built-in fonts.

[4/5] fbcon: Avoid hard-coding built-in font charcount
[5/5] parisc/sticore: Avoid hard-coding built-in font charcount

  Everyone (tty, fbcon, sticore, etc.) is assuming that all built-in fonts
  have 256 characters, and is using hard-coded 256 or 255 everywhere.
  These two patches removes some of them. [5/5] is parisc cross-compiled.

  Now is a good time to review all find_font() and get_default_font()
  callers:

  drivers/media/pci/solo6x10/solo6x10-enc.c      133 const struct font_desc *vga = find_font("VGA8x16");
  drivers/media/test-drivers/vimc/vimc-core.c    268 const struct font_desc *font = find_font("VGA8x16");
  drivers/media/test-drivers/vivid/vivid-core.c 1928 const struct font_desc *font = find_font("VGA8x16");
  drivers/usb/misc/sisusbvga/sisusb.c           2285 myfont = find_font("VGA8x16");
    * These 4 only care about font VGA8x16, so let them be for now;

  drivers/video/console/sticore.c                499 fbfont = find_font(fbfont_name);
  drivers/video/console/sticore.c                501 fbfont = get_default_font(1024,768, ~(u32)0, ~(u32)0);
    * Uses 255 and 256, (hopefully) cleaned up by [5/5];

  drivers/video/fbdev/core/fbcon.c               999 if (!fontname[0] || !(font = find_font(fontname)))
  drivers/video/fbdev/core/fbcon.c              1000 font = get_default_font(info->var.xres,
  drivers/video/fbdev/core/fbcon.c              1078 if (!fontname[0] || !(font = find_font(fontname)))
  drivers/video/fbdev/core/fbcon.c              1079 font = get_default_font(info->var.xres,
    * Use 256, cleaned up by [4/5];

  drivers/video/fbdev/core/fbcon.c              2548 else if (!(f = find_font(name)))
  drivers/video/fbdev/core/fbcon.c              2546 f = get_default_font(info->var.xres, info->var.yres,
    * Uses 256 but no easy fix. I'll clean this up after making
      fbcon_do_set_font() pass a `font_desc` as parameter;

  drivers/firmware/efi/earlycon.c               234 font = get_default_font(xres, yres, -1, -1);
    * Does not care about charcount.

Thank you!
Peilin Ye

 drivers/video/console/sticore.c  | 10 +++++-----
 drivers/video/fbdev/atafb.c      |  8 --------
 drivers/video/fbdev/core/fbcon.c |  5 ++---
 include/linux/font.h             |  3 ++-
 lib/fonts/font_10x18.c           |  1 +
 lib/fonts/font_6x10.c            |  1 +
 lib/fonts/font_6x11.c            |  1 +
 lib/fonts/font_6x8.c             |  1 +
 lib/fonts/font_7x14.c            |  1 +
 lib/fonts/font_8x16.c            |  1 +
 lib/fonts/font_8x8.c             |  1 +
 lib/fonts/font_acorn_8x8.c       |  1 +
 lib/fonts/font_mini_4x6.c        |  1 +
 lib/fonts/font_pearl_8x8.c       |  1 +
 lib/fonts/font_sun12x22.c        |  1 +
 lib/fonts/font_sun8x16.c         |  1 +
 lib/fonts/font_ter16x32.c        |  1 +
 17 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.25.1

