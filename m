Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD96CCA483
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 15:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiGKPun (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGKPul (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:41 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB62D64E16
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 08:50:39 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id trqd2700a4C55Sk01rqd49; Mon, 11 Jul 2022 17:50:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-0036ww-8s; Mon, 11 Jul 2022 17:50:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006sh5-QN; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 00/10] video: fbdev: atari: Miscellaneous fixes and cleanups
Date:   Mon, 11 Jul 2022 17:50:24 +0200
Message-Id: <cover.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

	Hi all,

This patch series contains miscellaneous fixes and cleanups for the
Atari frame buffer device driver, which were identified while working on
the Atari DRM driver.

Most of them have been tested on ARAnyM, and should be safe to apply,
except perhaps for the last one, which is marked RFC.

Thanks for your comments!

Geert Uytterhoeven (10):
  video: fbdev: atari: Simplify atafb_pan_display()
  video: fbdev: atari: Remove bogus FB_VMODE_YWRAP flags
  video: fbdev: atari: Fix inverse handling
  video: fbdev: atari: Fix ext_setcolreg()
  video: fbdev: atari: Remove unneeded casts from void *
  video: fbdev: atari: Remove unneeded casts to void *
  video: fbdev: atari: Fix TT High video mode vertical refresh
  video: fbdev: atari: Fix VGA modes
  video: fbdev: atari: Remove unused definitions and variables
  [RFC] video: fbdev: atari: Remove backward bug-compatibility

 Documentation/m68k/kernel-options.rst |   4 +-
 drivers/video/fbdev/atafb.c           | 101 +++++++-------------------
 2 files changed, 29 insertions(+), 76 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
