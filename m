Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB93EDAAC
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206767; cv=none; b=Fb+C0eN0U7rczRUiR++ikh1JtvfYuyKtkCuQxpXMGyfjiApKKKhpDkelC4otFRIjFGmQy3Pi80CvbZyMmMk++o0kuzMRduuESMdAv4N2NSzagu3DYDv488nNA0xsuZ97UE/YLFM0KraRybpo/fzr+M2OtHSrp0kOtdk0s7WblJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206767; c=relaxed/simple;
	bh=95pyT4Vh6HHV9tUtZR1CnydBNoHE4wMU+h5fgWmoMQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg+jdQr9e7XG/kJ5c5xwMvUyOUImAJluuKdZI7KU8xIrg+elAwZ8Oa8gSR7V/HJIwpqQkp1rysgQ/H+PzwNVD+TB3OMRYSPdgYJY2rReJNTGyckmXI60QLCdvLA5TWULHtHuWElzbYAxJ0GHDIlmsgY+rkxBHwiF1T4OVabmkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0S6GlYO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0S6GlYO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8710c9cddbso846673966b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 04:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770206765; x=1770811565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH8ain0P1CfpzApMGJqEysO9x8q6tU0rG1fyS+FPLF0=;
        b=W0S6GlYOcXO8A32lWfyjZ3lTW6HZObkUiArdlUwFfn4UetHh9d98jqNM/DuiD0LYxA
         PD05TV7BWDOM5GfJAQLhCxmwWfKyDL8M0n5L6fSrnRIrixADknijh8tcBdMppRbf840U
         95E1gPTb/M08dQQWAvX19uu5K+buEsISiuLShsLtJYh69MSvvQeQ25Y6iLL3ZkoXI6s2
         l0Om59vIBeiqsQiMQqE7IRbf8IIhW8T1jO3k9jjBjTbfIOS/HQHSZX/gIuQcu9nHYObT
         xKL6OShPwf/Gx29hsIq3W6kuqaLoQ9Ec+k3avHDPFhrTzjG9K/Od/09lcyU9iPE/IKnt
         4Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770206765; x=1770811565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WH8ain0P1CfpzApMGJqEysO9x8q6tU0rG1fyS+FPLF0=;
        b=legoHQ/OHUJqSfdsUcvGzEDjM1ORuzA8MUliyImv62RuYyM7jRTe5FiGC8Xb4tgpsv
         N+2cWh8D42OD4XlGk4XiaC8Da0paJOHo/z2Yd9xy8mu6AHmNc49ETAEPEpDzs8A0m8Xi
         WNJlFz5JwCuE/JuwuPzAXteLkOZB9onm+ow+gvouWpaOPg4VkQ1l67NSeFSZcXSANOOd
         lBUjD0tc5kPwZ3mVsUe9tlO5ISvu0sCofgys5voQOlDerSBenlFcMth8IVTgYTXa2MkE
         qTuEM8tnp84en/1Ch5tQ+7lrmSdXKmX+3g4z/NIRjE7Rg1bXyFqEr9+onRlpHR8+HHEm
         23Cg==
X-Gm-Message-State: AOJu0Yzrypk2rTsXlJOpGmXGQl19S4VkxseDF8VqVr0wSw4fWAgTfSv9
	CDRIz5akPrDr6OjI4NGPf5xnurFDY2GIxKj+UPm2X6hHYMo9G4l682Yg
X-Gm-Gg: AZuq6aKJgGTrrE+nJn49Hvt/mDeBBudm6wFgXEsUH7X6Yo/GtcvRPQtvCk9X0VYv1TM
	Cplp45GbCcriYqLKaKB/rfvEx+GDcEGaqtTutUqB34fNM3ppn/pV4DnMfVcrMH+6WWsWC55wpem
	2A+xdDf9q89J/vCfcH9MIsyeDYtZsZM7e5srl6n8+eF8CU6Ep44eR/hwqadao+QZ7iHnjNKK8G+
	CEmbTKJE35jM0JtFboL840/dc+8md0PiqgibjumqgCrUNSVqPRuyrHm9Xd8KgnlxExZMJUkATws
	b8uYUXWDWy6LRqkbLoC2kxaBqsBAPpw5upzDiNXa7GUFiv3ceb9DMK+XktmLbCLX2vXi+Qyq5Of
	krKkSLKTWGdxUfzA5CXiMuEyiMn6FCG4JhUHHYGBibmGtAd7WVSFKCM1VbOgLuKGraxOx+DjrvL
	pUUQPP/L98K6W7yEj37HZonD48TbjtchQrdTuEA2cL6oi8oX4pdMljCGLzetyNyma0M7Phx8sG6
	iUlFnlAENNqRg+zBfcDMuzqyHFev+2gEbt09KQgCVq2sAskoFd6dEDDv/A=
X-Received: by 2002:a17:906:eec8:b0:b88:775c:bd68 with SMTP id a640c23a62f3a-b8e9f10a2a6mr198934066b.28.1770206765140;
        Wed, 04 Feb 2026 04:06:05 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.79.91.34.bc.googleusercontent.com. [34.91.79.216])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fcd8be3sm117979666b.10.2026.02.04.04.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:06:04 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v3 5/5] staging: sm750fb: convert logging to device-based in sm750_hw.c
Date: Wed,  4 Feb 2026 12:06:02 +0000
Message-ID: <20260204120602.6715-5-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204120602.6715-1-iprintercanon@gmail.com>
References: <20260204120602.6715-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert pr_err calls to dev_err using &pdev->dev in hw_sm750_map()
where struct pci_dev *pdev is available as a function parameter.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index e3e4b75d6..bf4c1585c 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -42,7 +42,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	 */
 	ret = pci_request_region(pdev, 1, "sm750fb");
 	if (ret) {
-		pr_err("Can not request PCI regions.\n");
+		dev_err(&pdev->dev, "Can not request PCI regions.\n");
 		goto exit;
 	}
 
@@ -50,7 +50,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	sm750_dev->pvReg =
 		ioremap(sm750_dev->vidreg_start, sm750_dev->vidreg_size);
 	if (!sm750_dev->pvReg) {
-		pr_err("mmio failed\n");
+		dev_err(&pdev->dev, "mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
@@ -75,7 +75,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		ioremap_wc(sm750_dev->vidmem_start, sm750_dev->vidmem_size);
 	if (!sm750_dev->pvMem) {
 		iounmap(sm750_dev->pvReg);
-		pr_err("Map video memory failed\n");
+		dev_err(&pdev->dev, "Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
 	}
-- 
2.43.0

