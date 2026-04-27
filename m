Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934340DFDC
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268877; cv=none; b=SWFI4Vgp1n5Pmeri6f/723Jp4ELLkm0WBa2MfGNJpXfa68vJAkmBVAVC/5yClUhtZcg1vaty70PMUhbSDNojm0GyDwHj6Q3TBGejZrrqdYAaTOY5bQ+nMaE34dWp4yQcXGqGjZx0pQyexUB87KrXPAErEdYFKOp87HmgH0X/MtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268877; c=relaxed/simple;
	bh=ZNA+Z7uM0T4aC/rYpgG/WXQtXAqoG73zTJrV8YaYuyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YmGJNRoLyuY0Nwpnh3ijkhS6IaSka2Fy35TADS74R/hLE+HcpCVwgXWQsqJobNAtElQU2TrCRzUEcOMe4ETWunrBWt/wlcpxeou1gEIqf/KjXRlENmMax9+wtqvd/VGU+9dNOH7T2fzkeBNYm8eYtS1wPN8sllAKsFlx973W3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDJ2qc9E; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDJ2qc9E"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-12c45281a06so12722673c88.1
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Apr 2026 22:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777268875; x=1777873675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XooreDzs+cvNPadpU61rCgaOMb1b4M2JvjEhVgabVB0=;
        b=UDJ2qc9Er563MLooHzW9ydRExTpEImY7hceiFUwRwSHyKEuS/0401R7rMB2J0yfeWB
         6jXsyg2bKrQ4euJvwkG1PnfREAecCK2pyQfvshdLqherDvP+jRIP4MCbf1TSKo+MmJ4T
         RUN5ice1ReqDmk3BjHT5y0OPqg8mP64Xdo3rp0gKKmTul2X/+6FYTPiJOJBls8N3PJkJ
         L5pcFhqPW1715hpyY+gNhY9xAtEwUqX6BNm1o505KjXhkyCXZ0aXX8R7bLd7PH6qqzgS
         eiLV9BXydLgVO8/U/kttDBfjgZYzSSeLJZc9nvBYNURLVo3RZJSnauKUatII9pcCFXfP
         fXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777268875; x=1777873675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XooreDzs+cvNPadpU61rCgaOMb1b4M2JvjEhVgabVB0=;
        b=jPu2hxITl9cs39McuDQr9lz5ZjWfI/dx+4I9AwGOZfWNLGGIWy5K7CdUZ2EzEwcLym
         kjvXFL5XeOiwk5M3XuqN/Q/MDQUcaMfFCWAFvXO3PMZUmIrarU65ESGJoyNdexmw7cOp
         BukgBJWMHHmrN7B4WpLVl3hGsBaOodcO8DqN5yovn6+ZmdWMvu6HdJQ/bSg5/cyHa2JH
         xjjjiQxINnuSe8FFE2UNnh7I64eyi/GeX1d6gCUJDXzLv5o3VaX3HiTg7ZQvxuHHMsYW
         7K5wAtWGJ14/ZBOgv47tcHCru2yeOsyJlgz1PO/khXAmb+A5NdW5waJcGi77O7d78RH8
         Mglg==
X-Gm-Message-State: AOJu0Yy4vJSCIpT5qrC6CC6lu4e09dY6JvSHNslgchc48dKU6gn3HTIs
	8bWHKuiCVQbo7tEiBVtqnbCWdWzIWga2LF41ld4FxfHu7WTgTZ1oy5dN
X-Gm-Gg: AeBDies3mzrwRYaQ/1BArhC+vl8q0na+nio5dUHa5JRftygaGvHhyc5K/vJnDy/KkNE
	FGskl9bvYjD7fnTrageR4r/wBM36rrZz0Lw8mBaqlVS2N9CO80vfB3bC3RW8Hlw+CtcE6dE6KL5
	UdaP4niowxMf+Y7oqPHGNlFWO4NvjNmS0o1FYccJUdEmDbTeFeAvGhUmYTDy3TenVErPw8ohmKZ
	GgScYFx6lR03MG6v288GKfVR5v+upyzql3hmk9+TqqIFCGct5vtNXDXty0YATTXmniwJn56BuBL
	o+btFnhzdpZryXdi5GOEMlaKAjhOouDoiYd1cOhCwDxTKaDr+XX4XBE0cOap2puxaWgeudspRFB
	NFFaG00evTSRceYQCBnKOobyKBcA27xHKeC//2YPL/LTVcODMRXteCUdu7AFT00lgf86k8Yu0er
	S3wRuHcydjl21AxBAOI/6e6UJZQOereBjuWHgCa+/2wzX9PXelkZ6YsvKUtUzdJYQLopEe0XE+Z
	bty
X-Received: by 2002:a05:693c:2b15:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2e47a1027d4mr24568461eec.21.1777268874938;
        Sun, 26 Apr 2026 22:47:54 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm42350209eec.21.2026.04.26.22.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:47:54 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 2/2] staging: sm750fb: propagate error codes from de_wait()
Date: Mon, 27 Apr 2026 05:46:57 +0000
Message-Id: <20260427054657.758-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427054657.758-1-dennylin0707@gmail.com>
References: <20260427054657.758-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm750 acceleration functions currently return -1 when
de_wait() fails, discarding the original error code.

Since de_wait() now returns proper errno values, propagate
the error code instead of returning -1.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e91c..d8e91f7a7778 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -90,14 +90,16 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 color, u32 rop)
 {
 	u32 de_ctrl;
+	int ret;
 
-	if (accel->de_wait() != 0) {
+	ret = accel->de_wait();
+	if (ret) {
 		/*
 		 * int time wait and always busy,seems hardware
 		 * got something error
 		 */
 		pr_debug("De engine always busy\n");
-		return -1;
+		return ret;
 	}
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
@@ -154,6 +156,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int rop2)
 {
 	unsigned int direction, de_ctrl;
+	int ret;
 
 	direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
@@ -263,8 +266,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (source_pitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
@@ -326,14 +330,16 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 	unsigned int de_ctrl = 0;
 	unsigned char remain[4];
 	int i, j;
+	int ret;
 
 	start_bit &= 7; /* Just make sure the start bit is within legal range */
 	bytes_per_scan = (width + start_bit + 7) / 8;
 	words_per_scan = bytes_per_scan & ~3;
 	bytes_remain = bytes_per_scan & 3;
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	/*
 	 * 2D Source Base.
-- 
2.34.1

