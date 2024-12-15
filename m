Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FEE12DD95
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259878; cv=none; b=dxuzJiohIgP5yf/jjEg9EsHZ+IhP+YsWYgkRapnR7I2ocpfv0vw3munfoAf/6A5aENyLKhn+cOecWcg0g4B2bOJqY225lq7j4WFVabjyuN8b8hcX7iMjqpzKdZeCIcOzuSwoCHq6/REr4VFem5gHIXzMLAij0oO8OqjitHb2zRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259878; c=relaxed/simple;
	bh=39oQ6eKrXrfbE7a6soyOQ3GtZarT7COYWib9oOhqYAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PM4qBDwdLcLno6JVQ4CeSviD+peeDRdrIU3Zp1qSdGRkmAMnDy9Pe7M/AhIjKfBFsENT0zE7ag3X3DE7cc/+cYLp4yk5rKsIWq+jAEuexVJwmC/nXhYsgXASNu21WXnEkYZ384Iiqd6d0V3sjqfvA2v8vORm3Al9OQlclMzeHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4YB08d3Jt5z4wxL6
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 11:45:21 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by michel.telenet-ops.be with cmsmtp
	id oylD2D00j4qjdAp06ylDo0; Sun, 15 Dec 2024 11:45:14 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kk4-Bh;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nmV-P9;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 17/17] util: Use __attribute__
Date: Sun, 15 Dec 2024 11:45:08 +0100
Message-Id: <20241215104508.191237-18-geert@linux-m68k.org>
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

Replace the rare __attribute by the more common __attribute__.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/util.h b/include/util.h
index 5a6b5ab40d383d5a..1433b87b8dbefcfc 100644
--- a/include/util.h
+++ b/include/util.h
@@ -40,7 +40,7 @@ extern void Warning(const char *fmt, ...)
 extern void Error(const char *fmt, ...)
     __attribute__ ((format (printf, 1, 2)));
 extern void Fatal(const char *fmt, ...)
-    __attribute__ ((noreturn)) __attribute ((format (printf, 1, 2)));
+    __attribute__ ((noreturn)) __attribute__ ((format (printf, 1, 2)));
 extern void Debug(const char *fmt, ...)
     __attribute__ ((format (printf, 1, 2)));
 
-- 
2.34.1

