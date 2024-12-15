Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA012DD95
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734260003; cv=none; b=uI22W/FuDWLSNMMGxOkVfJfRrAszhra94nJOZZON2InPW9vwhq6BfxP6urQ6F4IkWsDJ1v9yQ8Gry1qhvfkNa8n4FcIWaD/rsOH1Z9Jrt2PJ0UIyo/nEZ2XRXGf9XUiXZimBeiLrL+wffu8+xITibkMW5J1jK5wjfOTiq7dr4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734260003; c=relaxed/simple;
	bh=gWOlCwo033U3BeyaBw8VE5a5osE6PQ6ubCLjTkchrbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUPwHcxRMX/Rds5+qkt9iQBEQd1N+XJM+WCCcp4TNvG1kKcN3MumD/6wx1v+PLNT8VhbocuIkr4FhsXt67xEFlhx9dDO/kH6Vq4vJRPy4HcTodjpzMPBsShBokElF6puPw/wD0aZK629plBKGC0w4hiJBIitCTtgTUq7jHtxh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2zf7z4wwhR
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by baptiste.telenet-ops.be with cmsmtp
	id oylD2D00S4qjdAp01ylDMF; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjM-3n;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nle-IR;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 06/17] drawops: Remove always-false check in generic_fill_ellipse()
Date: Sun, 15 Dec 2024 11:44:57 +0100
Message-Id: <20241215104508.191237-7-geert@linux-m68k.org>
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

x1 is u32, so it can never be negative.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drawops/generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drawops/generic.c b/drawops/generic.c
index ba8154b7ee34ca18..e81dea1ba23d6595 100644
--- a/drawops/generic.c
+++ b/drawops/generic.c
@@ -467,8 +467,6 @@ void generic_fill_ellipse(u32 x, u32 y, u32 a, u32 b, pixel_t pixel)
 		    dS2 += 4*b2;
 		    dT2 += 4*b2;
 		    x1--;
-		    if (x1 < 0)
-			break;
 		    y1++;
 		    fill_ellipse_points(x, y, x1, y1, pixel);
 		} else {
-- 
2.34.1

