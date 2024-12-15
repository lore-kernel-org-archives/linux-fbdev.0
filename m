Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2E14D2BD
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260003; cv=none; b=AnnbVv/rIfZqF5+VsWol0MS6OsBFSVJBEivbww7dDFWHigpd9YY9edXjwSZ1jDtZyju4NKE5BDccsGWMHzXq1yZXO0x2EnvFXEmT655cPFk1q0Sv0u6h2budfaew6A9Y2xdhmXMlXED3vqH8SEDNfkFqgixDGTePnxSayECm15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260003; c=relaxed/simple;
	bh=RiSYV2u/rXGtvrBA9gxQ450GsKzspJ1QWTJ+kPHzw84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cco0wGymq10L6i2KJ5Pk7gNxH7VVRac1hJtLffU2VXnPRr3ZAJy8u/9rhhtybyJwXkarrw02KXXlPYHZm1dBALlqOrQFbNxBR58JuzchI/Ndqd6H/TCn0dpVQ5lVSW7nQiWGh710jidF/Ji1oZAqmVsE8SZDVzEIsVG39uuuSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4YB08d3KMyz4wwsB
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by xavier.telenet-ops.be with cmsmtp
	id oylD2D00P4qjdAp01ylDEm; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjT-51;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlm-Jd;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 08/17] drawops: Return early in generic_{draw,fill}_ellipse()
Date: Sun, 15 Dec 2024 11:44:59 +0100
Message-Id: <20241215104508.191237-9-geert@linux-m68k.org>
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

This reduces indentation in the largest branches.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 324 +++++++++++++++++++++++-----------------------
 1 file changed, 162 insertions(+), 162 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index 4b64c20cc0fe68bc..471aefe38d43aaa4 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -295,90 +295,90 @@ static void draw_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
 void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 {
     if (a == b)
-	draw_circle(x, y, a, pixel);
-    else {
-	u32 a2 = a*a;
-	u32 b2 = b*b;
-	if (a <= b) {
-	    u32 x1 = 0;
-	    u32 y1 = b;
-	    int S = a2*(1-2*b)+2*b2;
-	    int T = b2-2*a2*(2*b-1);
-	    int dT1 = 4*b2;
-	    int dS1 = dT1+2*b2;
-	    int dS2 = -4*a2*(b-1);
-	    int dT2 = dS2+2*a2;
-
-	    while (1) {
-		if (S < 0) {
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		    S += dS1;
-		    T += dT1;
-		    dS1 += 4*b2;
-		    dT1 += 4*b2;
-		    x1++;
-		} else if (T < 0) {
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		    if (y1 == 0)
-			break;
-		    S += dS1+dS2;
-		    T += dT1+dT2;
-		    dS1 += 4*b2;
-		    dT1 += 4*b2;
-		    dS2 += 4*a2;
-		    dT2 += 4*a2;
-		    x1++;
-		    y1--;
-		} else {
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		    if (y1 == 0)
-			break;
-		    S += dS2;
-		    T += dT2;
-		    dS2 += 4*a2;
-		    dT2 += 4*a2;
-		    y1--;
-		}
+	return draw_circle(x, y, a, pixel);
+
+    u32 a2 = a*a;
+    u32 b2 = b*b;
+
+    if (a <= b) {
+	u32 x1 = 0;
+	u32 y1 = b;
+	int S = a2*(1-2*b)+2*b2;
+	int T = b2-2*a2*(2*b-1);
+	int dT1 = 4*b2;
+	int dS1 = dT1+2*b2;
+	int dS2 = -4*a2*(b-1);
+	int dT2 = dS2+2*a2;
+
+	while (1) {
+	    if (S < 0) {
+		draw_ellipse_points(x, y, x1, y1, pixel);
+		S += dS1;
+		T += dT1;
+		dS1 += 4*b2;
+		dT1 += 4*b2;
+		x1++;
+	    } else if (T < 0) {
+		draw_ellipse_points(x, y, x1, y1, pixel);
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
+		draw_ellipse_points(x, y, x1, y1, pixel);
+		if (y1 == 0)
+		    break;
+		S += dS2;
+		T += dT2;
+		dS2 += 4*a2;
+		dT2 += 4*a2;
+		y1--;
 	    }
-	} else {
-	    u32 x1 = a;
-	    u32 y1 = 0;
-            int S = b2*(1-2*a)+2*a2;
-            int T = a2-2*b2*(2*a-1);
-            int dT1 = 4*a2;
-            int dS1 = dT1+2*a2;
-            int dS2 = -4*b2*(a-1);
-            int dT2 = dS2+2*b2;
-
-	    draw_ellipse_points(x, y, x1, y1, pixel);
-	    do {
-		if (S < 0) {
-		    S += dS1;
-		    T += dT1;
-		    dS1 += 4*a2;
-		    dT1 += 4*a2;
-		    y1++;
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		} else if (T < 0) {
-		    S += dS1+dS2;
-		    T += dT1+dT2;
-		    dS1 += 4*a2;
-		    dT1 += 4*a2;
-		    dS2 += 4*b2;
-		    dT2 += 4*b2;
-		    x1--;
-		    y1++;
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		} else {
-		    S += dS2;
-		    T += dT2;
-		    dS2 += 4*b2;
-		    dT2 += 4*b2;
-		    x1--;
-		    draw_ellipse_points(x, y, x1, y1, pixel);
-		}
-	    } while (x1 > 0);
 	}
+    } else {
+	u32 x1 = a;
+	u32 y1 = 0;
+	int S = b2*(1-2*a)+2*a2;
+	int T = a2-2*b2*(2*a-1);
+	int dT1 = 4*a2;
+	int dS1 = dT1+2*a2;
+	int dS2 = -4*b2*(a-1);
+	int dT2 = dS2+2*b2;
+
+	draw_ellipse_points(x, y, x1, y1, pixel);
+	do {
+	    if (S < 0) {
+		S += dS1;
+		T += dT1;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		y1++;
+		draw_ellipse_points(x, y, x1, y1, pixel);
+	    } else if (T < 0) {
+		S += dS1+dS2;
+		T += dT1+dT2;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+		y1++;
+		draw_ellipse_points(x, y, x1, y1, pixel);
+	    } else {
+		S += dS2;
+		T += dT2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+		draw_ellipse_points(x, y, x1, y1, pixel);
+	    }
+	} while (x1 > 0);
     }
 }
 
@@ -403,88 +403,88 @@ static void fill_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
 void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 {
     if (a == b)
-	fill_circle(x, y, a, pixel);
-    else {
-	u32 a2 = a*a;
-	u32 b2 = b*b;
-	if (a <= b) {
-	    u32 x1 = 0;
-	    u32 y1 = b;
-	    int S = a2*(1-2*b)+2*b2;
-	    int T = b2-2*a2*(2*b-1);
-	    int dT1 = 4*b2;
-	    int dS1 = dT1+2*b2;
-	    int dS2 = -4*a2*(b-1);
-	    int dT2 = dS2+2*a2;
-
-	    while (1) {
-		if (S < 0) {
-		    S += dS1;
-		    T += dT1;
-		    dS1 += 4*b2;
-		    dT1 += 4*b2;
-		    x1++;
-		} else if (T < 0) {
-		    fill_ellipse_points(x, y, x1, y1, pixel);
-		    if (y1 == 0)
-			break;
-		    S += dS1+dS2;
-		    T += dT1+dT2;
-		    dS1 += 4*b2;
-		    dT1 += 4*b2;
-		    dS2 += 4*a2;
-		    dT2 += 4*a2;
-		    x1++;
-		    y1--;
-		} else {
-		    fill_ellipse_points(x, y, x1, y1, pixel);
-		    if (y1 == 0)
-			break;
-		    S += dS2;
-		    T += dT2;
-		    dS2 += 4*a2;
-		    dT2 += 4*a2;
-		    y1--;
-		}
+	return fill_circle(x, y, a, pixel);
+
+    u32 a2 = a*a;
+    u32 b2 = b*b;
+
+    if (a <= b) {
+	u32 x1 = 0;
+	u32 y1 = b;
+	int S = a2*(1-2*b)+2*b2;
+	int T = b2-2*a2*(2*b-1);
+	int dT1 = 4*b2;
+	int dS1 = dT1+2*b2;
+	int dS2 = -4*a2*(b-1);
+	int dT2 = dS2+2*a2;
+
+	while (1) {
+	    if (S < 0) {
+		S += dS1;
+		T += dT1;
+		dS1 += 4*b2;
+		dT1 += 4*b2;
+		x1++;
+	    } else if (T < 0) {
+		fill_ellipse_points(x, y, x1, y1, pixel);
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
+		fill_ellipse_points(x, y, x1, y1, pixel);
+		if (y1 == 0)
+		    break;
+		S += dS2;
+		T += dT2;
+		dS2 += 4*a2;
+		dT2 += 4*a2;
+		y1--;
 	    }
-	} else {
-	    u32 x1 = a;
-	    u32 y1 = 0;
-            int S = b2*(1-2*a)+2*a2;
-            int T = a2-2*b2*(2*a-1);
-            int dT1 = 4*a2;
-            int dS1 = dT1+2*a2;
-            int dS2 = -4*b2*(a-1);
-            int dT2 = dS2+2*b2;
-
-	    fill_ellipse_points(x, y, x1, y1, pixel);
-	    do {
-		if (S < 0) {
-		    S += dS1;
-		    T += dT1;
-		    dS1 += 4*a2;
-		    dT1 += 4*a2;
-		    y1++;
-		    fill_ellipse_points(x, y, x1, y1, pixel);
-		} else if (T < 0) {
-		    S += dS1+dS2;
-		    T += dT1+dT2;
-		    dS1 += 4*a2;
-		    dT1 += 4*a2;
-		    dS2 += 4*b2;
-		    dT2 += 4*b2;
-		    x1--;
-		    y1++;
-		    fill_ellipse_points(x, y, x1, y1, pixel);
-		} else {
-		    S += dS2;
-		    T += dT2;
-		    dS2 += 4*b2;
-		    dT2 += 4*b2;
-		    x1--;
-		}
-	    } while (x1 > 0);
 	}
+    } else {
+	u32 x1 = a;
+	u32 y1 = 0;
+	int S = b2*(1-2*a)+2*a2;
+	int T = a2-2*b2*(2*a-1);
+	int dT1 = 4*a2;
+	int dS1 = dT1+2*a2;
+	int dS2 = -4*b2*(a-1);
+	int dT2 = dS2+2*b2;
+
+	fill_ellipse_points(x, y, x1, y1, pixel);
+	do {
+	    if (S < 0) {
+		S += dS1;
+		T += dT1;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		y1++;
+		fill_ellipse_points(x, y, x1, y1, pixel);
+	    } else if (T < 0) {
+		S += dS1+dS2;
+		T += dT1+dT2;
+		dS1 += 4*a2;
+		dT1 += 4*a2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+		y1++;
+		fill_ellipse_points(x, y, x1, y1, pixel);
+	    } else {
+		S += dS2;
+		T += dT2;
+		dS2 += 4*b2;
+		dT2 += 4*b2;
+		x1--;
+	    }
+	} while (x1 > 0);
     }
 }
 
-- 
2.34.1

