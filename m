Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC52111D
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="RBGjfmf2"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD01711
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 07:06:05 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9F3FB24002B
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 16:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1699887962; bh=n57oq4q/Tf+qKEYs2pRrWhcCc1bFBqLQk97twmrop14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=RBGjfmf2kOohBWRrPMFefGieyMt892rF3yD4x8F7Cm+vUXPTkDHVG//3ZY13YroMX
	 NdXfussTZLpIzMXtoHsaX7vb9XLbJttkYF/QdTOcyhYiPxzH49naDRvuhpUhhqen36
	 XcU6eLCIXTMK/ZtZE0QvAysl8Z+9Mes0oSMjdIKQ9ULlcrL7dqL80BFl4zN68rnZOI
	 j7lsSJKlGNfnNuOFhITa+In2A7W6YYUjOxdMmndHevZOydhqaMmBV/Uxd9n8d+Uvmz
	 gxyooTAfW+kpitnoMhAwnvyIIjVrxuJSLfUGIsYs3ltTqyoh/KarxkYpT5LZNcHI08
	 33t9ysagjio1w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4STXn474y0z9rxV;
	Mon, 13 Nov 2023 16:06:00 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: 
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 1/8] staging: sm750fb: Rename sii164GetDeviceID to sii164_get_device_id
Date: Mon, 13 Nov 2023 15:05:06 +0000
Message-Id: <20231113150512.1210869-2-charmitro@posteo.net>
In-Reply-To: <20231113150512.1210869-1-charmitro@posteo.net>
References: <20231113150512.1210869-1-charmitro@posteo.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 8b81e8642f9e..3fb14eff2de1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -16,7 +16,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 	{
 		.init = sii164_init_chip,
 		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164GetDeviceID,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164ResetChip,
 		.get_chip_string = sii164GetChipString,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2532b60245ac..223c181dc649 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -48,13 +48,13 @@ unsigned short sii164_get_vendor_id(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
 	unsigned short deviceID;
 
@@ -141,7 +141,7 @@ long sii164_init_chip(unsigned char edge_select,
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 71a7c1cb42c4..a76091f6622b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -28,7 +28,7 @@ long sii164_init_chip(unsigned char edgeSelect,
 		      unsigned char pllFilterValue);
 
 unsigned short sii164_get_vendor_id(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
-- 
2.39.2

