Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFAD3203A0
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Feb 2026 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160085; cv=none; b=c+wIEhynrc1O0NTysFuL42wGiTyoUbLudxxXsKTQc+CInFUGodov1TtsOaas+6T8KJd+LvgQiWyN55CA6P4yvAWnMMpDMoebnbFNp3ORXbrdgBFHCf0uzk8AcNxNOSV3wODYYZtITxji4PolZKJYsJX97ISUWCYnuoeD+d7moew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160085; c=relaxed/simple;
	bh=Gcm1Iav91TTTAVj0nriWrXeBLn3kGO49ncq0sDbIYQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzpakD3o1rkYk1U35nAj3LJdnklio2SWQZsAKAZnjhHoHVdCJ2HaTVQAgT4hH8LI7uPpFamLMtNH2PiP1nR9R08y15JBN7Twg8L/IDz1MYAsG14RXWACfkIG2ml4PqZh6tv6OZNGLPzy8Dz3nQF6/eeTsVHA+c3sHc65Q20BPAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUwntbhY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUwntbhY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8876d1a39bso880453766b.1
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Feb 2026 15:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770160082; x=1770764882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8eVvK0hQtAaFSe0DxVimgKjYzP0klYwJacZB1JLMGw=;
        b=GUwntbhY4Rz2fy0emzXRlYo52Sew0ybe5wNjCGfZjcuw10tgqsb1deLGlBd3K3CrrS
         Z2BwgaVGBRMmYp0HqROJ6mFXPk8eaiPs5voLzh6p62JuK5cykYYL42CHRZMVEf1B+lnl
         23kQskGavYTBrfw4ZDyI8fLdkrs6xpny57Va9Ge55PgXhXSGHrVGHnD0r0+BG7l4nmHZ
         VUQ5wobyiMOQX8A0/CVveldkNWKNHCRSM2oJCyf7+G0wEEbOYURmiXS4/+zTTl0HCB+o
         BT6ImOsbg5FExZllg8MTjb4U83v79z4S8+pvdhKSIX85sdAm53WRYJrVK+IbWhhs0XUF
         baDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160082; x=1770764882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8eVvK0hQtAaFSe0DxVimgKjYzP0klYwJacZB1JLMGw=;
        b=YVMnK/P68r89GNP0fe2PKYpVDGfUW3fmCV3O85yad15pzKbN+36WKJ2lfNepVq5qka
         kPyqaV8Ofv1cUDn7zAup88sUxK9mPTE6g2lIF5avWw1xezCv3qDgm2spFxEY6X10wyxX
         NHyw5f3NwbMWZic3rZkgS3lIAFi5pa90jkDP8nGnE8RpDzUDhRFFwFAoTKPUXNzVsaBL
         vAtVjsK4+9mNoDgaps7TK+3XJWlxlkc0cZoAGiFDdpsQ4qaZUTAf8IEcy9K5Ku59Nf1G
         FQExXMAXb67R3vpEaQY27wLESFwZ6hUwJ+zpzRP7UNtOe4yiX6+dksG6HoLjK8OWh38z
         8aeA==
X-Gm-Message-State: AOJu0YyxjewcVsNJlBOD7vZlQlyE5z/UaR2Cg9fqEYwb/4aUQgUv5Clq
	26LX0RP82ddrgNClflW5oYiH8VI9nWfLcyv/Et5t/tr0TfCHwR73IYIo
X-Gm-Gg: AZuq6aIj/anV8v/r8mRsNzeuL0He1FjmoGKBOmKQVB60S1AukrR4cbQDTSTSsr4c5+1
	XxYrzr925HT0+i60JQ8cmALHIiF58oKQXOrn4HUnHxCaDpSgVmPgGdQeugiAkXuyGZ4VkZtsvlN
	p8E9OIGnHC2X36mJ+TwjdVpI0EwOp0TYnMO5qIHo8/nYa/Q4lGInP872LRF50W+REe8Ky4Zaq+z
	Q3a4jerub045mN3nMuvRLL1uIapZbdO4Y2Hy/V0NCA7Wp55vuKVJS4x/ZXjV2FZxr26o+pbsqz5
	ZUQdPcm97OXrZIR4FF3nbI+Y38R8OoLHJ1bWaf7noyg7GlrN2jQXTgtYTfq7CrDzQ/SDm9aoWVw
	uLmDEN0kWEp6qoCl0/5luri/VNdLsH8YwFe0bLTH804EJA3Ml8cEj6vmVis5j8CyqcuIpGuQxsh
	EZTLEnN0OR/6Ww904QXb3It/S+PtZQPq7buxKk3p9sBBlo3l5T9E12oC51LYLLFg2d7m9XtYluK
	YeX+YaKBP4TrFB7TvrmMDBWClus3tGjhfculWquA9RiYT4uZsmZBGgrcGY=
X-Received: by 2002:a17:906:7304:b0:b8e:3877:d1b2 with SMTP id a640c23a62f3a-b8e9f0a7a53mr74983166b.16.1770160081720;
        Tue, 03 Feb 2026 15:08:01 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (33.242.13.34.bc.googleusercontent.com. [34.13.242.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea0021b3bsm38486566b.49.2026.02.03.15.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:08:01 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH 4/4] staging: sm750fb: convert pr_* to dev_* logging in sm750_hw.c
Date: Tue,  3 Feb 2026 23:07:58 +0000
Message-ID: <20260203230758.3056-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203230758.3056-1-iprintercanon@gmail.com>
References: <20260203230758.3056-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert pr_info/pr_err calls to dev_info/dev_err in hw_sm750_map()
and hw_sm750_inithw() where struct pci_dev *pdev is available as
a function parameter. Functions without direct device pointer access
are left unchanged to avoid unnecessary signature changes.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..60f9f7135 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -34,7 +34,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
 	sm750_dev->vidreg_size = SZ_2M;
 
-	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
+	dev_info(&pdev->dev, "mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
 
 	/*
 	 * reserve the vidreg space of smi adaptor
@@ -44,7 +44,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 */
 	ret = pci_request_region(pdev, 1, "sm750fb");
 	if (ret) {
-		pr_err("Can not request PCI regions.\n");
+		dev_err(&pdev->dev, "Can not request PCI regions.\n");
 		goto exit;
 	}
 
@@ -52,11 +52,11 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->pvReg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
-		pr_err("mmio failed\n");
+		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
+	dev_info(&pdev->dev, "mmio virtual addr = %p\n", sm750_dev->pvReg);
 
 	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
@@ -72,19 +72,19 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 * @ddk750_get_vm_size function can be safe.
 	 */
 	sm750_dev->vidmem_size = ddk750_get_vm_size();
-	pr_info("video memory phyAddr = %lx, size = %u bytes\n",
-		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
+	dev_info(&pdev->dev, "video memory phyAddr = %lx, size = %u bytes\n",
+		 sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
 	sm750_dev->pvMem =
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 	if (!sm750_dev->pvMem) {
 		iounmap(sm750_dev->pvReg);
-		pr_err("Map video memory failed\n");
+		dev_err(&pdev->dev, "Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
+	dev_info(&pdev->dev, "video memory vaddr = %p\n", sm750_dev->pvMem);
 exit:
 	return ret;
 }
@@ -163,11 +163,11 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 			 * The following register values for CH7301 are from
 			 * Chrontel app note and our experiment.
 			 */
-			pr_info("yes,CH7301 DVI chip found\n");
+			dev_info(&pdev->dev, "CH7301 DVI chip found\n");
 			sm750_sw_i2c_write_reg(0xec, 0x1d, 0x16);
 			sm750_sw_i2c_write_reg(0xec, 0x21, 0x9);
 			sm750_sw_i2c_write_reg(0xec, 0x49, 0xC0);
-			pr_info("okay,CH7301 DVI chip setup done\n");
+			dev_info(&pdev->dev, "CH7301 DVI chip setup done\n");
 		}
 	}
 
-- 
2.43.0

