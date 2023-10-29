Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7703C4167D
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Oct 2023 23:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjJ2XId (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Oct 2023 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjJ2XIE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Oct 2023 19:08:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E47ECB;
        Sun, 29 Oct 2023 16:02:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CB2C116A3;
        Sun, 29 Oct 2023 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620437;
        bh=V3MW3HlJw0Dv/VdEsrQyNiXGgZkXx8rL2UAla9DTeeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRmDOZYNURMqCkb5tzUd9HJ/gj45WeCua6MUtpEl36kf3QA8r8ohbjpLUC+bKMELI
         eiXkbG1JWWUs77NRK3JEVtcUefG5j5zJeBfT4MBi/2q8mPl6UdD3lYNYbmYb9QMcXC
         IYDNoHghC311zvslBMIAYV9EmFDd2Bwqd7AM1a6C5kmHhtpGGMJqDEng4jaH37l5qi
         cRRruYB33xtiaj8fxqE332QlAmPwalvPsJ9FPnojUxVGHEnc1wtY+EFv0zM6+3RTGr
         MHfrvl6LAYQZUalFPrfeYdXfi4gKI54c3Scp2OLUNpUSUCSJbYvWNk7FipNFNlUBU1
         VHaBSdlPQZcOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, daniel@ffwll.ch,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 11/16] fbdev: core: syscopyarea: fix sloppy typing
Date:   Sun, 29 Oct 2023 18:59:57 -0400
Message-ID: <20231029230014.792490-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit e8e4a470b677511f9d1ad4f3cef32adc1d9a60ca ]

In sys_copyarea(), the local variable bits_per_line is needlessly typed as
*unsigned long* -- which is a 32-bit type on the 32-bit arches and a 64-bit
type on the 64-bit arches; that variable's value is derived from the __u32
typed fb_fix_screeninfo::line_length field (multiplied by 8u) and a 32-bit
*unsigned int* type should still be enough to store the # of bits per line.

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/syscopyarea.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/syscopyarea.c b/drivers/video/fbdev/core/syscopyarea.c
index c1eda31909682..7b8bd3a2bedc5 100644
--- a/drivers/video/fbdev/core/syscopyarea.c
+++ b/drivers/video/fbdev/core/syscopyarea.c
@@ -316,7 +316,7 @@ void sys_copyarea(struct fb_info *p, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	unsigned long const bits_per_line = p->fix.line_length*8u;
+	unsigned int const bits_per_line = p->fix.line_length * 8u;
 	unsigned long *base = NULL;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;
-- 
2.42.0

