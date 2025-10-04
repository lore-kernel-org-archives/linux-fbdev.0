Received: from forward204d.mail.yandex.net (forward204d.mail.yandex.net [178.154.239.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105F125A9;
	Sat,  4 Oct 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759611362; cv=none; b=tDohpr+Q+C32z+K/r3k3Yn90mF6drBlMvT7JzH4KYgQ3bZlanM0EKMnhXVdceFXqy2O5EpUVoO0VyEEeWzla80+jtZ2H2ZJvHw6u4D4JioIm4G1sOD/mUSmyfDHcGAHg44IukejoRym4NiNsHNGgR0Ldejy1q4Ouj/7QRw9ZdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759611362; c=relaxed/simple;
	bh=XunCZV2PWmEJivEDLw4jsSvbKlqnhJ5osN9+mZbKpDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmnIK6l5P3xqFvjNEro7I0Lz+zIwpzgaq3I04RyTrImh8YoJ6PvYOOZu3Ah8Ty3zdQC+khCECbFvqpLg7w0BNu1lIiomsMS3FzUyEn1xb6KJLNr7+aPx4jcSdkf3sP62GG18kPlJ3p97hEthfEhcP3ziWbBsDty84OwPaONmVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=EBz9ocGM; arc=none smtp.client-ip=178.154.239.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="EBz9ocGM"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward204d.mail.yandex.net (Yandex) with ESMTPS id D5B1A81A10;
	Sat, 04 Oct 2025 23:49:35 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 2BC6FC0033;
	Sat, 04 Oct 2025 23:49:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NnpTQIPLHqM0-yA8pSY4G;
	Sat, 04 Oct 2025 23:49:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1759610967;
	bh=P3tHAywGzzW94VXJ7Fsyl9O4UHti9Z7NcwrXELExkcA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=EBz9ocGM6Mj9NhVNCZDiqkGwLWaaRME6mP3d+TVrY1schcSm+kozE4ZuG2wJ6GguF
	 8xAg0BepUi4T0wNfMLFVbGb/6jizTp6CKeOBnB9qcHeURQ9/AycqpvUVn5LXoGDpCs
	 Uesg5o3cuBWr9RJHOd47lgU6CnJGs8c8fmstT/j8=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH RESEND] staging: sm750fb: rename camel case identifiers
Date: Sat,  4 Oct 2025 20:48:34 +0000
Message-ID: <20251004204834.3983-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.47.3
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
2.47.3

