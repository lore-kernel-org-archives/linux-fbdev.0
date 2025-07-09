Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F719280CEA;
	Wed,  9 Jul 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054853; cv=none; b=tx5AJwCxf8cdyP2hNvEKngzpWBuTLXsxCSLwdw0wL/mejGZBXVb/Bl4h5nVIzMWY3uC0iEoSNp3PQKjVhleRmz42mqRaPTWbTN1hr7nRQYEKRxl9FTDZ3jI4mgZ11pn8XF56MAku3s21Hi+POdgQu5yrUkL4J3yTSxTbFdOcCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054853; c=relaxed/simple;
	bh=yJI2G9Gl/Xz6Qj9FLk/Wyj2jas0ckXVUHhobMDEdWHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcZO0c4TKG6KHNgB0gOlhU7SGdjSkQVtXE9yR2AN3Sy6LurmbgIJG6r84okh/aUQG202tW8pbPrDEzCDPrXcWAzZzUySwnS5J9oC6cXm1tIeg8UimTUPtBfTJs65sAz4ORKjJQiLlLkj2ytEamitAwrbaWicdfhzK0IULTNQ4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT7tBcgA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT7tBcgA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso10329106a12.0;
        Wed, 09 Jul 2025 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752054850; x=1752659650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHIX4DGVlMOIDoc1JDERhnuKOL/EXoTRnc9bE0E0Up4=;
        b=hT7tBcgAG8t88D8X+SEGgPUY3m8UinTjgWAJYfWO6QYnv2I55n3HpnXKVN6ltkX5lQ
         liIAOhrZZNmCq8eUX18eIvv332mUg4UjmnTCWHQkTzgjtiqzkG/ZL8akxZG2zlQSPX9Z
         AfN0lwQVECRb+KXF91jkqeAngVUc9kRMWBJpeNY0ANsPrmoBmeKZPqzaPCJYBFuylfse
         TWjcOKR0zyBdCdHLjJHfZTUgXdSEpg8vNnn/KQoVZCNlxMT51EFGGUDfoPNDVffSV5b+
         jCFR1X0DP4Zdy5fSzTps4OeudIvzXI4CvwSP6r94jiV0j6FiyLL5C2N9J/znBnyyZXTg
         9gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752054850; x=1752659650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHIX4DGVlMOIDoc1JDERhnuKOL/EXoTRnc9bE0E0Up4=;
        b=g/0Q5IEOQ95mwGcgKoA+S4JyZi7tcjPU3wE6KjY5dGa2z4iiuZR2xEaXjBl8+JXj6H
         LgxAz2XKQFM2HLCFyWdsdOlTrZ/X7FufrT4nSJOwPcDRq/bOUOzSXzL2XoDlRvT38Clb
         /T5Q8ATEE2PV7jA7bDmgaah0rfxHxsmqTNiK2/cceExe01k5ZTmmbqjX5b6f8SxG5T1m
         w0T+2dUu6y8vOjtdHIRss9xsS3dYxQJoHMWsYZf6Ch2+gUmqljg2BI+LV5JZHXm+f+4w
         CN6oXE/n4iSJhyZoIcr0sObVZaKdW4oR7CeV7LQu/9sELLU2/6Iir6F8MhHRq0URy3P0
         4X/A==
X-Forwarded-Encrypted: i=1; AJvYcCXwUbgjEbO1dSArfIw52hjmTkld5yRB96kjWACLUi2TSRutWYkZDWur5EtnwL1CeA4N52POLBcXeD72S7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDDF86bO6qbOgNhl50sS/dXrM1ta2FSNVl4A28jmpJzcWrjxu
	sjtPnz98X1WNuFEd+O+9GkJbmD7xRUAhanzwwhYHA3rsaOTtANbk6vgJ
X-Gm-Gg: ASbGncugQy8FNYU6pN3zuyl2U7fZyT5DMPbl5YLL63AxnUspB9dmjFsm3DifsbxWdIK
	YVwYE0W2PaXvJz3Z/MBkXdx7XhKC/4Oq/lrcE1Du25ORgfVCkUV7nF5WBOGKSb2DUhl2sj5iZxb
	Y3SyaZ2viAhg+TqF24sB7jECx5mbvGE9F6qaii1kLuWlcFsopAbFi5Bj5CH20rHnH/iO1GopJ0l
	SCfmvuQK0bI/UAVVdnM62c17sVcJZ0oPW2oYmUJBConqTBxHmwa0kT6XJiIR+oBZmeHFLvJD7RG
	nmAaAYsSkhpbD1UlKyCLG04URsue5OfYAMaYh13LRStrjuAs2nZS2txByfhzEqMoKfSXnETt5+e
	m6T2sRva7G36SJ7kMb+jAJYYxMBoiC1vXi98qLu6mKXdhbcxdE/Xpngyh2HLfaYY291yN2lTj3O
	x+BA==
X-Google-Smtp-Source: AGHT+IHfPGbgZiNeOlmBwJt5gWKvm49O2S4cDZYFHymXUMsQvbq8cqvnLJyix/nXBpDbUy6wTdP9tw==
X-Received: by 2002:a17:907:c16:b0:ae3:eed1:d018 with SMTP id a640c23a62f3a-ae6cf560eb6mr176692666b.9.1752054850161;
        Wed, 09 Jul 2025 02:54:10 -0700 (PDT)
Received: from kubuntu-e14.homenet.telecomitalia.it (host-87-21-242-88.retail.telecomitalia.it. [87.21.242.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6949cb2sm1074172266b.67.2025.07.09.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:54:09 -0700 (PDT)
From: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
To: tzimmermann@suse.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
Subject: [PATCH v3 1/3] fbdev: kyro: Add missing PCI memory region request
Date: Wed,  9 Jul 2025 11:53:52 +0200
Message-ID: <20250709095354.931589-2-giovanni.disanti.lkl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
References: <20250709095354.931589-1-giovanni.disanti.lkl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kyro framebuffer driver did not request its PCI memory regions,
which could lead to conflicts with other drivers.  This change
addresses the task "Request memory regions in all fbdev drivers"
from the file Documentation/gpu/todo.rst.

This is addressed by using the managed device functions pcim_enable_device()
and pcim_request_all_regions(). This simplifies the code by making error
handling and driver removal cleanup automatic for these resources.

Signed-off-by: Giovanni Di Santi <giovanni.disanti.lkl@gmail.com>
---
 drivers/video/fbdev/kyro/fbdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 08ee8baa79f8..86e5d60ed0ff 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -679,7 +679,8 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	if ((err = pci_enable_device(pdev))) {
+	err = pcim_enable_device(pdev);
+	if (err) {
 		printk(KERN_WARNING "kyrofb: Can't enable pdev: %d\n", err);
 		return err;
 	}
@@ -688,6 +689,10 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!info)
 		return -ENOMEM;
 
+	err = pcim_request_all_regions(pdev, "kyrofb");
+	if (err)
+		goto out_free_fb;
+
 	currentpar = info->par;
 
 	kyro_fix.smem_start = pci_resource_start(pdev, 0);
-- 
2.43.0

