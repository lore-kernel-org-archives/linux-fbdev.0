Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A33320A0E
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Mar 2026 06:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773124912; cv=none; b=vCwAaXkEqLdjECVoTVZu8U6eS6Nbywrgf6d/5ClSjOiIL1h3m7T1xDhfspkRqX7vprce6+Wpg5Hk7Uo22y3m+dsNgiINlqo5XqXUAnDhrRVj0WmS/v52xhzH5tbAUIE0H6PtnYF+BcoQ9PeQ01oJrU0hv3ENWWOdW24g5g/c5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773124912; c=relaxed/simple;
	bh=dYlycPl8p/x1gwyJn8ULpzMUW2NWNjW7cVDYT72HC9s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SRJByA3zJbQ0quo+67X9raIeT7NjaIIXQvcEX1kuOzw/45kZbgXgxif7jgRqSUSCMkl97idlHmU0Zgva3RVO7dJNGXzCq3Be3N0MdvB+ewu2IqyQAuP3qf3IERIm4g/l2j1pWhMPYANDLGOle69gDb8iN5CtcPvQat6u0R4/1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=W7xnpFmx; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="W7xnpFmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1773124908; x=1773384108;
	bh=M6MVz99apPoJz3VJsJLHJVaKn3OU4ENXUSbQXnLReTE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W7xnpFmxT4+cYcexITuG6Nh/H0Qz8e307MsCr52I9+6jd5XHfxyZJin2RYdtzWZrK
	 Gt0n0J1ffxopbYw/TWDcfpyDplNEt3g23jUPnH/5/6gKm9l77sZep9nv0z+rmUZ8us
	 tEZBuK02xgcp2S6i6aFXxc/zQ0ZPJnIm85/+thjHKSNvaWW6O6yIM7w+phvDDHcx9l
	 vX/sCUxCdooAx7pUrvg8wkFE9JCMGFgpuc7i4p2LGmMb+R3dWTIIyIU0PUv7DtL9Sj
	 oQP54+Ak/kQbJdmOnJkr3+N74fh+P3Q0F5xNnDl4l0QHNEJqLWxVtl9++UXv/RVq8x
	 VMmc8lJn5zx/g==
Date: Tue, 10 Mar 2026 06:41:43 +0000
To: Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Brigham Campbell <me@brighamcampbell.com>, Thomas Zimmermann <tzimmermann@suse.de>, linux-nvidia@lists.surfsouth.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH] fbdev/hga: Request memory region before ioremap
Message-ID: <20260310064124.602848-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: d4777026df3fa38f46012efaf1cb841e71c5cd25
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The driver calls ioremap() on the HGA video memory at 0xb0000 without
first reserving the physical address range via request_mem_region().
This leaves the kernel resource tree incomplete and can cause silent
conflicts with other drivers claiming the same range.

Add a request_mem_region() call before ioremap() in hga_card_detect()
and release the region in all error paths and in hgafb_remove().

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 drivers/video/fbdev/hgafb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 14418aa3791a..ceca6cc2c928 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -284,9 +284,16 @@ static int hga_card_detect(void)
=20
 =09hga_vram_len  =3D 0x08000;
=20
+=09if (!request_mem_region(0xb0000, hga_vram_len, "hgafb")) {
+=09=09pr_err("hgafb: cannot reserve video memory at 0xb0000\n");
+=09=09return -EBUSY;
+=09}
+
 =09hga_vram =3D ioremap(0xb0000, hga_vram_len);
-=09if (!hga_vram)
+=09if (!hga_vram) {
+=09=09release_mem_region(0xb0000, hga_vram_len);
 =09=09return -ENOMEM;
+=09}
=20
 =09if (request_region(0x3b0, 12, "hgafb"))
 =09=09release_io_ports =3D 1;
@@ -348,6 +355,7 @@ static int hga_card_detect(void)
 =09}
 =09return 0;
 error:
+=09release_mem_region(0xb0000, hga_vram_len);
 =09if (release_io_ports)
 =09=09release_region(0x3b0, 12);
 =09if (release_io_port)
@@ -619,6 +627,7 @@ static void hgafb_remove(struct platform_device *pdev)
 =09}
=20
 =09iounmap(hga_vram);
+=09release_mem_region(0xb0000, hga_vram_len);
=20
 =09if (release_io_ports)
 =09=09release_region(0x3b0, 12);
--=20
2.53.0


