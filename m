Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F27139D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259877; cv=none; b=So3fwFK4WgAmg5WOQ+raV9DWIMKRhPdNWZ6ZwBlVc8/L6qoOC0Da/V2Jq8Ycs+PJpSj/KIyhD6D1uwaMcznpYSwGSS/3/JG4+i1klGMdhvJg1KSXC+pjxShcTuXDYNf1vLahM2EiQDu09ufSKRtOhrpFCGxfDPZdtvwHFZYBNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259877; c=relaxed/simple;
	bh=xa/5Pvv+6jmIZuNlaDgSnuHxLFolDf+phO1ADj2xxTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8nBkMkvRUt0NYjQ/uLU8+OZZnhr6pSuNoeJOBvNElbCgsknaGW1S+RYXz+VsQTPDartDmbNqtudkkh1UQw5ANEuC3QauYZ5OK7QVxWP6tYuhaJcG/rri4+9FaehFpXitTr5WjVNNDrJ7fpSMG/3x/Ki6eXiRJSVHlZuCTAOkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2kHqz4wxK5
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by baptiste.telenet-ops.be with cmsmtp
	id oylD2D00U4qjdAp01ylDMH; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjR-4T;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nli-J3;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 07/17] drawops: Refactor generic_draw_ellipse()
Date: Sun, 15 Dec 2024 11:44:58 +0100
Message-Id: <20241215104508.191237-8-geert@linux-m68k.org>
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

Make generic_draw_ellipse() more similar to generic_fill_ellipse().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index e81dea1ba23d6595..4b64c20cc0fe68bc 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -309,15 +309,18 @@ void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 	    int dS2 = -4*a2*(b-1);
 	    int dT2 = dS2+2*a2;
 
-	    draw_ellipse_points(x, y, x1, y1, pixel);
-	    do {
+	    while (1) {
 		if (S < 0) {
+		    draw_ellipse_points(x, y, x1, y1, pixel);
 		    S += dS1;
 		    T += dT1;
 		    dS1 += 4*b2;
 		    dT1 += 4*b2;
 		    x1++;
 		} else if (T < 0) {
+		    draw_ellipse_points(x, y, x1, y1, pixel);
+		    if (y1 == 0)
+			break;
 		    S += dS1+dS2;
 		    T += dT1+dT2;
 		    dS1 += 4*b2;
@@ -327,14 +330,16 @@ void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		    x1++;
 		    y1--;
 		} else {
+		    draw_ellipse_points(x, y, x1, y1, pixel);
+		    if (y1 == 0)
+			break;
 		    S += dS2;
 		    T += dT2;
 		    dS2 += 4*a2;
 		    dT2 += 4*a2;
 		    y1--;
 		}
-		draw_ellipse_points(x, y, x1, y1, pixel);
-	    } while (y1 > 0);
+	    }
 	} else {
 	    u32 x1 = a;
 	    u32 y1 = 0;
@@ -353,6 +358,7 @@ void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		    dS1 += 4*a2;
 		    dT1 += 4*a2;
 		    y1++;
+		    draw_ellipse_points(x, y, x1, y1, pixel);
 		} else if (T < 0) {
 		    S += dS1+dS2;
 		    T += dT1+dT2;
@@ -362,14 +368,15 @@ void generic_draw_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		    dT2 += 4*b2;
 		    x1--;
 		    y1++;
+		    draw_ellipse_points(x, y, x1, y1, pixel);
 		} else {
 		    S += dS2;
 		    T += dT2;
 		    dS2 += 4*b2;
 		    dT2 += 4*b2;
 		    x1--;
+		    draw_ellipse_points(x, y, x1, y1, pixel);
 		}
-		draw_ellipse_points(x, y, x1, y1, pixel);
 	    } while (x1 > 0);
 	}
     }
-- 
2.34.1

