Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07B41C79;
	Sun,  6 Oct 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728198959; cv=none; b=e1pSsI0Ft5D6fuLd6ol0GxOlAKrX9iULpD+cVtIoEXTRb707CaA/K54oExrr1OL17SwZz8u3QD8XDbb04+ZWLSyDz5H+fDbei3LL3zLzyD/PkZIPsMcm69nk+GsBwpbVuQUPD3tcMgS2stpOL4WENsezDGr2pS7H8/Wbpr122Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728198959; c=relaxed/simple;
	bh=GNKMruB10LYBdDUAQMPVmLyssNcYBL25YfXgpnNVVQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljwPh32rw/BBJijCTJfRYaawLIi5iVa60Fyj2FSAt1EiHW6SEUqRTGPKtI1mNF2I/KQPEanU3zfM3vXgNLf0uSfr1oGOP34x1evE3MfDo0QbITN8yM9iIvwaZGVh4TFsImOgykDVlGieuDovu6kZ3oTe/SQ15/MYEYXQJlNZwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kva4xTFU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kva4xTFU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2913329a91.0;
        Sun, 06 Oct 2024 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728198957; x=1728803757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EY5p4xlsAqQOcxvqm9u7nE7mDZrPMRJXe9re+U3pcIg=;
        b=Kva4xTFUTEfeGyKgvDq81Ob5HgyGMAvv6HG1eu6ZThDDu4PMbiXTM5wrt+NqlDAHCP
         +wOicWiMTYPUExA+4LolFxGQOp88XpU2LzH4kpa5Y+RoYRbY2kG3+ryEMbEjMhrZmPNK
         M95+MHIOLfusQ/yhg2+9P5Y3BARKBWWww7+n6gj/JX2ZiL4vWxFsHcRxBN3NuSDKVhnH
         GaH2ml34G/0DvmbXhyolLfMhcJw9DErv2dggi4WWr20l+6nLsnLGFWaEkm3804XwTY50
         RC3bthBqx44Q+KSpld2BclnACjZugCxCxgtZCWxc4kQFpWZPTow3QOrnv0GKIBCd72iu
         A6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728198957; x=1728803757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY5p4xlsAqQOcxvqm9u7nE7mDZrPMRJXe9re+U3pcIg=;
        b=Ak3Qs7A+DVBrxCgFfczXqjmpgRRIWJJbrdt6BkihYi3ty+Ko1ozFhxEvffG+Z5lUFE
         YPvAsOfmMbD+UEjRSD2pYDBc4O8hzxMSoaLUYJQrjEccezLAfdFn/AtbvIvSEA+yapHe
         RfPNbZgsmnKkaoyO2yAEi6xO4vmJFz/0SeQBWE1eV0cpAWU++xCc2SPedLt+uyqYXm+r
         /3va2pc0HbquM9yee043h2mCnOb1/DqSwmppD13/hlR06SVMBdlT2noGsANxHrO7kFJL
         WCJ6md9nPL1kcsSUTChKidhFKc5Zn6SYcrWqHQv+4N4WUqxPrW09wGwB9my3G9qhwVUE
         MUZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuS+76Mxa/pSALU+kcdRRg9Iwcbq8DZ9TwPBc+9aYLduuOpmmyReR88iSqDJC1f6KnrQ8EqlIGJ+dTLOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaX7zgNkzFpftoXQlaCk7e4HH9pZw9z4SFX3CMxQXhoOQUaWIM
	GfEnhuSHf3Y+N7ztFJPibqKihbMPf5cPPX5vRmkoF7QgoX6pAZpt
X-Google-Smtp-Source: AGHT+IHfxiCQnGgXw6gWSyy7mb50GfJveRtEjxaOuoIhvi/t6X26Ke+95wPLjiBS3eg+nZBeW/KzDA==
X-Received: by 2002:a17:90b:b0c:b0:2e0:99bc:6907 with SMTP id 98e67ed59e1d1-2e1e6229e93mr9356389a91.15.1728198956928;
        Sun, 06 Oct 2024 00:15:56 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:230:2966:8a2:4c2e:bb52:a9af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20aeb7db0sm2943600a91.15.2024.10.06.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 00:15:55 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: adaplas@gmail.com,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] video: fix inconsistent indentation warning
Date: Sun,  6 Oct 2024 12:45:14 +0530
Message-Id: <20241006071514.5577-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the indentation to ensure consistent code style and improve
readability, and to fix this warning:
drivers/video/fbdev/nvidia/nv_hw.c:1512 NVLoadStateExt() warn:
inconsistent indenting

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 drivers/video/fbdev/nvidia/nv_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_hw.c b/drivers/video/fbdev/nvidia/nv_hw.c
index 9b0a324bb..75afaa07e 100644
--- a/drivers/video/fbdev/nvidia/nv_hw.c
+++ b/drivers/video/fbdev/nvidia/nv_hw.c
@@ -1509,10 +1509,10 @@ void NVLoadStateExt(struct nvidia_par *par, RIVA_HW_STATE * state)
 	NV_WR32(par->PFIFO, 0x0495 * 4, 0x00000001);
 	NV_WR32(par->PFIFO, 0x0140 * 4, 0x00000001);
 
-    if (!state) {
-	    par->CurrentState = NULL;
-	    return;
-    }
+	if (!state) {
+		par->CurrentState = NULL;
+		return;
+	}
 
 	if (par->Architecture >= NV_ARCH_10) {
 		if (par->twoHeads) {
-- 
2.34.1

