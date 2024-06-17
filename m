Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CF155736;
	Mon, 17 Jun 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634513; cv=none; b=Hzpk2cOtFzYoNZxqebyF6UMyv5/FpaILfgt7W+BE/DFdJqu1fHJZkc80hZ9zGFMa6yT2f0CmQnfsApK1ISjeeapMLjnht1xVmqr1qkX6jt8iDXnwL7tYD3eNRRpmKN+gKKbn8FcL4fXrEIPPa4TopUPYn4mntYPOXZwm3LbnlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634513; c=relaxed/simple;
	bh=P/NrncKQR4tv9oXaIUeKT1Nf/NY6cRVCw7zAn/4OBNI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gf1g6c99brI79GFwMRNMfh/o0x7/VjS7mtCzEabNziEgkHt2Yn+tL4nFI90zYbtDQEiJAUdyIIPAwH0J6uX9dZVGZHj7MpF8qT1xG051XsI4UJKU4fUK7l7Oq+zEekTUZrciyukMb2WZ8RXype1ldnffUvc/glJB8M3FKoixtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=XrwjtL/i; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="XrwjtL/i"
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4W2sgX1DfyzDqfq;
	Mon, 17 Jun 2024 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1718634504; bh=P/NrncKQR4tv9oXaIUeKT1Nf/NY6cRVCw7zAn/4OBNI=;
	h=From:To:Subject:Date:From;
	b=XrwjtL/iln3NR2iQzbx77hmYVMi4RnePeEXTPlRDM+86BX8uj9GI57V1lqlXNfSUp
	 NU702EoCYOSam/Q/FV6XR9qK3TikLVHodbjpLb4kqabeuJcrr8XrBXRxNNT1YEjU/M
	 V/Bg5Ut7eyhVuwnQF0rx1czC+IeyTKL/uYhDpchE=
X-Riseup-User-ID: C43C3320A8254A748022E269A5DF7B5E499C7825BF1B5A845D821EB134D22584
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4W2sgW0yTXzFt8Q;
	Mon, 17 Jun 2024 14:28:22 +0000 (UTC)
From: Shiva Kiran K <shiva_kr@riseup.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roshan Khatri <topofeverest8848@gmail.com>,
	Shiva Kiran K <shiva_kr@riseup.net>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Remove unnecessary parentheses
Date: Mon, 17 Jun 2024 19:57:47 +0530
Message-ID: <20240617142746.51885-2-shiva_kr@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary parentheses in `if` statements.
Reported by checkpatch.pl

Signed-off-by: Shiva Kiran K <shiva_kr@riseup.net>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 drivers/staging/fbtft/fb_ra8875.c  | 2 +-
 drivers/staging/fbtft/fbtft-bus.c  | 2 +-
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 0be7c2d51..409b54cc5 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
 	devcode = read_devicecode(par);
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code: 0x%04X\n",
 		      devcode);
-	if ((devcode != 0x0000) && (devcode != 0x9320))
+	if (devcode != 0x0000 && devcode != 0x9320)
 		dev_warn(par->info->device,
 			 "Unrecognized Device code: 0x%04X (expected 0x9320)\n",
 			devcode);
diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 398bdbf53..ce305a0be 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -50,7 +50,7 @@ static int init_display(struct fbtft_par *par)
 
 	par->fbtftops.reset(par);
 
-	if ((par->info->var.xres == 320) && (par->info->var.yres == 240)) {
+	if (par->info->var.xres == 320 && par->info->var.yres == 240) {
 		/* PLL clock frequency */
 		write_reg(par, 0x88, 0x0A);
 		write_reg(par, 0x89, 0x02);
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 3d422bc11..ab903c938 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -85,7 +85,7 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 	if (len <= 0)
 		return;
 
-	if (par->spi && (par->spi->bits_per_word == 8)) {
+	if (par->spi && par->spi->bits_per_word == 8) {
 		/* we're emulating 9-bit, pad start of buffer with no-ops
 		 * (assuming here that zero is a no-op)
 		 */
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index c8d52c63d..64babfe3a 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -666,7 +666,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 		txbuflen = 0;
 
 #ifdef __LITTLE_ENDIAN
-	if ((!txbuflen) && (bpp > 8))
+	if (!txbuflen && bpp > 8)
 		txbuflen = PAGE_SIZE; /* need buffer for byteswapping */
 #endif
 
-- 
2.45.2

