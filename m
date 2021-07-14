Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D4C11F69
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3496D61106
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbhGNPBG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbhGNPBE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Jul 2021 11:01:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFCC061760
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jul 2021 07:58:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bcf3:b2b1:dff6:480b])
        by baptiste.telenet-ops.be with bizsmtp
        id V2yB250014sai0K012yBy8; Wed, 14 Jul 2021 16:58:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKw-001AEh-Om; Wed, 14 Jul 2021 16:58:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKv-00AcN1-RD; Wed, 14 Jul 2021 16:58:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
Date:   Wed, 14 Jul 2021 16:57:59 +0200
Message-Id: <20210714145804.2530727-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

	Hi all,

This patch series optimizes console operations on ssd1307fb, after the
customary fixes and cleanups.

Currently, each screen update triggers an I2C transfer of all screen
data, up to 1 KiB of data for a 128x64 display, which takes at least 20
ms in Fast mode.  While many displays are smaller, and thus require less
data to be transferred, 20 ms is still an optimistic value, as the
actual data transfer may be much slower, especially on bitbanged I2C
drivers.  After this series, the amount of data transfer is reduced, as
fillrect, copyarea, and imageblit only update the rectangle that
changed.

This has been tested on an Adafruit FeatherWing OLED with an SSD1306
controller and a 128x32 OLED, connected to an OrangeCrab ECP5 FPGA board
running a 64 MHz VexRiscv RISC-V softcore, where it reduced the CPU
usage for blinking the cursor from more than 70% to ca. 10%.

Thanks for your comments!

Geert Uytterhoeven (5):
  video: fbdev: ssd1307fb: Propagate errors via
    ssd1307fb_update_display()
  video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
  video: fbdev: ssd1307fb: Extract ssd1307fb_set_address_range()
  video: fbdev: ssd1307fb: Optimize screen updates
  video: fbdev: ssd1307fb: Cache address ranges

 drivers/video/fbdev/ssd1307fb.c | 143 +++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 47 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
