Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4ED314A86;
	Sat, 23 May 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550513; cv=none; b=swmG0LPC6LzC9F0VtAY+I68XAwb+m0ExdIcfyYTS30bRMWKtWdJag6UmpxWrSKR+AbE2JnE8mgiAE9fHVMB3n7bg5aABQ0xD2i4jlkXEQrAceE3Xnt5zsNcIjlGaZxxVY35cHkDTvOCkbYg8GCJND8UCyuYOxFsZwynUExDPvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550513; c=relaxed/simple;
	bh=Wjadc35WcyCRyJQkobvIgVt6g7yrhLQ73KYo1vbHSxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6FNOq4OeZAtdc9qAQ8vxelmOOMhcuMV7h6ze5DoyEstNNnB/ecBw9AkfMz0/l9lnJDeLMMfspPvvUHZMWpszS/8BoEgQbjcCsA4ybujrqcd2lXhJDu3Lb+vle0DBTCoJlrcALE+lpPeteDxlQyCkHD6d+hC5l1UDgS6qZxzoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=eoe+MrWw; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="eoe+MrWw"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id AE01EC0051;
	Sat, 23 May 2026 18:35:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp) with ESMTPSA id 1ZXKP9PgKKo0-RgVynCwS;
	Sat, 23 May 2026 18:35:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779550510;
	bh=J/yxEt3eIebvZXTjKlRrPlybwNWvVjWnftLRPHwzLRI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=eoe+MrWwOVLOsNHVE8229DbiFd0ObQdMDSrCmh4ZGJi6QsHBxy4q4/39/5asPEm9L
	 25Nz9ZQhk63nSc5UY/rVgpf03756NwNzGFZdrLBPaz4YG8WE1SghCJYBgOmwLIu1S4
	 YlM8UQX2+U6LBCRUUKMqG3zFwQ9j3w2nkbEY2aYk=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v2 4/4] staging: sm750fb: deduplicate fbinfo loop in suspend/resume
Date: Sat, 23 May 2026 15:34:59 +0000
Message-ID: <20260523153459.177488-5-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523153459.177488-1-ahmet@sezginduran.net>
References: <20260523153459.177488-1-ahmet@sezginduran.net>
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
v2: No changes.

 drivers/staging/sm750fb/sm750.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fff9c35ee7b0..12703fc4bf0c 100644
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

