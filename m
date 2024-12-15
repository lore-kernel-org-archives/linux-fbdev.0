Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FED14A4F9
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259524; cv=none; b=rEDynYVDT7Qn8MijSpoVY23aE0v5GKqj0+YaCAw7n7mYpQ1F+szcRMiMKmnaDUkarvr2REfhC6fYt7cyr7cm1DV1vG+RXkz5fxi8r2KBqJ682fkllhMdWDoT1V6jSxISK97Y4niRn+Qp0D8HSf9joZpQkxPh+8kOORGQhnVqVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259524; c=relaxed/simple;
	bh=h6gTcNt0Kq5jy2CZ1jMUbozvqiXQG7WvxI04IQh5eVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaRbhefj14hGt/GyI0/iMXJn5WTCOe+KcGSKUiEWzFZvU+rqfmP0yfo3mOrCLsc9Hhfp3X6lHzVYP3WA0bHiBizhVu4OzjyyR5LeNxvRsWEQChqJxXKsDRdYfAi5C7Po/7sOsWGhVhnJuOfeBBku0IOUZHUhjN3TE1L5aJnGC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by andre.telenet-ops.be with cmsmtp
	id oylD2D00Y4qjdAp01ylDUQ; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjX-5e;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlr-KG;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 09/17] drawops: Extract do_ellipse()
Date: Sun, 15 Dec 2024 11:45:00 +0100
Message-Id: <20241215104508.191237-10-geert@linux-m68k.org>
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

generic_draw_ellipse() and generic_fill_ellipse() are very similar.
Reimplement them as wrappers around a common helper function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 132 ++++++++++------------------------------------
 1 file changed, 28 insertions(+), 104 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index 471aefe38d43aaa4..b3218f50d86c6d4c 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -292,101 +292,6 @@ static void draw_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     }
 }
 
-void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
-{
-    if (a == b)
-	return draw_circle(x, y, a, pixel);
-
-    u32 a2 = a*a;
-    u32 b2 = b*b;
-
-    if (a <= b) {
-	u32 x1 = 0;
-	u32 y1 = b;
-	int S = a2*(1-2*b)+2*b2;
-	int T = b2-2*a2*(2*b-1);
-	int dT1 = 4*b2;
-	int dS1 = dT1+2*b2;
-	int dS2 = -4*a2*(b-1);
-	int dT2 = dS2+2*a2;
-
-	while (1) {
-	    if (S < 0) {
-		draw_ellipse_points(x, y, x1, y1, pixel);
-		S += dS1;
-		T += dT1;
-		dS1 += 4*b2;
-		dT1 += 4*b2;
-		x1++;
-	    } else if (T < 0) {
-		draw_ellipse_points(x, y, x1, y1, pixel);
-		if (y1 == 0)
-		    break;
-		S += dS1+dS2;
-		T += dT1+dT2;
-		dS1 += 4*b2;
-		dT1 += 4*b2;
-		dS2 += 4*a2;
-		dT2 += 4*a2;
-		x1++;
-		y1--;
-	    } else {
-		draw_ellipse_points(x, y, x1, y1, pixel);
-		if (y1 == 0)
-		    break;
-		S += dS2;
-		T += dT2;
-		dS2 += 4*a2;
-		dT2 += 4*a2;
-		y1--;
-	    }
-	}
-    } else {
-	u32 x1 = a;
-	u32 y1 = 0;
-	int S = b2*(1-2*a)+2*a2;
-	int T = a2-2*b2*(2*a-1);
-	int dT1 = 4*a2;
-	int dS1 = dT1+2*a2;
-	int dS2 = -4*b2*(a-1);
-	int dT2 = dS2+2*b2;
-
-	draw_ellipse_points(x, y, x1, y1, pixel);
-	do {
-	    if (S < 0) {
-		S += dS1;
-		T += dT1;
-		dS1 += 4*a2;
-		dT1 += 4*a2;
-		y1++;
-		draw_ellipse_points(x, y, x1, y1, pixel);
-	    } else if (T < 0) {
-		S += dS1+dS2;
-		T += dT1+dT2;
-		dS1 += 4*a2;
-		dT1 += 4*a2;
-		dS2 += 4*b2;
-		dT2 += 4*b2;
-		x1--;
-		y1++;
-		draw_ellipse_points(x, y, x1, y1, pixel);
-	    } else {
-		S += dS2;
-		T += dT2;
-		dS2 += 4*b2;
-		dT2 += 4*b2;
-		x1--;
-		draw_ellipse_points(x, y, x1, y1, pixel);
-	    }
-	} while (x1 > 0);
-    }
-}
-
-
-    /*
-     *  Draw a filled ellipse
-     */
-
 static void fill_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
 {
     if (x == 0) {
@@ -400,11 +305,9 @@ static void fill_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     }
 }
 
-void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
+static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
+		       draw_func_t draw_inner, draw_func_t draw_outer)
 {
-    if (a == b)
-	return fill_circle(x, y, a, pixel);
-
     u32 a2 = a*a;
     u32 b2 = b*b;
 
@@ -420,13 +323,15 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 
 	while (1) {
 	    if (S < 0) {
+		if (draw_inner)
+		    draw_inner(x, y, x1, y1, pixel);
 		S += dS1;
 		T += dT1;
 		dS1 += 4*b2;
 		dT1 += 4*b2;
 		x1++;
 	    } else if (T < 0) {
-		fill_ellipse_points(x, y, x1, y1, pixel);
+		draw_outer(x, y, x1, y1, pixel);
 		if (y1 == 0)
 		    break;
 		S += dS1+dS2;
@@ -438,7 +343,7 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		x1++;
 		y1--;
 	    } else {
-		fill_ellipse_points(x, y, x1, y1, pixel);
+		draw_outer(x, y, x1, y1, pixel);
 		if (y1 == 0)
 		    break;
 		S += dS2;
@@ -458,7 +363,7 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 	int dS2 = -4*b2*(a-1);
 	int dT2 = dS2+2*b2;
 
-	fill_ellipse_points(x, y, x1, y1, pixel);
+	draw_outer(x, y, x1, y1, pixel);
 	do {
 	    if (S < 0) {
 		S += dS1;
@@ -466,7 +371,7 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		dS1 += 4*a2;
 		dT1 += 4*a2;
 		y1++;
-		fill_ellipse_points(x, y, x1, y1, pixel);
+		draw_outer(x, y, x1, y1, pixel);
 	    } else if (T < 0) {
 		S += dS1+dS2;
 		T += dT1+dT2;
@@ -476,18 +381,37 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		dT2 += 4*b2;
 		x1--;
 		y1++;
-		fill_ellipse_points(x, y, x1, y1, pixel);
+		draw_outer(x, y, x1, y1, pixel);
 	    } else {
 		S += dS2;
 		T += dT2;
 		dS2 += 4*b2;
 		dT2 += 4*b2;
 		x1--;
+		if (draw_inner)
+		    draw_inner(x, y, x1, y1, pixel);
 	    }
 	} while (x1 > 0);
     }
 }
 
+void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
+{
+    if (a == b)
+	draw_circle(x, y, a, pixel);
+    else
+	do_ellipse(x, y, a, b, pixel, draw_ellipse_points,
+		   draw_ellipse_points);
+}
+
+void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
+{
+    if (a == b)
+	fill_circle(x, y, a, pixel);
+    else
+	do_ellipse(x, y, a, b, pixel, NULL, fill_ellipse_points);
+}
+
 
     /*
      *  Copy a rectangular area
-- 
2.34.1

