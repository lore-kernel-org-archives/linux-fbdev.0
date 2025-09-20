Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436D220698;
	Sat, 20 Sep 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383783; cv=none; b=Jlcw9kM0Lhk0rTMz0YiYMxpcXdGAfGoae5nUCe3uLBSKkbLPK8wDZA84txVY628SUacEr1VKu0IqMXTAq1xk6hDv+gyVrhnVLkNRdXGGYJuPs0cDPnl7gDZNCih5KTcrHy7iuyTxj4grIwD7mOqgRGA6zT5d0KcWCaaglmUTttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383783; c=relaxed/simple;
	bh=hQHDmwnGbYQZbf9/nPLWKaETgRt4+EZd0tTre0SC4NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/EnLOdTLgyDgEWPtGLL+Sp3hZJtmxPfBdrVenasFm9Q+7oD2ZdEttVA1QvxrRkpRSgjeFwiPjFHM7cnF/NLz52gmKgRX3N7YA+VferZchnGpYrnaj4HsrUncGjcDnA1ubd7yDRPhGiCoOcsE07YjdtjHS3WLM4ppLuhrzILH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=iOOUzFT0; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="iOOUzFT0"
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5b9b:0:640:5d70:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id ECDD5C0051;
	Sat, 20 Sep 2025 18:56:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5uWWxMdMsKo0-C9EVhexi;
	Sat, 20 Sep 2025 18:56:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1758383769;
	bh=2Cm8GwjzPTQSGnGP/jtp41W0WE0pfRZxKAWpYfamrA8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=iOOUzFT0Cj6wnaZ2vyLATF/lg/uDMgx3iDzFfwnOSOAh3RU8S9MQYTrYC5cQdK9VL
	 6X2GyU0kxD9QqTuwIfwRNpFqGWRYHPdofdQqSgXKfdbVq5LB0t+xh7AjroESed8xeF
	 Di7j588LnSiFOHv5B74D8ColloZrohZle6+hPquA=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH] staging: sm750fb: rename camel case identifiers
Date: Sat, 20 Sep 2025 18:55:52 +0300
Message-ID: <20250920155552.261976-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename two identifiers from camel case to snake case, in order to follow
kernel coding style.

Changes:

- Local variable `deCtrl` to `de_ctrl`
- Function `deGetTransparency` to `de_get_transparency`

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750_accel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index b07c1aa68621..046b9282b24a 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -89,7 +89,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 x, u32 y, u32 width, u32 height,
 		      u32 color, u32 rop)
 {
-	u32 deCtrl;
+	u32 de_ctrl;
 
 	if (accel->de_wait() != 0) {
 		/*
@@ -121,11 +121,11 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		  ((width << DE_DIMENSION_X_SHIFT) & DE_DIMENSION_X_MASK) |
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr8 */
 
-	deCtrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
+	de_ctrl = DE_CONTROL_STATUS | DE_CONTROL_LAST_PIXEL |
 		DE_CONTROL_COMMAND_RECTANGLE_FILL | DE_CONTROL_ROP_SELECT |
 		(rop & DE_CONTROL_ROP_MASK); /* dpr0xc */
 
-	write_dpr(accel, DE_CONTROL, deCtrl);
+	write_dpr(accel, DE_CONTROL, de_ctrl);
 	return 0;
 }
 
@@ -284,7 +284,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	return 0;
 }
 
-static unsigned int deGetTransparency(struct lynx_accel *accel)
+static unsigned int de_get_transparency(struct lynx_accel *accel)
 {
 	unsigned int de_ctrl;
 
@@ -391,7 +391,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *pSrcbuf,
 		DE_CONTROL_ROP_SELECT | DE_CONTROL_COMMAND_HOST_WRITE |
 		DE_CONTROL_HOST | DE_CONTROL_STATUS;
 
-	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
+	write_dpr(accel, DE_CONTROL, de_ctrl | de_get_transparency(accel));
 
 	/* Write MONO data (line by line) to 2D Engine data port */
 	for (i = 0; i < height; i++) {
-- 
2.51.0

