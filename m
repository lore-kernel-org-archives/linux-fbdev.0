Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBDCC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Feb 2022 11:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiBOLVr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:21:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBOLVq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Feb 2022 06:21:46 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80910A9E15
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Feb 2022 03:21:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8c73:faf1:1d11:4a47])
        by albert.telenet-ops.be with bizsmtp
        id vPMZ260043BmCM306PMZ7v; Tue, 15 Feb 2022 12:21:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-000rqc-NN; Tue, 15 Feb 2022 12:21:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-00B34j-3v; Tue, 15 Feb 2022 12:21:32 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] video: fbdev: atari: Miscellaneous fixes
Date:   Tue, 15 Feb 2022 12:21:23 +0100
Message-Id: <20220215112126.2633383-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

	Hi Helge,

This is a small series of miscellaneous fixes for the Atari frame buffer
device driver.

The first patch has been sent before, and is untested, as I have no
access to the hardware.
The other patches have been tested on ARAnyM.

Thanks!

Geert Uytterhoeven (3):
  video: fbdev: atari: Fix TT High video mode
  video: fbdev: atari: Convert to standard round_up() helper
  video: fbdev: atari: Remove unused atafb_setcolreg()

 drivers/video/fbdev/atafb.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
