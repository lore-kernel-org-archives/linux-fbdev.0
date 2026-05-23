Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E427B34E;
	Sat, 23 May 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550511; cv=none; b=fIdT2RnBtwix1EdZQECbSSn4hdo5GMEq+7KOsmkYLqmfyxZA7jmkNvlfPXdNnFxK8IAEyWi14kj7ANqa3CEj0rZdkahbyIuo/baXd0Qnao1t1DusJ+NcUeAFhT8/Sn9JRHX2p8IaNaEkLmjdRJvGWtzR6qeXux6xVVUoKKmk4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550511; c=relaxed/simple;
	bh=YiM3B7nohSUCSAKRM0OX8VymyOaplIsA9wxEbdk9eOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgm/89Mz32F9Q0vO8/gI4BToIx0CU10Gw+sJMmLuo7jHlqJxzY2+bbYdN0rBY786iOR/lHgWisgx0wge0lagYocay3zI/RCR/Usvtcaj5zkwdO5daRLM9tbrrllsOfG1p+q5dTgQsdyrHGuW1AZ0ThHvePSudkYReWrDZVH8r/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=EuXZ+bIO; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="EuXZ+bIO"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 63293C0076;
	Sat, 23 May 2026 18:35:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp) with ESMTPSA id 1ZXKP9PgKKo0-C94JiP7C;
	Sat, 23 May 2026 18:35:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779550506;
	bh=3BDigBGEVC4JTzCnNadCuw8zrWzIKxOvt9uPnvBcMSk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=EuXZ+bIO0YRGuBQSjO63NFrZatud/yXeDu0eS0El4PudTV5eLLZjb9AAPiGvwJoWK
	 qcTrdLZlYTn6pjhdjamea9A5r0Ax8coH7q1BF+81IlUNOoLECXSxKTtoPCJ85h/4zf
	 WDVuP7bt2BKdZA60K6BHqfRJvj2VyfZQ9NvAXC/M=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v2 1/4] staging: sm750fb: remove commented-out forward declarations
Date: Sat, 23 May 2026 15:34:56 +0000
Message-ID: <20260523153459.177488-2-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523153459.177488-1-ahmet@sezginduran.net>
References: <20260523153459.177488-1-ahmet@sezginduran.net>
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
2.53.0

