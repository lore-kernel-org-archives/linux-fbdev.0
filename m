Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99B1C93A0;
	Tue, 27 Aug 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772364; cv=none; b=tit7ed9LbozDzI0A4CvbAaabm99InKszpGBmMj/ssw3d7E4ULHeAwzdzVw4N8FCERnsnkOwxcJc8Gbdnhznidoe42T2ok+b/srhfqe91lhHmFhe4AruMe67NWTHsF8SrwSCdIZ3CaIaLt7oHsYOVwVkKqrtP0/RGCDfXKj5Zq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772364; c=relaxed/simple;
	bh=WOYVZE4elMTLqZPSxOgwkH1342itHfJBnZKFofqCp5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ugNpZIre/HUcQQRz/GOs08UpmDltX1ZI5feAI5L7crAPiFHwnBkZAqA2Emj47WdIuIaFSKoU6+C1BEnzuAvfgUbl04kGTlrXBtXLon+2s3aY1TsPrvSRAHzYNrtvdgTWVS26H4ur+41qnwTQxq6n+Uf5FRI0qcWuC0XXS7BRZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HLfKAd4e; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HLfKAd4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772359;
	bh=WOYVZE4elMTLqZPSxOgwkH1342itHfJBnZKFofqCp5s=;
	h=From:Subject:Date:To:Cc:From;
	b=HLfKAd4ecE+/8gyl8MCAFIKbgbfGjs1KwNPoWCG8FoHFUDl/x8BRDiv7j8uSddGH3
	 lBoB7RO2cS8ImEqpZVPRVzxDhu7lWGJ2BYbfiQA09RNyZZr6ySgmJUt3K4O1tEQFTZ
	 4Y9BuJoKV4s0GQUE43fH5NWoSDj2WLe9BQZ7DM2w=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] fbdev: devm_register_framebuffer() and some fixes for
 efifb
Date: Tue, 27 Aug 2024 17:25:11 +0200
Message-Id: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANfvzWYC/x2MQQqAIBAAvyJ7TjCRlL4SHUzX2ouFC1GIf086D
 sNMBcZCyDCLCgVvYjpzh3EQEA6fd5QUO4NW2iinrcREaZP8cmKJXrloVXDBTNCLq3T7/Ldlbe0
 DpzeC910AAAA=
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=1005;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WOYVZE4elMTLqZPSxOgwkH1342itHfJBnZKFofqCp5s=;
 b=7cFNZ+8YbmjoRNA/U+xUZ5sibM8RhEZT+/vLwKa+33Kcp1wG/avGokCL7g33hhDDxZUHHeYQN
 ZE1xbeLEmY2AqydNSyVqVIFTgBPSQLkN9ugkgttLb0c4a3qaLqg1hOz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some random optimization and fixes I came up with while looking at
efifb.c.

I can't get the efifb driver to probe on my hardware,
so this is only compile-tested.
If somebody could actually test it, that would be great.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      fbdev/efifb: Use stack memory for screeninfo structs
      fbdev/efifb: Register sysfs groups through driver core
      fbdev: Introduce devm_register_framebuffer()
      fbdev/efifb: Use devm_register_framebuffer()
      fbdev/efifb: Use driver-private screen_info for sysfs

 drivers/video/fbdev/core/fbmem.c | 24 +++++++++++++++
 drivers/video/fbdev/efifb.c      | 63 +++++++++++++++-------------------------
 include/linux/fb.h               |  1 +
 3 files changed, 49 insertions(+), 39 deletions(-)
---
base-commit: 3e9bff3bbe1355805de919f688bef4baefbfd436
change-id: 20240827-efifb-sysfs-ea08d70c8c46

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

