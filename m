Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE41DFDB8
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Mar 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707213; cv=none; b=clYv/e0+QO9/7eW9dcjXQQIyGinISg0YnYzu9pYNQDkoMys7QF1CX0Caxia0U6IjgfY+JWngwBqEACoCnUSWFg+YW9bIsjDhWcLwaztPT/OVKLoSuXxwxbQ5gVpq/F1uSBKO5FEdMz1uEL4sEY7eoQ7R/tb9kx6zgYUAA22XzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707213; c=relaxed/simple;
	bh=7wwPRFEwqJjtd8mjU0q8MFVpL0Q24wonELX9YMh4bvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIpmydJ5l+pIx0QhXtcIQswiFJaQVA0BZ8lP/rARfKPiDtyX6z5yt4EkvWpj+NcLmgGPXP1ElX5rdHRuJZMH8oUmXJ8kNKC+pB/PURDEqKDrnYX6ZeV0N6NS8ATnPD3PQwqHZ1/ZD8ctdrwYTjUXLeYGHbMr5esqRVqmDI7bLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RAF/z83a; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RAF/z83a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772707200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FD1c8dWV5+6VqsbjY0c8AD7ho4tdjFdPaw+cN63q3So=;
	b=RAF/z83aRL5u+eAX2wIOFOjQvBG7MFAqq3Yv9Es460M5PB6b07KDBjUIRRZ+t1l3nfBQjf
	WRPpS96NCQ0Mjk7M5bWKUyh4Knj8FPH/tNn5ftJFeCjwG+g05bGWrR4BqfRhOGbFHrdli3
	HzzWAFvPDI6xvyMPRl2dJRxDCj+PTsU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Helge Deller <deller@gmx.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: macfb: Replace deprecated strcpy with strscpy
Date: Thu,  5 Mar 2026 11:39:15 +0100
Message-ID: <20260305103919.158067-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  No functional changes.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/video/fbdev/macfb.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 887fffdccd24..ef3d2304e2f4 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -668,19 +668,19 @@ static int __init macfb_init(void)
 
 		switch(ndev->dr_hw) {
 		case NUBUS_DRHW_APPLE_MDC:
-			strcpy(macfb_fix.id, "Mac Disp. Card");
+			strscpy(macfb_fix.id, "Mac Disp. Card");
 			macfb_setpalette = mdc_setpalette;
 			break;
 		case NUBUS_DRHW_APPLE_TFB:
-			strcpy(macfb_fix.id, "Toby");
+			strscpy(macfb_fix.id, "Toby");
 			macfb_setpalette = toby_setpalette;
 			break;
 		case NUBUS_DRHW_APPLE_JET:
-			strcpy(macfb_fix.id, "Jet");
+			strscpy(macfb_fix.id, "Jet");
 			macfb_setpalette = jet_setpalette;
 			break;
 		default:
-			strcpy(macfb_fix.id, "Generic NuBus");
+			strscpy(macfb_fix.id, "Generic NuBus");
 			break;
 		}
 	}
@@ -707,7 +707,7 @@ static int __init macfb_init(void)
 		case MAC_MODEL_Q700:
 		case MAC_MODEL_Q900:
 		case MAC_MODEL_Q950:
-			strcpy(macfb_fix.id, "DAFB");
+			strscpy(macfb_fix.id, "DAFB");
 			macfb_setpalette = dafb_setpalette;
 			dafb_cmap_regs = ioremap(DAFB_BASE, 0x1000);
 			break;
@@ -716,7 +716,7 @@ static int __init macfb_init(void)
 		 * LC II uses the V8 framebuffer
 		 */
 		case MAC_MODEL_LCII:
-			strcpy(macfb_fix.id, "V8");
+			strscpy(macfb_fix.id, "V8");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
@@ -729,7 +729,7 @@ static int __init macfb_init(void)
 		case MAC_MODEL_IIVI:
 		case MAC_MODEL_IIVX:
 		case MAC_MODEL_P600:
-			strcpy(macfb_fix.id, "Brazil");
+			strscpy(macfb_fix.id, "Brazil");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
@@ -745,7 +745,7 @@ static int __init macfb_init(void)
 		case MAC_MODEL_P520:
 		case MAC_MODEL_P550:
 		case MAC_MODEL_P460:
-			strcpy(macfb_fix.id, "Sonora");
+			strscpy(macfb_fix.id, "Sonora");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
@@ -757,7 +757,7 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_IICI:
 		case MAC_MODEL_IISI:
-			strcpy(macfb_fix.id, "RBV");
+			strscpy(macfb_fix.id, "RBV");
 			macfb_setpalette = rbv_setpalette;
 			rbv_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
@@ -767,7 +767,7 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_Q840:
 		case MAC_MODEL_C660:
-			strcpy(macfb_fix.id, "Civic");
+			strscpy(macfb_fix.id, "Civic");
 			macfb_setpalette = civic_setpalette;
 			civic_cmap_regs = ioremap(CIVIC_BASE, 0x1000);
 			break;
@@ -778,7 +778,7 @@ static int __init macfb_init(void)
 		 * We think this may be like the LC II
 		 */
 		case MAC_MODEL_LC:
-			strcpy(macfb_fix.id, "LC");
+			strscpy(macfb_fix.id, "LC");
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
 				v8_brazil_cmap_regs =
@@ -790,7 +790,7 @@ static int __init macfb_init(void)
 		 * We think this may be like the LC II
 		 */
 		case MAC_MODEL_CCL:
-			strcpy(macfb_fix.id, "Color Classic");
+			strscpy(macfb_fix.id, "Color Classic");
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
 				v8_brazil_cmap_regs =
@@ -802,7 +802,7 @@ static int __init macfb_init(void)
 		 * And we *do* mean "weirdos"
 		 */
 		case MAC_MODEL_TV:
-			strcpy(macfb_fix.id, "Mac TV");
+			strscpy(macfb_fix.id, "Mac TV");
 			break;
 
 		/*
@@ -810,7 +810,7 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_SE30:
 		case MAC_MODEL_CLII:
-			strcpy(macfb_fix.id, "Monochrome");
+			strscpy(macfb_fix.id, "Monochrome");
 			break;
 
 		/*
@@ -828,7 +828,7 @@ static int __init macfb_init(void)
 		case MAC_MODEL_PB140:
 		case MAC_MODEL_PB145:
 		case MAC_MODEL_PB170:
-			strcpy(macfb_fix.id, "DDC");
+			strscpy(macfb_fix.id, "DDC");
 			break;
 
 		/*
@@ -840,7 +840,7 @@ static int __init macfb_init(void)
 		case MAC_MODEL_PB180:
 		case MAC_MODEL_PB210:
 		case MAC_MODEL_PB230:
-			strcpy(macfb_fix.id, "GSC");
+			strscpy(macfb_fix.id, "GSC");
 			break;
 
 		/*
@@ -848,7 +848,7 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_PB165C:
 		case MAC_MODEL_PB180C:
-			strcpy(macfb_fix.id, "TIM");
+			strscpy(macfb_fix.id, "TIM");
 			break;
 
 		/*
@@ -860,13 +860,13 @@ static int __init macfb_init(void)
 		case MAC_MODEL_PB270C:
 		case MAC_MODEL_PB280:
 		case MAC_MODEL_PB280C:
-			strcpy(macfb_fix.id, "CSC");
+			strscpy(macfb_fix.id, "CSC");
 			macfb_setpalette = csc_setpalette;
 			csc_cmap_regs = ioremap(CSC_BASE, 0x1000);
 			break;
 
 		default:
-			strcpy(macfb_fix.id, "Unknown");
+			strscpy(macfb_fix.id, "Unknown");
 			break;
 		}
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

