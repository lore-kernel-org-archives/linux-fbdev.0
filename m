Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92312C13D
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259877; cv=none; b=rtjUrvmTKSXcn5wvEZ8Cz2tPsckndu28KvUv0ndoRTmcxIkN7sLLK3ENCUqS0eYqWlimi2Q+l5X4xJmg2JE6D86deDW6tPlTDOLcDwXGvXwGTWCWrUdt48J25+87fCl8XJoRD6HEhvVoIGTAhedUXNhfgL93Wu2LoObpJAeOtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259877; c=relaxed/simple;
	bh=zyj3ShxJQNX6ijMzXKQxlqR8dPw34gmFSlk84FsF/Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7Vjvc2PeFLy/LyNhqYtHL8jazmVBGMFCNE/HR7S7ORYN2JQUQV+Opjlnr1mf4Py221WX5lacRXlyTAKnKWTDE6NEeL5JgufpfKrfBmwa1Y5FUDFYzsLl7bCnbEB3nuZOE7ZHekW8KbonZGaW9c1o0TPv558pF/cMDQbMsv/LXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4YB08d2sBBz4wxL4
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by michel.telenet-ops.be with cmsmtp
	id oylD2D00d4qjdAp06ylDnu; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kjx-9L;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nmI-Nq;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 15/17] test013: Fix off-by-one error in maximum circle calculation
Date: Sun, 15 Dec 2024 11:45:06 +0100
Message-Id: <20241215104508.191237-16-geert@linux-m68k.org>
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

A circle with radius R has an actual diameter of 2*R+1 instead of 2*R.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 tests/test013.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test013.c b/tests/test013.c
index 96fc1cd216b81b0a..25904270901eaded 100644
--- a/tests/test013.c
+++ b/tests/test013.c
@@ -63,10 +63,10 @@ static enum test_res test013_func(void)
 
     while (1)
 	for (i = 0; i < sizeof(sizes)/sizeof(*sizes); i++) {
-	    size = sizes[i];
+	    size = sizes[i] + 1;
 	    if (size > fb_var.xres_virtual || size > fb_var.yres_virtual)
 		goto out;
-	    benchmark_circles(size/2);
+	    benchmark_circles(sizes[i]/2);
 	    sizes[i] *= 10;
 	}
 
-- 
2.34.1

