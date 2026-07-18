Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0E2C21F1
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355681; cv=none; b=s3RI7ChuaOBG+4DLIki70po0BOn0U5xWSQ/dLITi39Vv5rlwov7cbp3pqLyW0Pdwm7PSLHcmH6c0TyLaeMZBuhGSLD6UW9b69eFf45iRDwvaZCzTEFsWOH42vZOJGA/CJ6D1Jb/mQuRAMn7kUEfAl0r0q0Xw+8DscZZXRLVOgTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355681; c=relaxed/simple;
	bh=8KMAGVXMXEho8yhK/Y/llg3Pl8qS9CSrbUKC/EW/R5M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/u2tzpyoDcqh9b/PDpTFc4xH4RsoqPTghm+mC40Zd48JPBNxApLHYnJicRbXpJ2Rx47wqPdFrkQs/N60z2QhnujDSE6USyoal8Qem5KZ9Wi6/7DtKnlHSgh1Ke//9RGLF5d+yciZHj4GGnRztnYylRis9o8fJNnvXnV/1LQWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZuxMljfy; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZuxMljfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1784355669; x=1784614869;
	bh=8Il7b6wWmDfdMOETploLySGnbVhq17FaIic7m1Su2uI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZuxMljfyMiAL37uWwaanneoMymgNbEk0ZsuBiXv0qFPECr3uKYwcPH18x8F7iDo/+
	 seMX/sOI7ghFJ920VuHhhg0Jpsdusvpz7dbPkBXUSlwzS0pJoeGQ4NH0nimQNRIyL9
	 bLoHHhik6KSWDkMVHQocPbHPfkKToYxFa6+oP7UEQOXewQhZo7aYzEK8MTc55djUDN
	 YkMXTijUFK/1stZxdH9f7ZwXR1ST7xtGeTIHEhcVScpZz2lvac6ZJFdFfK/56EpBB0
	 mN8wQqS0SsnkUESj2X/LfYIw0LPrRwnmG6G1BEceJ9PjnUFMWwrXxShT+RTuxhRSFY
	 XC1P7PuNGM+JQ==
Date: Sat, 18 Jul 2026 06:21:06 +0000
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: [PATCH v2 1/2] staging: sm750fb: remove dead VALIDATION_CHIP conditionals
Message-ID: <20260718062027.5850-2-nils.lehnen@proton.me>
In-Reply-To: <20260718062027.5850-1-nils.lehnen@proton.me>
References: <20260718062027.5850-1-nils.lehnen@proton.me>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 3e35adcd54a191c59064103aeba3f712c30dc9b8
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

VALIDATION_CHIP is defined nowhere in the tree and no Makefile passes
-DVALIDATION_CHIP, so every #ifdef VALIDATION_CHIP block is dead code
and every #ifndef VALIDATION_CHIP condition is always true. Resolve all
fourteen conditionals accordingly (dead branches dropped, live branches
kept), as the driver TODO asks under "remove unused code".

No functional change: the disassembly of all ten sm750fb object files
is bit-identical before and after this patch.

All English text in this patch (commit message and code comments) was
translated from a German draft with the assistance of Claude Fable 5.

Assisted-by: Claude:claude-fable-5 sparse unifdef
Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>
---
 drivers/staging/sm750fb/ddk750_reg.h   | 34 --------------------------
 drivers/staging/sm750fb/ddk750_chip.c  |  4 ---
 drivers/staging/sm750fb/ddk750_power.c |  6 -----
 3 files changed, 44 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb=
/ddk750_reg.h
index fe412ead72e5..4bcede37584a 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -294,29 +294,15 @@
=20
 #define CURRENT_GATE                                  0x000040
 #define CURRENT_GATE_MCLK_MASK                        (0x3 << 14)
-#ifdef VALIDATION_CHIP
-    #define CURRENT_GATE_MCLK_112MHZ                  (0x0 << 14)
-    #define CURRENT_GATE_MCLK_84MHZ                   (0x1 << 14)
-    #define CURRENT_GATE_MCLK_56MHZ                   (0x2 << 14)
-    #define CURRENT_GATE_MCLK_42MHZ                   (0x3 << 14)
-#else
     #define CURRENT_GATE_MCLK_DIV_3                   (0x0 << 14)
     #define CURRENT_GATE_MCLK_DIV_4                   (0x1 << 14)
     #define CURRENT_GATE_MCLK_DIV_6                   (0x2 << 14)
     #define CURRENT_GATE_MCLK_DIV_8                   (0x3 << 14)
-#endif
 #define CURRENT_GATE_M2XCLK_MASK                      (0x3 << 12)
-#ifdef VALIDATION_CHIP
-    #define CURRENT_GATE_M2XCLK_336MHZ                (0x0 << 12)
-    #define CURRENT_GATE_M2XCLK_168MHZ                (0x1 << 12)
-    #define CURRENT_GATE_M2XCLK_112MHZ                (0x2 << 12)
-    #define CURRENT_GATE_M2XCLK_84MHZ                 (0x3 << 12)
-#else
     #define CURRENT_GATE_M2XCLK_DIV_1                 (0x0 << 12)
     #define CURRENT_GATE_M2XCLK_DIV_2                 (0x1 << 12)
     #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
     #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
-#endif
 #define CURRENT_GATE_VGA                              BIT(10)
 #define CURRENT_GATE_PWM                              BIT(9)
 #define CURRENT_GATE_I2C                              BIT(8)
@@ -376,9 +362,6 @@
 #define MODE1_GATE_DMA                                BIT(0)
=20
 #define POWER_MODE_CTRL                               0x00004C
-#ifdef VALIDATION_CHIP
-    #define POWER_MODE_CTRL_336CLK                    BIT(4)
-#endif
 #define POWER_MODE_CTRL_OSC_INPUT                     BIT(3)
 #define POWER_MODE_CTRL_ACPI                          BIT(2)
 #define POWER_MODE_CTRL_MODE_MASK                     (0x3 << 0)
@@ -400,15 +383,10 @@
 #define PLL_CTRL_BYPASS                               BIT(18)
 #define PLL_CTRL_POWER                                BIT(17)
 #define PLL_CTRL_INPUT                                BIT(16)
-#ifdef VALIDATION_CHIP
-    #define PLL_CTRL_OD_SHIFT                         14
-    #define PLL_CTRL_OD_MASK                          (0x3 << 14)
-#else
     #define PLL_CTRL_POD_SHIFT                        14
     #define PLL_CTRL_POD_MASK                         (0x3 << 14)
     #define PLL_CTRL_OD_SHIFT                         12
     #define PLL_CTRL_OD_MASK                          (0x3 << 12)
-#endif
 #define PLL_CTRL_N_SHIFT                              8
 #define PLL_CTRL_N_MASK                               (0xf << 8)
 #define PLL_CTRL_M_SHIFT                              0
@@ -422,7 +400,6 @@
=20
 #define SCRATCH_DATA                                  0x00006c
=20
-#ifndef VALIDATION_CHIP
=20
 #define MXCLK_PLL_CTRL                                0x000070
=20
@@ -431,7 +408,6 @@
 #define VGA_CONFIGURATION_PLL                         BIT(2)
 #define VGA_CONFIGURATION_MODE                        BIT(1)
=20
-#endif
=20
 #define GPIO_DATA                                       0x010000
 #define GPIO_DATA_31                                    BIT(31)
@@ -1020,9 +996,7 @@
 #define CRT_DISPLAY_CTRL_CRTSELECT                    BIT(25)
 #define CRT_DISPLAY_CTRL_RGBBIT                       BIT(24)
=20
-#ifndef VALIDATION_CHIP
     #define CRT_DISPLAY_CTRL_CENTERING                BIT(24)
-#endif
 #define CRT_DISPLAY_CTRL_LOCK_TIMING                  BIT(23)
 #define CRT_DISPLAY_CTRL_EXPANSION                    BIT(22)
 #define CRT_DISPLAY_CTRL_VERTICAL_MODE                BIT(21)
@@ -1121,22 +1095,17 @@
=20
 /* This vertical expansion below start at 0x080240 ~ 0x080264 */
 #define CRT_VERTICAL_EXPANSION                        0x080240
-#ifndef VALIDATION_CHIP
     #define CRT_VERTICAL_CENTERING_VALUE_MASK         (0xff << 24)
-#endif
 #define CRT_VERTICAL_EXPANSION_COMPARE_VALUE_MASK     (0xff << 16)
 #define CRT_VERTICAL_EXPANSION_LINE_BUFFER_MASK       (0xf << 12)
 #define CRT_VERTICAL_EXPANSION_SCALE_FACTOR_MASK      0xfff
=20
 /* This horizontal expansion below start at 0x080268 ~ 0x08027C */
 #define CRT_HORIZONTAL_EXPANSION                      0x080268
-#ifndef VALIDATION_CHIP
     #define CRT_HORIZONTAL_CENTERING_VALUE_MASK       (0xff << 24)
-#endif
 #define CRT_HORIZONTAL_EXPANSION_COMPARE_VALUE_MASK   (0xff << 16)
 #define CRT_HORIZONTAL_EXPANSION_SCALE_FACTOR_MASK    0xfff
=20
-#ifndef VALIDATION_CHIP
     /* Auto Centering */
     #define CRT_AUTO_CENTERING_TL                     0x080280
     #define CRT_AUTO_CENTERING_TL_TOP_MASK            (0x7ff << 16)
@@ -1146,7 +1115,6 @@
     #define CRT_AUTO_CENTERING_BR_BOTTOM_MASK         (0x7ff << 16)
     #define CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT        16
     #define CRT_AUTO_CENTERING_BR_RIGHT_MASK          0x7ff
-#endif
=20
 /* sm750le new register to control panel output */
 #define DISPLAY_CONTROL_750LE=09=09=09      0x80288
@@ -1326,9 +1294,7 @@
 #define ZV0_CAPTURE_BUF1_ADDRESS_ADDRESS_MASK           0x3ffffff
=20
 #define ZV0_CAPTURE_BUF_OFFSET                          0x090014
-#ifndef VALIDATION_CHIP
     #define ZV0_CAPTURE_BUF_OFFSET_YCLIP_ODD_FIELD      (0x3ff << 16)
-#endif
 #define ZV0_CAPTURE_BUF_OFFSET_OFFSET_MASK              0xffff
=20
 #define ZV0_CAPTURE_FIFO_CTRL                           0x090018
diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750f=
b/ddk750_chip.c
index 0bb56bbec43f..ab8b68076dec 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -387,9 +387,7 @@ unsigned int sm750_calc_pll_value(unsigned int request_=
orig,
=20
 unsigned int sm750_format_pll_reg(struct pll_value *p_PLL)
 {
-#ifndef VALIDATION_CHIP
 =09unsigned int POD =3D p_PLL->POD;
-#endif
 =09unsigned int OD =3D p_PLL->OD;
 =09unsigned int M =3D p_PLL->M;
 =09unsigned int N =3D p_PLL->N;
@@ -401,9 +399,7 @@ unsigned int sm750_format_pll_reg(struct pll_value *p_P=
LL)
 =09 * applied to any PLL in the calling function.
 =09 */
 =09return PLL_CTRL_POWER |
-#ifndef VALIDATION_CHIP
 =09=09((POD << PLL_CTRL_POD_SHIFT) & PLL_CTRL_POD_MASK) |
-#endif
 =09=09((OD << PLL_CTRL_OD_SHIFT) & PLL_CTRL_OD_MASK) |
 =09=09((N << PLL_CTRL_N_SHIFT) & PLL_CTRL_N_MASK) |
 =09=09((M << PLL_CTRL_M_SHIFT) & PLL_CTRL_M_MASK);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750=
fb/ddk750_power.c
index eaba3bc2e01a..d617f554f58d 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -58,14 +58,8 @@ void sm750_set_power_mode(unsigned int mode)
 =09/* Set up other fields in Power Control Register */
 =09if (mode =3D=3D POWER_MODE_CTRL_MODE_SLEEP) {
 =09=09ctrl &=3D ~POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-=09=09ctrl &=3D ~POWER_MODE_CTRL_336CLK;
-#endif
 =09} else {
 =09=09ctrl |=3D POWER_MODE_CTRL_OSC_INPUT;
-#ifdef VALIDATION_CHIP
-=09=09ctrl |=3D POWER_MODE_CTRL_336CLK;
-#endif
 =09}
=20
 =09/* Program new power mode. */
--=20
2.43.0


