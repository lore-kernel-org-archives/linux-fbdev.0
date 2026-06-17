Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEE395AD0
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689459; cv=none; b=rhbR14qWykRrNvh35lI+A7HKh/B014eezrFKULNknhHeHrsxLJKfkEHvSqeleGSefm37w2xAcFZBhxWHs7TjET79VF7dAumk+Y6heRz36BCof73AVt8c6QTPeTySeeQ2Tepc5uKmcu1gOrvyu4ag3F/qhnfxJOSxmtvoLaahAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689459; c=relaxed/simple;
	bh=sfrAhb1Z+VzM4SLtBkm5dpCf6X9unUUYYTWLBBKX+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UK7r0CPAXHqabYGikeb2UOTwIYTFNuJGpn1WC1ysKXiJYGR2kYZ1pR7LMHhZzZUvfHJkxSJJv997GVvT0up1P6BFYMBc1OoJSlMk4ttXBJnNQ0mEZ9fblgsTSEyff4U93OoX/KpocuFC2omXyggGT9mfH5zwtJYdF21cKa1fibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JgfY6jyN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JgfY6jyN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4624c1409c9so475487f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781689456; x=1782294256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5e5ThiuCQuL2m3Kf27kb7O5XV1gp2X/Il1NBQqxg5Bg=;
        b=JgfY6jyN1PtX/OeXLMfJsb9ghFjYVL31wPDUCP2tCK6wE3cUqSAvLY5DQTEF/dbu7L
         1Sz+U9ZzsVMukjDZtvgmPQkn8o9GAw3/bUR5AkarkLrbDxNRAX9B9R7wf6JhSz589rlf
         fPJuNdtKCRpsTyu4uWN/THt9iy/994nOZJoM3eSwcXdBkFYe+47e44eGWkSF/pgWpN4u
         9A6tBKh6dwmoRz0qFBup0UkjZngk/K52EADPzdskqa/QYGNEWlVRRclnqVBYWXSj/YmO
         BhLEUhFUT0PCkmIXGZx8w52TKPW8qtQBQUTkvEBB9du1RuxrdFoPSkAQ2BOH2n5R9U3+
         m0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781689456; x=1782294256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e5ThiuCQuL2m3Kf27kb7O5XV1gp2X/Il1NBQqxg5Bg=;
        b=iFFtiLzFUfGIs38FesSjnQSDiXpJYzvMz0hfENnaOaGClaIMu+bIyjc/rNDNeBF41I
         pt4xQm0AI7IgSjUD3ATcQPy4lXaijkm/fcukokj45it85LwTrG7HcgQlgrLs++LU+oSX
         IsyBPDbSG3VgiPg7//fgNwjSHqCzoKxcLq9zs/Hg3MGFT8rsUvrvlgbLymvzZF+tRKNn
         Bp+3ZzYnvCv6zbSLLUY2/JtmZUeYqb8TgyCT0uPwVKAWdE/dVjy+K4faiJEVoTmN6wlS
         nsd+LfDhv6kQNcXCs9cQ2qna/ij8sxKW2lCR+G9Pn/VA2h2AiFqMhuVSN6i5FdTN9VzI
         beUg==
X-Forwarded-Encrypted: i=1; AFNElJ9y7hZ1NmdjTVhlsQmgkT92OYQQK3oKwblTVPF3+tWE5GakLvktRD8SIURk9Td61d504tc/KHUwRn9L+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyALMpuYX64LBnN39h1n/KxgkMDpXQ/tSIeFh8Jdx8EdcW5jvUb
	W/Dde5rjAxpCXU3I0V2tZRWJWEIIaH7c/vzym6QyBRG8T7D5RVGI1rJ5/qFXNVY2CYk=
X-Gm-Gg: AfdE7cl2tQwV7Zqn+XdTEh0IUXuKljQpBGUga27NkXcpGt4uT4FIoypkETikctCwQwM
	ifgmgsy07/mOk8lOSZ0hwpL3GMSIrXbJOjGmh5mE7M7F30lVd2YTBoCqkf195qwc9qlNCMu7yw7
	iwQ5Bfga7wBDF7XWF5OsNV//Hj7ElG1FOqcEhoh48ZS6ZOpq7LHW6zRQ25NuVLxqFaJPmhSYecl
	upEFetc/96IbWz2WhrxGPESHzubWDl6ZNOxRMSMBR/5l/cJOrZSIvsF/pBd/i6OgABnNvqZNp2O
	u+yCB1nuzG028n5b/J1rT2Jx3GO9dgxI4Bz4vird5KsSXlBQZEd1pCNj+w5vcEjfkfYAZy4rXhj
	1R/OM39YixZs04LS5Z79atAHfEd60vj5nMKBH1bEkDDue83TWtJNVhgZGXwhICL3EsYzTPiTt1F
	8wl1dPGvuP3dis1gMMi5gCS6xElrZL+9nCUxEh4WFIlNdbpOEYvxciOb7YgRBlxWi3G0tx3LLpr
	mpK
X-Received: by 2002:a05:6000:2913:b0:45e:ef4a:8192 with SMTP id ffacd0b85a97d-46238bc0537mr4819136f8f.38.1781689456251;
        Wed, 17 Jun 2026 02:44:16 -0700 (PDT)
Received: from localhost (p200300f65f47db04bc2080ea3c93ea6d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:bc20:80ea:3c93:ea6d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-462236047c8sm7797131f8f.10.2026.06.17.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:44:15 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Javier Garcia <rampxxxx@gmail.com>,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] fbdev: vga16fb: Drop unused assignment of platform_device_id driver data
Date: Wed, 17 Jun 2026 11:44:08 +0200
Message-ID:  <02710e01b80c06230f399afa6a7d247b95b3f2de.1781689394.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=sfrAhb1Z+VzM4SLtBkm5dpCf6X9unUUYYTWLBBKX+Bw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqMmxppssr45MHySgEWeWZleAyeuAwv3bsYiZiq r9lwBexJquJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajJsaQAKCRCPgPtYfRL+ TnGSCAC2BtWvXO0gmLj+tyQU4J7B+LnhNFDgUzyzNZ7l6PEKXhgel4HZQXSYuEgSkIAzWyRk/ev rLK4bC97m/7SdwgoOKsmXgGl/LU2l49JxH9yzxemF0LIshQEp4lO2b8YdVd7TzZVOvEsENyqreM PTUsQWuPXtZRbPZQ0gMPvFWHWiYgiO4UUsOobWuDtL2GqAgQtRvjZXHzif0zPPwHNsKVBDz9tMP LfuekMSZDeUIiBbNBiosjVGIKs4knvXYk9vARIrSB/gRq6HmTLqVqWPO15at8VixbX5azGXnVNT KP0nsPwH+BbFT2heZrEox0WUItbcXRuyQTMEnnmDmev27k4b
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver explicitly sets the .driver_data member of struct
platform_device_id to zero without relying on that value. Drop these
unused assignments.

While touching this array unify spacing and usage of commas and use
named initializers for .name.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/video/fbdev/vga16fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 22085d3668e8..cdd6b8de0ceb 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1421,8 +1421,8 @@ static void vga16fb_remove(struct platform_device *dev)
 }
 
 static const struct platform_device_id vga16fb_driver_id_table[] = {
-	{"ega-framebuffer", 0},
-	{"vga-framebuffer", 0},
+	{ .name = "ega-framebuffer" },
+	{ .name = "vga-framebuffer" },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, vga16fb_driver_id_table);

base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
-- 
2.47.3

