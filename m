Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55387C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Feb 2022 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiBPJEq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:04:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiBPJEp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Feb 2022 04:04:45 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5EC2AD674
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Feb 2022 01:04:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by laurent.telenet-ops.be with bizsmtp
        id vl4V2600c18GbK101l4VCJ; Wed, 16 Feb 2022 10:04:30 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nKGEf-000wtW-FS; Wed, 16 Feb 2022 10:04:29 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nKFqO-00CDww-3p; Wed, 16 Feb 2022 09:39:24 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] linux/fb.h: Spelling s/palette/palette/
Date:   Wed, 16 Feb 2022 09:39:22 +0100
Message-Id: <20220216083922.2913515-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix a misspelling of "palette" in a comment.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/uapi/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index 4c14e8be7267761b..3a49913d006c9bf6 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -182,7 +182,7 @@ struct fb_fix_screeninfo {
  *
  * For pseudocolor: offset and length should be the same for all color
  * components. Offset specifies the position of the least significant bit
- * of the pallette index in a pixel value. Length indicates the number
+ * of the palette index in a pixel value. Length indicates the number
  * of available palette entries (i.e. # of entries = 1 << length).
  */
 struct fb_bitfield {
-- 
2.25.1

