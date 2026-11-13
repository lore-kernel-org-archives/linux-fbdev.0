Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570457;
	b=zME0e72LeDE2d/h6tyV8S0oaluH7wNfYb/uxr5bhYhc1jR5LvOWQtyv52Tdn9Or6zEba
	 76wFeYGLqzKOr32y3idpBQOmrMy6EOjqeMmfhoO7tulwbCH5dHvFr1T44poTfuqoYxFn1
	 24gk9RgSmFhEMLXnwBrOlwJ18223mxwjI/wr7NRhVuv4t84+ePB+S0DkQzAJa+g9KMiW9
	 dXY2UkJD7d3I1Aw1NX+DZWE+HH0syhJdwLldRLkITP+//I4cmo8i7RKx8hqCApMUfE1Bg
	 ByVbI5Hz2FfA23tbnPdcA0jsddbDMIuEbvyUc2qK0vwkJumobOfK6kNJCOfjJWWMqsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570457;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=hw6iuwPNz9xqHLB6VPecRpVOyJoujoDzeolzbUQLp+8=;
	b=EDArw+zlSGSC5HD4tlq0tqlCCT84sBpsRgsk2Ve3ZI328gEZu5uGDB4vtIpsq1c6gRY2
	 7XgzrNae4malF6jCajN4LyUuXHn3WhGJCCnOkyiXXriesgRgV5ZDVxbYgAZPEW9G9OaOM
	 gzWrXyiTuWQix4zqSW+OrvLvMLkNLDwtjtqYzPUSkohL33UO6D8GiMotKiXBVwftwTMlD
	 CnBaiHEdc7JRSClj55jlXkTOQ48DX3lI2EdGHT0Tvj2ENMBk4xIQ6BpB7JbusTrBEQAGA
	 4eh5xnOA+Rma+cGs2F+3G+4yaXObChWcRHh7QxKFY5kkN99HLcE4opneIt4oql1QLWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=x0E1WDdV;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E4606A883;
	Fri, 13 Nov 2026 11:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F10E4606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=x0E1WDdV
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jQwV70xgdzKr56;
	Fri, 13 Nov 2026 12:47:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794570447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hw6iuwPNz9xqHLB6VPecRpVOyJoujoDzeolzbUQLp+8=;
	b=x0E1WDdVP4c9oqpyfQAwOc/vjGHZ2uDFSX5kPvZydwf1eOVyH3B0NUpQonNZLTDwQttkFS
	pKnceJtSKU2t4esGm59G7LYVP1XOSKwOoiuFrpXzA9CxW1bBjGJa5esXD1mpwGEuWbMkuu
	9ku6OJtwufgLAaXb/7LnLEUhfyH8V83kudYCEk5dt46NF7YHXMhF90YQIuHG6zztsAtZkw
	zS/HlowPvka107q5puvkiuMD/LpDCWcP8TgHBFq5N7VxzB2bI6oaSLqCuoUD49kOfWBo2t
	pYMtEgj/F5dGglax32wYH5Z9vp7yGCb9pUtTUngdTFD1mL1jFm8Bq39b4msGGg==
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
Subject: [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
Date: Fri, 13 Nov 2026 12:45:52 +0100
Message-ID: <20261113114552.895592-2-manuelebnerli@mailbox.org>
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
X-MBO-RS-ID: 76b2e7b13eb03885d2a
X-MBO-RS-META: d8ac538mishf1rhdaakw5ozqknkm43q5

This comment describes a struct as a kernel-doc. Format as such, fixing:
  $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
  Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
   * CGBC backlight driver data

Fixes: b516456e9f91 ("backlight: Add Congatec Board Controller (CGBC) backlight support")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[v2]
 added 'cgbc_bl: ' to title (Thomas Richard)

[v1]
 https://lore.kernel.org/all/20261112192744.850142-1-manuelebnerli@mailbox.org/

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

