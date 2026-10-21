Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553183;
	b=MxfeS0z305RnLl/M4v4mMNG/SG+Kt/2YyKcsnPiNYntRu5lpmJC3bFSwPlZV1/ex+7Yp
	 7FSzc6pxgN18+d32PBokNDNqhUccf0ZO5JRsLu6RREw4ezQpyvItZVFC0wNoyceXbhIC/
	 VWL77pgVnluRNA6YsSjlYHmR4zerlwXnfOO8IcIsIFUHjdf20kfAayZTlb65taVc3UGXd
	 l0uZDQVeC3ZOh2oCa3uyApjUxBkMZlKNoQxmXfLKFzWAuPva8ciieQMm4FtXK9Fc2JQOL
	 fljFK8xpjh0I1TaY2JXmiGzC+3+Uh2z1nkm0SBR30dohSDScLg64HY5mTR0ghFObSVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553183;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=G+Ehm9l8Xv95Bx6oKmHAdogDlKOh7ugIKpG8hkUh+Qg=;
	b=wk9jlCSz/G56WSjgMRCps8Ix7liHcxiALqVXhxbPvSHXwbfs2orRWDNznRVl9KwRnW6E
	 d462FpVZ7Ihrg5h2s0vj5MywtDPp2HzUEfeSLJjktL8aQnp2AgZ/w11dp3ZCZpfOIyzoG
	 f5WeYDtOVNEfs+ZNa3/jIRbL+pYbHNnNKX7ZpdGM+I81uL647fNOSgmjsoCjUUIMvZ8eG
	 nJ+bDMMVnFbxviUOutbZY0LSdkocR6L+a1cb4c6XYXy7mYkwpvLSvLYtjGYr8ixVAG9tM
	 xoA0ky62O509C5usdeBLOt0DwgYsygl2Q9/C2dr1XJs95Bcr1xXnwfNGgmoo/96yxlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="X+gN1MV/";
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB6607154A;
	Wed, 21 Oct 2026 03:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAB6607154A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=X+gN1MV/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792553176; bh=G+Ehm9l8Xv95Bx6oKmHAdogDlKOh7ugIKpG8hkUh+Qg=;
	h=From:To:Cc:Subject:Date;
	b=X+gN1MV/62tdQSIKs5RCr+dGrVb3dKBUUwzcOI7ZNWR0srYEDNTPBNiQWlelf2d1Q
	 cXD8K4ENETT/Wq01CkmqWvfWRCy+IJto8FIlvwqQRxZSeiDxX705dxzi12UD+e0KmX
	 VY0UBYWmHLv9OCGlZg2Wxf12Dgrt3lU/gRRqn87c=
Received: from Liujunyuan.. ([218.106.117.235])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 68994661; Wed, 21 Oct 2026 11:26:09 +0800
X-QQ-mid: xmsmtpt1792553169tykol0mr5
Message-ID: <tencent_FFC8FA1142CEF600BDEBE1EDF4EC27C39005@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJ9jpRfuEWKcN4czwvt/COfC8g6UlvEKtVZGfio2W3eSYLdQ3Tey
	 7eZgUuFSxQFyO0YtRWNaRFpGuyTjn7Z28BQ8Ot6nxwuWp1mtWSlS0MM75YoungkdChUSqXZvt5WD
	 UuBsXAQbebrZW5ubeFUfcFIaQGTjf9HUBQI6d9O44Ae+BaSnNXsmuX2ccwrBvWntQrNljnexPucH
	 +sxMbPDou9fstgEPiStjVR+6hIsarEP9ytp8MRZnPYMSMCJJK+zHgBzIx3fo5z6ByTO/Kx7JrA9r
	 tZi70WkGWP/q/wXM3OslVFY5c9hXRxgl/NogrjsRGO4AtmhQu4teoY3QQWSUnqUqfBQaByUsDOnf
	 mwFw2zLAh3SwuBGpz4tTkKvZVgMFcrC2znmHNqpVgJA4xMCaaXGLexavxDhKV/AsFwV6SkJLaCYc
	 QDl2IxCPMp0HnRt/t7oHjwbVZJO2RISYJzIUSH3T4UwBy2DoRW1ReSVra1cI6Njh+8W1F1X4Wa1Z
	 p7jVYv02yUnQoDIg71PWBgSvj3JOKjqGtMKvDdMXPnfwFR4EMwIXaLaYYGN4ul1X0SmKllkLu+BX
	 DSaGhodP43SH7hhJWakIvISpv5WMMye5fHOBKKA76+aDGA9uuRtvnrJbQwvIcvFq+6dDx9TNkxAe
	 aWvdVyojZRI/FCtgtL9ueI+ZKMX1eOKJ6O763LA4BW/YgFeMalG9uPgc1Z9+V8OhbDoaKtw5Dbwe
	 Ub/5AKiYonVw4CpRYUIRJ7EXMyLK89PqBwJcgcZZLdB8Tug130nWUq5Eihc33xPERXjGCsGcSmEm
	 uzJ9JwUIwOVOWQ+vovL50Neio/lssWy2NeAgznIPSaXwzRIZtGVmCbTs+jysGcDh7SdHflBHGRJL
	 1oHVBJfoHTC1MbJIAhz/y0//VBDYYgVYuOYAFBcb0KmIrrkgmESqv+WenHsyIJOVGkpcH9/OckWw
	 yvzCORre0xWewHkuOyOWq+m7CKaRF1W9i2sUrDSiOgjbUVp79v82hD/6bC01QMQYzDGDYjNgi4lv
	 biPnp9ukldQhrdlHPZ0aVCkzinkr6nlL5U30Qh57E1dW4PTgru
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: LiuJunyuan <2058432396@qq.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	LiuJunyuan <2058432396@qq.com>
Subject: [PATCH] staging: fbtft: use scnprintf for fixed-size text buffers
Date: Wed, 21 Oct 2026 11:22:08 +0800
X-OQ-MSGID: <20261021032208.12827-1-2058432396@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with scnprintf() when formatting the framebuffer
description strings into fixed-size buffers.

Signed-off-by: LiuJunyuan <2058432396@qq.com>
---
 drivers/staging/fbtft/fbtft-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 7925d974de80..f7751b972a52 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -785,10 +785,12 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	fbtft_sysfs_init(par);
 
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
-		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
+		scnprintf(text1, sizeof(text1), ", %zu KiB buffer memory",
+			  par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
-			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
+		scnprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz",
+			  spi->controller->bus_num, spi_get_chipselect(spi, 0),
+			  spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
 	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
 	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
-- 
2.43.0

