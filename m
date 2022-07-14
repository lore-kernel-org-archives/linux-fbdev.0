Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C4CCA482
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiGNKjM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiGNKjI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jul 2022 06:39:08 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8946B545D3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Jul 2022 03:39:03 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id uyf1270184C55Sk01yf1Eh; Thu, 14 Jul 2022 12:39:03 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBvwx-003The-6V; Thu, 14 Jul 2022 12:20:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBulZ-00Bf1B-G5; Thu, 14 Jul 2022 11:04:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/5] drm/modes: Command line mode selection fixes and improvements
Date:   Thu, 14 Jul 2022 11:04:05 +0200
Message-Id: <cover.1657788997.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

	Hi all,

This patch series contains fixes and improvements for specifying video
modes on the kernel command line.

Changes compared to v1[1]:
  - Add Reviewed-by, Acked-by,
  - Keep length check.

This has been tested on ARAnyM using a work-in-progress Atari DRM driver
(more info and related patches can be found in [2]).

Thanks for your comments!

[1] "[PATCH 0/5] drm/modes: Command line mode selection fixes and
    improvements"
    https://lore.kernel.org/r/cover.1657301107.git.geert@linux-m68k.org
[2] "[PATCH v3 00/10] drm: Add support for low-color frame buffer formats"
    https://lore.kernel.org/r/cover.1657294931.git.geert@linux-m68k.org

Geert Uytterhoeven (5):
  drm/modes: parse_cmdline: Handle empty mode name part
  drm/modes: Extract drm_mode_parse_cmdline_named_mode()
  drm/modes: parse_cmdline: Make mode->*specified handling more uniform
  drm/modes: Add support for driver-specific named modes
  drm/modes: parse_cmdline: Add support for named modes containing
    dashes

 drivers/gpu/drm/drm_modes.c | 56 ++++++++++++++++++++++++++-----------
 include/drm/drm_connector.h | 10 +++++++
 2 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
