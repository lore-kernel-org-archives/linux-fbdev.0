Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5B38AC6E;
	Sat, 16 May 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778970403; cv=none; b=vDzNF8lUfuuPgn74pdINk3L7szDFiA8GE+iQx8xvRnppEcZuUMULbzkd7XP8oFjMQ/UC4gM2bUM5wIfZlmnpfad9ZCDQGpFE4lJ/0Bq1HluoNnfyGaSsbc/73Xksw8VqfV3Gn50IHHoBchjJpIN//p50Wi3Fm9/F8lVmkBbHXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778970403; c=relaxed/simple;
	bh=AbyOLTl3i5DzwCHnxLGY4ENSI7qP2LuoBPL8iFh0wzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNkkIIZtWq3kWzoH/bhhdmhoMQbNsBbnJVD+yaF193Xl1Q/wGBDK8FYVN8GOEb2rAF1itlcA08TcCt8WSnlKEIBKMCcnTTLQBJ1Vm/m2Alx5PLP4sow4iYhCVX0vInqG4BYbA2p35YsI/kElgG0NTn+1QOMOVJxhGn+a2UaY0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=etN57q2i; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="etN57q2i"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gHzF834z4zDqCx;
	Sat, 16 May 2026 22:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778970396; bh=WeQNATTwhaBva6pUZJK0HccJpYHuy1nkweVeG7AkY1g=;
	h=From:To:Cc:Subject:Date:From;
	b=etN57q2iAFHVgjtUG3klKYTHsqpmp6Bv1meiPE2PbBCoR1doFtGB5mZhq0G9TjH0Z
	 1vajdGfdxsTVrGsbCvsOdf5UKmnc8rMW7TIMe04MMDPzEkTWHjSNQr2BfeKCpuWlvS
	 XtN71Ei9xJI3/i28VHsVww2vMScHL4YpDimfaIlM=
X-Riseup-User-ID: A3B42586109FB1D8AEFC1F897B4FF3B2DDA8BB9E1AB3F4C89A77CA5259E122AB
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gHzF56J3hz1yZH;
	Sat, 16 May 2026 22:26:33 +0000 (UTC)
From: Emmanuel Arias <eamanu@riseup.net>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emmanuel Arias <eamanu@riseup.net>
Subject: [PATCH] staging: sm750fb: fix CamelCase variables name in sm750
Date: Sat, 16 May 2026 19:26:12 -0300
Message-ID: <20260516222613.1178800-1-eamanu@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace CamelCase variable name with snake_case:
- pvReg -> pv_reg
- setAllEngOff -> set_all_eng_off

Signed-off-by: Emmanuel Arias <eamanu@riseup.net>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 drivers/staging/sm750fb/sm750.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 996a586a3727..9b30627a19d0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -755,7 +755,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->pv_reg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
@@ -860,7 +860,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
@@ -1059,7 +1059,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->pv_reg);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..e8885133da2e 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,7 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
+	ushort set_all_eng_off;
 	ushort reset_memory;
 };
 
@@ -97,7 +97,7 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
+	void __iomem *pv_reg;
 	unsigned char __iomem *vmem;
 	/* locks*/
 	spinlock_t slock;
-- 
2.53.0

