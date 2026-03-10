Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B83CCFD9
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Mar 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145834; cv=none; b=jVNK29UH6IM41FXbrX7Az43S5dIw5SXW9BEWdqz0zLu2GSJW6q2H6THvvvJBygZcqUBd6N7U5g6XV1cdzPAkV6JvWTYuMnv7eoIPUWWbzbVNcThDn/qDCgzBj2jP4oCR8UOyqB+u7idUctSNy5yihX2kN8qpf06rmSbVfHGsnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145834; c=relaxed/simple;
	bh=KKy2poCEl/KEvHbB7vJt1Km85ohKJhIBhSddoDeu41Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PVj0Yrr/DeVwZWiCc1iDbq5uBL+1ySaHkcJIEoldAWJoi320yPvhNSZBg76CJuKlQaHxPBQZE2AoZAwC6BXM1z6lg0l2QHo5UA6FaBkk00nDUSlX1uqwnjINX2OLvcE96wBSVrpJyMHFQiYMH5jNGSfArP6sJz1GgqyTTDRVA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=opJSFmdF; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="opJSFmdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1773145830; x=1773405030;
	bh=70qYgbuSjChtaC/Be+ZW82CQnptfCc3jGidv51tEe7w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=opJSFmdFfOSQHxw1F6eoKz0R14nyZbkQZjs6DliIUApwaf5j1qEsjvczagE1ft1E/
	 xMnci9i3DQe2CndssWqRWiqnYCXCp0P5icjK6ckQ0qcPsHD+RLWKNvZuelOeOqyLW9
	 H76yjoFSjqiqptLERebctmzHQGkrU9nwhBNdTL/kt4Hgj4TKIPXkScTGXJEUFqlI2f
	 6WhJN0SBAmvGgMF9REliytyYdSv5oQtNrC3Hw9C0QUgTzRbY1xdd1txhQ10XQ2vEYp
	 6cix3rZCTStolijLZO4oLTrdmjfXzjiUS4JEx+DqzexqcmtuRUZ0i+REkVKPZMC8Jq
	 DY6r9ygjuRgJg==
Date: Tue, 10 Mar 2026 12:30:27 +0000
To: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>, Thomas Zimmermann <tzimmermann@suse.de>, linux-nvidia@lists.surfsouth.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3] fbdev/hga: Request memory region before ioremap
Message-ID: <20260310123004.888132-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 1e6537c57d7eaa74a5eb9d60b28cae32c0f30467
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The driver calls ioremap() on the HGA video memory at 0xb0000 without
first reserving the physical address range. This leaves the kernel
resource tree incomplete and can cause silent conflicts with other
drivers claiming the same range.

Add a devm_request_mem_region() call before ioremap() in
hga_card_detect() to reserve the memory region.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
Changes in v3:
- Used dev_err() to log memory region request, based on another review
  comment by Thomas [2].
Changes in v2:
- Used devm_request_mem_region instead of request_mem_region, based on a
=09review comment by Thomas [1].

v1: https://lore.kernel.org/all/20260310064124.602848-1-hardik.phalet@pm.me=
/
v2: https://lore.kernel.org/all/20260310113810.789575-1-hardik.phalet@pm.me=
/
[1]: https://lore.kernel.org/all/5f9749ba-18a8-4b6b-a6e7-a011a3871bfb@suse.=
de/
[2]: https://lore.kernel.org/all/ec635591-c861-4aa8-a259-718690ddaa4e@suse.=
de/

 drivers/video/fbdev/hgafb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 14418aa3791a..d32fd1c5217c 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -276,7 +276,7 @@ static void hga_blank(int blank_mode)
 =09spin_unlock_irqrestore(&hga_reg_lock, flags);
 }
=20
-static int hga_card_detect(void)
+static int hga_card_detect(struct platform_device *pdev)
 {
 =09int count =3D 0;
 =09void __iomem *p, *q;
@@ -284,6 +284,11 @@ static int hga_card_detect(void)
=20
 =09hga_vram_len  =3D 0x08000;
=20
+=09if (!devm_request_mem_region(&pdev->dev, 0xb0000, hga_vram_len, "hgafb"=
)) {
+=09=09dev_err(&pdev->dev, "cannot reserve video memory at 0xb0000\n");
+=09=09return -EBUSY;
+=09}
+
 =09hga_vram =3D ioremap(0xb0000, hga_vram_len);
 =09if (!hga_vram)
 =09=09return -ENOMEM;
@@ -568,7 +573,7 @@ static int hgafb_probe(struct platform_device *pdev)
 =09struct fb_info *info;
 =09int ret;
=20
-=09ret =3D hga_card_detect();
+=09ret =3D hga_card_detect(pdev);
 =09if (ret)
 =09=09return ret;
=20
--=20
2.53.0


