Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9AB1494D8
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259877; cv=none; b=PqMdBOU9vtACczNaxrtgJLbuRKN7tvML3HAqinHBT6Ub1SK9BLjq9ZFlOzLNKAHhTZF3XfZymZEQqGwDQ9xBqdcizPZGgSTVnLe8VUSvtay3fhbw/J7QDhoBuUbwdIY1xjExmbzUEE5Zuzna0MYoRbRgE/G4xjD5VCqUo2K3bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259877; c=relaxed/simple;
	bh=Ki95VsDGPnVdCe6KW17Ff1vZgtvjH5m/lJTod8Jdr0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXLP20S5enBOrsMdtVIej4ed/CPsnMimvSCiy/UHwKs8mCr2ZjHNVqzayUE1QIlft+S2IRcTw5vhRfiMKarcHLTBJ93oTgCRqv1xWlMZfB0JvfQOWzOF4XnfC/JbIV2YbjDGTlTc1toTnZp9U49H7cWvKiGuQv2f8Sj5SZYmz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4YB08d3PlMz4wxLF
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by michel.telenet-ops.be with cmsmtp
	id oylD2D00T4qjdAp06ylDnj; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001KjA-2Q;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlP-Ft;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 03/17] Test002: Fix test description
Date: Sun, 15 Dec 2024 11:44:54 +0100
Message-Id: <20241215104508.191237-4-geert@linux-m68k.org>
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

The test does not draw circles, but ellipses.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 tests/test002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test002.c b/tests/test002.c
index 8f7cab0537535fcb..e24f0b3c629cf369 100644
--- a/tests/test002.c
+++ b/tests/test002.c
@@ -49,7 +49,7 @@ static enum test_res test002_func(void)
 
 const struct test test002 = {
     .name =	"test002",
-    .desc =	"Draw a grid and some circles",
+    .desc =	"Draw a grid and some ellipses",
     .visual =	VISUAL_MONO,
     .func =	test002_func,
 };
-- 
2.34.1

