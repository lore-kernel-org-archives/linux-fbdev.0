Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75BFC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 15:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiGKPz4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiGKPzz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 11:55:55 -0400
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 08:55:54 PDT
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2813C27CD2
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 08:55:53 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4LhSyl2lF7z4x2YY
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 17:50:39 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id trqf270054C55Sk01rqf58; Mon, 11 Jul 2022 17:50:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgE-0036x2-H5; Mon, 11 Jul 2022 17:50:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006shk-Vj; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/10] video: fbdev: atari: Remove unneeded casts to void *
Date:   Mon, 11 Jul 2022 17:50:30 +0200
Message-Id: <d1da8bf1b21759bcda39c572bc102c5a6380b1a8.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
References: <cover.1657554353.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arbitrary pointers can be passed to functions accepting "void *" without
casting.

Remove the casts, as they make it impossible to validate types.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index f20535ea3e549384..fbc333d5615df5d5 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2599,14 +2599,14 @@ atafb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 #ifdef FBCMD_GET_CURRENTPAR
 	case FBCMD_GET_CURRENTPAR:
-		if (copy_to_user((void *)arg, (void *)&current_par,
+		if (copy_to_user((void *)arg, &current_par,
 				 sizeof(struct atafb_par)))
 			return -EFAULT;
 		return 0;
 #endif
 #ifdef FBCMD_SET_CURRENTPAR
 	case FBCMD_SET_CURRENTPAR:
-		if (copy_from_user((void *)&current_par, (void *)arg,
+		if (copy_from_user(&current_par, (void *)arg,
 				   sizeof(struct atafb_par)))
 			return -EFAULT;
 		ata_set_par(&current_par);
-- 
2.25.1

