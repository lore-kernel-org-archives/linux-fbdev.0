Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CF369354
	for <linux-fbdev@vger.kernel.org>; Wed,  3 Sep 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927350; cv=none; b=I7x+fpkxO9Ccn5lXxd/Q3e5gG8X/EYwiuT4YHvk78JKfjyhQQXsUPk58Gu3t3AOxP1lVDqr6JJLgNvji6L3+aXjEb1QwxKTNBpyIfZGjleZpcDr/70nZ0YKB8eAWpl/W1QCcEODbsjbHurRP1CIp7a4n5c3HuZGMuOj6xuxjekA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927350; c=relaxed/simple;
	bh=PW71A6iwDao0SSIOsQYX0zraUIVAvrnfCwlhqzJ85OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yo2a0vQYJ9fM6iF/1JswGKiSnkfXvhqIyR9Knl0ck3NjcFAV0yscWbZUe+sFPFIXixXiM08A/s0NU31xzHJiZwBiCBmjaxdXFAJ2GOfaj/oE66UaeRNvL8qO5PZKNcWPK8JG90M+xjqijWi2iw6iwAekJFF+BaCDYlDQFkMG4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 463DD101E3; Wed,  3 Sep 2025 21:22:16 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	deller@gmx.de
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbdev: s3fb: revert mclk stop in suspend
Date: Wed,  3 Sep 2025 21:14:15 +0200
Message-Id: <20250903191415.5048-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are systems which want to wait for as long as it takes for the
stopped video memory to answer. Mapping it out helps to avoid that
while the system is running but standby still hangs somehow. So just
leave the memory on in standby same as it was before my change.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/s3fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index a6cfed0a87..ba30e5568c 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1510,7 +1510,7 @@ static int __maybe_unused s3_pci_suspend(struct device *dev)
 
 	fb_set_suspend(info, 1);
 	svga_wseq_mask(par->state.vgabase, 0x18, 0x20, 0x20);
-	svga_wseq_mask(par->state.vgabase, 0x14, 0x03, 0x03);
+	svga_wseq_mask(par->state.vgabase, 0x14, 0x01, 0x01);
 
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
@@ -1539,7 +1539,7 @@ static int __maybe_unused s3_pci_resume(struct device *dev)
 
 	vga_wseq(par->state.vgabase, 0x08, 0x06);
 	svga_wseq_mask(par->state.vgabase, 0x18, 0x00, 0x20);
-	svga_wseq_mask(par->state.vgabase, 0x14, 0x00, 0x03);
+	svga_wseq_mask(par->state.vgabase, 0x14, 0x00, 0x01);
 	s3fb_set_par(info);
 	fb_set_suspend(info, 0);
 
-- 
2.30.2

