Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC083D3329
	for <linux-fbdev@vger.kernel.org>; Thu,  8 Jan 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865654; cv=none; b=HkIweoiDPNjIvNGEDlNd54Z4NpIECJhOa8TMyFAd0iLP4ph4rfk5cGZM43Wj9Vf8CI6w+pG7iflkZnYwFqwUAhjLYJ4pd1s6uGB3wsA8hV/3SjP75zv6n0ji0++hmKiyyoVp7J1KVgQAJq5oLA+2b7HGNnFcvMSy4INZgAAAbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865654; c=relaxed/simple;
	bh=dssYB9ZiBeg3VZkmmPibDzS/sUjaPn78Ja8YTcImm8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8Oo3au7NGSkKa0ArAZQl8KpAq7fg7zYCdZ0zNWJQWsCgPfxq8/mpP00InzrDm8sIaaLnRPldHUJZh132nIovctiFNnvMEJwATJ94j5FaHNuNf0O2q2frW//hfbfxTWV/dZsAB8SBsnK/37VNouTu/wy4K1wR9ejANV39FMUFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sz5Jc5wP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sz5Jc5wP"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81345800791so1715957b3a.0
        for <linux-fbdev@vger.kernel.org>; Thu, 08 Jan 2026 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865642; x=1768470442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHueD//8AAJamdtTx3KncyHUFlVGKxTPD0kTSQsmSD0=;
        b=Sz5Jc5wP6Y64Tpo2wdUBwcTLZ2qXF1kLbDX5UPhODFp7CGIFAMcy8OGxU24wIk9BMC
         FnDo+U1j9N+w+blO0ugYuaK8fE0w3aRW/vMuq/CEBK18cY2p40kZx/sH3ToO5lTi3w1F
         7AsaBe5MTwO6i1dkN3mwAZt/JogSVt729ybEJMocNHaUNrgPlSQtD5KiROP0bOsGbGad
         K8Fz/gdels5oqxoPDwkz/P3fNVxRqqU+oHnPIMZANA9rSqF0xnECZHiFSwQtAjD0tbYY
         yJt8/C286Se6ZgTXbyBSD7wOzOjMZEHIdRfJT9h084EZY69silrzJvExokC9cmhApP9M
         pzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865642; x=1768470442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHueD//8AAJamdtTx3KncyHUFlVGKxTPD0kTSQsmSD0=;
        b=BYCG3YQnOkWUnsJwgiwYo6XqteiTawrpQFoCRO2ANLTZ4C0tfSqFJTNQCI4bDLdm8e
         6UJ4Tn6uCXkgU2Zf8xiv/Vl4P0ZGmX9QDnlg7oAVGj8COYW26INHFQhfW9ktHVuuW2Oi
         xzO6LRkiobes77FtbuuXdic/rn3Zx8obUi02j49Y25LElkYThU9uualBC+flRsIrA44j
         gRT4o/q3MbV0ISjCOEuFk/jSTcKihhqcav6lcIQb1vZWAYrcsDltGs33WJLNkOlW7Y+E
         3ZmwOjwm+FeGRvZ4jarjCcL5SGkdlqEQHex2+tsBVb8fDG14VFj8HUhabEBwjDaDUJHp
         Heeg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7WoGecCwLyQwWWy3DQGN6zNBBkzZ/mgvlQdDA6VYt+3/ibUbnI51pnzbO4aQRdNPCOACwIf0YY+q8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaeF5Se08OZevnHRswkjtJjttFKpbwrktm87ZCXe0Qh4IlkvA
	X5NVh+zz065we2CXZbHwMCRmFAXsrWv6KSGXCppNVlLK8gJiUT3K40wk
X-Gm-Gg: AY/fxX7M28KC8e04lPS54PA3YXF1VqX5p5ZRWHKmjm1CNNCW7yymrTaUSgejZd0SDLF
	gtFUyXSKW2kLcqonU2Vzapu9bCsaCSqN00aAnHwDHDig8nCs4U1BY0OIQ8WY21RsrEoOFGj0XYo
	7wf7dpLvlVB+0W0+DFuD5h6gA5egTgG4uJTP2OJ2Bokn4CqwMdmZWKn741u3bW4iRaKFEsvzSvY
	8tA/FEYrlmL2QCx+OxSH7GpAXtg7+8MPeaYX7Pdo9j8kS8SwAaJxYaVUmBcmJUhTaUl3A/u1o2A
	J3+0I0nF7LOVz7oVnlQWqnXzJmD1RB9KnV3JB9X+hwawKNq/b7unSJczw/LoFR5OcBVAkkEvgeg
	oU5h5I0k5dTLPvqkaC6T4Aloq2cTz+2nHtRmI60uVp3aQJE/wL3R3xUxhYsR34r0qFTMSRzD/rd
	SLi/abb0KwaLlHEvvHCcBnt+UFxyloxGYVTFk6MyVSreoJjxzakAHrHEWeAmfeDNeJHl+48w==
X-Google-Smtp-Source: AGHT+IEbE+jBmq+j0BRN5nADLvU8jxL1ZMAc9aObMxYhpM+qu+5ZyALvccqrtar+8Lm5985P6axv3Q==
X-Received: by 2002:a05:6a20:9184:b0:34f:2f38:cad9 with SMTP id adf61e73a8af0-3898f976c60mr5324357637.53.1767865641705;
        Thu, 08 Jan 2026 01:47:21 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:44:c9c0:8d34:cc3d:a8c9:1a48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88c2sm73602135ad.79.2026.01.08.01.47.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jan 2026 01:47:20 -0800 (PST)
From: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chaitanyamishra.ai@gmail.com
Subject: [PATCH] staging: fbtft: align tinylcd write_reg args
Date: Thu,  8 Jan 2026 15:17:09 +0530
Message-ID: <20260108094709.92561-1-chaitanyamishra.ai@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch reports a misaligned continuation line in the

fb_tinylcd init_display() write_reg() gamma table. Align the

continuation line with the open parenthesis to match kernel style.

No functional change.

Signed-off-by: Chaitanya Mishra <chaitanyamishra.ai@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..60cda57bcb33 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.50.1 (Apple Git-155)

