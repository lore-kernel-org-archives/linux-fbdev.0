Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C73DEAD6;
	Mon, 25 May 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699727; cv=none; b=oiu5cLOGNlq8EzEcqLEQG0hCrhYIsz1qp98h1octFbYh5KKILYAopnxKkmuhrOtrGEqWXYpPsZ/gVjbzhW6AOaMC4E0UnVW8ibOdDkPre0jkZAh8smUD52fLWiARNNfIF9arw7ebLn+jINPGZDg9m7NCPiccu0XKQltIalT5uA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699727; c=relaxed/simple;
	bh=Di6ibABpARxJN4ZZwf5FABaY0H9wWb22U9iDf+YEuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J12e9hIdCoZzZEoqhbq1YPA6qFP2V17v79sCuqw5iOU3+RvPBt95Ovb8ob52IHcSyE7qfl0J/d6QQxubPNtHlQ0j3N4cpIEaTeDnELGM4grE+s38r7PserSzBEJJdGHu6yREkp3ZouaySqjirHkTpETF27qtEKCTCPMHUEYzzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=BgPt5ehw; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="BgPt5ehw"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 673E7C006D;
	Mon, 25 May 2026 12:01:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id m1TmE1aggiE0-151w8OVQ;
	Mon, 25 May 2026 12:01:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779699714;
	bh=2ZoiQpFopaWvdiWpWI/Ri4/uAAd0/TLSBl8SwvS4+XI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=BgPt5ehw8friqH91cLDhN6ecmKXUFy3s4gAlJFcCKwUK5U8Z0yTrfcuci1AZ22ego
	 zAbWg4nsKMyhZWpdrSLc0JDKqTaxFZZg1ZaZUjSOjHKCOx8x5TTs/L43k2gu4J0W7v
	 poNAXwthn4Q2bTmEr0SjDSEe64PffU3+2d30L5C0=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v3 1/4] staging: sm750fb: remove commented-out forward declarations
Date: Mon, 25 May 2026 08:58:05 +0000
Message-ID: <20260525085808.171974-2-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525085808.171974-1-ahmet@sezginduran.net>
References: <20260525085808.171974-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block at the top of sm750.c declares lynxfb_ops_write() and
lynxfb_ops_read() inside a commented-out #ifdef __BIG_ENDIAN guard.
Neither function is defined anywhere in the driver, so the block
is dead. Remove it.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
v3: No changes.
v2: No changes.

 drivers/staging/sm750fb/sm750.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..02db1418476b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -8,15 +8,6 @@
 #include "sm750_accel.h"
 #include "sm750_cursor.h"
 
-/*
- * #ifdef __BIG_ENDIAN
- * ssize_t lynxfb_ops_write(struct fb_info *info, const char __user *buf,
- * size_t count, loff_t *ppos);
- * ssize_t lynxfb_ops_read(struct fb_info *info, char __user *buf,
- * size_t count, loff_t *ppos);
- * #endif
- */
-
 /* common var for all device */
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
-- 
2.54.0

