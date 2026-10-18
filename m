Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9584F19E96D;
	Sun, 18 Oct 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792313705; cv=none; b=ie5PBq2WeHLz/FBe1+5bZFOX0s/nAvg6rQy535DRvlT3ijYsyRpfJXp/YY/pdDUBIzEWPawI/+3b2jd8d0l77FB5c6y7w/sRDPgYeBqzYCGNTTRQV7XvqOcpGy6JtcH9vE5wDMoUUTBgFEx7xWfVU3hL4SsbGA4fiF1q1J5UzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792313705; c=relaxed/simple;
	bh=NzsxOeMwWGd2HI7xAuf3oFAKxsxzOG/fsd/2k5dwqtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=argnLWQwSDbu6afof+94Y0+V5N9u8SArkqD41ovN5PNTP8Qdog1n4tFkbJl72R/ydEDF1FK5d3A6b35rU35Tcqa+h6oWJ6rUMfP/8hOdbEBtS+IGHVkNXERcq2WxG51+DBjrnoD54Hkdp66jpExj111zUC3oc3Je6RsMd8iqZfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oYTzbovY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oYTzbovY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nj
	KpD5KvXo0yuFxJRRUc1mEoEJbSGpQ+k/5uhHX1AuI=; b=oYTzbovYBFYcWzZ67S
	QmLJMwz1lfqLQ3ir4N0ExjEG4waLlb6cFpXWcJq9EOgLzvFA7zNX0KLZrWx7a9Hd
	B3pPYBxwUG6ShpyRgeSi3602QBHkA3ncAfO+Ely33aDrgb36tcEEfKme8Z+MEgk2
	cHIvR+esO+zxRYBu8+qPldYEU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_74eidRqUCqWAg--.42280S2;
	Sun, 18 Oct 2026 16:54:05 +0800 (CST)
From: wrmfwv@163.com
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gtl-m <admin@micronull.cn>
Subject: [PATCH] staging: fbtft: fix syntax errors in macros
Date: Sun, 18 Oct 2026 16:53:45 +0800
Message-Id: <20261018085345.17619-1-wrmfwv@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_74eidRqUCqWAg--.42280S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rGF1UCry3JF4kCr1kuFg_yoWkXrgEvr
	n7W34kZFW8Gr1xtw1fCr1ayFySq3yUZF4qqFWUtFWFqa4fCw48X398u34kKws5Xa1UKFWr
	Cw47XFyjvr18KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8KLvtUUUUU==
X-CM-SenderInfo: xzupw4ry6rljoofrz/xtbC5g09KWrUiS0ueAAA3z

From: gtl-m <admin@micronull.cn>

checkpatch.pl reported errors regarding unnecessary commas and spaces
before closing parentheses in the fbtft_write_reg macro definitions.
Remove them to strictly comply with the kernel coding style guidelines.

Signed-off-by: gtl-m <admin@micronull.cn>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.25.1

