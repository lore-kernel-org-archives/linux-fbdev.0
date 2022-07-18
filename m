Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA8DC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jul 2022 12:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiGRMoQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiGRMoJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Jul 2022 08:44:09 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3726126;
        Mon, 18 Jul 2022 05:44:02 -0700 (PDT)
Received: from rustam-GF63-Thin-9RCX.intra.ispras.ru (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 8751E40D4004;
        Mon, 18 Jul 2022 12:43:57 +0000 (UTC)
From:   Rustam Subkhankulov <subkhankulov@ispras.ru>
To:     Thomas Winischhofer <thomas@winischhofer.net>
Cc:     Rustam Subkhankulov <subkhankulov@ispras.ru>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org
Subject: [PATCH] video/fbdev/sis: fix typos in SiS_GetModeID()
Date:   Mon, 18 Jul 2022 15:43:43 +0300
Message-Id: <20220718124344.46338-1-subkhankulov@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The second operand of a '&&' operator has no impact on expression
result for cases 400 and 512 in SiS_GetModeID().

Judging by the logic and the names of the variables, in both cases a
typo was made.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 drivers/video/fbdev/sis/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index b568c646a76c..2ba91d62af92 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -355,12 +355,12 @@ SiS_GetModeID(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDisplay,
 		}
 		break;
 	case 400:
-		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDwidth >= 600))) {
+		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDheight >= 600))) {
 			if(VDisplay == 300) ModeIndex = ModeIndex_400x300[Depth];
 		}
 		break;
 	case 512:
-		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 1024) && (LCDwidth >= 768))) {
+		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 1024) && (LCDheight >= 768))) {
 			if(VDisplay == 384) ModeIndex = ModeIndex_512x384[Depth];
 		}
 		break;
-- 
2.25.1

