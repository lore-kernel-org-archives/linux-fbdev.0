Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132C4D8D94
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056296; cv=none; b=u9hksm2ZjvLCXcouh0NlQVoJqhrEL//STeISLT84FXHAG9b43pLRO9yTVGGJ86KxyiiWiqhbseX7OK0E2bGQOwTiWEh1CCQCHu5wvMEJxMSJE4vB4ZEHv26nFDrnXVFcs+wmocaOnowe/ZP2MxmvOmYBSu343+OsX8g0oq6ghKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056296; c=relaxed/simple;
	bh=Doe/noE/VDzrhJcyhcBLmdrRHSxJXKSyGVrXNoRFS60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5srbJZyYtNwwHTZuEHu4cBVzEDlwlJWztUYyqJlwpsOhk3JKWqARqdQEEIRmsHOF1UzFRf3SpYzFBwrE1Z7GnfGrFpCcYD6Sm0372jD5bUABfG8nu+YAmhOkkA6y55HIYDzhW7e8qWra5lDHrD1iK3XF+VKfF8qpEL7AFbsvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeItzqTe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeItzqTe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so39237775e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056288; x=1784661088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfWoPu5aITaJ5jCwkR3a7VKo4LHkSTdvVPxiL19RVY4=;
        b=GeItzqTea0baNA2o8hsAaLI+w7/NxYcJfB25XXuo+i9IFWA35QPYSUCidj+gGVMLk6
         uFl1iEXcimBQv08V0JL+O4RyFcZVOuzX6JhHUchoGXG2eyHxuXUjbEpG2ZbiWvdZC3+E
         V/PX/9ylQuQpAGoHmq3UHFcfnPB1XfoWXuN0LFUHiw8xUZ2rWNpvW1UuGbMPfm9LD1TT
         R20XxqqBWFPw18SGl4pi1VxrmT3JJin+vmufBuQ48vkfV8eFY4NcqC4nVblckPiXGdfp
         elBGxL5swPxXZAu+KXC9DTxBFKZDA9MH1RHGbNy7xtjNjN0OAX5wnDOdQ79Tnwj+vjVW
         zSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056288; x=1784661088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfWoPu5aITaJ5jCwkR3a7VKo4LHkSTdvVPxiL19RVY4=;
        b=IF5vu7BzKhvVkwkZKCsBFJ6rfdbwSoOQWxzacKptCZFtz+tZtcuwzokmmEQD9JbllX
         F286x0+OhGumNUqYYmidb/RdTVwyNtPZOLHyAhQ5InZhlmFENXXf++dGbeefHuUSD2nD
         VyLuxsShJEr4E8ZuWsExu8YJa2kQ/Wn7RfIuB4qmaOHq2riHa0yjetZUQ7QL/Box1P91
         w2tqvMcQzdxXCuomlsammYBcLwFPQGM8axARtxekwu78XnpA2rVlzyxk4VaaoZVPfpHS
         LKtTjekXMD1Lgk4I8g9mdsJrg+MYc0rwOUzFFUCuPHsEts76RVq/uYEVdYa8aXLVW460
         FfBA==
X-Forwarded-Encrypted: i=1; AHgh+RqX+z0buvm99Qh3yp9dFaZrRCTSxnfUfG6AnoXAN4l4DFCTKUiTVq4CmSreN6J5Ra0hYEkAk8FuqByKQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySAjxlnZGH85dZqXzndgs91VyH6Lhn0HpczB9PzwnRxFIAteOR
	OecNISocaCbIbUDs6/kwN4rgS2i5C+OUKoPgJqIlFxzJYZXthWIJ4aaW
X-Gm-Gg: AfdE7cmaHMxKv21I/wkgEnkVsU5FT74q6Fd9t80H7mL2bJ4tY8zUSoI2dg7unxvWNlw
	QmL6ZOKny2WpJhGdRDFDzjJAHnqfmEgWl2RviZu6/Lb5NpfuNBcwu59EAOhh59l5oKmFgrFNNdG
	Td0oddF3UtNdmzrMe6N5Xr+elNRHuyy4CinNljn3RLTtjq/6Xtkt1ExWduQ5Yc54s31mNSv9Mm5
	3tha30CpG5tdPe5Ss5rcv7EmCESDbqZ5VsdYh6m3GNzyQBgTnJ9OiVD3kTktTo+ctnv3OLUS2mp
	/dojfgGo6eGhipq0bGY7cDa5UTytmClT2QiPdvViPAvc0s8+tXaemP/PJ0BfgDEhwCeBuAcLd4I
	sxSh+EDMr126yiHPjeGgcl+OJ2WMkyUNOh30VfKUl+wPAdlXejnKUR4cWHlS3kAUpGw0C05AePw
	I2b5GbSBHU9IJjMV7NWG/WAlGQ4Wwb3pusJ1fOsAKKSOTnxBSqtGCmGdltTT2iymoeevxfma4SG
	cFlIv/EUomZn6dBMHb45g==
X-Received: by 2002:a05:600d:644d:20b0:493:c601:3e23 with SMTP id 5b1f17b1804b1-49538992cfbmr31608585e9.5.1784056288413;
        Tue, 14 Jul 2026 12:11:28 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:11:28 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de,
	tomasz.unger@yahoo.pl,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 3/3] staging: fbtft: Replace udelay with usleep_range
Date: Tue, 14 Jul 2026 22:09:42 +0300
Message-ID: <20260714190958.219437-6-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warnings preferring usleep_range over udelay.
Replaced udelay() calls with usleep_range() providing a reasonable
upper bound to allow the scheduler to coalesce timer interrupts.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c    |  4 ++--
 drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..d2400bb44f1c 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 200);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 200);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..e26766f58a50 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	usleep_range(100, 200);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0025, 0x003B);	/* amplitude setting */
 	write_reg(par, 0x0026, 0x0034);	/* amplitude setting */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0027, 0x0004);	/* amplitude setting */
 	write_reg(par, 0x0052, 0x0025);	/* circuit setting 1 */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0053, 0x0033);	/* circuit setting 2 */
 	write_reg(par, 0x0061, 0x001C);	/* adjustment V10 positive polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0062, 0x002C);	/* adjustment V9 negative polarity */
 	write_reg(par, 0x0063, 0x0022);	/* adjustment V34 positive polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0064, 0x0027);	/* adjustment V31 negative polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0065, 0x0014);	/* adjustment V61 negative polarity */
-	udelay(10);
+	usleep_range(10, 20);
 	write_reg(par, 0x0066, 0x0010);	/* adjustment V61 negative polarity */
 
 	/* Basical clock for 1 line (BASECOUNT[7:0]) number specified */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 300);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.55.0

