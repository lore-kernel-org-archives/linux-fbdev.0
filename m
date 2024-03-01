Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027236CDB8
	for <linux-fbdev@vger.kernel.org>; Fri,  1 Mar 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292957; cv=none; b=g9LUdmHHpUo9YflUolm+84SGv+jK5p065FVgfg8V9VmR3gGM9fXYaNmpBYc2dh4ia1NohV0+ZF+1iO4rk/LH0qh3SWBtViYP2WJuDRis8jLx29hgJYETPs4S/94RW/cWeUy6Hn4MBOel7vYN93tsuMmo0Wl1DLXZTFUGpVVbjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292957; c=relaxed/simple;
	bh=VxMwlPmyLqrmV/iJHNW0APD+AzM24+JdL8iQ00ER42Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDmd0jderUAA+SEwg4i64VP7xkAdFEIy3CpTpF3lUHm8g5St0OVUmQIzjDTO4sJA/hU2ctcfrft39VjH+ibUOHC6gRmSCG+Xm5ZdAHsEDlqYST8Wqvf/42jgYOxzAHQIsex348CHX0Pxbb+mlfwIpoRhPvvmawkh2mqzCWJA5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=fdk0hSQA; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="fdk0hSQA"
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id BA7AFDD794063;
	Fri,  1 Mar 2024 14:35:49 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id t6YX3ZWUrrNT; Fri,  1 Mar 2024 14:35:49 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 89A8BDD79406B;
	Fri,  1 Mar 2024 14:35:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 89A8BDD79406B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709292949;
	bh=VJ2zoNTUueL/JHteCNWD30APnwn3/VJRPo8jrelaiZg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fdk0hSQASucZG7BJAPYeqXiOuY+4Xwk717AEnrrSLhuIoXoYpqBromV2LY0e5jz9W
	 ay4HjtXPGCHWKmgPdL/WZxIaLcLTQ/7FnyuwRg7RxieTGVJSSploErni5VKPkjwHma
	 lBB2z5oWlbGuFcZVrvgooQu8r2OCSJ2h+FnE2+DVFezsAaZtbHXrHYnEEsN9Mo2ltY
	 6yrlUpGOECzshC8Y5PH/e7tdSt0YI7NAYh3MC8CV4YXJtrEOOlAQHxAIH83+j0JVs8
	 /7wKQZXMKSzZu/uD/LLi8aFnUgcjftS5/YMo6o7pA5BQIekqdVYOJaZ2MDH/hZa0uZ
	 FOIwRXq8tDDBw==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9A5XyZWdS1Qe; Fri,  1 Mar 2024 14:35:49 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 5A50ADD794063;
	Fri,  1 Mar 2024 14:35:49 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Helge Deller <deller@gmx.de>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	linux-fbdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] fbdev: fixed typo in hw_bitblt_1 and hw_bitblt_2
Date: Fri,  1 Mar 2024 14:35:43 +0300
Message-Id: <20240301113543.24312-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are some actions with value 'tmp' but 'dst_addr' is checked instead=
.
It is obvious that a copy-paste error was made here and the value
of variable 'tmp' should be checked here.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/video/fbdev/via/accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/accel.c b/drivers/video/fbdev/via/ac=
cel.c
index 0a1bc7a4d785..1e04026f0809 100644
--- a/drivers/video/fbdev/via/accel.c
+++ b/drivers/video/fbdev/via/accel.c
@@ -115,7 +115,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u=
32 width, u32 height,
=20
 	if (op !=3D VIA_BITBLT_FILL) {
 		tmp =3D src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_1: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
@@ -260,7 +260,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u=
32 width, u32 height,
 		writel(tmp, engine + 0x18);
=20
 		tmp =3D src_mem ? 0 : src_addr;
-		if (dst_addr & 0xE0000007) {
+		if (tmp & 0xE0000007) {
 			printk(KERN_WARNING "hw_bitblt_2: Unsupported source "
 				"address %X\n", tmp);
 			return -EINVAL;
--=20
2.25.1

