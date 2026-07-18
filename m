Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA83342CB4
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jul 2026 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784354288; cv=none; b=HW75rJ5Dv9BsZEZBCGDthyXzBdGoZgMMKWC4uGhPNd2ZRXiIBXiLpK8iTkwdqHBgOHS5rDNzTbfRTbKoj4/2laVGaMuQiiLACKGXZaFzNT4uxH1y7vLuRabX0mtkuAciEjXVbONz86NdciZPNcAk6AW4tav1Mdbe6ypPYbgoD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784354288; c=relaxed/simple;
	bh=aq5lttLtQv85kpcA9dgGHVffvIKBzVoUW5PjkNwm+EE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac8u03stzXwsp4xzQuIGvyy5TppB4eZ266ndH1eUAjqw1KTwBsrzKXIG+Lmv/PF9kx85oNGWR7RAlsaZu6fC33+2DBa/17iSHWyX9GanGT8Ucbtxn6WlZ3QfPD5KiV6OSzynKSqD7X/lO7a8rucmSuzjHV8pXYdf5HMN0FIJ7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=K9lETJ49; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="K9lETJ49"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=j4x6cjfux5gvdf2umpuz7eazx4.protonmail; t=1784354282; x=1784613482;
	bh=Bqe7z/QlpFlTUiqHzSAAcKslRo0AbEz85QoZxwn5E0w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K9lETJ49WzkBB8fxsW+ybdQjM8DVEhVg7FxL+EKc0AwBRWOCDgRh6mXx1PjycLhN9
	 nTW85zC17Etxbs+qArSmVX1ef3eqYXmV73Msaq8sqE6xuWXVKavyloS6G2CVwsBZ34
	 zngE6v3mRjOCuF9vRga6Em28zVZamVwjQ9FvU2m9ERht4s12AlJ+3Uq8cD7IdzNfk6
	 7xIPJd/ilAZQ+Ik93LwEXLf6gBlpID92e0+E+L4MV8qJ2ALB0fRizZBPNCzy5sf36r
	 +1R4Sa+lJnmdWXbm4PtGCTRlpGfYK370O0jic2T4+Y+o46cluAhrW9gRufSCddNPgc
	 jS7HiK9AEM9Dw==
Date: Sat, 18 Jul 2026 05:57:58 +0000
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nils Lehnen <nils.lehnen@proton.me>
Cc: linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Nils Lehnen <nils.lehnen@proton.me>
Subject: [PATCH 2/2] staging: sm750fb: unindent defines left by conditional removal
Message-ID: <20260718055709.466-2-nils.lehnen@proton.me>
In-Reply-To: <20260718055709.466-1-nils.lehnen@proton.me>
References: <20260718055132.441-1-nils.lehnen@proton.me> <20260718055709.466-1-nils.lehnen@proton.me>
Feedback-ID: 188354734:user:proton
X-Pm-Message-ID: 1c2d4d2739e77f126e1d9d2bae2b15a45f897bc7
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The preceding removal of the VALIDATION_CHIP conditionals left the
surviving define blocks and one comment indented by four spaces, and
two double blank lines where conditional lines went away. Move the
now-unconditional defines to column zero while keeping the aligned
value column untouched, and collapse the blank lines.

No functional change: whitespace and preprocessor layout only; the
disassembly of all ten sm750fb object files stays bit-identical.

All English text in this patch (commit message and code comments) was
translated from a German draft with the assistance of Claude Fable 5.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nils Lehnen <nils.lehnen@proton.me>
---
 drivers/staging/sm750fb/ddk750_reg.h | 50 +++++++++++++---------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb=
/ddk750_reg.h
index 4bcede37584a..2888ffe32fa2 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -294,15 +294,15 @@
=20
 #define CURRENT_GATE                                  0x000040
 #define CURRENT_GATE_MCLK_MASK                        (0x3 << 14)
-    #define CURRENT_GATE_MCLK_DIV_3                   (0x0 << 14)
-    #define CURRENT_GATE_MCLK_DIV_4                   (0x1 << 14)
-    #define CURRENT_GATE_MCLK_DIV_6                   (0x2 << 14)
-    #define CURRENT_GATE_MCLK_DIV_8                   (0x3 << 14)
+#define CURRENT_GATE_MCLK_DIV_3                       (0x0 << 14)
+#define CURRENT_GATE_MCLK_DIV_4                       (0x1 << 14)
+#define CURRENT_GATE_MCLK_DIV_6                       (0x2 << 14)
+#define CURRENT_GATE_MCLK_DIV_8                       (0x3 << 14)
 #define CURRENT_GATE_M2XCLK_MASK                      (0x3 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_1                 (0x0 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_2                 (0x1 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_3                 (0x2 << 12)
-    #define CURRENT_GATE_M2XCLK_DIV_4                 (0x3 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_1                     (0x0 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_2                     (0x1 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_3                     (0x2 << 12)
+#define CURRENT_GATE_M2XCLK_DIV_4                     (0x3 << 12)
 #define CURRENT_GATE_VGA                              BIT(10)
 #define CURRENT_GATE_PWM                              BIT(9)
 #define CURRENT_GATE_I2C                              BIT(8)
@@ -383,10 +383,10 @@
 #define PLL_CTRL_BYPASS                               BIT(18)
 #define PLL_CTRL_POWER                                BIT(17)
 #define PLL_CTRL_INPUT                                BIT(16)
-    #define PLL_CTRL_POD_SHIFT                        14
-    #define PLL_CTRL_POD_MASK                         (0x3 << 14)
-    #define PLL_CTRL_OD_SHIFT                         12
-    #define PLL_CTRL_OD_MASK                          (0x3 << 12)
+#define PLL_CTRL_POD_SHIFT                            14
+#define PLL_CTRL_POD_MASK                             (0x3 << 14)
+#define PLL_CTRL_OD_SHIFT                             12
+#define PLL_CTRL_OD_MASK                              (0x3 << 12)
 #define PLL_CTRL_N_SHIFT                              8
 #define PLL_CTRL_N_MASK                               (0xf << 8)
 #define PLL_CTRL_M_SHIFT                              0
@@ -400,7 +400,6 @@
=20
 #define SCRATCH_DATA                                  0x00006c
=20
-
 #define MXCLK_PLL_CTRL                                0x000070
=20
 #define VGA_CONFIGURATION                             0x000088
@@ -408,7 +407,6 @@
 #define VGA_CONFIGURATION_PLL                         BIT(2)
 #define VGA_CONFIGURATION_MODE                        BIT(1)
=20
-
 #define GPIO_DATA                                       0x010000
 #define GPIO_DATA_31                                    BIT(31)
 #define GPIO_DATA_30                                    BIT(30)
@@ -996,7 +994,7 @@
 #define CRT_DISPLAY_CTRL_CRTSELECT                    BIT(25)
 #define CRT_DISPLAY_CTRL_RGBBIT                       BIT(24)
=20
-    #define CRT_DISPLAY_CTRL_CENTERING                BIT(24)
+#define CRT_DISPLAY_CTRL_CENTERING                    BIT(24)
 #define CRT_DISPLAY_CTRL_LOCK_TIMING                  BIT(23)
 #define CRT_DISPLAY_CTRL_EXPANSION                    BIT(22)
 #define CRT_DISPLAY_CTRL_VERTICAL_MODE                BIT(21)
@@ -1095,26 +1093,26 @@
=20
 /* This vertical expansion below start at 0x080240 ~ 0x080264 */
 #define CRT_VERTICAL_EXPANSION                        0x080240
-    #define CRT_VERTICAL_CENTERING_VALUE_MASK         (0xff << 24)
+#define CRT_VERTICAL_CENTERING_VALUE_MASK             (0xff << 24)
 #define CRT_VERTICAL_EXPANSION_COMPARE_VALUE_MASK     (0xff << 16)
 #define CRT_VERTICAL_EXPANSION_LINE_BUFFER_MASK       (0xf << 12)
 #define CRT_VERTICAL_EXPANSION_SCALE_FACTOR_MASK      0xfff
=20
 /* This horizontal expansion below start at 0x080268 ~ 0x08027C */
 #define CRT_HORIZONTAL_EXPANSION                      0x080268
-    #define CRT_HORIZONTAL_CENTERING_VALUE_MASK       (0xff << 24)
+#define CRT_HORIZONTAL_CENTERING_VALUE_MASK           (0xff << 24)
 #define CRT_HORIZONTAL_EXPANSION_COMPARE_VALUE_MASK   (0xff << 16)
 #define CRT_HORIZONTAL_EXPANSION_SCALE_FACTOR_MASK    0xfff
=20
-    /* Auto Centering */
-    #define CRT_AUTO_CENTERING_TL                     0x080280
-    #define CRT_AUTO_CENTERING_TL_TOP_MASK            (0x7ff << 16)
-    #define CRT_AUTO_CENTERING_TL_LEFT_MASK           0x7ff
+/* Auto Centering */
+#define CRT_AUTO_CENTERING_TL                         0x080280
+#define CRT_AUTO_CENTERING_TL_TOP_MASK                (0x7ff << 16)
+#define CRT_AUTO_CENTERING_TL_LEFT_MASK               0x7ff
=20
-    #define CRT_AUTO_CENTERING_BR                     0x080284
-    #define CRT_AUTO_CENTERING_BR_BOTTOM_MASK         (0x7ff << 16)
-    #define CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT        16
-    #define CRT_AUTO_CENTERING_BR_RIGHT_MASK          0x7ff
+#define CRT_AUTO_CENTERING_BR                         0x080284
+#define CRT_AUTO_CENTERING_BR_BOTTOM_MASK             (0x7ff << 16)
+#define CRT_AUTO_CENTERING_BR_BOTTOM_SHIFT            16
+#define CRT_AUTO_CENTERING_BR_RIGHT_MASK              0x7ff
=20
 /* sm750le new register to control panel output */
 #define DISPLAY_CONTROL_750LE=09=09=09      0x80288
@@ -1294,7 +1292,7 @@
 #define ZV0_CAPTURE_BUF1_ADDRESS_ADDRESS_MASK           0x3ffffff
=20
 #define ZV0_CAPTURE_BUF_OFFSET                          0x090014
-    #define ZV0_CAPTURE_BUF_OFFSET_YCLIP_ODD_FIELD      (0x3ff << 16)
+#define ZV0_CAPTURE_BUF_OFFSET_YCLIP_ODD_FIELD          (0x3ff << 16)
 #define ZV0_CAPTURE_BUF_OFFSET_OFFSET_MASK              0xffff
=20
 #define ZV0_CAPTURE_FIFO_CTRL                           0x090018
--=20
2.43.0


