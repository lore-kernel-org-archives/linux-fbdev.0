Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0A35E1B6;
	Mon, 22 Jun 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110972; cv=none; b=Am3mJylxR24J7NfZNVnFu1/SYHoFoHdCwuKkTtojg1lwfn6C621sWIAPVuvbdZhAblriHCjeKiXiXUYfB0+cz50AM+QIVtJbYlI/Pbze3+yU9+qVDbDmicdhZeCkF2S15Ni1Dp1AWk/bbFiPS7dOOWHKtV94oSdVilUuFQ8jNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110972; c=relaxed/simple;
	bh=EQOWa8kRYuuWRg52iCF52VEd76oWm/PpP5deBStqEug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ejq1ZJxj/dervqdr5rA4zMw6SqPtZ5pzHfrZiFq9+OdkJ1qSEIlqj2EdDFuW74+XrfbNtZJvR/lzxtyfauc8vODlLO7zUTRX8UTj80C8FIhoeetmLOtCXuSBnJ7H8QLID9K9930Hy4EGjiQsafpsULU/nFlPpWUAuSpeLnwDGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GEAh3FmK; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GEAh3FmK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=JM
	u/grGaexoffKjwUAwcH2phMjsPJMeGjxVjgQkm/4I=; b=GEAh3FmKzRYAwZMHbo
	Y+4tvWTPWjJ7zqs0Hg/NadlY6BCeCIcaRh5zFJaI5s1TlMiezOl2h/MB6toVYKmr
	6fdD4n7Y4xLPmRHUoV7PGvKUASx0XcSm+VoiLeCE/KUdlho33xS2dDho+d2S7ZYW
	H/ucOGt28+XsLMa0YiD0JPYU8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnhyPs2jhqX8kADg--.55168S2;
	Mon, 22 Jun 2026 14:49:18 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] video: hpfb: Unregister DIO driver on init failure
Date: Mon, 22 Jun 2026 14:49:15 +0800
Message-Id: <20260622064915.767194-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnhyPs2jhqX8kADg--.55168S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF15Wr47GFykZr4xAF1fJFb_yoW8JryUpa
	1jka90vrWjqw47WrsrtF1fXFyUX3Z3JrZF9r47uwnIqanYyF4DW3y7tFyjgF45ArWxuF13
	tw15Jw43ua4Y9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEEfOUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxg6aCWo42u5uGAAA3L

hpfb_init() registers the DIO driver via dio_register_driver().
If a later error occurs, the function returns directly without
unregistering the DIO driver. Unregister the DIO driver before
returning from these error paths.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/video/fbdev/hpfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index a1144b150982..1405712e5b4f 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -407,10 +407,13 @@ static int __init hpfb_init(void)
 	err = copy_from_kernel_nofault(&i, (unsigned char *)INTFBVADDR + DIO_IDOFF, 1);
 
 	if (!err && (i == DIO_ID_FBUFFER) && topcat_sid_ok(sid = DIO_SECID(INTFBVADDR))) {
-		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat"))
+		if (!request_mem_region(INTFBPADDR, DIO_DEVSIZE, "Internal Topcat")) {
+			dio_unregister_driver(&hpfb_driver);
 			return -EBUSY;
+		}
 		printk(KERN_INFO "Internal Topcat found (secondary id %02x)\n", sid);
 		if (hpfb_init_one(INTFBPADDR, INTFBVADDR)) {
+			dio_unregister_driver(&hpfb_driver);
 			return -ENOMEM;
 		}
 	}
-- 
2.25.1

