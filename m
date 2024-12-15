Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85212DD95
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259993; cv=none; b=b1P2ZydEPxUHmzDAUvsZt/8NTMUi1nB5A3eRpNN5GSZQFH9fL6y8FSjc4eQCp4GicZOzgdSNIRQW3fbT7Fc9PNIdo22V5uicA/QwJmEpDE+dQdu7Bsm50p/KwuKGFogVnw/Kt1v8zkErM4vyQ/lerCNVonWDzV8NmrsnZp3OXNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259993; c=relaxed/simple;
	bh=pprltnKf/0+GmnJpn7dCFkr63bC2wJJ+2CpKRtD9PvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ar+Rep9c23+Nwzy2r8iTBCDfGT+hFRetn9d5VxcsyE0GA5cwYNW+1K5TjezdnE+h0xWgCbANftIllDSFA0uK2ZxQ9pIYBgvTLNRNJo055x1Os6yJVMMiIM6bLEELqpPpGebVa/8QuB6oqMeAR9/pJd9IryHifI9KUOlcgjiirSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2rd0z4wx6m
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by baptiste.telenet-ops.be with cmsmtp
	id oylD2D00R4qjdAp01ylDME; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjJ-3K;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlX-Hm;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 05/17] drawops: Use "y == 0" in draw_ellipse_points()
Date: Sun, 15 Dec 2024 11:44:56 +0100
Message-Id: <20241215104508.191237-6-geert@linux-m68k.org>
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

Replace the rare "0 == y" check by the more common "y == 0" check.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index 9fd8aafb69a868a2..ba8154b7ee34ca18 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -281,7 +281,7 @@ static void draw_ellipse_points(u32 cx, u32 cy, u32 x, u32 y, pixel_t pixel)
     if (x == 0) {
 	set_pixel(cx, cy-y, pixel);
 	set_pixel(cx, cy+y, pixel);
-    } else if (0 == y) {
+    } else if (y == 0) {
 	set_pixel(cx-x, cy, pixel);
 	set_pixel(cx+x, cy, pixel);
     } else {
-- 
2.34.1

