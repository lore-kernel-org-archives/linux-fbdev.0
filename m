Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AE2ED141
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Mar 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142718; cv=none; b=ofEwXVJYP2CtXHoR8rGah1lGcEihw92B0LSqPGD1ihCbZfd8XkyuwxKNLg57d+N/z9tqv7WDkrlQYOBf625riWdXanoEgFBM96iGDZIISmGjJEvt66Gn5HDwnnxR8YRgcJtGyqlihLsMoOlRkxxV1Q5fqDOlwI2POklL0L1WEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142718; c=relaxed/simple;
	bh=SwSnr72oGPGmvGiCmUsqzZvAtaUKeBXUbDTvUnPFM7I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YLl7uKPXx8BIQjmwNkmwa/68QEPRTIcXxlV5QtAhqNrP66iIr1OL7EGZfbc2A9RLvDpcMe05H1jDiVuQiZCD+YvjLOK8mUo5rNAhPzX9mNCQ+0YnoK901xpT0Ds38dM9tO2gwV9ScKMG15PWdgYTXZ2b8s7HwFwN9zkOsywWnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qnXHBB31; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qnXHBB31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1773142714; x=1773401914;
	bh=eICeDc0YioNGect4MGlHBciAuFdQz2A+NxiWqF39LlQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qnXHBB31ce0nFbc7qrbMu4/OX7OSBLDpRAclrJ4JhxgYqkwI411GD/LLUXgZocrut
	 RoxlidwtcbDyt0DEyWaXS2GvL5586p1c+0PenI4O5RqIMa1hNg0hFUp20S2t3nPtMF
	 0Nl9gOcj9r5P+3FjUl64WV7MrzSJLAsDZbGx13E6RkHHanynsO9V9Xx6MJcrYztfVt
	 C6SqWOHQP01PLQuBFCZKkigJtN7S9F0ei/zvGbq06Pqz5DLC5As636n+YPdnU7ojW4
	 mjV55IL7vF9rQTYSlp0bx8xflPnCjjrAzs79G5FlZGeF7gIbg9qIZ53aidFN8R13sY
	 h6n66YlSxeDRA==
Date: Tue, 10 Mar 2026 11:38:29 +0000
To: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>, Thomas Zimmermann <tzimmermann@suse.de>, linux-nvidia@lists.surfsouth.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v2] fbdev/hga: Request memory region before ioremap
Message-ID: <20260310113810.789575-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: db1d6e9f0552cbd8316b5eb5945ca5b1bc7bbb69
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
Changes in v2:
- Used devm_request_mem_region instead of request_mem_region, based on a
=09review comment by Thomas [1].

v1: https://lore.kernel.org/all/20260310064124.602848-1-hardik.phalet@pm.me=
/
[1]: https://lore.kernel.org/all/5f9749ba-18a8-4b6b-a6e7-a011a3871bfb@suse.=
de/

 drivers/video/fbdev/hgafb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 14418aa3791a..fffd34141f8d 100644
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
+=09=09pr_err("hgafb: cannot reserve video memory at 0xb0000\n");
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


