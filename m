Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEAAC4332F
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Oct 2023 22:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjJ2W55 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Oct 2023 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjJ2W5l (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Oct 2023 18:57:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9473F10E3;
        Sun, 29 Oct 2023 15:56:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DB1C433CD;
        Sun, 29 Oct 2023 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620160;
        bh=dOPID+WAHBe+1C/wlvaKW7GPyApeXN5OKVtbv1qYIlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFuZdiuAz1Hq8npp/tH4kf8nmRYWDbNqDr8r9bk2prj6YiAbQJHyJpvnnxOynheIx
         SzPEAn1xOvL/7UP9N31bTWhq3bikvFR75GDalHPxTgPzsMU8O2PfHpqOOoFvuHyv9g
         fn+p9RwgCLjjzXMhANVh8E/ba8197MGv31Q9b0JL2iBDI2EAYYEMFOOQBX1B+3Dpvy
         TGIcvCQhfxVoTxmkDYsvkuJtbeptWO6QcatVYTLsWX68Va3kXCj5QuMKps97DOfzvS
         1odL9ycYNu1CjjmPLCbbGTyZEy3eCC2Qew7wOALSgZhuJnrW2sFshWsOMEfru1MgrD
         hIYOop/UUk+Lw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, daniel@ffwll.ch,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 34/52] fbdev: core: cfbcopyarea: fix sloppy typing
Date:   Sun, 29 Oct 2023 18:53:21 -0400
Message-ID: <20231029225441.789781-34-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 7f33df94cf0156f64eee9509bd9b4a178990f613 ]

In cfb_copyarea(), the local variable bits_per_line is needlessly typed as
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
 drivers/video/fbdev/core/cfbcopyarea.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev/core/cfbcopyarea.c
index 6d4bfeecee350..5b80bf3dae504 100644
--- a/drivers/video/fbdev/core/cfbcopyarea.c
+++ b/drivers/video/fbdev/core/cfbcopyarea.c
@@ -382,7 +382,7 @@ void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	unsigned long const bits_per_line = p->fix.line_length*8u;
+	unsigned int const bits_per_line = p->fix.line_length * 8u;
 	unsigned long __iomem *base = NULL;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	unsigned dst_idx = 0, src_idx = 0, rev_copy = 0;
-- 
2.42.0

