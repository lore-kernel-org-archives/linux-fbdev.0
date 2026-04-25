Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C63290A0;
	Sat, 25 Apr 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777100427; cv=none; b=SoE8q6tJGOKulKOaxMf4SjDxZoC8pgClgczdUl1UIFNuvEb+pl6Mlp8Q49Hq+1/nY7NukMFPftXI3TnofDne8EOa6M9ViND/VbZDexz7j6NjdivXJEmcA5TpI0EFrCun9JuB0gOPEehBEa33VY5Hpq2zpx8lYG8oEYHbX8xBHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777100427; c=relaxed/simple;
	bh=Gonxd0iL9Tuk6y5z2YyM12SrWNe71P84mx/Nq1ooZWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kedr/uy/7yA91DSRhvGe+uTOBYdbuD+ELV/W8cOuoXe85QW4RjItrZ+LO/WFshS76oJbhlkORtH9jW0US4gltzxkN0JjXW6ug90D2p/b1V/ZGIPPYsDpU+DvEY3apsX4qMoopolxfaG12yH6pdIVD8FegMt+PJ2xw7b0p38B9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b15c40e407411f1aa26b74ffac11d73-20260425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0c821f6f-9d7b-434f-8633-d577e1bb29c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:811162c714472847b9bf5bdc8c960aba,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|898,TC:nil,Content:0|15|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b15c40e407411f1aa26b74ffac11d73-20260425
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <aichao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1074413301; Sat, 25 Apr 2026 15:00:18 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux@armlinux.org.uk,
	dilinger@queued.net,
	adaplas@gmail.com,
	James.Bottomley@HansenPartnership.com,
	FlorianSchandinat@gmx.de,
	alchark@gmail.com,
	krzk@kernel.org,
	kees@kernel.org,
	rene@exactco.de,
	tzimmermann@suse.de,
	rongqianfeng@vivo.com,
	thorsten.blum@linux.dev,
	chelsyratnawat2001@gmail.com,
	soci@c64.rulez.org,
	gregkh@linuxfoundation.org,
	daniel@thingy.jp,
	linmq006@gmail.com,
	fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-geode@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	Ai Chao <aichao@kylinos.cn>
Subject: [PATCH 17/35] fbdev: rivafb: Use safer strscpy() instead of strcpy()
Date: Sat, 25 Apr 2026 14:59:08 +0800
Message-Id: <20260425065926.1091168-18-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425065926.1091168-1-aichao@kylinos.cn>
References: <20260425065926.1091168-1-aichao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a safer function strscpy() instead of strcpy() for copying to arrays.

Only idiomatic code replacement, and no functional changes.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/video/fbdev/riva/rivafb-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/riva/rivafb-i2c.c b/drivers/video/fbdev/riva/rivafb-i2c.c
index 6a183375ced1..5ee59be01850 100644
--- a/drivers/video/fbdev/riva/rivafb-i2c.c
+++ b/drivers/video/fbdev/riva/rivafb-i2c.c
@@ -91,7 +91,7 @@ static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.class		= i2c_class;
 	chan->adapter.algo_data		= &chan->algo;
-- 
2.34.1

