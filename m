Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775657;
	b=C/pmDlR9w7+1SxWGLPdG6lcDE5P7Zm+uK5d/o+Ds7gvjll+E3vu/QniKqo577e040e+9
	 JJ5mSEQGKyV2gR6GJ/vGxSuXvYpj7SSZxWYFmVHW9ak/SGPcXuQtz0zAnVG4QUq+8I4Dx
	 bAcVlz4MEt91tdJRIzwTb7x9fbPZ8OD7XmsVME99QoqXwD2jA91vMXwfkJ1aroLDY8uZc
	 ln2pkaeBX9kbzlMcJnieSwnUHLZyNBYC2y3nCf1HjiDu3aBz+T9qRFywCW6iKhYGtqeG7
	 T73xZBVwGK8VIVj1SDm5ynyqGLPS6V7fHSOF1TEsf1NDJ2zJNi8UhYm3bYBs5M7K3Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=12R8+MxmoCMK3Pvk1lqEg5lov8oGmq9pon4JJH+fMUM=;
	b=QtK6QBUY61vIpOJlByxSk262qUCKUL2jzluTkU23DniP1qH6kH1Y04SIwbDULlcZmii9
	 ZcUFhgPH6qRBM41tGfxfxyyIsGy6icrwibFwP9xbauCK43nTd2SUB4BOS8YODPCxkb631
	 0K8/+5YnrO8PD5DHBU2oMh18JZqGpKmHnTZZTlLbu3aiR3ycf5attuypd5KUDB58s7+Yq
	 iFXnbPSbs2Q6Q2aDC0w3Fh/SMpdmUiRjtvzHU2UTAfQmadzKh8EYym8yj4SJl3AT3Aza8
	 4C8Ru8Pm8rgrFCk94h/bsueUlbUNH8OPJ/isVuNSmfcZSZ/E6TNafcy1pL7Pgi74/eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQMPExpF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54E606A31C
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQMPExpF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E01F00897;
	Fri, 27 Nov 2026 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775657;
	bh=12R8+MxmoCMK3Pvk1lqEg5lov8oGmq9pon4JJH+fMUM=;
	h=From:To:Cc:Subject:Date;
	b=PQMPExpFdlMdxmUO2KahNRNrA+Kixwz2/YhcsQut2hC3NR78H8DXxKij/GC5ktnSm
	 MHuVRqFEPvJDZjgKZnzomlFp0Qu9twn8LVj3Pz9jNNQBdnmGDkhAfbBT2niz456lqb
	 9IpIcqBAb9hP8d5KB5cs58ZAQ5cird5Bd9J6MTRCiSCyoSfu1AbACzi4OYZhci+BNf
	 VsLpTBpDnGyB3hSXfve+iXTnycEiuOdCT8o/1gNtXyGFrFzKrXKz12u5okV3/pXZtc
	 A8Jt3SfYNUwWKZUto4GoebTdisCTlZXSBtw6oxLpe4g5+s7W8CTKYnwpB8aIbK1TKv
	 gL3zn+ywg5kzw==
From: Thorsten Blum <blum@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Pengyu Luo <mitltlatltl@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Junjie Cao <caojunjie650@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2] backlight: aw99706: Clamp negative brightness values
Date: Fri, 27 Nov 2026 11:33:42 +0100
Message-ID: <20261127103341.663905-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=blum@kernel.org; h=from:subject; bh=rU3L8+ljDsDEvOv0FEVg6DJCO+bDkPX4OtCb3WNCsdA=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNmcMa2yW3Re+UsqXr+275Hjg6b5ixYaiZ/eUbXIMHMNl /yr4wnnOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAi8v8Z/ievXCh6+N+fvNSl HVEPDOync/A1qrr94j/ome/m3Fhw+jsjw/Ov712yrig3nDyXkaxny9bhPuPOsj2nHIQljjy1m7n rLwcA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

device_property_read_u32() reads both the "default-brightness" and the
"max-brightness" properties directly into signed int fields. Therefore,
values larger than INT_MAX are interpreted as negative and pass the
upper-bound checks.

Read both properties into a temporary u32 and clamp the values before
assigning them to the signed backlight properties.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Also clamp the default brightness (Junjie)
- Clamp both values before assigning them to bl_props (Junjie)
- Update patch subject and description
- v1: https://lore.kernel.org/r/20261127021423.656745-2-blum@kernel.org/

 drivers/video/backlight/aw99706.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 43f82c83f91a..1ea5d0d2146d 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -265,18 +265,13 @@ static void aw99706_dt_parse(struct aw99706_device *aw,
 		aw->init_tbl[i].val = val << __ffs(prop->mask);
 	}
 
-	bl_props->brightness = AW99706_MAX_BRT_LVL >> 1;
-	bl_props->max_brightness = AW99706_MAX_BRT_LVL;
-	device_property_read_u32(aw->dev, "default-brightness",
-				 &bl_props->brightness);
-	device_property_read_u32(aw->dev, "max-brightness",
-				 &bl_props->max_brightness);
-
-	if (bl_props->max_brightness > AW99706_MAX_BRT_LVL)
-		bl_props->max_brightness = AW99706_MAX_BRT_LVL;
-
-	if (bl_props->brightness > bl_props->max_brightness)
-		bl_props->brightness = bl_props->max_brightness;
+	dt_val = AW99706_MAX_BRT_LVL;
+	device_property_read_u32(aw->dev, "max-brightness", &dt_val);
+	bl_props->max_brightness = min(dt_val, AW99706_MAX_BRT_LVL);
+
+	dt_val = AW99706_MAX_BRT_LVL >> 1;
+	device_property_read_u32(aw->dev, "default-brightness", &dt_val);
+	bl_props->brightness = min_t(u32, dt_val, bl_props->max_brightness);
 }
 
 static int aw99706_hw_init(struct aw99706_device *aw)
