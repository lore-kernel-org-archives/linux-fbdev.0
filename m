Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6C39FD4
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012602; cv=none; b=Cbz1z0Z7U4Hn0yFxeQvLxekpv1KizUeEXnFrUphzJVXxm1FYP128vmrDRVu+Lj5B6xt6ivJasyo4J9w6p/VADY6UeD2lNb/WhnhMOxX7WR8YSJtgKw0rh4F1s7nYwCWsZ3/lN4NqQkGKq9tI2ssTWLyV1U48IP7L7+EDjXRQGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012602; c=relaxed/simple;
	bh=/fq4vDr56CO2k+npiEa+6hwzqLAU9ijIhxkJrtFIYjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOtZpfYYiezDPQ0ko4q2Kt2bc20GmVGle+uWcOMknsgFwmqYT8Q89fvnGbsAUtxWMRVwZI2INLAZ1KNd8v8Svy9cV4eLefp/BS1goEZZk68x7D1MvgR46WRRSl+XAKYGBMbY+idqgditqkgYtACCHdsj3rYzz8VfcCd0aO76Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foKFqgwV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foKFqgwV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7645adbdso209827f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 12 Apr 2026 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776012599; x=1776617399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
        b=foKFqgwV7teFIr4zOB2lXtdokX4iahJIXHv4jRurzS+5Zx6xOYMDmBUOI49KMzZdsC
         dLE1IpIqWzGIIogYa/SiF4/+S2DRIzbPoulqxLeRYwYKAYOZDjSNSGrjl0kcBh7dn9/P
         zncSgQavUdiU2EihVoo43ZD9NsNUZjJHGrB/piKIBu0QEjSNEYkkdMIMXINXFQyVfsjn
         SA/kuVRwVnfN+ciE8RO9rg00RYR444mIP0Hg+8PKjl6/AXnCBhiEWiCAL8yTpM+PqlUF
         xPvV7viqfqjfOdaaXFS4YxSEn7UVABeZ4qojk0M/Z9p1oVmVbSN4epReKUrskFL1WV5n
         iD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776012599; x=1776617399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY6yfZkHIbKAhpXHmyMs2cR3FIwM5tf4pW3ivO5AZFE=;
        b=PXB1aObftddL+0qY2o5ssf+a2kFMd17uaHChL8UcKLwUQxG0Cf54HleMi6tjW9XWy0
         KPwkBW6Aej1vK/wfbWU0lsHO51msrttLKwQ1/h7aeK2fpJD5pH3RrOunfCc3HX6gUpWG
         jRtF4XE3PWbELpheYFNw+01reZd1Ze3QFSpLfqsTFYSaysjxM1ZuvMCL3xViOJi/7667
         FnXKH6mvex1GCr4hEkmQVfhGg7JD1M/xpSY1A+1H7qzExTHe4G4urtnMjCgd52+XdcUO
         I2kXPMYwPdqXSVc9Axl6kz4wsq4Q7FFx6tQrjbQx3kJJKotguuBlHjDAklJuqrXgbs3R
         RGiA==
X-Forwarded-Encrypted: i=1; AFNElJ8UY/hnZMLudiS1ERdHSCydynalz9DbdG50Wof4KxYqrv2H7bRlK0hLx6YFi3wIpJA5F/o+GmUgJwiWVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0pJhqQPR3XF0aE5XLJdbWZ92jnufID0lbzLN5MjRdYR71EJm
	ySXrNbeDiaelPctU+EkdSxQqAJ5g8MLAqYMXlu9UKFc+T70HDt+EA558
X-Gm-Gg: AeBDiescEG/BJfWbp19OBfFJIP+gnxNRLvsoqjq3ZmqNHaJ1FYN6P1wZEyBb+XX4TRQ
	5FYs5qG57QLScSGXmAELJlk+2mr6jOtRH1r6hsnZbjBridGx8mdStzWQz/eHvEwDtbepPVzII04
	qoKAc+3gkc1F7MvKH6yWCYzOqGTdS/dSFxFI4ojg6ScjsKBLPyC4DHk4nIacRZY0ygU+cpAr4s4
	6DzOxNWDnUVVy/ZDFTIbEcFo9SHJOSd9RwPtkz/vxYsn75QVKlfFc8QUDlnsVz0UXQGueqVmeQl
	6SuHY5OVBQ8NJ43P7wareTTiWx8D5ES1lWANG6SNfzxtWMLuC1AjNYpOHnqDjILj2f6C7inWIzp
	B8WPqVPSiB6lNB/mIvnXPkIqObZttGVvLjbkK6ChIIH2z6CsDjIvtJ9ultVoiYmlnRLe6oUW0ak
	Iw8hj63N0GflJdAJ/eKmAb
X-Received: by 2002:a05:6000:238a:b0:43d:7883:87ce with SMTP id ffacd0b85a97d-43d788389c8mr903275f8f.34.1776012598717;
        Sun, 12 Apr 2026 09:49:58 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c7:2682::3d6:8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2999sm24999175f8f.6.2026.04.12.09.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:49:58 -0700 (PDT)
From: Baker <mzndmzn@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Baker <mzndmzn@gmail.com>
Subject: [PATCH] staging: fbtft: fix coding style issue in fbtft-bus.c
Date: Sun, 12 Apr 2026 11:49:53 -0500
Message-ID: <20260412164953.1470-1-mzndmzn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing space and comma before closing parenthesis ')' in
define_fbtft_write_reg macro as reported by checkpatch.pl.

Signed-off-by: Baker <mzndmzn@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..409770891c54 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.47.3

