Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAF421341
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="ZWM8NpLD"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D651724
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 07:06:06 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 448BE24002A
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 16:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1699887965; bh=8g5GOgbsSIb0+uiH/RjuHbvfKx7eOUtzVUmIxlBSlU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=ZWM8NpLDkkv3EBMarEBNCs4/C4YLe3fwY1XDbR0dNPVPiMJiPTScXxDtS23Q+nZpz
	 Gnb4LBOWD5/lgzBhv5OEpawP60O8BC5yCiIeLrOUb1iFh04NmznB0+C3gWqCiuxhYg
	 rfz9Xj5brCVe4PErsOACn+5OAxqEaLwc2jCzMXOZ+a6uV8KWIjpUBkPjhbQp+BlZQE
	 TOzG/H2FKgk3zlVhG/GFfunyjzd7rfqnHUNZ/Tx0K4v0sI66HsrVX/4DjlnEaHmPvK
	 pIqeEgEPoGS38voY7S4o9pvee3C5E5+t1ri/YTY9oNqnpHCsNkN8nuFfZXka4vNXoP
	 7XUQLpFRwWBeQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4STXn760GLz9rxf;
	Mon, 13 Nov 2023 16:06:03 +0100 (CET)
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
Subject: [PATCH 3/8] staging: sm750fb: Rename sii164GetChipString to sii164_get_chip_string
Date: Mon, 13 Nov 2023 15:05:08 +0000
Message-Id: <20231113150512.1210869-4-charmitro@posteo.net>
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
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 6dee95e60a6e..e568c210e2bd 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -19,7 +19,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
 		.reset_chip = sii164_reset_chip,
-		.get_chip_string = sii164GetChipString,
+		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164SetPower,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
 		.is_connected = sii164IsConnected,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 284c32f7e9b4..f0a255da1b36 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -261,13 +261,13 @@ void sii164_reset_chip(void)
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
 	return gDviCtrlChipName;
 }
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 7a71f94a1e9b..7c5cc81f38d4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -32,7 +32,7 @@ unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
-char *sii164GetChipString(void);
+char *sii164_get_chip_string(void);
 void sii164SetPower(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
 unsigned char sii164IsConnected(void);
-- 
2.39.2

