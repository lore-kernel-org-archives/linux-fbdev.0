Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281400;
	b=vtvySAB3v+lyNvz1OJENXOhQEfT061ti4oicvIeUJRiglGkFExPA1AUgabojQXvGsa2q
	 cmB+yUycBG//5LVxXsY0ehqBt3quGDxqwaE9YePAKNqFMh/7eL7V9AJkbN3uS6vMfRTj4
	 yNm6VkltoG/2eXY00nSCocTqzphEsNBebvE0EFRNQJ1SQZVX4L9aZ5gOl0xk1oLB+VR4w
	 IDtEsUVluE75fo4phQ3bSLUlPOCtdKvvxupa16bRG/VSRgTasKrO9JYkTKBUr7F1FY9XR
	 rtjoSNPFFCFcfDkg/lHGPkaDyH29a6VeL7wv+I7ZQKVSpzXw+BTs1L8lXG8C1I25/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281400;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wAfXimiNyxGjt5hvSoNH/WZxt6zmJP9vl158/kVceow=;
	b=DqgGQv+60BObj2TMd+47K6QQg5y+sVgCsxdoYp2B0/ElH5ult+p2GbJyeynPO4JIQzTl
	 US52u6HBs9HMvNCgIvAE/qo/1isHAHAzCunhYKAo/+qRPG3ZB/PKKBzHpXD4vFER+W/vo
	 5bEL9srTSFe1JZYlh41omloebxLU+d1uvkG4X2cYBiS0HE6ptlFcCXyf9oiT3mGhIJTfg
	 GkYAl08MwwEvxqDytg0zi2jcCqnQgydOpuBJvx6SRa44a6Xi5DWIGwv+Re3CRoLl+ZRKU
	 jqKvHl79zMWT0IJ9YAqRF8NIbGuefKo6xJWhXTxhGT8EQEHLSM4TWRJRdli1LWgZNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=eU2JvbEg;
	arc=none smtp.remote-ip=212.27.42.2
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A40606A320
	for <linux-fbdev@vger.kernel.org>; Sat, 21 Nov 2026 17:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A40606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=eU2JvbEg
Received: from localhost (unknown [45.13.107.210])
	(Authenticated sender: lucasantunes@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 7FE792003CC;
	Sat, 21 Nov 2026 18:16:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1795281391;
	bh=I58JmmLrPF8Q8+YukbWHcL+IJM3ErWNQw1kMPHisjD4=;
	h=From:To:Cc:Subject:Date:From;
	b=eU2JvbEgitzfH3eQfgXoPcDvPSPHznJas7ghOS8buU/FIpSIhuknQmgUoYkqnc0Y+
	 gtbUdmrnD86YGSswVknz/2pwYlrwFZnOnQvELYLMw8qKoj8kpmrBoy0v3nqHzzaQ4D
	 f7Yw6JfF2cRiSwMrZ7jz1ECcloyJ16P9ZXC4UIqEEMIpkmjtz/LgqQEhakPGm/7Mrf
	 apgHEzXQ0fVR0z3y6/VE6tDbi3cL4cijdXIfuJ/6ypodbkB4dP5pV3s9o0FnQFHRED
	 WGqwpHt/k9s7HC1grW+TbTeT1nDMzns7PSEn0jyNZ23pKGafdaFyzFMWYtYNNZlW2E
	 WUou3q2vcnlKQ==
From: Lucas Antunes <lucasantunes@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	Lucas Antunes <lucasantunes@free.fr>
Subject: [PATCH] staging: fbtft: upd161704: use fsleep() instead of udelay()
Date: Sat, 21 Nov 2026 18:16:10 +0100
Message-ID: <20261121171610.16391-1-lucasantunes@free.fr>
X-Mailer: git-send-email 2.56.1
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

init_display() is called from the probe path, which runs in process
context and is allowed to sleep. Replace the busy-waiting udelay()
calls with fsleep(), which picks the best delay mechanism for the
requested duration, as recommended by
Documentation/timers/delay_sleep_functions.rst.

Delays of 10us or less keep busy-waiting inside fsleep(), so only the
100us and 200us delays actually change behaviour.

Signed-off-by: Lucas Antunes <lucasantunes@free.fr>
---
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index 7288140e7c3e..26b7309d6455 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	fsleep(100);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	fsleep(10);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	fsleep(200);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.56.1

