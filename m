Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D1C5517A
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFA920757
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJd5hFTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767624AbgJ0Qbw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:31:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41085 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766281AbgJ0Qbv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 12:31:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12so1085531pgm.8;
        Tue, 27 Oct 2020 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUeg+KxMLxDKpdFvHBE7A01n74AzfVei6UlOMkqKwCo=;
        b=eJd5hFTofb9nO3xoRiSpfTlcid9glOapJOgmYsVfMyHHvMSOJrs4pSTEHyGbbow16A
         ylY6G8NsY4Rp2W3YRR23uTBIjPOT6NLyB31lgklY3LxgRJ/jXQHmWYolJMwNMykAU31L
         omCPGFyX2TlmPysrnXjSmUBT8KEmMLUW+VC7XCS+IyXKHgQxUeuMo1eHvIeFGwJm1BcP
         vk75vFLvPAzsd9ZmvJaT58BJu7ihx6Ek0p7WWMCQA59LU+F79ktZMZugsSsvx14EMtQ7
         0mfZo1CtrJq1SA460eQflL/mteTWCpWJlAEewb/I7nJcuLWBv8+OdRm8fXsBjW5Y/XB4
         qKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUeg+KxMLxDKpdFvHBE7A01n74AzfVei6UlOMkqKwCo=;
        b=ZYBj0jIG+DPVuSTGjX9nNjkdkH9imtgOXwSEUPwyS0BP+MRFMNj6TjqX15Cts6Yrx0
         BdPSQ4pdIFKYcPVxjV/gks+8RNwuzslqTb4dYIJpzuCkcnR1r/k4/oW67o8z+xcNPnaF
         Dc/byPEylVjYCA4//Ji+7LrG3O7P95W9aE+Z5YhsYMv9YGlQis48W0J652q8Due+Fvhd
         pFWs1fLF/gh8ot6sNwec4/zullb8lH5GWeeMS/BNasTWbe/EZSM7JcTYHI8MFVNN+AJz
         kgSsOvmgkndELPugrocBhidwXiaoyU6gDHHH4Zsbs2bx9RQTIHDMUqwiX9q88c3gUTHw
         9BBg==
X-Gm-Message-State: AOAM531XOsFph0vlfNuk0qaJc2fhU8AXa5bYibK9tcKxzFirg1mk54+O
        WygJ6R4jNBvqM5Tm5vBgJsMeoF82zELG
X-Google-Smtp-Source: ABdhPJzXlpA9p0YQjtHIKX03TX1A/bHiqf2YTkdJxUi2MkxnIAQILYuosDzjXEQDPdnA50zJo6DPEA==
X-Received: by 2002:a63:fe49:: with SMTP id x9mr2496134pgj.192.1603816310574;
        Tue, 27 Oct 2020 09:31:50 -0700 (PDT)
Received: from localhost.localdomain (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id y8sm2771710pfg.104.2020.10.27.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:31:49 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 1/5] fbdev/atafb: Remove unused extern variables
Date:   Tue, 27 Oct 2020 12:31:08 -0400
Message-Id: <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603788511.git.yepeilin.cs@gmail.com>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove 6 unused extern variables to reduce confusion. It is worth
mentioning that lib/fonts/font_8x8.c and lib/fonts/font_8x16.c also
declare `fontdata_8x8` and `fontdata_8x16` respectively, and this file
has nothing to do with them.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
$ # Build-tested (Ubuntu 20.04)
$ sudo apt install gcc-m68k-linux-gnu
$ cp arch/m68k/configs/atari_defconfig .config
$ make ARCH=m68k menuconfig
$ make ARCH=m68k CROSS_COMPILE=m68k-linux-gnu- -j`nproc` all

 drivers/video/fbdev/atafb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index f253daa05d9d..e3812a8ff55a 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -240,14 +240,6 @@ static int *MV300_reg = MV300_reg_8bit;
 
 static int inverse;
 
-extern int fontheight_8x8;
-extern int fontwidth_8x8;
-extern unsigned char fontdata_8x8[];
-
-extern int fontheight_8x16;
-extern int fontwidth_8x16;
-extern unsigned char fontdata_8x16[];
-
 /*
  * struct fb_ops {
  *	* open/release and usage marking
-- 
2.25.1

