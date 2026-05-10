Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78118859B
	for <linux-fbdev@vger.kernel.org>; Sun, 10 May 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382673; cv=none; b=j53zNFc1gk+vhiaox6N6tCXMbzhzjbCKsqniCHgo7fRFnGBYOEy0TynWPx1UEhnaln/eNfp65TnNY6FHvkHNQb9HF+LhIivJyMTnhoUIpOm0SN45jl3wKHrbrnoGs2BhZ9ErG3bOZvMO98MQEZ48h4nUpVAGBllQwLiinMTokqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382673; c=relaxed/simple;
	bh=gQA4Z0I4dAD3lpM3WcSiD7Z4kubZPjVnKPmZMkhI4ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWY/xZ3mXn7jubz5egOfYz8qGknwdPuTWljk8qI/nWPaqTZankK6aOmVk+1KAPvzXEUeZsJB6JCuefIimK++1hmdAV1Lo3rdgt85I1uJJveDjNJ1O1VeAqXNVPvcpaHP/Ihrx3FvVeTxH8A+QRYy0dwh5HnDb6TB85FVUbA3gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1nf/1s/; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1nf/1s/"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2f30a4601bbso3387308eec.1
        for <linux-fbdev@vger.kernel.org>; Sat, 09 May 2026 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778382671; x=1778987471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk9eeAKn3FhBbqVLjcl9tAfYozaTPwOkZxBuF5GgNhQ=;
        b=n1nf/1s/mmOfVkB99s2fuIwoBaOBAhPFqdR1w8kElU8IlrnF7QZQxLf0HBuu4iC8Gi
         DGdtnEzOe1PcJBiz+ijnoOZzpxIOpgqh8KOq8UlRxQsSjnZGkEQuLYRdaQu9y+unlq/s
         ThopCnq2h1dDW5+fWQQrgCP2xD+x4Fmw+wMS7fJaofkgfeQNAw7KFDYscrhpAO4RRArR
         56XEGFXzjd6unfVJYv+mHx9gGNw0p5dMCaVQyZwztflXvK02e8uHbFsQRXDJfx9qAmts
         QqDq2Mdr0i159/CTYGooGsS558V23XUyxWezosfU9KaTW8xgDzktzFRVPrFu/0z/msC1
         X1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778382671; x=1778987471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk9eeAKn3FhBbqVLjcl9tAfYozaTPwOkZxBuF5GgNhQ=;
        b=d3RG/FT10iNnMiqYeGPoopLUPaEs2+yibUT1XQpSjRAgcBcPcsRy2XEggY+xXC2Ka0
         Cuf1LZpQL7M04+mQKVlf6+QJN//rI7XsKq+gvafZ/gzGc2z6w+S5xVbkfGRhEPdphBk/
         9i56pSxzyQRWHocNFwkUiKGx9IdmPcg5d3ggbsnxxcQ62WHeRelXbs1m/1Ud8Cy1df5W
         G75Biqg8geWJlWub/cnhJrNpgWSqqQe0F+WiM+iHspc7TBzO1HS8eLSXkknF7yS/HmPk
         h/boGKRWs08RDBiTGRL6LqxLMrAJ3ofzhF51y0r6mzSIvLxFXzphsAvEwArj01GYxgx/
         yQ/g==
X-Forwarded-Encrypted: i=1; AFNElJ+hLkVrmGV7wRw0xg4T7p+V28lYUgW+A7r+fAy1bLG+3StvCjLQszcPtlCd3gtq1+LwuTGy2oUVNmFoNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFPKopbKEJ0nUZBj6xrsMRt57oMEnxYiSDEXfdknLZ0WxC+Ju
	yjtfTPXE/4vlIs1KfAwYQEFI1W2e8Sk09Rr5gxiExGWTc+PzAxN8AECe
X-Gm-Gg: Acq92OF/dCVJTDhZjksQqXr9fCjIQGDOjG2xH8DHHF6cKktdBCa3BKve/im1OJUvf7q
	8E9j6C+i04fm124cBGqNFM5bOm0+xrz8VtbvH41Hhb39ytoREMEoL8E5PBbGsLBtpKna2i11U5d
	s9ezMTpo5mT3+IvIBN2tsd/WdnnSC2WhBMan+/mt8A3DB5tqKKJ1j1H5+W30nwgw9qYoO+X60rg
	YR4sJj+Yx2ae3wNfxBJ5NUqLDyQGernhNuhFcZDnD6Sb/G+9/ItG/C3tSBomn2Rqw8GQWD9r8vz
	X0/YZ9akANcNi7tKIIbEwnxkev7a60ArSDppAfC+cM4dKJYrnYTXERgC2OSdGUKOfLedNWVk4xy
	8zA/0dS1Lp39y98jjz2uA+D6mDqx0MvJ66dKZoxBDC8SilhTeWAMkwCs2gVo8fRP3ksyPZADTzq
	bgxdxFKWQdEWHEYDScTxGmv9qTc7LMvN4vkRVHL5ndyyZ+M1G3TwzkQF0K2t0c52h/I969KVU4d
	lzcPlPGuUCnguYu/PVNuMxCJzvx2Ny9hwu8qepxMkgxKrdqb2ZEkFWgReHseOCuetzbA/QNE3/z
	lkP3AQnnF4Kj0xA7qw==
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2f54c587faemr9231006eec.15.1778382670966;
        Sat, 09 May 2026 20:11:10 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm8433793eec.24.2026.05.09.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 20:11:10 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] ARM: move Risc PC-specific <asm/hardware/iomd.h> header into mach-rpc
Date: Sat,  9 May 2026 20:10:36 -0700
Message-ID: <20260510031100.255248-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <asm/hardware/iomd.h> header is specific to the IOMD chip used on
the Risc PC. Move it into mach-rpc to avoid polluting asm/hardware/
with machine-specific headers.

Also take the opportunity to remove a comment with the file path from
the header, which is bad style.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 MAINTAINERS                                                     | 1 -
 arch/arm/mach-rpc/dma.c                                         | 2 +-
 arch/arm/{include/asm/hardware => mach-rpc/include/mach}/iomd.h | 2 --
 arch/arm/mach-rpc/irq.c                                         | 2 +-
 arch/arm/mach-rpc/riscpc.c                                      | 2 +-
 arch/arm/mach-rpc/time.c                                        | 2 +-
 drivers/i2c/busses/i2c-acorn.c                                  | 2 +-
 drivers/input/mouse/rpcmouse.c                                  | 2 +-
 drivers/input/serio/rpckbd.c                                    | 2 +-
 drivers/video/fbdev/acornfb.h                                   | 2 +-
 10 files changed, 8 insertions(+), 11 deletions(-)
 rename arch/arm/{include/asm/hardware => mach-rpc/include/mach}/iomd.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 211cc683e25b..6a1da8903c04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3398,7 +3398,6 @@ M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/iomd.h
 F:	arch/arm/mach-rpc/
 F:	drivers/net/ethernet/8390/etherh.c
 F:	drivers/net/ethernet/i825xx/ether1*
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 50e0f97afd75..717a81475670 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -20,7 +20,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/mach/dma.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 struct iomd_dma {
 	struct dma_struct	dma;
diff --git a/arch/arm/include/asm/hardware/iomd.h b/arch/arm/mach-rpc/include/mach/iomd.h
similarity index 98%
rename from arch/arm/include/asm/hardware/iomd.h
rename to arch/arm/mach-rpc/include/mach/iomd.h
index e3f130345ebc..2a3f4a5f3fd9 100644
--- a/arch/arm/include/asm/hardware/iomd.h
+++ b/arch/arm/mach-rpc/include/mach/iomd.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/hardware/iomd.h
- *
  *  Copyright (C) 1999 Russell King
  *
  *  This file contains information out the IOMD ASIC used in the
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index e924c9b813ab..649d81874c86 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -4,7 +4,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/irq.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #include <asm/irq.h>
 #include <asm/fiq.h>
 
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index f70fb9c4b0cb..d068f5e4873d 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -22,7 +22,7 @@
 #include <asm/elf.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index ad93c4dfafcd..566113f9774f 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 #include <asm/mach/time.h>
 
diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
index 99b6b1c3fd9e..703b4a42f466 100644
--- a/drivers/i2c/busses/i2c-acorn.c
+++ b/drivers/i2c/busses/i2c-acorn.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 #define FORCE_ONES	0xdc
 #define SCL		0x02
diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
index 6774029e0a1a..475c3ca22fd4 100644
--- a/drivers/input/mouse/rpcmouse.c
+++ b/drivers/input/mouse/rpcmouse.c
@@ -23,7 +23,7 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC mouse driver");
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 4d817850ba3b..e452ad07e2fa 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
diff --git a/drivers/video/fbdev/acornfb.h b/drivers/video/fbdev/acornfb.h
index f8df4ecb4fd7..e65388587f80 100644
--- a/drivers/video/fbdev/acornfb.h
+++ b/drivers/video/fbdev/acornfb.h
@@ -7,7 +7,7 @@
  *  Frame buffer code for Acorn platforms
  */
 #if defined(HAS_VIDC20)
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #define VIDC_PALETTE_SIZE	256
 #define VIDC_NAME		"VIDC20"
 #endif
-- 
2.43.0

