Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C6AD51
	for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765621214; cv=none; b=Ai7dzyecuV+bxaFyGBQVvq6BSamfK4RRxEKaGsoJJN/pHQ63GOL+eh1yBxfGMKcMk6qLd/pgxP0MsO+v7pK6iDuFkBXKOQypTF7UTfBfWElWATFj5VcEzcXrjOir8IT1UXFGi/RACtiSp3uQK8vMfEYk3hYg0+lO+wDdE92E59Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765621214; c=relaxed/simple;
	bh=110V8MRAVFzY+ljgGcNiKmMR2g1liAw+OHK43WqkrP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J70iNk8+YwmTcKWLlO1GcqqXDLdZYPGp/rxMQbhM5PpA8GtySFoLz5TvM9VH1blb8nNq4rh5Kmwv4i4GAOQALfhmiRgeUAzgxPQH1OSetVMjUgvEXdijR5k4Oud8RP1R+oWuECGjdhrcNy1zLMk5EK1lVI1E0usb9cVsngvFOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCiVOzBr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCiVOzBr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4ac44fbso10007855ad.0
        for <linux-fbdev@vger.kernel.org>; Sat, 13 Dec 2025 02:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765621212; x=1766226012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDk2RYtju5qtTpUCS+SSH/qPrCY50aSULuux/1/O0pk=;
        b=XCiVOzBrpwKEwyd4tkTCpcq2Wvp5mKjeUY0Z8DmQmh+IkDizhzfTtrIFr3leZ2+meY
         mfZT4EsfZSaNbXy2L1RNPSNZCCWQym/K9h6vQw3DgaZe1RYF7BqYMUwDlxkq0/xFP5yY
         8xSU+Q5JfYKfL9yb0fXEZ3ocBEINDxfwZFFHR0l925er5ZOsNbSY0iPMdGhDWZdaLqEC
         OKnV+H8HrKXm8151GsTd+FpQ82t9lT4IhSYqM5tSCf2aefnuz9ySIeeSdWfg/MtQsEJe
         pM9b6KrUk3cNd+nTBGroaLFOa3NfGqGm+OT2lHM9qR+sWNjQYkBi4iDq/BkbvsfXixFz
         obfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765621212; x=1766226012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDk2RYtju5qtTpUCS+SSH/qPrCY50aSULuux/1/O0pk=;
        b=gf55OrkKIDs6esSi9mX7PwdyuurshOhI4VEcJyUuLAjLRT1WLLG6sZnyxXi5UCKiqR
         vDj6bIhXKvtQM1VeT850oM746jhI38/dfrNKrStWAIbYjhbVQXSTrHZTDMqBqhlxD3Pl
         NH/p3cEBtK/IwJri613v8J4xxjZJyyLIjMraDuGoDgkddBfAjRfj56HLUDcWejAd1eX7
         rL+QnAUgbZhya6VkpIaAkpfWA35LrJC9fSym5OfGMCfxqw85N628D4XqkxYUcvpyUQsh
         h4SkKg/cIB/g2WYC4WFTrKZAJ81yUWIjBVXP0JNBu7etslUxXvmrw/C7di10PGNz+lI2
         qwwg==
X-Forwarded-Encrypted: i=1; AJvYcCUz8uS96H9vI6XLcEPO9CRAXYKBzfXF5QFGhzjq+4sbq4LYGevKoLUBWIcjRCuy4v69hk0QdjKm/8X9uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1aKQp4Im0+ycYxyTy/N+5UGjq7g+KZqUTQB/jRILECAqm84u
	LU2wzjE3vK4+/HXPFykYpODnMFw46JexV8TnKkdOrco1+nKDhwrypwGR
X-Gm-Gg: AY/fxX7ocST1A583A3JJhgbT9BfgbZAnncqI7V4hgx6qnO9F28DuA195GY6PUC5KVpd
	oxCfaNYQBDR/u13rcWMjuiFN6GdlntrcF22WiiYUNmludKFkaEutEz5WVlgyn+LKKwCiobYbS8T
	PtqRc0TutuN1YcWLlx6EQtrNYOgevYU6+qGDx+UqEBpQk+tGNDnpgLzmf1h5Ux0MGNp3kZwPVs1
	KnhmC75ABNS5rC7gYuvlMrn3dKmPOlVxYfkxCNnW6IUCrDdfOPF7UziY6e1+NZmeRth2lxp7gBN
	3cqWZpNdcM/du66lU+4CyDHkr5AdvERqqoWb1AqHIo18xVAp77HTZzap5g7hs+pvi//GC658LGI
	5tNrbatwgWvvTOYBF2RwBfGVO4Drp03CWpE7HfTFF4jKTQD2Hy7eMps2ZpxYsccSk1K+CNtVnq0
	YwdDfA0rD3WrycDFu8Fsw=
X-Google-Smtp-Source: AGHT+IFu9zPL+mIphNboykWtLWGEbFoexbc06Rx6KFOEt6W1rTUNLE0jEqrLOWhn7Hq+MEnNrC1oTg==
X-Received: by 2002:a17:902:db11:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-29f24e6fd04mr52687645ad.14.1765621212431;
        Sat, 13 Dec 2025 02:20:12 -0800 (PST)
Received: from LilGuy ([2409:40c2:105b:dc88:1107:395c:23c0:2b1b])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29eea016c6esm79041905ad.59.2025.12.13.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 02:20:11 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Frank Li <Frank.Li@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kees Cook <kees@kernel.org>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: [PATCH] fbdev: arkfb: Request legacy VGA I/O region
Date: Sat, 13 Dec 2025 15:49:32 +0000
Message-ID: <20251213154937.104301-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arkfb driver uses the legacy VGA I/O range (0x3c0+) but does not
request it. This can cause conflicts with other drivers that try to
reserve these ports.

Fix this by using devm_request_region() during the probe function.
This ensures the region is properly reserved and automatically released
on driver detach.

Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
Compile-tested only on x86_64.

 drivers/video/fbdev/arkfb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index ec084323115f..24e4c20d1a32 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -1018,6 +1018,12 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)

 	pcibios_bus_to_resource(dev->bus, &vga_res, &bus_reg);

+	if (!devm_request_region(&dev->dev, vga_res.start, 64 * 1024, "arkfb-vga")) {
+		dev_err(info->device, "cannot reserve legacy VGA ports\n");
+		rc = -EBUSY;
+		goto err_find_mode;
+	}
+
 	par->state.vgabase = (void __iomem *) (unsigned long) vga_res.start;

 	/* FIXME get memsize */

base-commit: a859eca0e4cc96f63ff125dbe5388d961558b0e9
--
2.52.0

