Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C801C13D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259992; cv=none; b=kOtFj60TdUlkb4Xcop8a6KJDdflao2eY7lWeMPlnD/Lna8ILv3KxrqT6lqJl4oMFmIBUSTRXnemq1tAzppJyGKMcMZojPR/Q2dMdtivCpsHff0R87ajXo7qobsc/JxUI2j9zu+BSlBSiVJVVxMQiegBJ277NR9F5FKze2+izLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259992; c=relaxed/simple;
	bh=Zi84ZlNKfGwmW6Vmr/as83nRkDAii5SOWttr8XntV8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRwlAhyELjnkL3ZeIMRGlL56hRT0rFtd5mbhtkpFsbYbKrURj6FFiahXGuwP03OivLpp7qELCgS3n3kE2izr1RolAlToWdcVUR563t75elB5kBbLRHSjt0EnShICmc1qjCyigZfhgrzDtDBmrjC8Q03Qxbf/1CH6EQF4WiVBAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2lp6z4wwxQ
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by michel.telenet-ops.be with cmsmtp
	id oylD2D00X4qjdAp06ylDnq; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjZ-6H;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlw-Kr;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 10/17] drawops: Make de in do_circle() unsigned
Date: Sun, 15 Dec 2024 11:45:01 +0100
Message-Id: <20241215104508.191237-11-geert@linux-m68k.org>
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

"de" is never negative, so it should be unsigned.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index b3218f50d86c6d4c..5c068e10d28fbdfe 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -238,7 +238,7 @@ static void do_circle(u32 x, u32 y, u32 r, pixel_t pixel, draw_func_t draw_x,
     u32 x1 = 0;
     u32 y1 = r;
     int d = 1-r;
-    int de = 3;
+    unsigned int de = 3;
     int dse = -2*r+5;
 
     do {
-- 
2.34.1

