Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF78BE5
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259526; cv=none; b=NMIALN530ESlkq5S/tHUVKY6XeDtk34OsGWs74YzPddd6uWCul/Yk+XzO4kaWnDSIpgv6rHBS6vnyNIQ6/ACruqWtPmL0BjS1Ax7Xj0IiZu+Ycw61VuP74DgZBQb8vBwe3B6Xjg8NeDnjXXRvVL74/YyvQNEqR0o7VJ3u+NA6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259526; c=relaxed/simple;
	bh=xnfxFYhkZY7KQ5iXeY1f39w5olq7txFZ2Nl2KlnICCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evlmHb/p1e2w4/qIGZ6AHhNyUqd2xcB+Vi4G0khbYKE/iYih9P/FcWkwtll9GAEAYUWYxfrrGlsCJszeyMuY9SJUE5WlXgQtPQ3rUrJPLYgQoY62aZ4C9G0XK+12v5VW+xrsvYNJoZ4JcuN+/muYx0vCosEyR8izJ17augqToG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by laurent.telenet-ops.be with cmsmtp
	id oylD2D00X4qjdAp01ylDAh; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kjb-6o;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nm1-LR;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 11/17] drawops: Make dT1 and dS1 in do_ellipse() unsigned
Date: Sun, 15 Dec 2024 11:45:02 +0100
Message-Id: <20241215104508.191237-12-geert@linux-m68k.org>
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

"dT1" and "dS1" are never negative, so they should be unsigned.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index 5c068e10d28fbdfe..5fd971b59bc698fe 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -316,8 +316,8 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
 	u32 y1 = b;
 	int S = a2*(1-2*b)+2*b2;
 	int T = b2-2*a2*(2*b-1);
-	int dT1 = 4*b2;
-	int dS1 = dT1+2*b2;
+	unsigned int dT1 = 4*b2;
+	unsigned int dS1 = dT1+2*b2;
 	int dS2 = -4*a2*(b-1);
 	int dT2 = dS2+2*a2;
 
@@ -358,8 +358,8 @@ static void do_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel,
 	u32 y1 = 0;
 	int S = b2*(1-2*a)+2*a2;
 	int T = a2-2*b2*(2*a-1);
-	int dT1 = 4*a2;
-	int dS1 = dT1+2*a2;
+	unsigned int dT1 = 4*a2;
+	unsigned int dS1 = dT1+2*a2;
 	int dS2 = -4*b2*(a-1);
 	int dT2 = dS2+2*b2;
 
-- 
2.34.1

