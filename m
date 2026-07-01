Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721040BCCE
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904355; cv=none; b=GP6TR3yDiU15LIkHfjvEvBe/thng3sfM/i5WxduQV1gQ/rLjHo+upyJcNVt4z6WkmsuKE7nxCvV0TNQrvVI9dIW0My3cPYN4Oue30F39gZBS0qLKatauIraufV6pgwZss6esFGGz6Viv4A+18mRkn+rLpPF1756x+DNBJ5HtRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904355; c=relaxed/simple;
	bh=aeXVj6xt4QLaE5ZubVLapizM3pMzsZveZsZvA4exgZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CiZn9nYxT+/lfShTd+EIiVXOsLVwpHClNxWiMGHuF7PNP4lUrDNJdQb+MKbNbgE8bTD9SNJFlmrdFZYM0fysAq4aHh8yfQ8LbMEP7yxgjVMXtpBfgT5BVxPDquno4ij8H7zyW5DfuyHYeprzkP+52t+gig3xadO/Wom1hWKFnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Ob0bBk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Ob0bBk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9dbd00f1dso2831955ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782904353; x=1783509153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
        b=R4Ob0bBk3lEKb4xAyIkFLcf5k31lef9NAc2PGKv1DNcrGEITFCYCwWHkLNti3tpgEZ
         zZVvnk3UdaGD7XEaWdVGGIQBPmgXCnUasW71a452uO7F+NEGmA+M/g8UPZvOOs6wzFVN
         TejK6oZnF/Yf4r1/7T7XvxqYUA+VFMNr4CgKzS4sCm6gJDWKsT3jbgHjASr2j9lVmeZg
         V6KS6cpI6zwDSCkP58GgCk3DiQHe0xaD2yw/ZuSPU2kIZn3cSC5DTTJWm+4w94gslM4S
         Q/0CS84f5cin9tJEY1U2R42YHRAsk/UsDmhaJ/OIuD/jwgn4NILEFJkWFIj1EgM/82rG
         5+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904353; x=1783509153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWJtxV4Ta72iy42vKEzWLu7hcuhePMIVVuTHVh0+3Bw=;
        b=IvF10D6LMOOxSdSMkoYbvR8QANdBqnwksFdBL/WDzAjz+IRdqpr09jFdukFtLCRw5A
         v7PWnLUinUpmc1bgbhC1Y6iHBXxzSghP1/aOOb6GHU1mH8b5hTK68RfPpRtLzlWa/D18
         4Gb7of9Soa37DJZLeQA+FZIbGrdLEv8YfFggsFoAm9PLbBmPFHNAK4JGTbORixfl9I9R
         EQta1RcRDa3ImojN9jP+QY9fonFxF45ubh6Gl1YFyZe4nx/kEoSWrlUkrhDaVQulPmr2
         ZrJDzrY80Sssn7pc2qPbO4fCQBLPQMhVLW+M8owuKwQbTSTQ8gcNRDe0+kqZ+C0ZCxKr
         28NQ==
X-Gm-Message-State: AOJu0Yw6/8nds9fONG6y+V7P6CIC9gf7L3J2YcdfCl/89KzsgaJObdJQ
	hDZumWd+Xy1J3h77K1VQnI+D2TkKzeJBY8PQy6putiPd75mApTkwJaM=
X-Gm-Gg: AfdE7cmfPSaM5veUSlIrzgBmI6BXZmTHrj8J5OXh3qOksAgZOlcN8UZEt6ctpCRUVF4
	geu91vyWWUaJSLh8YGu4eT1ST9osivc6E3uBZTbPWf6MJsp3nT3AyxU+b7t2oR8Z6GPJyEM4XXN
	gjUsKlrw1n4uSZjJKAO+b/nKu7NjcuJwUd1h+pFj4W0ZXAP5756Fwcz+vqitf702UwN+8/4P9+W
	+9k2wmjGIRsp44GQU2TKBT/Amtb3APfNpSp1uYX4PJSa5K9/1SzX8OPz6FFhcEotfaFT/LYxCuS
	gMrpoGRWwdfC3pNHkmPHN7fDl8HUtjjUR7fhkk7kKJE7R/ieuh599wtG/7WPOQOvoRlinwJFf6w
	LKxnIH1PGVGlTohiS05kqfSBIUuEH13GK6S/CDEi0kydZ1ofPiNVmW/gVkFzIJ8IJNPUq9z1BY/
	nb1mzWy8pmdyK6gh4eOJyhZUpAIlql1LU5T9Zo1JfA5pb7OZdH1K9n3Bjci0WG2AAB5jwHly0Qy
	MzGpAlvQ8o3NTKjeggqn4FjKHYofG0+mGvZtngkUWrFM/Bn1Q==
X-Received: by 2002:a17:902:d4cd:b0:2c9:bd64:8c81 with SMTP id d9443c01a7336-2ca7e6d9f27mr12395735ad.18.1782904352730;
        Wed, 01 Jul 2026 04:12:32 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a71053sm30977565ad.8.2026.07.01.04.12.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:12:31 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Michal Januszewski <spock@gentoo.org>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] fbdev: uvesafb: unregister connector callback on init failure
Date: Wed,  1 Jul 2026 20:12:24 +0900
Message-Id: <20260701111224.48646-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uvesafb_init() registers the v86d connector callback before registering
the platform driver. If platform_driver_register() fails, the function
returns the error directly and leaves the connector callback registered.

The later platform-device failure path already unregisters the callback.
Add the same cleanup before the final return when platform-driver
registration fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/uvesafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 9d82326c744f..ccc9dbc25813 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1907,6 +1907,8 @@ static int uvesafb_init(void)
 			err = 0;
 		}
 	}
+	if (err)
+		cn_del_callback(&uvesafb_cn_id);
 	return err;
 }
 
-- 
2.47.1
