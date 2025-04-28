Received: from ksmg02.maxima.ru (ksmg02.mt-integration.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0625D54B;
	Mon, 28 Apr 2025 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854890; cv=none; b=kLAx0eZEQz7idQHYPi1JBHMXVTPo2jxuSFsCGjscdaINwQ4Yy9OpPqTINF3p90lluvUeSDtPNm1aO+YAT6+zX05GfSb5rSCVb4c+rZ2/B1ZTXzmCDUMvUDD6puwFVKe33ergEiWCUh7kFqgWRQRnx+YxPL9q0GwKxSEtFTgISrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854890; c=relaxed/simple;
	bh=0NFN/7ts5W1DCTgPaUMeIVw8qEUxSvWKMMoVpxYiz/o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NIPDLCZ40KmPJd9Z9+fMCN1d+9wjAdxdgh35/o69WD7ad5rUQawv2/ca7+Ts8ywAgApWFiiOv6BeO3Ep/nFoZe47Elj7zMMrdXDjJlA+wo9SGc308mQPOdJJ+8zPvLn9zMevFcrY7cCOOJscJlqYZAXmA4nHk0O90ESUIk6YMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=DWfcei5e; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="DWfcei5e"
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id F27A01E003E;
	Mon, 28 Apr 2025 18:34:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru F27A01E003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1745854497; bh=ZS+sfkXfHx9Y98t0ndNQwB5Sc2zKSAG59d8lpKp8Eac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DWfcei5eLVpu/QXTHelhU91zktJBecVvWLZie56ybCSppJ8E4MdXl9JmyZA9Ny/Fu
	 BgumBPyDz5m+SPr+OaYgvvHHkh+K36Le6fReLA4Sj4V3p1nL2iyzKrA+5bk38u3zZy
	 tvmX1/Wiy4tWhfdXSUVWhm/OGiAtJoZwMLlxe8WZXS+OGBV0GTtuOqrbtBz3yu4kSp
	 6uCxtz6onlUzDcNNLPE1LW+gJepNFPzRXcZPeFh6V4hk8yQHsS13LTIsdCqfPVoXiR
	 hzGmt2qodUxDuE56PnhRCSSIm8HRaoZL+ZUFrmHsfKSKsVHCg+XFrrupj6cbNRxfx/
	 ML4B+FjRHoqtw==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (not verified))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 28 Apr 2025 18:34:57 +0300 (MSK)
Received: from deb16-01-masimov-t-build.mti-lab.com (172.25.20.25) by
 mmail-p-exch02.mt.ru (81.200.124.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 28 Apr 2025 18:34:56 +0300
From: Murad Masimov <m.masimov@mt-integration.ru>
To: Simona Vetter <simona@ffwll.ch>
CC: Helge Deller <deller@gmx.de>, Murad Masimov <m.masimov@mt-integration.ru>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	<linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 0/2] fbdev: Prevent null-ptr-deref in fb_videomode_to_var
Date: Mon, 28 Apr 2025 18:34:05 +0300
Message-ID: <20250428153407.3743416-1-m.masimov@mt-integration.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mmail-p-exch01.mt.ru (81.200.124.61) To
 mmail-p-exch02.mt.ru (81.200.124.62)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 56 0.3.56 52db7f275cc9b6820389ba9ab2ac225370e1c244, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mt-integration.ru:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 192977 [Apr 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/04/28 14:14:00 #27936619
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

These patches fix the bug that leads to a null-ptr-deref if
fb_videomode_to_var() fails to allocate memory. This bug is present in
do_register_framebuffer() and fb_ser_var().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Murad Masimov (2):
  fbdev: Fix do_register_framebuffer to prevent null-ptr-deref in
    fb_videomode_to_var
  fbdev: Fix fb_ser_var to prevent null-ptr-deref in fb_videomode_to_var

 drivers/video/fbdev/core/fbmem.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--
2.39.2

