Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D1401A18
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500369; cv=none; b=h7YPeqgIFMuinOR4fw54ZUDQvEuDdrVeqy2EsV4q9KLX5malVkrGw21sky6QMe+f7HIJwxDl1m8okpRW8oixTKF5FIqxANFxIieNt49OKKNresFWmsEIf3/26sSeURS7eyWpCb+FMEss+rszTrPQ84KFGAnnF88IsKgaYQItQxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500369; c=relaxed/simple;
	bh=S5Pj/mZuEKVhW+Yo2GzUHV6Shsf5sPXE3yXbPmQc2X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coT6ecVMmsVOr/MQ0z2zofO2KjPW5vhGNnZ1/dB8HAZTGspb42MfVd4rNUwlTbsut+SCsrvVBcppPiN9Vdk0XUDXDifLAWr+QU+Bq22wv72WiK35nThPv+gC/RdHElO5Z7IyjxpMRgqHp+wsJpBQe8aLHLFyLY/W1pBwdQRgmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Nf5rSxhS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Nf5rSxhS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso952865a91.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785500368; x=1786105168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QGIvsiAITywJ0rNp56g69w0ITDJR/V//o9H2LeZBivE=;
        b=Nf5rSxhSYuZ/gvX3cgBF5Mi8wcZrNwRdfLaO59GU3Ta0KwdkaSW7VxfRRv7vap3/YV
         hb2EJUih5CsdnTawvHdPIGYNXZBo1E8bn0tjm6UlJmlliVzZ/ozbBR5PWHGEu7qN9GCp
         hLx1P4bvWH5oXMMorW8zH5WziAifi6vf73laU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500368; x=1786105168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGIvsiAITywJ0rNp56g69w0ITDJR/V//o9H2LeZBivE=;
        b=EOow9wnras+CdUbT0hOzm35SF9e+ZSqWiysPnzvxDp/qCa+kQ04Vn1dW2DHWVvWL61
         UXs4zE1ADOmxxCdd9/AzhissGGmQWXgnamFsHcikaQ3oPMGoQN1za2bvIDcT1nXTeLep
         +HF5IAraTJuG4/TrU8lwrBnjQ0a/76FmNZumMbqBry/PMhRn+wiCs7q5KDhh9xL7sBhv
         V+2E2iCRm/JCcZyDt072u5BaSo1tOmdasFp/JAJ9/9Xcje9LR5HA9QRCjn57A7PfVMDD
         3i05YvJjJ4tldOCvd5sDsXSmeBmUewRDPn9mkU7WT//kavQzTZAZbJirghcXteVN1yup
         Cv8Q==
X-Gm-Message-State: AOJu0YzI83veAD6LjFaUPU+djooQovduI6hpaJd5iRd2f6gS1ctXp4j2
	TPkY8Zp2Y3vO06upFv0/7wXAzxdttwFsfdS9a3w9hT4hD98qjSOiq7t94sdrBjEFkVA=
X-Gm-Gg: AR+sD12+kn8RWw9S4JuxdZtDEh+t6VGUNy9mpmNQYqTw4BNyw/eDvEfypfC1O0m+/oc
	/4XGD4j/mljwMym7vvDVSYk6J1WJoIwV3vMURobQWBJ4bWHzJiFbblXHwXqkQqbcW4kkGpXMgnn
	9b2FqUGNC0NBcIWnCS/yRQBeoVFXIKSox5o5kFAsJvWtr+/orwugNKb5aUCbg4HuuhrFmpTeL4e
	uooCeJamGbGIA/yjtAqcUSylgeaI708CB4cnYOIm0cFXjxsmSefZSPSnddeBJ/NxoimhyDFWOLq
	DNzGdlrEWjv1916r8gRe7V4Mo6VM8Od8hGRVGAxcYIteFDnvTVx1+ZmwLQGoLNTFMDutEfwPu/T
	pboJoVOBTlEf/n4bXKkfod9icab413F+tU8sXDz6l3bTi9nRdNhqTFNWuTpRanQosbed8xyNQN1
	Vh0gaUfOqOTNfqEBs7vXHemguZWUwPd/ZIc/4ygsHYz5nOk/w+AhA=
X-Received: by 2002:a17:90b:1b03:b0:387:e0db:3faa with SMTP id 98e67ed59e1d1-38fb13e34bdmr1636318a91.35.1785500367635;
        Fri, 31 Jul 2026 05:19:27 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:19:26 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 2/5] fbdev: tdfxfb: Attempt to detect if the card wasn't booted
Date: Fri, 31 Jul 2026 21:19:11 +0900
Message-ID: <20260731121915.3362232-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731121915.3362232-1-daniel@0x0f.com>
References: <20260731121915.3362232-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now a card had to have been booted by its video BIOS
otherwise the driver would probe, create the fb etc but there
would be no output on the display.

There doesn't seem to be a documented way work out if the BIOS
ran or not. Checking if the values in registers match what is
in the config table in the BIOS seems to be the only option.

On my 16MB Voodoo 3 3000 checking the contents of the draminit0
register versus what is in the config table seems to be enough.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index e92658274411..465c46edf6e7 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -414,6 +414,34 @@ static bool tdfxfb_get_bios_cfg(struct pci_dev *pdev,
 	return false;
 }
 
+/*
+ * Try to work out if the card was booted or not, just checks if
+ * one of the dram config registers matches what is in the config
+ * table if there is one.
+ */
+static int tdfxfb_hw_init(struct fb_info *info, struct pci_dev *pdev)
+{
+	struct tdfx_par *par = info->par;
+	struct tdfx_bios_cfg cfg;
+	bool have_cfg = tdfxfb_get_bios_cfg(pdev, &cfg);
+
+	/*
+	 * Can't tell if the card is booted or not,
+	 * also cannot boot it. Card might not function.
+	 */
+	if (!have_cfg)
+		return 0;
+
+	/* Card is, probably, already configured. */
+	if (tdfx_inl(par, DRAMINIT0) == le32_to_cpu(cfg.draminit0))
+		return 0;
+
+	dev_err(&pdev->dev,
+		"Card hasn't booted and is unusable\n");
+
+	return -ENODEV;
+}
+
 static void do_write_regs(struct fb_info *info, struct banshee_reg *reg)
 {
 	struct tdfx_par *par = info->par;
@@ -1509,6 +1537,9 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_regbase;
 	}
 
+	if (tdfxfb_hw_init(info, pdev))
+		goto out_err_regbase;
+
 	info->fix.smem_start = pci_resource_start(pdev, 1);
 	info->fix.smem_len = do_lfb_size(default_par, pdev->device);
 	if (!info->fix.smem_len) {
-- 
2.53.0

