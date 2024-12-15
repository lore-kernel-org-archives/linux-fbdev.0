Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754E13C9D9
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260030; cv=none; b=HXh4UfMG3aOVUhTIhAe/4M6yj9M1iCmjSRAKsj/ecAmwiiMMzyYx5294FezzaYVsOXQEIh/HAZfi9u4kxa1yCE+knWuDp8NmcYVj37QrNsPjZ0cjbwUuHTVypuPR5nu3gvwNLdZEsLdkSd7ALoHCCmHRVa94Ldabg84I3Kc4gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260030; c=relaxed/simple;
	bh=q5OADPiwPmkPJafYpfCEBKSAdjM3jUcJrAwHrVYTmzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM5JiFXWkgdpOIAZoETaZtXuPAnVDt7EkOop6QTGCBzHZqRX81GlzEhbXq3GE32Kb9C61O0qBe+C1dIjSuF1lPQhFH9YXb5msZVmRYVyEaCDQr3FoXfuiiK2FaGqgOSm0rxcd5aJf4UlhCRpGm4JdvgmZXzV7+kDPj04WYOZmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2thBz4wwr1
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by baptiste.telenet-ops.be with cmsmtp
	id oylD2D00W4qjdAp01ylDMK; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kji-7N;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nm6-M1;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 12/17] drawops: Fix crash when drawing large ellipses
Date: Sun, 15 Dec 2024 11:45:03 +0100
Message-Id: <20241215104508.191237-13-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215104508.191237-1-geert@linux-m68k.org>
References: <20241215104508.191237-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"test002" crashes when run with a display resolution of e.g. 2560x1440
pixels, due to 32-bit overflow in the ellipse drawing routine.

Fix this by creating a copy that uses 64-bit arithmetic.  Use a
heuristic to pick either the 32-bit or the 64-bit version, to avoid the
overhead of the 64-bit version on small systems with small displays.
Replace (unsigned) int by u32/s32 in the 32-bit version for clarity.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 127 +++++++++++++++++++++++++++++++++++++++++-----
 include/types.h   |   3 ++
 2 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index 5fd971b59bc698fe..c4cfad3223773a23 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -305,8 +305,98 @@ static void fill_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     }
 }
 
-static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
-		       draw_func_t draw_inner, draw_func_t draw_outer)
+static void do_ellipse_32(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
+			  draw_func_t draw_inner, draw_func_t draw_outer)
+{
+    u32 a2 = a*a;
+    u32 b2 = b*b;
+
+    if (a <= b) {
+	u32 x1 = 0;
+	u32 y1 = b;
+	s32 S = a2*(1-2*b)+2*b2;
+	s32 T = b2-2*a2*(2*b-1);
+	u32 dT1 = 4*b2;
+	u32 dS1 = dT1+2*b2;
+	s32 dS2 = -4*a2*(b-1);
+	s32 dT2 = dS2+2*a2;
+
+	while (1) {
+	    if (S < 0) {
+		if (draw_inner)
+		    draw_inner(x, y, x1, y1, pixel);
+		S += dS1;
+		T += dT1;
+		dS1 += 4*b2;
+		dT1 += 4*b2;
+		x1++;
+	    } else if (T < 0) {
+		draw_outer(x, y, x1, y1, pixel);
+		if (y1 == 0)
+		    break;
+		S += dS1+dS2;
+		T += dT1+dT2;
+		dS1 += 4*b2;
+		dT1 += 4*b2;
+		dS2 += 4*a2;
+		dT2 += 4*a2;
+		x1++;
+		y1--;
+	    } else {
+		draw_outer(x, y, x1, y1, pixel);
+		if (y1 == 0)
+		    break;
+		S += dS2;
+		T += dT2;
+		dS2 += 4*a2;
+		dT2 += 4*a2;
+		y1--;
+	    }
+	}
+    } else {
+	u32 x1 = a;
+	u32 y1 = 0;
+	s32 S = b2*(1-2*a)+2*a2;
+	s32 T = a2-2*b2*(2*a-1);
+	u32 dT1 = 4*a2;
+	u32 dS1 = dT1+2*a2;
+	s32 dS2 = -4*b2*(a-1);
+	s32 dT2 = dS2+2*b2;
+
+	draw_outer(x, y, x1, y1, pixel);
+	do {
+	    if (S < 0) {
+		S += dS1;
+		T += dT1;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		y1++;
+		draw_outer(x, y, x1, y1, pixel);
+	    } else if (T < 0) {
+		S += dS1+dS2;
+		T += dT1+dT2;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+		y1++;
+		draw_outer(x, y, x1, y1, pixel);
+	    } else {
+		S += dS2;
+		T += dT2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+		if (draw_inner)
+		    draw_inner(x, y, x1, y1, pixel);
+	    }
+	} while (x1 > 0);
+    }
+}
+
+static void do_ellipse_64(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
+			  draw_func_t draw_inner, draw_func_t draw_outer)
 {
     u32 a2 = a*a;
     u32 b2 = b*b;
@@ -314,12 +404,12 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
     if (a <= b) {
 	u32 x1 = 0;
 	u32 y1 = b;
-	int S = a2*(1-2*b)+2*b2;
-	int T = b2-2*a2*(2*b-1);
-	unsigned int dT1 = 4*b2;
-	unsigned int dS1 = dT1+2*b2;
-	int dS2 = -4*a2*(b-1);
-	int dT2 = dS2+2*a2;
+	s64 S = a2*(1-2LL*b)+2LL*b2;
+	s64 T = b2-2LL*a2*(2LL*b-1);
+	u64 dT1 = 4*b2;
+	u64 dS1 = dT1+2*b2;
+	s64 dS2 = -4LL*a2*(b-1);
+	s64 dT2 = dS2+2*a2;
 
 	while (1) {
 	    if (S < 0) {
@@ -356,12 +446,12 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
     } else {
 	u32 x1 = a;
 	u32 y1 = 0;
-	int S = b2*(1-2*a)+2*a2;
-	int T = a2-2*b2*(2*a-1);
-	unsigned int dT1 = 4*a2;
-	unsigned int dS1 = dT1+2*a2;
-	int dS2 = -4*b2*(a-1);
-	int dT2 = dS2+2*b2;
+	s64 S = b2*(1-2LL*a)+2LL*a2;
+	s64 T = a2-2LL*b2*(2LL*a-1);
+	u64 dT1 = 4*a2;
+	u64 dS1 = dT1+2*a2;
+	s64 dS2 = -4LL*b2*(a-1);
+	s64 dT2 = dS2+2*b2;
 
 	draw_outer(x, y, x1, y1, pixel);
 	do {
@@ -395,6 +485,15 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
     }
 }
 
+static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
+		       draw_func_t draw_inner, draw_func_t draw_outer)
+{
+    if ((a + 576) * (b + 576) < 1440000)
+	do_ellipse_32(x, y, a, b, pixel, draw_inner, draw_outer);
+    else
+	do_ellipse_64(x, y, a, b, pixel, draw_inner, draw_outer);
+}
+
 void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 {
     if (a == b)
diff --git a/include/types.h b/include/types.h
index 9112ba6855b61eaa..0e3c76521469912f 100644
--- a/include/types.h
+++ b/include/types.h
@@ -21,6 +21,9 @@ typedef unsigned short u16;
 typedef unsigned int u32;
 typedef unsigned long long u64;
 
+typedef int s32;
+typedef long long s64;
+
 #if defined(__LP64__) || defined(__alpha__) || defined(__ia64__) || \
     defined(__mips64__) || defined(__powerpc64__) || defined(__s390x__) || \
     defined(__sparc64__) || defined(__x86_64__) || defined(__hppa64__)
-- 
2.34.1

