Received: from h5.fbrelay.privateemail.com (h5.fbrelay.privateemail.com [162.0.218.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320442C3745;
	Mon, 20 Oct 2025 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988336; cv=none; b=fzRgZ62IPVEy0OkwefkKAPaLcXclOhO0F7IPXAkSMFJY0ma/siQVHJ24Xubd87G1KE1Xe2uFUC7iOcznH0I9/LXZzHf0ecOycHcZFb8R1fze948Zj5NzBts8BtW6VZwAwN02074TFeHqwtXy123DuyvR3yjch+ix3LOZ+Kpl3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988336; c=relaxed/simple;
	bh=nrgRgNHCDk2InzSXMS2FndXavGmVtBMyfPdak7dPxU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y0Yiqm609VE2N4NYgumxEEKPv4yF17MrL8qKA1BcNlspCKvH0dmfT1GNVU8GikyG0aQAv2c7kJKSJ2b5GFUT2nxtvfpqzIThoE4zxSHXd/zkkOiPcIvUweQemuaiCVqrrXQWa/H5jR8uEXt0u/kG0r/vQLZoVdoUbzXVfGf98no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev; spf=pass smtp.mailfrom=lukowski.dev; dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b=fsZmiJ/X; arc=none smtp.client-ip=162.0.218.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukowski.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukowski.dev header.i=@lukowski.dev header.b="fsZmiJ/X"
Received: from MTA-10-3.privateemail.com (mta-10.privateemail.com [198.54.118.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h5.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4cr4sB5rjQz2x9p;
	Mon, 20 Oct 2025 19:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lukowski.dev;
	s=default; t=1760987751;
	bh=nrgRgNHCDk2InzSXMS2FndXavGmVtBMyfPdak7dPxU8=;
	h=From:Date:Subject:To:Cc:From;
	b=fsZmiJ/XedZgMdFLTAho3wpjBWEeK4tvba9rx2fXhRJRtdXi5bYdq2gL1Z9tqyPyV
	 0rlAgETTT13G+Ycz21NWQAP3SzN9oz4Xs1GyHiDj957okFciL6QkUN6gIQwTQb+oFS
	 rto5cGulzzqj3b4rk8Y3vz2wWZ2lP1Wd1EVx4O3eVWuHsVjmfyxtYxIio+7kzzxdNa
	 SdlINBWlnmZwr0x+91N9MCIeMruCXANqQEf7iYNNc92RVoudEheyguZkabkBEHP0sQ
	 G8Usmu3iOtsKpz6Iq2Y02DOzGZpR0iTXT3DNMwOKSWB4HYZ7rQ1qZW+HkBzzOrwsU1
	 XnjcyJtkrtfjQ==
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4cr4s26mHXz3hhVD;
	Mon, 20 Oct 2025 15:15:50 -0400 (EDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [150.228.61.196])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Mon, 20 Oct 2025 15:15:42 -0400 (EDT)
From: Olle Lukowski <olle@lukowski.dev>
Date: Mon, 20 Oct 2025 22:15:36 +0300
Subject: [PATCH] staging: fbtft: fb_ra8875: replace udelay with
 usleep_range
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-staging-fbtft-ra8875-usleep-v1-1-9592dd390c13@lukowski.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqEIBAA0F+JOe+AWWb0K8serEYbCAvHjSD69
 6Tju7wLhBKTwFBdkOhg4S0W1J8KpsXFQMhzMWilTa20QskucAzox+wzJtf31uBfVqIdrW1UR86
 0zWShDHsiz+e7f3/3/QCE9POSbQAAAA==
X-Change-ID: 20251020-staging-fbtft-ra8875-usleep-77306ea543c7
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Olle Lukowski <olle@lukowski.dev>
X-Mailer: b4 0.14.3
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 4cr4sB5rjQz2x9p

Replace udelay(100) calls with usleep_range(100, 200) to allow the
scheduler to yield instead of busy-waiting. This is the preferred API for
sleep durations above 10 microseconds.

Signed-off-by: Olle Lukowski <olle@lukowski.dev>
---
This patch replaces udelay() with usleep_range() in fb_ra8875.
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de664..d2400bb44 100644
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

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251020-staging-fbtft-ra8875-usleep-77306ea543c7

Best regards,
-- 
Olle Lukowski <olle@lukowski.dev>

