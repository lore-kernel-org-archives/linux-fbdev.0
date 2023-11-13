Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006321360
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cZTlFL/0"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B149171A
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 07:06:10 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2C351240028
	for <linux-fbdev@vger.kernel.org>; Mon, 13 Nov 2023 16:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1699887969; bh=+0firMEs8jGDnwurQSwdedi7SuSTkZP4QKZILe7SstQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=cZTlFL/0STVCQhNkdzXzcVbpju767yxMPdu7HsF4yEc4ysIMfmUitmsJFX/tdF9Vh
	 4+h5nfS6C5se+tccwzgDiWeTlLJ8yX5TDQOADpFdFaW40RzODxSKc6MwJl287PF66e
	 nOcVcQg9o44pkgkGIt5qcxLfYTDn1/6vi8c6R8+EkUkSUpg6iN8+HYrEUm3JmU+/6K
	 RPyU4RZ62rgqg3OpGwYA3q/yk4kQqAS6v1sGH4eQchsuEZmXLrBE+YXBs4wk7XZM6h
	 flBgGZcTU2SJ5ElmOZHkIJuHOsgAiPfpP2+KOFTKFISl9p/TcioQ7WS+PEr68qqdMI
	 0arY8pS97rkVQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4STXnC3t5Fz9rxS;
	Mon, 13 Nov 2023 16:06:07 +0100 (CET)
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
Subject: [PATCH 6/8] staging: sm750fb: Rename sii164IsConnected to sii164_is_connected
Date: Mon, 13 Nov 2023 15:05:11 +0000
Message-Id: <20231113150512.1210869-7-charmitro@posteo.net>
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
index 1ce44c50617a..ac1aab77da28 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -22,7 +22,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_chip_string = sii164_get_chip_string,
 		.set_power = sii164_set_power,
 		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.is_connected = sii164IsConnected,
+		.is_connected = sii164_is_connected,
 		.check_interrupt = sii164CheckInterrupt,
 		.clear_interrupt = sii164ClearInterrupt,
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 430acc4c2a80..24f40db0dfcf 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -350,14 +350,14 @@ void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ea3859a5a430..f8689bb3e1d5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -35,7 +35,7 @@ void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
 void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
-unsigned char sii164IsConnected(void);
+unsigned char sii164_is_connected(void);
 unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
-- 
2.39.2

