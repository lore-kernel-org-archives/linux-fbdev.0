Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743928;
	b=YzqPNRoHyccfy+SEq8E62m3cSc2x+qhrPGInpr/J23meu1aKf6lM7nsBsGZ01Zz9Gdbr
	 xXSpGF6Od+NTuuNfkl4dF2wEKohRjOnxw5xG+QHoWMARgaTcg+k+akCRg0fXsMYCxIBV+
	 OIpTMk4I/K+2acUf02WTkefFpXZcA7zdYy+XACUSe47FTz/GIAdx/AVoR5nE4D762slRZ
	 gwYC4e7MTHcmdlId5jyZdAHft4mTlcbam9O0lfmau07cRav1bncCiBzIaesyJvhD9JCsw
	 ujm5Rm1KtQCbO+MKG6a2Noicy8W9FTbXIwntla0jahDGOPXV6CdIlgMqg3El8pHgKVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zhleLxlgO/8KkinCeUWj94TJDi+jMt0bo+ONkONjbbs=;
	b=R5zjiJi0Nb3V7tTrYmNx2B2tM6Xy8rckZuwecGWEKCVRtWeiC2zpsBTIEzwarhAyZdUk
	 qLumyQxMxVPGVVx75LIcVQuHnETHrIUyecF+XiMTO0Zad82Z7oTxRRUAC8X9OZatM/82Z
	 vcVOwtWpiEZos5tK+OnIdaktDbauAeZC6GdV+z7iLwvWOGxTNaPsMnD8Oz5NAefHwJV3+
	 P0sO3c/RBIvdOOxvZpSamKluYBzp9k4tVqT/I8RHW6Di28PEMyhMLJLD9d4VbbUVoLZTZ
	 9wRpctlIxEaAckba3fhMdgVx6dKH5CoCIDyobVDOrLEzdXFOqDgVygli5Vle6j/aK8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNQaeexo;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1E606A32E
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 22:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE1E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNQaeexo
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2f2edb19so11362385a.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Nov 2026 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743927; x=1794348727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhleLxlgO/8KkinCeUWj94TJDi+jMt0bo+ONkONjbbs=;
        b=dNQaeexo070rGE4C/67h8WZNf6wxbBnzJmOcC528E3v+1GzJUyNnnBFGW4h6hMrHL/
         9YGIZ1lILzlQG4oQsYxFCFML66YMizEVunqW3ESxUpYwqUusW2LzsEMkfJpl9m3wO4EX
         aTN9DykuxDO4cPmqcPJm1J6EtKY+nmY5/UOFEYsw4tlESAmrffp444CWT+0l4Dg1qkc3
         9k2qtypqc7jXlOqJu5vCvsHGoUTxZFd+IQ1aUfw15RNA0Etohudj3DLnTETyoG1ofF4x
         3Kd32c7tTl/e7zsbAXSW78J5JRhZU4boOkyGaVMdl5r3FUBd3PI0NjU8R4zFitaRoB4F
         z5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743927; x=1794348727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhleLxlgO/8KkinCeUWj94TJDi+jMt0bo+ONkONjbbs=;
        b=XP0G9h0kUqsHo9EbXCPwk29QHgQ4MnS2o7CN+FnB2hCVU3ME6M9wRdRF9A3VPDGz3/
         qG+D6KADVTaITpr0ssWb0GZdm2o7Iyz6zCXg7Tam3CSSovZf5yR94nyY2gNHTy2A9S3n
         Y8i1XZ4vDyE2uPZ1AcdyyNsV4QeWY93CCrikNimz+T0i+qPPYWr0P6FNIGnB8XnvY6Lv
         kKN4Bh09PAAyNKNSOOtjdS6HYhAeG1X1GEzQQOCNloxPkIVoW9Yu2aOayke7tDfnD6HY
         g2cB8xmMH6sbCeuHcWDB1uxuF8kU9lUT7UkJD7U8Kl2Kx8s2JvW3SwGW0N1EA++jrOw+
         4NJA==
X-Forwarded-Encrypted: i=1; AKwUvBx5yWyXK0gkTXFSAhart6TS61xsCtkmb7xnHKZw3iHpTr8uH/Lud0w14vz0ZaDFyI2KL7osh49coouowA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ExnxqUzErwLHj9BJkV7XQtQuTrOI7EsnN+FZnbLAcx4rThJ88
	JvuvTFJ13L4z4L5ntEp5xWNKzFDIPS3u794/PK0QARTGX2Piyw0ACF2Q
X-Gm-Gg: AYBFou22+dkPmme+l0GsGky2QD1AC+OqBXKcMbnbkLAw6hCFCwg+hs2hD5oJopB9mSD
	hRBm1AsM+nNeTqMFsdA+5vflah+CNR3l9CStflFjF9GVX5M2w5IZ71ERizQETlBV0pL/K6seXYZ
	XP449aZcyW88EoijOG/QdptUg1Sgr45S0JjGl9axb0Z9jww8N9td5qt45jAlhe5OT05yedzL2gE
	sW+PPzyhyPqx27n946DzBReDOrOWVCKZ/nN5vKxeO2H6wWcRE+ELVE3W/cp8GVzoriQnN85JGeI
	BVS+tOupgWhpTgLOO+/ASdy7kugGPGEpNMSqSEkfig6BvtDDeHe5R4XHF0LcRtvQTyKmykcp53I
	rqKTgKOhAV01IrXp+2+RPzR7HU3qL3iHDQJ5gUYrxLaWF/b/prI4U27taP+6Mr2uWN7+SgTXOsu
	fXOBybnInnY0bPvFXn1VdVEPVQaF4Hpd9M2eyMe81iv61HcNp8JroDW2rIM/UY2YiinYgmh+6iX
	BD5guhsOk+YEMlYouEPRsE52owJl0Dd8dBuNekkrLUaChV0QvVGcaKEiCb158gH459CJCDEVZ0G
	+ECsB3mf/fzIPZQsfI3oT8iINm733SBr0kkcjj9c14AddJ7ALcS1YODIU7M6XdXxSxivUbDZJm8
	EUoYItat0k74NrJ/8uUvTNFXPdrGnV+zpthE=
X-Received: by 2002:a05:620a:2805:b0:93b:d79a:c463 with SMTP id af79cd13be357-944216db682mr2344562985a.59.1793743927168;
        Tue, 03 Nov 2026 14:12:07 -0800 (PST)
Received: from codespaces-be20d5.ynsnsb35uh3ubhr4tvarlepncd.bx.internal.cloudapp.net ([172.191.151.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844be4sm39276485a.29.2026.11.03.14.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:12:06 -0800 (PST)
From: Eileen Blessing Kabi <kabiblessing5@gmail.com>
To: outreachy@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eileen Blessing Kabi <kabiblessing5@gmail.com>
Subject: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
Date: Tue,  3 Nov 2026 22:11:41 +0000
Message-ID: <20261103221142.45100-1-kabiblessing5@gmail.com>
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

Fix the spelling of "written" in the write_vmem() kernel-doc comment.

Found with codespell.

Signed-off-by: Eileen Blessing Kabi <kabiblessing5@gmail.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a15414..c4db681eb 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
  * write_vmem() - write data to display.
  * @par: FBTFT parameter object.
  * @offset: offset from screen_buffer.
- * @len: the length of data to be writte.
+ * @len: the length of data to be written.
  *
  * Return: 0 on success, or a negative error code otherwise.
  */
-- 
2.56.0

