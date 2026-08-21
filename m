Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922E346E5E
	for <linux-fbdev@vger.kernel.org>; Fri, 21 Aug 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325350; cv=none; b=cV/dBFlZunuWyP5ys5R4AzL/XodfIid3wmywP//7LMQwJMKxZXZ4dhihRAqtU1nnVWTKJKY3a1rMfJAaz+LLqUK4CpK/bINd+O7WrA9o9ixUPf7vfaFT1weqveKXymeNieJ2zDFnvFjsw/WCn6J1WkD6t6MoNQw2QO+MP3neLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325350; c=relaxed/simple;
	bh=VWprNmqQgfznUUymEi7MLyrplr+mofikIGdmMHvaI5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCfvR7Xv9IPZMUudinfLdM7ll5Cm1mxZjZJ7NxG/ZmBaIcxz3SYasQK4vGznGoZRjqo4e/OFba5pIabLphlrvIraljMr8XR+Af/sXx6nkq6KwV571I2TlUFvHOu3Xjpu7yRYGf10pjg/hEmDnb+EifotFfnmzsuhr7bQIBFPX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3Exgo4q; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3Exgo4q"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e85499ffbso86419585a.0
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Aug 2026 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787325348; x=1787930148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpgB6bU5DPvqDeHFBiZr0voqp9OUP9pmguygZ0b0Ukw=;
        b=E3Exgo4qZG0oOwO1AcEPDff/Spg4iRrss6jmJfCtLD5S8JRHIPWxNhEQ8YAerX3f9h
         BIhw1H88c5bvd1FP3jAxZ7+3vkWMb+ZWhPzlgVXTR3qKTqLC6WCiIDORQ8N7u5Rs+Jjm
         qZKgqLsspm5crEcDiJ3P6SsP9BhKk36SyF0Tt1WjGA6i2SrLwnzVgHnG2KM3ssjk+q0L
         r4fnCtQTNhB61rcPFMYPyTudzFT+GAxNyy2d6I7XlzGkW39GhzzBrPo51mHiMobg/jvm
         2Vxgr+midgwKskyoPW0P4kT7RTIeidIx15d2yP/2VM/AKzN4U73DSQDWJnmZ7ZDU8XZG
         SGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787325348; x=1787930148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpgB6bU5DPvqDeHFBiZr0voqp9OUP9pmguygZ0b0Ukw=;
        b=BHTHn2KPIKYeFWZNtdBS77rDkJLpsa9RqHqTMIXyl5N3UT4m+LnUX+D96pYNSt3VPL
         l+I5c7ExmthMGzfvzzhcCF7/VPDqaZqjDpuETwUj9eUq82ItDn6g7PlIYrYC8BiGCOPi
         wHB9H9gybjHdAgOFkDw39oXbPnIT/5DIPgj5bskD7RclaVmHGvdK4dueRsr84UGv0VxP
         6uhFb7ucZKeMu1CT//RHnEdyho2MItEN/bBYE760a/Uo5Tdf8wIqwJfKx+DbD/40jCu2
         NRIwuk3ivvodXFnlYcNN9YVT+NMCk/BJr0o5O7nWy6HlUIYFS6uXcea+S8gkn3Rvsla0
         rlcQ==
X-Gm-Message-State: AOJu0YyNaKo69B0MS0cFVWyodPnUv340bZ6DPPEJ1bx73pQ4EbEjL2FB
	L4eE3uXxwyfauw8x2oClGcIiR+qyAFA4WfFgRjNp9l1HPq/MoxwTsFWE
X-Gm-Gg: AR+sD12sy1m9gbiSXiA5fmAkaHFza5pGRWlqI+TopaPbKuAFjclznyLkNS6t9tdBP0s
	vF7UdX0rCiF6hHT3EMwxArcFwKqicHwIFYFdyChJbIt9lMeT1WEiy7pgcfKHt0lLVMS4IKZXjAi
	VrH/fCno1JZKxtZboxRhaiLFu50IJaMfxCGzjx8xe66VTNkFDGAz/Or37pHkrTN3IX4u8lHiJdE
	wLWqR0hMMS/TniuKkmygZWAzXSynsKeSByqL0Kv5UQSs9Cs9gjK3UBDYyrPJnUyPVL3BElrVrRR
	XCJ26y4LsG2ISSQp7Z8DeNDXzFi6fht4KnDDu6jiF2keJQFGKJosZuy+XDOigwnUPALGJXpGWeP
	uj6blEv6mMBGRI0pS6v0YZ64koDmAzw5+7qImu3BZ/wzaoK/3xQM6wyxpWbcBAXtmyDHlVR7Lzf
	jo6yFZxhR1HWesP52hpjyZ9SdCb7sZi0xLUzP/uDrTmg==
X-Received: by 2002:a05:620a:f0d:b0:936:48f2:b04f with SMTP id af79cd13be357-93739432247mr652456285a.6.1787325347871;
        Fri, 21 Aug 2026 08:15:47 -0700 (PDT)
Received: from fedora ([2601:5c2:8600:6e00::18ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493f35sm614552785a.9.2026.08.21.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:15:47 -0700 (PDT)
From: jaiden.linux@gmail.com
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Jaiden Magnan <jaiden.linux@gmail.com>
Subject: [PATCH] staging: sm750fb: rename CamelCase variable pvReg to vreg
Date: Fri, 21 Aug 2026 11:15:25 -0400
Message-ID: <20260821151525.54751-1-jaiden.linux@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaiden Magnan <jaiden.linux@gmail.com>

Rename CamelCase variable pvReg to vreg. This is to fix the following:

CHECK: Avoid CamelCase <pvReg>

Assisted-by: LLM
Signed-off-by: Jaiden Magnan <jaiden.linux@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  4 ++--
 drivers/staging/sm750fb/sm750.h    |  2 +-
 drivers/staging/sm750fb/sm750_hw.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..0bfda7508bb5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -743,7 +743,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	 * must be set after crtc member initialized
 	 */
 	crtc->cursor.offset = crtc->o_screen + crtc->vidmem_size - 1024;
-	crtc->cursor.mmio = sm750_dev->pvReg +
+	crtc->cursor.mmio = sm750_dev->vreg +
 		0x800f0 + (int)crtc->channel * 0x140;
 
 	crtc->cursor.max_h = 64;
@@ -1047,7 +1047,7 @@ static void lynxfb_pci_remove(struct pci_dev *pdev)
 	sm750fb_framebuffer_release(sm750_dev);
 	arch_phys_wc_del(sm750_dev->mtrr.vram);
 
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->vreg);
 	iounmap(sm750_dev->vmem);
 	pci_release_region(pdev, 1);
 	kfree(g_settings);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..a40dbcc2e6c8 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -97,7 +97,7 @@ struct sm750_dev {
 	unsigned long vidreg_start;
 	__u32 vidmem_size;
 	__u32 vidreg_size;
-	void __iomem *pvReg;
+	void __iomem *vreg;
 	unsigned char __iomem *vmem;
 	/* locks*/
 	spinlock_t slock;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 34a837fb4b64..03c951619c70 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -23,18 +23,18 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 
 	/* now map mmio and vidmem */
-	sm750_dev->pvReg =
+	sm750_dev->vreg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
-	if (!sm750_dev->pvReg) {
+	if (!sm750_dev->vreg) {
 		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto err_release_region;
 	}
 
-	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
-	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->vreg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dp_port_base = sm750_dev->vreg + DE_PORT_ADDR_TYPE1;
 
-	mmio750 = sm750_dev->pvReg;
+	mmio750 = sm750_dev->vreg;
 	sm750_set_chip_type(sm750_dev->devid, sm750_dev->revid);
 
 	sm750_dev->vidmem_start = pci_resource_start(pdev, 0);
@@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	return 0;
 
 err_unmap_reg:
-	iounmap(sm750_dev->pvReg);
+	iounmap(sm750_dev->vreg);
 err_release_region:
 	pci_release_region(pdev, 1);
 	return ret;
-- 
2.55.0

