Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45A3D9024
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200141; cv=none; b=IFwHXOnEEwLbRQ4hNk2UXVa7sFmTyJ+RG3l7G6rCaA8d7kx930G8ilzPP1/zgoMmszM7o/tDXocCI7BJd7xd25nyk6a5PPizYbowNXZO0PBOjmgYYmyzllO55uEesiis8XOWQMBciTM9Rc8aMHDp8+qX7LtPemWQkU3/+EEhLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200141; c=relaxed/simple;
	bh=bMxUq70RwVuk5iigpePsp7XMrOK64peoAD9t3HviJFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlQedzPyEmNuLmll9qwTiNWInI4FDdRn/gXpGDHQqVgoH8eQTO37AqFzFHOmqKK2nJMrB5/+co2kSlKLThY/Lydvgdv0yah8HQFOJII+i9LYgCR6KyfggUgY6kgNgGxVI7VpbwLgeOLzdZA5Zq732UDtr7XpVEcr5xiMnG0rqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwBHoPPi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwBHoPPi"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8e9f89a8e3so101176366b.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 02:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200140; x=1770804940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McnoIwHymvcTqEFWu2XGqZPzlmsKHzZzIUqEBe0TJKw=;
        b=dwBHoPPiVCpHfOVS0KmTnVqDJiGt2rz6U6SF4qJpM8yfuwArW+tgeGjVUjjGDR72fb
         4R5k/nxaonyAWuNXbU73lb/1zLv9cr3G6F/s5p/Dl15TMwcmMqtbvs1GsJUFSqyHSnnn
         ksPOKjlFzdrWK39wr1KpBK27SlTBzwHt4Z911pQknc80vN5msdWmyMVSK+ybT0p7SGhc
         yMB/qLLE0VGlQyXErUfzqmaU3Km4HfoTxeoynXS2wGjQNxFxfhnxEQIhoK6KaWibjIQV
         Eax14oJzroAhDVTa5mvbc5eE47Pd6MAyidzjGOmXJNhmWjSlP7eRGHjpsUuMPN3ivaaE
         mcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200140; x=1770804940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=McnoIwHymvcTqEFWu2XGqZPzlmsKHzZzIUqEBe0TJKw=;
        b=Aq1g2dKcAfI7mouEH5Q9+97ijmo3aj8aGp2oskT3w28f1mROpWaeTDu7Co2KHAmyfc
         mPrMctj7Jg5b8Ee0UEksjR6MGZ/ClCcyLQ7BzPOZxPuKmpWsNryiiSwQjxYDPvOsUAzp
         sT3BIihi4W1SwsYzfOAL4mX9uk822Z4Oan+mVaP9LR3Kbv8NRA0JrOLzXzoYi7q8ymr+
         tpswcaJTij9WuB/csxhd7xssXfeCx8BwW6odnstorjOpVeXWPKWV56f8wRMBx5Ef1cDN
         /BlSc8R98duHdvd2qROXK2VsL5F/M30BceVI4ntP3Q/BGgf3VLp9u/b3TYZAmAMzAP9x
         Gyow==
X-Gm-Message-State: AOJu0YzHhlFq8V1vqys9rgNcK14vnXZwiPuSMTppj5GCBXNghTSouIVU
	qxYUTdYbFmxrrdKXQqykYmxndMVbkwqW/mkMjqAdZZXgAG6/3g0ZpOBJ
X-Gm-Gg: AZuq6aJ1khZWL28m9PNfOy1Jpa1XUgxyJdqpFPi7WiLbvvU3s//WPQRv3sUhkoPDLf6
	Xg2KdFA6hwpA4oXdb4Q0s1l7c/ibfwTPei2+J2S3GnJVCnglMlv/h3GunTeayXz0ZNGQnJk6p+d
	i6dJceAjSw1D75hUuhuWyp1x/+KYo08esx6jCWbNDgZsQSVdSbyOXFSc5int/Ea3KLEcHHFQaYU
	vOmiSr3tWBEvhN/Z/pIxla8NKAhGHaw0P94dU1hDr+jUJK/i45ttLqpkPrL7nfUwR+sl00iqGNI
	OdQYTeows2mKuATKfpPVNyx2GbkZF1MpUPVWtafBBhtd0SE+JyhC3BK7Buyf1Ls5LH1OIXp3fit
	IftXD1cd/JrEfjyXBjict6NEL3GT7xGdZDP9SmG/pFrEOW/v3Qs+VQjjnrRk2HnE7Sqv4amAwJs
	blbavMechDuwxKuRrKuMi28CrMVEbbqUd3q0vEh4tVXJhvRICbyzMtRQ1t0PkKfjGMZsGeo2dmn
	tCIPgxZQkd/Anmzzf48IdE4oANL7MUQLve2OoAmRUSzmeFhxvTR03XKHBKNqw==
X-Received: by 2002:a17:907:9409:b0:b8e:8874:8384 with SMTP id a640c23a62f3a-b8e9ef30487mr155370566b.4.1770200139491;
        Wed, 04 Feb 2026 02:15:39 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (181.183.90.34.bc.googleusercontent.com. [34.90.183.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0e17sm106440366b.33.2026.02.04.02.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:15:39 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 4/4] staging: sm750fb: remove debug prints and convert logging in sm750_hw.c
Date: Wed,  4 Feb 2026 10:15:36 +0000
Message-ID: <20260204101536.3311-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204101536.3311-1-iprintercanon@gmail.com>
References: <20260204101536.3311-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove diagnostic pr_info prints that dump physical and virtual
memory addresses. Convert remaining pr_err calls to dev_err in
hw_sm750_map() where struct pci_dev *pdev is available.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ce46f240c..420ebe057 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -34,8 +34,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->vidreg_start = pci_resource_start(pdev, 1);
 	sm750_dev->vidreg_size = SZ_2M;
 
-	pr_info("mmio phyAddr = %lx\n", sm750_dev->vidreg_start);
-
 	/*
 	 * reserve the vidreg space of smi adaptor
 	 * if you do this, you need to add release region code
@@ -44,7 +42,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 */
 	ret = pci_request_region(pdev, 1, "sm750fb");
 	if (ret) {
-		pr_err("Can not request PCI regions.\n");
+		dev_err(&pdev->dev, "Can not request PCI regions.\n");
 		goto exit;
 	}
 
@@ -52,12 +50,10 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->pvReg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
-		pr_err("mmio failed\n");
+		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
-
 	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dp_port_base = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
 
@@ -72,19 +68,16 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 * @ddk750_get_vm_size function can be safe.
 	 */
 	sm750_dev->vidmem_size = ddk750_get_vm_size();
-	pr_info("video memory phyAddr = %lx, size = %u bytes\n",
-		sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 
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
 exit:
 	return ret;
 }
@@ -163,11 +156,11 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
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

