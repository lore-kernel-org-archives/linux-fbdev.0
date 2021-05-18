Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90657C43460
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7558160720
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbhERJHd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 05:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbhERJHP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 05:07:15 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DA1C06138C
        for <linux-fbdev@vger.kernel.org>; Tue, 18 May 2021 02:05:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by andre.telenet-ops.be with bizsmtp
        id 695s2500U446CkP0195sSH; Tue, 18 May 2021 11:05:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-2z; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069n1-Kq; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] video: fbdev: ssd1307fb: Optimizations and improvements
Date:   Tue, 18 May 2021 10:28:04 +0200
Message-Id: <20210518082809.1467549-1-geert@linux-m68k.org>
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
