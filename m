Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9EC1B2190;
	Tue, 10 Dec 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840351; cv=none; b=uEkTWx6lgV4lluA4Fdjd0rUhtvzqim/8nGdy1csxUiWAcs0bkOe5+RO7V2d2tP2wzjqWA+0pQc3hDbUk3VVpvhGYObYgeqs+H5inEyZsS/G5HnZiHR0zrhyQ5XgdT3eMyZkhb25KwD74HwGyeKnkYFkHEJc7HkRytX+WY6ycDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840351; c=relaxed/simple;
	bh=3i+zRGoIAHKVd1ck+sBGI2cSTSVfLNulHCLRTB2UM2Q=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=UP8BMlKpoStsE8QNx8RX175YAajnc7AzxvcdL6S9aYYibB+1xlzk224t5IarycsfAvCw8TlKBpgwy9mi+Uzf8k0HOAJgdN4ORj5bv+x+yEC0ZC+s8Rsz4rKLEda9zujhGyv88GAWcdYpnTiXGE7JEa87xpjEDW9GXUS7CLZLswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ariccio.me; spf=pass smtp.mailfrom=ariccio.me; dkim=pass (2048-bit key) header.d=ariccio.me header.i=@ariccio.me header.b=S9rRYHQf; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ariccio.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariccio.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariccio.me header.i=@ariccio.me header.b="S9rRYHQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariccio.me;
	s=protonmail2; t=1733840335; x=1734099535;
	bh=3i+zRGoIAHKVd1ck+sBGI2cSTSVfLNulHCLRTB2UM2Q=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=S9rRYHQfXfj/PIluj2/xZdYstKBPvz3w0HeYZrsoNQ9RBF6YoEg/U8PagBXHmKeg2
	 HjWVsRJA/sZEh+jUCzuWD6oA5JL9yscBL0MvN/yzf0E5vO3+P3gzd8Qk8/9uENTqVw
	 FVDmNEn607DIbOjBGKjooQ1+HZjFHOgwJOl6yfNrRl/u8K5sKzQ0XgJofFOiAVaG3S
	 D9SrZ4DZAMseQTjDAd9isaJz4ix4vet27w1XZTzbjcgRuvuUjybyCYeUAuNHPP7AhS
	 Gs2eYthrr+N3uXnR6IJWM6w9EZyFPhQq7LEzgrTMIq8nzSauLUSxW8WtO6p1R8e3du
	 zuXzfiuL+uOhg==
Date: Tue, 10 Dec 2024 14:18:48 +0000
To: gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
From: Antonio Riccio <linux@ariccio.me>
Subject: [PATCH] staging: fbtft: Remove unnecessary parentheses
Message-ID: <Z1hNxNkVSt11ncXs@stream-circuit>
Feedback-ID: 117734652:user:proton
X-Pm-Message-ID: 81922902d7a06e1f45d4210d9402e12cd586accb
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Unnecessary parentheses around 'devcode !=3D 0x0000'
CHECK: Unnecessary parentheses around 'devcode !=3D 0x9320'

Signed-off-by: Antonio Riccio <linux@ariccio.me>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_=
ili9320.c
index 050fc2367c12..9f97cfa34b81 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -35,7 +35,7 @@ static int init_display(struct fbtft_par *par)
 =09par->fbtftops.reset(par);
=20
 =09devcode =3D read_devicecode(par);
-=09if ((devcode !=3D 0x0000) && (devcode !=3D 0x9320))
+=09if (devcode !=3D 0x0000 && devcode !=3D 0x9320)
 =09=09dev_warn(par->info->device,
 =09=09=09 "Unrecognized Device code: 0x%04X (expected 0x9320)\n",
 =09=09=09devcode);
--=20
2.43.0


