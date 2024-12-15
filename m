Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D214D2BD
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259525; cv=none; b=ApBQgmVdS6g7fxqADf0pvSid7AtSZgGKQfdVWfajL4nLN3s8YiTvoEZFmCLUKd0DcosYFZr/Rqpq6Uxi456PTd42x41tn1qY2/CmEuib2p0FVy6dDoGlJgHb6aw1fT5SDjudMW5K8Z1nBPooPwZwrYr7hbA5zkPNy/VCSOAifRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259525; c=relaxed/simple;
	bh=ckgLCKZhlosLPfVF6woguPYpvmGpa8ywmnfGusgamBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SncAyOqsa4HM8zKYdqOtw787tcUbmlztYhj9tqFGt+J1D4vGIUNFAB/sJR4Z11Hh984/8JD9WWigt051F4+j5T/+4Oa/U+PcwxCgBjhbEo34UyWVYCTwtXAYJcxuPgZNgJfsRLf/LRXLdd1iMDsXKq9flTH9Y/A8RbOs+PdB8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by albert.telenet-ops.be with cmsmtp
	id oylD2D00T4qjdAp06ylDsd; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjF-2m;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlT-GX;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 04/17] drawops: Extract do_circle()
Date: Sun, 15 Dec 2024 11:44:55 +0100
Message-Id: <20241215104508.191237-5-geert@linux-m68k.org>
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

generic_draw_circle() and generic_fill_circle() are very similar.
Reimplement them as wrappers around a common helper function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 51 +++++++++++++++++------------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index b2543b877a3a6154..9fd8aafb69a868a2 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -209,35 +209,6 @@ static void draw_circle_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     }
 }
 
-void generic_draw_circle(u32 x, u32 y, u32 r, pixel_t pixel)
-{
-    u32 x1 = 0;
-    u32 y1 = r;
-    int d = 1-r;
-    int de = 3;
-    int dse = -2*r+5;
-
-    do {
-	draw_circle_points(x, y, x1, y1, pixel);
-	if (d < 0) {	// Select E
-	    d += de;
-	    de += 2;
-	    dse += 2;
-	} else {	// Select SE
-	    d += dse;
-	    de += 2;
-	    dse += 4;
-	    y1--;
-	}
-	x1++;
-    } while (x1 <= y1);
-}
-
-
-    /*
-     *  Draw a filled circle
-     */
-
 static void fill_circle_points_x(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
 {
     if (x == 0) {
@@ -259,7 +230,10 @@ static void fill_circle_points_y(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     }
 }
 
-void generic_fill_circle(u32 x, u32 y, u32 r, pixel_t pixel)
+typedef void (*draw_func_t)(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel);
+
+static void do_circle(u32 x, u32 y, u32 r, pixel_t pixel, draw_func_t draw_x,
+		      draw_func_t draw_y)
 {
     u32 x1 = 0;
     u32 y1 = r;
@@ -268,7 +242,7 @@ void generic_fill_circle(u32 x, u32 y, u32 r, pixel_t pixel)
     int dse = -2*r+5;
 
     do {
-	fill_circle_points_y(x, y, x1, y1, pixel);
+	draw_y(x, y, x1, y1, pixel);
 	if (d < 0) {	// Select E
 	    d += de;
 	    de += 2;
@@ -277,14 +251,25 @@ void generic_fill_circle(u32 x, u32 y, u32 r, pixel_t pixel)
 	    d += dse;
 	    de += 2;
 	    dse += 4;
-	    if (x1 != y1)
-		fill_circle_points_x(x, y, x1, y1, pixel);
+	    if (draw_x && x1 != y1)
+		draw_x(x, y, x1, y1, pixel);
 	    y1--;
 	}
 	x1++;
     } while (x1 <= y1);
 }
 
+void generic_draw_circle(u32 x, u32 y, u32 r, pixel_t pixel)
+{
+    do_circle(x, y, r, pixel, NULL, draw_circle_points);
+}
+
+
+void generic_fill_circle(u32 x, u32 y, u32 r, pixel_t pixel)
+{
+    do_circle(x, y, r, pixel, fill_circle_points_x, fill_circle_points_y);
+}
+
 
     /*
      *  Draw an ellipse using a differential version of the Bresenham algorithm
-- 
2.34.1

