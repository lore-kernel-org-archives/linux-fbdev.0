Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCF421227
	for <linux-fbdev@vger.kernel.org>; Wed,  5 Aug 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964018; cv=none; b=LijCjXwhoTCsXhSF9SbdC/s5ybY9CygRZc1BspzhdMb+hljzP/nChis2o1cy+ScFyyhNrpa6CEKYZ0xzNKl2ZCSlwfySyHTwsdG5zDAfFCX6N1ViGE6Gyr5l6S8DVChoyKR1ygqBcjX0x5nS6kY06evW0c9n2/KznUcZrMf2mMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964018; c=relaxed/simple;
	bh=hgrmNSr09hPR5IceCMKheeeiPSobGRzBWznmsq+0gvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z79+I/Jid9bjaY3HG8d+Dg1oJXErwGuQECTqGpLEg6p8dJBM2tJexQM1x+k66biGp488iE1C0Ne/JUm06wOjvPMLoftsEVSZq1PXmhNHV49ulQVyhhrA6EWHV5VavbwbytMvz2BehVkTq9Khr62R3VGPKbjtiSh4a3matTPT33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwANh4vf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwANh4vf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353701F00A3A;
	Wed,  5 Aug 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964017;
	bh=yV71WKEt/WAbV1xBlNtRxMHsWGPwbojddA+EY1CASxY=;
	h=From:To:Cc:Subject:Date;
	b=nwANh4vfV4fU6w4XrgSRt0FnRZpxHBUWwuhVflmL5efi6VNuouyjl6WzG2pgk0u+/
	 y0no+UeqBWXqBtkigByV24OMWDbOmHE5Yd+eeiFmReoq+vyTzPzvHo71b3TUKaavQw
	 64xHMnVWJ/Grc/w71Coggvqim6YeAjSMeuDePbqVnnkg2JR8QD8vB0cMVOlhSfEyIu
	 7Kqvs+hWhcMcy6KKkUrHVl3aZB+5L/wbksJoamHtg0bNmZhF5Grg+3Cql7W+afwkH6
	 ooUQBA3PJYRSFY5lXaRpfr7QrE0OrIVwZZKVPNrm9w3mu9CadPxqXBBaHmgzvsqgoD
	 VAhjeW+6x9a1A==
From: Helge Deller <deller@kernel.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: deller@gmx.de
Subject: [PATCH] sticon/parisc: Detect default STI graphics card for console output
Date: Wed,  5 Aug 2026 23:06:41 +0200
Message-ID: <20260805210641.21740-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

If a machine has multiple graphic cards, detect that graphic card
which is used to display firmware messages and use that one as default
graphic card for sticon and fbcon.

On parisc machines the default graphic card used for BCH (boot console
handler, aka BIOS menu) is stored in the stable storage (equivalent to
CMOS storage on x86) or in the console path in page zero. Extract that
path and store it as default STI path for later comparism.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/sticore.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 0d37e4b10447..4eac672a4713 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -1148,6 +1148,25 @@ static void sti_init_roms(void)
 	pr_info("STI GSC/PCI core graphics driver "
 			STI_DRIVERVERSION "\n");
 
+	/*
+	 * Find default console by hardware path which is either stored in
+	 * console entry in stable storage or alternatively from console path
+	 * in PAGE0 used by BCH and PDC.
+	 */
+	if (!default_sti_path[0]) {
+		struct pdc_module_path conspath;
+		struct device *dev = NULL;
+
+		if (pdc_stable_read(0x60, &conspath, sizeof(conspath)) == PDC_OK)
+			dev = hwpath_to_device(&conspath.path);
+		if (!dev)
+			dev = hwpath_to_device(&PAGE0->mem_cons.dp.path);
+		if (dev)
+			print_pa_hwpath(to_parisc_device(dev),
+					default_sti_path);
+		pr_debug("default graphic card: %s\n", default_sti_path);
+	}
+
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
 	WARN_ON(pci_register_driver(&pci_sti_driver));
-- 
2.54.0

