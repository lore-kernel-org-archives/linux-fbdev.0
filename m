Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53534CFAE;
	Fri, 13 Feb 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973233; cv=none; b=OlYT30mMO6i6Ipp7zUFPmSfWHad3xpdMsfNoNK8UGkb2YJ1ucCHaDo2Pxc/nDcFBVtmTEfcr1hh+9muZeCSR0Z9Mn3T43XrWO7jPT5MJEjj78Fis0A8M7+89nck5JtXUxF9PSApQfEIAv0mbvDXxsar+sWadjoVoLd83JH4N/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973233; c=relaxed/simple;
	bh=ZJ5pn12CsGmHgXviZQQLyvWudGJUfy2ptQnWYfoS+f8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QZXuZ99epWy1AsGv95anEju01qpIgTzWmRTdAVTQpVIechdJh8Hs64cBOkJdy02Or9j0sn2MNshlbDDJASOPk5gpt7J3eKHOZkHWADPuJj7t/AEbmwHONAtEV0wVufVIdoOkhPUmNqbJv/n+e62EyDZWJZaB2PWKimd6aHskys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFsH16hx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFMgoAi+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFsH16hx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFMgoAi+"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770973229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HBjGiadin9K7jCzJsgR1AQK9TwCsTvwqWCR1pRrUqgk=;
	b=PFsH16hx5YJjpN9FQjkZF9p5saNhXpRQ2B54njPaHJOcFFC5ozIwWi9rUgGmBnlDkpziWB
	+l+LClST7Nj4Kr9POj7tfz6ng8q8gMNV+O2swYk9KUBmL9coA14W8oAF/nm01FDzUpnK9g
	El9NZ4in1GBDhJHilw2Cj1Cgi9vRuJZ1xmcLVwArXx/9cbwNVfabPo4gZAYal3h56A/8h7
	lq+BZOKSpCeSQAA4ECmOVk6aI5sxc0SX0lYZFOIYLAL1ktLBnMJuycFI5JWUOr+ll+5C5C
	Zkd0ZTZh2lCxM0QvfYCnNnCfR4B68JWpGxxqOkopv+4jFZzDlcBQn+vmFqnq3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770973229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HBjGiadin9K7jCzJsgR1AQK9TwCsTvwqWCR1pRrUqgk=;
	b=IFMgoAi+iSys5vU6ZqAnASNkqDADw3CCWYo1oUWptAgtTUcHry/GWxjZ8U3AeqHfrSm7bU
	lQMChSfja6AX7FAw==
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nam Cao <namcao@linutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: Optimize partial write()
Date: Fri, 13 Feb 2026 09:59:46 +0100
Message-ID: <20260213085946.3673695-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When user write() only to part of the screen, the driver still updates the
entire screen. That wastes CPU cycles.

Optimize by updating only the changed lines. Improvement is measured by a
pair of trace_printk() at the beginning of fb_write() and at the end of
fbtft_deferred_io().

Update type         Before     After
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
full screen         196ms      200ms
half screen         200ms      124ms
quarter screen      193ms       81ms
one pixle           199ms       43ms

It is interesting to note that if the deferred IO's delay time (40ms) is
subtracted, then the time amount scales linearly with the write size.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/staging/fbtft/fbtft-core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbt=
ft-core.c
index 8a5ccc8ae0a1..16899b979623 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -300,12 +300,6 @@ static void fbtft_mkdirty(struct fb_info *info, int y,=
 int height)
 	struct fbtft_par *par =3D info->par;
 	struct fb_deferred_io *fbdefio =3D info->fbdefio;
=20
-	/* special case, needed ? */
-	if (y =3D=3D -1) {
-		y =3D 0;
-		height =3D info->var.yres;
-	}
-
 	/* Mark display lines/area as dirty */
 	spin_lock(&par->dirty_lock);
 	if (y < par->dirty_lines_start)
@@ -414,9 +408,12 @@ static int fbtft_fb_blank(int blank, struct fb_info *i=
nfo)
 static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t=
 len)
 {
 	struct fbtft_par *par =3D info->par;
+	u32 start, end;
+
+	start =3D off / info->fix.line_length;
+	end =3D (off + len - 1) / info->fix.line_length;
=20
-	/* TODO: only mark changed area update all for now */
-	par->fbtftops.mkdirty(info, -1, 0);
+	par->fbtftops.mkdirty(info, start, end - start + 1);
 }
=20
 static void fbtft_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 =
width, u32 height)
--=20
2.47.3

