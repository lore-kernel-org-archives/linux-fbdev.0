Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1507D3002B3
	for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784491187; cv=none; b=W/lVj92Gcr3JcTmqKVl7Fm0bpWI2MfICqMbrYbgwc50jX7p1OvfYG2ovWU1WeBpExJ8eDT3Zjgj6m+OWGT8vXZAh+3Ei5ALIz7ysrneGKoKE3e3GpKnp6oXRndcSV+WlQoyiJhOPlNfcEeUk1FLf2tOA3g6iahFLZvsoWMO9l6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784491187; c=relaxed/simple;
	bh=HtlgJEOcV9TvPw40PlMf9ou3r6CO7zfIG3w3eY986jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoXjJ4+7GL8vJwYp3XbQZujLmcwzdOwrtIF5lQBc5UPsFf376ZGNKPHnAItnu4GSZKWMMRZ08prOf8nUp4HDFlQ35UZ/7OfAapzHW+E+e0RLY07baPPVb2zGVRuhcnMydqYFBRThAZR94UooxywtFF8ReBQpNc0lIVhlGb8Yvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJBN9KC6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJBN9KC6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso6450605a12.2
        for <linux-fbdev@vger.kernel.org>; Sun, 19 Jul 2026 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784491185; x=1785095985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXeHE7LmM8N9m7jjvtApZJl6UZon5En6RknZ9/+XFyo=;
        b=dJBN9KC6lmC0KvFQPaM8oN+LsMYR//j8g2ZxGlXy5J1t732tKP8GLeAMYDdymcL4nc
         2T7JUBBLCP6wI7hooCqwcLgSYoAyA7HueAIRFC07+BtAGsWNeP0FXPP505kpy0RuvFTI
         Ut0qO+JUjqxxjG6qY2oT0N3ZWv2r0VAHGP8LVdv63CaiWNtsjbzFmn7FNfANiyyqV8J1
         KMeP9YJxVycOIYFgWdn3Ll9k2SQJbV/5F5VFan7Mt6h8PT8LiHtCxqhBBLx8BIHV52nh
         YFZp8QANDgAbST5kWHJZljMPUUEd42i0ETDsmZXnFDO2eR5xEfv470Iwc4lUGNtt25EP
         vpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784491185; x=1785095985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OXeHE7LmM8N9m7jjvtApZJl6UZon5En6RknZ9/+XFyo=;
        b=lqXJ4qRhDRMbMdCsezBIR2PgjJ02fX5VLGM680YsnEv/PqRfsFrQiMt24NVvofms0h
         Udk2+1FW67+Un1DNABWp8+a686+0Ue1zAn9qPjr3n9Jwh4Eqe4Y7xaRlDES6OB3ed4sH
         1b7CiZI+aXFXb7B6nbfdpoVHIyWQO0g65UvCXqsTgplK+wjBxzRu3cJcYmdDfp3zyilc
         Uwmb/DFFU3sdGEk/SojensZSTEjajPEvp8RvkvQzfXtFTWIPF/vonqeD40iibT+ZHSFs
         9aCN0mQSBTnVg3A563cQQkKO3bcHGCxBW/Yvr+HPrA2olUdVwGRbJywVq6ph6nbYxvpe
         kmAQ==
X-Gm-Message-State: AOJu0YwIOB6ayTq4sRU/S2bII+Z0eyMlj7YWkCGpIqq+TO1QGm8R6xMt
	Xhpr96aXmGgEVlwH/sIsSGxVp+Pk10zj2qr74sIU8E8j7PLvlsJfKzA4
X-Gm-Gg: AfdE7ckl0ar0bW0Q0xeZ+JFVSTtT2yy/bMfWBOJ3ZA7KIVVnFgUKZzv5dkft6zBnD6E
	ieChQknSCFvU5tzX52Xkkb6KxB7eyeI3mZboiYwAQtX4GRQTL5JMCWRC2BxxefANBq0SI4buYP8
	kWR3czL9TEB2Fd6Zch0DIk5Mf30+it0c9E7kqSz53qc30HJtjY51TzVfGWYBDPbkB3ldinej3EP
	mtHoMU9xKKCjIyT7ZhhvE37YD+LSKA450gShEswnxHLL4qv5DcDWt7pV48Zw03RPQQbhP6nQ+Mi
	iu517by0nbVjym+P29yDUsOxCZHFrOQttVxW1yvEL/nv0+qSKl5D9MpJBmpybPiSrkv3NxqnUjv
	lI7BX8bs3hLKLD5ZPW/Zzg+lcqI1lzhHBe26hy4Fonh/Z1q90Pk1++u/LMX7c4Q9kFk5flMz3f8
	rac8WQPZIrG0s=
X-Received: by 2002:a05:6300:4047:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3c3ad66819fmr11031755637.12.1784491185390;
        Sun, 19 Jul 2026 12:59:45 -0700 (PDT)
Received: from PC.. ([103.172.209.59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20c158sm31076333eec.29.2026.07.19.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:59:44 -0700 (PDT)
From: MishraMohit21 <mishraloopmohit@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MishraMohit21 <mishraloopmohit@gmail.com>
Subject: [PATCH] staging: sm750fb: Refactor init_status to use initchip_param
Date: Mon, 20 Jul 2026 01:28:39 +0530
Message-ID: <20260719195839.24937-2-mishraloopmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719195839.24937-1-mishraloopmohit@gmail.com>
References: <20260719195839.24937-1-mishraloopmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver initializes the hardware by casting 'struct init_status *' to
'struct initchip_param *' in ddk750_init_hw(). This is technically
undefined behavior, violates strict-aliasing rules, and is fragile.

Furthermore, 'struct init_status' defines the 'reset_memory' field as a
2-byte 'ushort', while 'struct initchip_param' defines it as a 1-byte
'unsigned char'. On little-endian architectures, reading the low byte
of the ushort happens to evaluate to the correct value (0 or 1) by accident.
However, on big-endian architectures, casting and reading this field
reads the high byte (0x00) instead, causing a silent failure where the
memory controller is never reset.

This endianness layout mismatch was empirically verified using a standalone
test harness (scratch/be_test.c) compiled under a mips-linux-gnu-gcc
cross-compiler and executed under qemu-mips.

Resolve this by removing the duplicate 'struct init_status' entirely and
using 'struct initchip_param' directly. This removes the unsafe pointer
cast and ensures endian-safe hardware initialization.

This change has been compile-tested only. No hardware was available to
verify runtime behavior.

Signed-off-by: MishraMohit21 <mishraloopmohit@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    |  8 ++++----
 drivers/staging/sm750fb/sm750.h    | 12 ++----------
 drivers/staging/sm750fb/sm750_hw.c | 16 ++++++++--------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..5986dbef67c0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -844,11 +844,11 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 
 	swap = 0;
 
-	sm750_dev->init_parm.chip_clk = 0;
-	sm750_dev->init_parm.mem_clk = 0;
-	sm750_dev->init_parm.master_clk = 0;
+	sm750_dev->init_parm.chip_clock = 0;
+	sm750_dev->init_parm.mem_clock = 0;
+	sm750_dev->init_parm.master_clock = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..313c2683bf6c 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -38,15 +38,7 @@ enum sm750_path {
 	sm750_pnc = 3,	/* panel and crt */
 };
 
-struct init_status {
-	ushort power_mode;
-	/* below three clocks are in unit of MHZ*/
-	ushort chip_clk;
-	ushort mem_clk;
-	ushort master_clk;
-	ushort setAllEngOff;
-	ushort reset_memory;
-};
+#include "ddk750_chip.h"
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
@@ -102,7 +94,7 @@ struct sm750_dev {
 	/* locks*/
 	spinlock_t slock;
 
-	struct init_status init_parm;
+	struct initchip_param init_parm;
 	enum sm750_pnltype pnltype;
 	enum sm750_dataflow dataflow;
 	int nocrt;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 34a837fb4b64..54c1b241ae6e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -66,20 +66,20 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
-	struct init_status *parm;
+	struct initchip_param *parm;
 
 	parm = &sm750_dev->init_parm;
-	if (parm->chip_clk == 0)
-		parm->chip_clk = (sm750_get_chip_type() == SM750LE) ?
+	if (parm->chip_clock == 0)
+		parm->chip_clock = (sm750_get_chip_type() == SM750LE) ?
 					       DEFAULT_SM750LE_CHIP_CLOCK :
 					       DEFAULT_SM750_CHIP_CLOCK;
 
-	if (parm->mem_clk == 0)
-		parm->mem_clk = parm->chip_clk;
-	if (parm->master_clk == 0)
-		parm->master_clk = parm->chip_clk / 3;
+	if (parm->mem_clock == 0)
+		parm->mem_clock = parm->chip_clock;
+	if (parm->master_clock == 0)
+		parm->master_clock = parm->chip_clock / 3;
 
-	ddk750_init_hw((struct initchip_param *)&sm750_dev->init_parm);
+	ddk750_init_hw(&sm750_dev->init_parm);
 	/* for sm718, open pci burst */
 	if (sm750_dev->devid == 0x718) {
 		poke32(SYSTEM_CTRL,
-- 
2.43.0

