Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD73164C5;
	Mon,  4 May 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927626; cv=none; b=NxZwLMtoASdY+tpnO90O6tOm9mTSjlebIZLWvTDTV3KQNaL2LSpsc2hbv5AiMC7YOOjERBIFh3tEmy2nM8Rn8S87Vw+EZhJksiFYrGwuiFIqWyDwlS3XWIbaOF1+SvVp+ubN/AMnxXBQAroFRZDe28pbG2cxJhxARxOnLaPR65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927626; c=relaxed/simple;
	bh=08t+r0coPFPOtxXp3hFRFYMI0LSHb3U5gWeUqynXig0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CoC7g40Rt8VNacBzFZ2+9ZnKTL4IwYfaWbhT0ZyjUjRvGSMtg+fpQBPntj3OV+SS2gzV1sppn1qnaE0XRRywOD62quIHubNhg69QzMySHGUnLNYLV+Dh5EmGfcHo38rRiO2x4UbmUEtAGoQHNXx83GuH2350exib4obimXe69fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=gq+ubEuj; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="gq+ubEuj"
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 91A0CC0079;
	Mon, 04 May 2026 23:46:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id okmaLUwSNqM0-B2CvVUOY;
	Mon, 04 May 2026 23:46:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1777927613;
	bh=ieK1us3BRhqqmU6g0lTUV7iD/KLBEH3TK39pum1eGq0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gq+ubEujHzO5rabbXCLzOGJyMqKJKshAN5dvjhz1w+onyRsgZhgZK2mtso9AG81OJ
	 OXW5YhLzG/YSYzcmBOLzGi3xlklYyaSpJ01S+2FtFCXtTCv1m1GUtJafp2PubVDiLK
	 mp45ISwTj8x3Bu6XbQ93bbl9b2icvPRJu6P1z8iE=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH] staging: sm750fb: remove unnecessary initializations
Date: Mon,  4 May 2026 23:46:12 +0300
Message-ID: <20260504204612.55657-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove two instances of `ret = 0` initializations since the variable
is overridden unconditionally before being used.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750_hw.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index beef05ded98d..780fe6c391d3 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -29,8 +29,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
 	int ret;
 
-	ret = 0;
-
 	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
 	sm750_dev->vidreg_size = SZ_2M;
 
@@ -243,7 +241,6 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
 
-	ret = 0;
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	sm750_dev = par->dev;
 
-- 
2.54.0

