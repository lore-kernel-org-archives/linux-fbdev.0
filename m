Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DB1494A8
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259525; cv=none; b=LOt/QbVf8Uq0qNhVWB08uunHgG2Rritp43Hp48CcXhQharo15XZAi0orjB+l1/5ZqWI6jazV/UyuQHU2PBiPaFUwgd8zZ4LNQAqpKpdQLnZ4F+gr2JAszQwzx0FGpO4eOAlCgjahuYfhjjXKF1/5tjkyHt2S/V8wuzX3t6PMcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259525; c=relaxed/simple;
	bh=0dbe42JMI18o2S+1bATwPcLi67ZrJlFvinIYsXH026k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D2hH2V8CmbBRC5u8rncB+IgjKJdqs6L7U2SIzl+f/MMQgopcycQFWYy/vnXKk6ix5c7PJYA9/qpb6FKYTLUR93Yx6OvJsnYsoFEtgf3IplkK+mJiXdakIkh01HEMSeKRGyRcDWqX28qaE4k8ZzzmMiNpLQQNGg3kauGb77WLiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by laurent.telenet-ops.be with cmsmtp
	id oylD2D00N4qjdAp01ylDAY; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kj5-0r;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlL-FK;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 02/17] tests: Print test description in debug mode
Date: Sun, 15 Dec 2024 11:44:53 +0100
Message-Id: <20241215104508.191237-3-geert@linux-m68k.org>
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

Print not only the test name, but also the test description.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests.c b/tests.c
index c92236f869f41594..b1573032372e8090 100644
--- a/tests.c
+++ b/tests.c
@@ -55,7 +55,7 @@ static void run_one_test(const struct test *test)
 {
     enum test_res res;
 
-    Debug("Running test %s\n", test->name);
+    Debug("Running test %s (%s)\n", test->name, test->desc);
 
     if (test->visual != VISUAL_NONE && !visual_set(test->visual)) {
 	Debug("Visual %d not supported\n", test->visual);
-- 
2.34.1

