Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91523E5A24;
	Mon, 25 May 2026 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699732; cv=none; b=jlGoACUm0ITyRqNF+CLlRhW2OqSDAn543qmQEGUI5bDIMRwSGnJNwZze1ii/KuP3l8fL5D1dXR4aFwcNIEofHz8kj/UvsaH422iK1MO7lHqSaiIav/q6fbsi7yVXcMLurV5T9VOrYzsqd9n+uF6n/IFIFpZetXjetwOUqdVxGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699732; c=relaxed/simple;
	bh=bKIOcjeTKtuzzrrQ+uACwiXgTYqZfklyisEbOyEJKf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/bp5y0BqZvGOiLqBv0D+kBz9GGPkrvMgVMVGC56losYTdTAkwpW+DqcHsOpgCxKv2M1fIP7Gimxny141VTqlPPj8uYYCODhGhzHsg4qIRJKcA1r/06BBUDRb+uK/Tanh5g3iJN7qRQsrYqgkK1nfrEFjS5vZHAOTDpLG0bAnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=e8qTzzZK; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="e8qTzzZK"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id DF19AC0131;
	Mon, 25 May 2026 12:02:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id m1TmE1aggiE0-NknztBpr;
	Mon, 25 May 2026 12:02:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779699720;
	bh=l/Y8MqxgP8cHThtgUHGreggx6yNi71NGQJ3DsYcQqNE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=e8qTzzZK3F0iXmnZE+1oXULa6Rw3yzePt9QrXinLlpKyBuQiQSevSWu3jQXBatqgU
	 Qc08NqQDq8M+59apTGppwcLGIL/aeN6u0xAgLt4MVVQVHURgCiSwDpE82NP7TprLkh
	 WjheEQqEpibsoHE3OhimxmM1pRIJFOzPrTbmiQ5w=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v3 4/4] staging: sm750fb: deduplicate fbinfo loop in suspend/resume
Date: Mon, 25 May 2026 08:58:08 +0000
Message-ID: <20260525085808.171974-5-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525085808.171974-1-ahmet@sezginduran.net>
References: <20260525085808.171974-1-ahmet@sezginduran.net>
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
v3: Add braces around the multi-line if (info) body in the
    suspend loop per Dan Carpenter's review.
    Remove a stray blank line left behind in lynxfb_resume()
    after the dedup.
    Link: <https://lore.kernel.org/linux-staging/ahQB8C1gTr7LF0FO@stanley.mountain/>
v2: No changes.

 drivers/staging/sm750fb/sm750.c | 36 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fff9c35ee7b0..1f6f92473c80 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -388,18 +388,19 @@ static int __maybe_unused lynxfb_suspend(struct device *dev)
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
+		if (info) {
+			/* 1 means do suspend */
+			fb_set_suspend(info, 1);
+		}
+	}
 
 	console_unlock();
 	return 0;
@@ -414,6 +415,7 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
 	struct lynx_cursor *cursor;
+	int i;
 
 	sm750_dev = pci_get_drvdata(pdev);
 
@@ -421,21 +423,11 @@ static int __maybe_unused lynxfb_resume(struct device *dev)
 
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
-
-	info = sm750_dev->fbinfo[1];
+	for (i = 0; i < sm750_dev->fb_count; i++) {
+		info = sm750_dev->fbinfo[i];
+		if (!info)
+			continue;
 
-	if (info) {
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
-- 
2.54.0

