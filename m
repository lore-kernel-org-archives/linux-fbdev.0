Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D03FAE1C
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777544750; cv=none; b=LWuSz3OihvYcEV//gUwkFrca+iLEVjIg7rgSGIy+gQtR/R2pqnZu39kHjLO891+j+tM+53V9O2RW+WlLIYuLxFvAazrtN/J7NMi528Kb98iVvYDKHTGPtcPl/41UqZ+lIliExqcgAwiog09Q/mr0qpQTzsW+Nvx7vYpzBlSs7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777544750; c=relaxed/simple;
	bh=3uV3oobCX+C+KtmVFK+xxp2L0k+Bn/WYb55L660d+6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4V2OJL/yQDoFUJNyc0dV1UZfv95lJENUYMW66OOIRcVPpMMpqbTaS3/ZGGKgpePhpq4JfhO5vYkkK6hhLoq/JeTuzP09qwmkVC30kEmIaGIKMkaR78tAQtMwkwz8OB1S/9rcXD5tp32KTMcisTfmB2gEnn2jIuXPJ/BCrJ4pKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzhPH0Zf; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzhPH0Zf"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2d9916deb14so172545eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Apr 2026 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777544745; x=1778149545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uyYaWTV5ahYl27fxYzw7aiTm9/pi+cupE4KnUEMoGHo=;
        b=AzhPH0ZfGXZXWR/soO/ujP62PkcLmJex0pQoCRkDuY0/LYu3FNzMEqSGXdH2Bp1VD/
         LG4s+NRhdmUzB2RGGBVwDeA5w3utCVPKJsW8swJDvwVmnfJGfSJY/nvDaBsJLPgeNGgB
         t4aW6bBFw/Ey35BwT2qPGqIptcZAkI9d0sqgKgQhJNELaJZMgwKCX7zswbDqnTp9pzgZ
         Y4+SRm3HK3XVJpZgIdF55rlWRjX9szZLriUQegnzqORJzm4JdOUcYkErstEwnEjxruut
         EU/k2ngQcP7UjjqUo8fHHCgTQ/FpO0jTp/LFgVGkKAAIMn0xJZq8fC1+PSdQwCi0A3Td
         eQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777544745; x=1778149545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyYaWTV5ahYl27fxYzw7aiTm9/pi+cupE4KnUEMoGHo=;
        b=nBtksP8i80TJD0Sa/jWbJz9GK63KhtPa0KAXNuVroaT8aZxitqqgxHstLpdfDQdMe/
         haTA4nfKlJuh8Qh43nK4EXAfxxQRzsBlDOuZLgFU05gvlWSetjoxq3CCckKxbXVmYtyx
         PFXY0VyaTzyUIiUsVs3VKKCCKDik6Wwm1WmSwjb4Z8+CgTu8DPHRqyfbF/hBUzzFGlHD
         DcAZwkhQZ/g56BnlBNR9fkwSXnBtF9qiovFS/u+wN7KJlRnYVNIzc0nizo38uOFI5TCz
         zFFVqDLqvXFAU25d332wipLvX+HZuNCBhYaB9xgX+TeUUpmrVKHm8ZZXMD+l/LpMbzyO
         9Quw==
X-Forwarded-Encrypted: i=1; AFNElJ+jO2B5gX8J60QCFWJ+oWRqdPw5TaIwBQIfOSXlu0Cy5cxsYOQy1X4HkPXb0m3GANISBdcpKd6qHoRkbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmS4xKqn3ph2BPDwjYuZzHpmy1PQzNQnPBLlCU1cjoty4/IPC
	FqKKFDIQ+JPM0SpWon+rWTbFLYrxv5vI9/y3IeQMZxAwqB8anRCLxgDg
X-Gm-Gg: AeBDieuz/5whGqeLLlFiIdAboSOCPp4B4X1peX5ofFWvh0ZyOTKpasdS4HnpNC2PBmx
	+ZQJjR0jWU2/Rf1RKttJoftTZL4yrYSGiRyb9gcSycqmFcupCuyw9mEyB0XAQMyhIgvUR5hMKCx
	+hLOUIKaA9ehg4D4U2S5YV0oZARHGT7GcaapdLuX8hKmKKrLP/Matt8TCRffujCmKwCVln4QlLt
	wwNJFGg+MMuF/VKW0BS4FTsLTsqYc4gEUcbwbM+du1lPYtIGj8fADVY94XGhl18xMKHSxu/gbw5
	HoYmWpwV8XVA3rNHUOYDBr9TJEOpkWwPQ7ahgBrd3NTYNnSq+z4Y7/k1B+ZdhoaA4mRfmc6/8bw
	mxh/mG6tGoJtAL6ywhRARx0Vsi3xe0qYUwSZK/O4rcZ2vAUWYkyfWTGqpxHW5nM1AGqQtMekCVm
	Z3WwGR1hB5qts4cPqTXeKe6/cdmytL+8pd2EjAJHoaUDSRY7drAm0cLJOYx/qjzFBVkw==
X-Received: by 2002:a05:7300:e614:b0:2e6:4d6e:2cbd with SMTP id 5a478bee46e88-2ed3bef29dcmr951391eec.8.1777544745512;
        Thu, 30 Apr 2026 03:25:45 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d419sm6191614eec.2.2026.04.30.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:25:44 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: gregkh@linuxfoundation.org
Cc: andy@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused function fbtft_write_gpio16_wr_latched
Date: Thu, 30 Apr 2026 10:25:29 +0000
Message-Id: <20260430102529.25019-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function fbtft_write_gpio16_wr_latched is not referenced anywhere
in the driver and only contains a stub implementation.

Remove it from the driver.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/fbtft/fbtft-io.c | 7 -------
 drivers/staging/fbtft/fbtft.h    | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index de1904a443c2..7d331eba947a 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -227,10 +227,3 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 	return 0;
 }
 EXPORT_SYMBOL(fbtft_write_gpio16_wr);
-
-int fbtft_write_gpio16_wr_latched(struct fbtft_par *par, void *buf, size_t len)
-{
-	dev_err(par->info->device, "%s: function not implemented\n", __func__);
-	return -1;
-}
-EXPORT_SYMBOL(fbtft_write_gpio16_wr_latched);
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 317be17b95c1..c7afb0fd3943 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -262,7 +262,6 @@ int fbtft_write_spi_emulate_9(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_read_spi(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len);
 int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len);
-int fbtft_write_gpio16_wr_latched(struct fbtft_par *par, void *buf, size_t len);
 
 /* fbtft-bus.c */
 int fbtft_write_vmem8_bus8(struct fbtft_par *par, size_t offset, size_t len);
-- 
2.34.1

