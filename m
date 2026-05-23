Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F053EA66;
	Sat, 23 May 2026 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779513663; cv=none; b=AO9ZRkYXTDbZlUanPuA5Ndxk0+91ldrJIHsLgHau2zszLdJHdDPwg63+ALMMmWO7lQ4HBdsWvrV6yUgM8Q1uO9MDKcqp+lk4QUm8oIqyQihNrSdEpqtUipfRL5QtjS3jJth6jSHM/ild4qoRc2+ym7CiFj6GjpgQD7fKi0VAvjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779513663; c=relaxed/simple;
	bh=lRLTEhZDHzg1bMcQQyh+N6hTgp70dNNJqO0x7Gu1FpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrGBe127biVLW51UKHbjAQzoX12WspJSlhEKUrBO+r0jHhHwX7NSZsUkunOU3QmXnqz8hFuBCUUKviPNL7GWdKIEIM6yLkqmRNIfGCQti3+h7nZpqKV7HUZFYdEuwBZLiTf7vI/0Ve2X0ZNP1LPQZ+haMtJdxo2KK7mHcPhfd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=O8Q/96CU; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="O8Q/96CU"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id 0476081180;
	Sat, 23 May 2026 08:15:32 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 57608C0041;
	Sat, 23 May 2026 08:15:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id DFNL0fJe2Ko0-DjBQ4v6g;
	Sat, 23 May 2026 08:15:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779513323;
	bh=zrl/uPh8XULY9xneCuXEdgDPlcjH+DMAp7B3cFGot8o=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=O8Q/96CUKkIS4WozKOQhe/YRn19hoITkLBYVQnNShY6NVw7pU8OoWPs8QM9OUdNcJ
	 I0BEMg6OimqdDDuEf2uuXSKjK2aqyZqhBLJILV6vyF2DKePL/4/YWJHkjCKdg4qf7v
	 HLvIbfOrbMVw31svlzVjkPgKd54ZJg/BmUevQG+o=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH 5/5] staging: sm750fb: deduplicate fbinfo loop in suspend/resume
Date: Sat, 23 May 2026 05:15:09 +0000
Message-ID: <20260523051509.166152-6-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523051509.166152-1-ahmet@sezginduran.net>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lynxfb_suspend() and lynxfb_resume() both walk sm750_dev->fbinfo[]
via duplicated per-index blocks for fbinfo[0] and fbinfo[1].

Replace each pair of blocks with a for-loop bounded by
sm750_dev->fb_count, the number of successfully registered
framebuffers.

No functional changes intended.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 465615b528fd..279471d6cd14 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -388,18 +388,18 @@ static int __maybe_unused lynxfb_suspend(struct device *dev)
 {
 	struct fb_info *info;
 	struct sm750_dev *sm750_dev;
+	int i;
 
 	sm750_dev = dev_get_drvdata(dev);
 
 	console_lock();
-	info = sm750_dev->fbinfo[0];
-	if (info)
-		/* 1 means do suspend */
-		fb_set_suspend(info, 1);
-	info = sm750_dev->fbinfo[1];
-	if (info)
-		/* 1 means do suspend */
-		fb_set_suspend(info, 1);
+
+	for (i = 0; i < sm750_dev->fb_count; i++) {
+		info = sm750_dev->fbinfo[i];
+		if (info)
+			/* 1 means do suspend */
+			fb_set_suspend(info, 1);
+	}
 
 	console_unlock();
 	return 0;
@@ -414,6 +414,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
 	struct lynx_cursor *cursor;
+	int i;
 
 	sm750_dev = pci_get_drvdata(pdev);
 
@@ -421,21 +422,12 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 
 	hw_sm750_inithw(sm750_dev, pdev);
 
-	info = sm750_dev->fbinfo[0];
-
-	if (info) {
-		par = info->par;
-		crtc = &par->crtc;
-		cursor = &crtc->cursor;
-		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->v_screen, 0x0, crtc->vidmem_size);
-		lynxfb_ops_set_par(info);
-		fb_set_suspend(info, 0);
-	}
+	for (i = 0; i < sm750_dev->fb_count; i++) {
+		info = sm750_dev->fbinfo[i];
 
-	info = sm750_dev->fbinfo[1];
+		if (!info)
+			continue;
 
-	if (info) {
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
-- 
2.53.0

