Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511740;
	b=BvFSzTtHfiE9W/EXfHXOh0S2OQ5hSYHiXydbGzYSMqH1VHMaWGm0gPMzcy5lJfCTNZQp
	 M2aKSONx0hMK/HFymqpNhm25MXaBXwp1X94VXVNkU26GCo6DyrhK+DbUyq9acaWMugMPE
	 48aLmyie9RnbxmfZxnYAfm8zd2AhRbiUVdM6Uph3xCIWK7OI1lWWMTZBYju1xjF98z+zX
	 gvkOgg/rsIIZTUsyVvKzhfB+tNfvAPer3Mm+WNjj7xQwDUzRaDNC6jNwTOwemPAv63j60
	 V/nkIuiMpBUYHqTgiJpHHiPNpxTVcX/uDeUuO+gyYUp4Enio9U9oBmTSfjWFDGdylMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511740;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=ccf5XW1NMi/JnOTHax4S88P+nla3YnRILZIqWBgjgjM=;
	b=U5SKz4euQOT0OhhEttcuDXmppHEVZ5E7Z4oAiat19xk5OGB6sVZ7rOWD/zfO7xoGhhbM
	 3gCuIbo0bqvdpJzFXol3Cj7JNtCGBshTArgnMhU6mUTToggIty49VmcdzGEHPcb1oDc64
	 gFtoIl9byM0QfI5XfKV5ksrkrf5HhakKp5Bsv8p4DCM36QYQFTrN0gyRaeln/e1/wx7Kt
	 Qjpe7adFcVhBoUUgn2p5VGZrmAJeh76hUtlOY11llerZ0f65uQcNTDfYk6rwr1QZaGMSR
	 OWlYGh5tVvP08ehabnB4tZ/Uv5Ov/eJJbn3uFKHTCoaaC4Q942SzEMjTwL44UCDrD9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bPHy+O+m;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EA606A31C;
	Thu, 12 Nov 2026 19:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=bPHy+O+m
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jQVmy2WnrzMlFB;
	Thu, 12 Nov 2026 20:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794511730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ccf5XW1NMi/JnOTHax4S88P+nla3YnRILZIqWBgjgjM=;
	b=bPHy+O+m3HH6XJsCkCd8MWKWxpkeKDMounytMr175GyLvuc4HcBpSpg+YquQ4RMEWHyYKm
	YK0u0QHa6hS9hx60Sa/rgW0H/GK8OL2wsevt6KnKbnIOhAhwORERadBq+ZqmLNlfbGnzZD
	DLJEONMw28cjcyjfsHBszdHIEd9rb1E1uZM11vbD4CUvfdHwD3YyN9Yj43e+U0cnIBh7mW
	P/10rf1lAHUuSApilwXTXN7LPsBSnFa/8Ylck/a3/eqJzBg4J7NhB1GbKGE9pd+3vLUL2J
	s6uUM7b89skh4CJ0EpxjnWtBBf4mN3nkPf13scGcoBW1t31xBM58Do3vICa+wA==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Thomas Richard <thomas.richard@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Petri Karhula <petri.karhula@novatron.fi>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: Fix kernel-doc
Date: Thu, 12 Nov 2026 20:27:43 +0100
Message-ID: <20261112192744.850142-1-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7daa768aaa933052410
X-MBO-RS-META: 9azndg7mmh5xfyc7pzicq6bgsqkosin5

This comment describes a struct as a kernel-doc. Format as such, fixing:
  $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
  Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * CGBC backlight driver data

Fixes: b516456e9f91 ("backlight: Add Congatec Board Controller (CGBC) backlight support")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/video/backlight/cgbc_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/cgbc_bl.c b/drivers/video/backlight/cgbc_bl.c
index 3be140284e..63408fe40f 100644
--- a/drivers/video/backlight/cgbc_bl.c
+++ b/drivers/video/backlight/cgbc_bl.c
@@ -27,7 +27,7 @@
 #define CGBC_BL_MAX_BRIGHTNESS     100
 
 /**
- * CGBC backlight driver data
+ * struct cgbc_bl_data - CGBC backlight driver data
  * @dev: Pointer to the platform device
  * @cgbc: Pointer to the parent CGBC device data
  * @current_brightness: Current brightness level (0-100)
-- 
2.56.0

