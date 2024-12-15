Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809B12EBE7
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259525; cv=none; b=YbHz3ue6L0E6oaTv1jtYF85g/7+6pGk41AWYtqc6I4CmO/PgtJ6i2YdeTCZCygaoteRSCJraYkz6bc0nWUXfE90VoPbbK88IOtfO/4zf7Upqyl0LEg9YdWiktudm77C77fkpC6Y1ONkKBky/TmlGTmSVoDJJ7ySvvcbP6sU6T3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259525; c=relaxed/simple;
	bh=uqGcQiJ0YuNKzx4exfxPzynZ3B/NFqehpjdxfOrL/BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/wwofRohDHYXVWoxwn09MekQFilEEA3o4491WUkEO8f1nzDnmyFbztYwm3z3SikF1QyuafZg00G1A9ciJ2Hm2+ngK+SdEtliwlmcYhhON4WcrzB2VjkbSBn4/hSmDFOLFgkXm1E9eFr/A1OnWpRQOkGKs0MKSih724/Gu7cpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by laurent.telenet-ops.be with cmsmtp
	id oylD2D00Z4qjdAp01ylDAj; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kjn-7z;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nmA-Ma;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 13/17] tests: Clear frame buffer before each test
Date: Sun, 15 Dec 2024 11:45:04 +0100
Message-Id: <20241215104508.191237-14-geert@linux-m68k.org>
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

Make sure the frame buffer is cleared before each test, to avoid
leftover artifacts from a previous test.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/fb.h | 1 +
 tests.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/fb.h b/include/fb.h
index 1df4e48311b6c1e9..6506ec120aa962ae 100644
--- a/include/fb.h
+++ b/include/fb.h
@@ -28,6 +28,7 @@ extern int fb_set_cmap(void);
 extern int fb_pan(u32 xoffset, u32 yoffset);
 extern void fb_map(void);
 extern void fb_unmap(void);
+extern void fb_clear(void);
 
 
     /*
diff --git a/tests.c b/tests.c
index b1573032372e8090..22a8a0f489c2bc06 100644
--- a/tests.c
+++ b/tests.c
@@ -78,6 +78,8 @@ static void run_one_test(const struct test *test)
 	}
     }
 
+    fb_clear();
+
     res = test->func();
     switch (res) {
 	case TEST_OK:
-- 
2.34.1

