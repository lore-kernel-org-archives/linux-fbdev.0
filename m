Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1539F184
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792345840; cv=none; b=auOqBgwWtk++YN/g4GTnT8+3gqzjyEWG6eTuKrfbe9FiSUbY7LO+B+SvBpX+D6zidBC/mSc6oTGI9h06MpCz9eE4IotSQwsq3vKt8OgBebt9mCqpaxgixQQgtVOKkIIPu2qtZ9j5YJd7k6labV64yLZW8ESHYqdxjoHXFwNcoT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792345840; c=relaxed/simple;
	bh=GDtfl2HGmpniyM65dSeoeUzS6m9aT0IQ/soOxMzJCqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XNtwYFSIwAZH1dYFoBJYw1Hyf7pdsna6ujoFJgX4hmF7+NEUvLGO4avdlTf3BZiNd2ZMaAFHvjugfF7VwXiMOi1d5V7tsfR6Wd2qllk7P8/H0RwPYjXvS/CTbdPIG14thyxchGuW+egBOa4WXX2GKZ4dkXbwGWbXnMLCI6jO5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVHdp7NX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVHdp7NX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso11754945e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792345837; x=1792950637; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aOuTmv61Tfcjl1ZoA7Fh17PttCqQQo4Ja/Cvpk6+cDo=;
        b=mVHdp7NX6RsvDOa9Knboa26BXX6FdxYmxHatkkyisPKCBdCH+gBFNsThQZpyQmfcTX
         nrt3IAFMStRgA6X7nD2FJbH7VSgoEiTZByJKKmwSf5sc6ox7u2uflNZ63SLmVhuC+KIa
         Aq26La+d7GmQIJKMzlBKRpmZ4O1NQSIMWSdKuppC/yHPU6WKJ6gH9Xky5wtg4y0xLC9U
         GUL1ETR1ifd9tfWkzzCn/ei5f/GNvCoy/Ad9EvyjQ0wJe2/hmHKdtwBRyYor05K1Yn+P
         smAsw0me5/pTVhiTt+8k8hsI58dVcQ2wqr1wPkwepvaUU0vMN6IJr6gU/S0lAe1ruR7l
         gmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792345837; x=1792950637;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOuTmv61Tfcjl1ZoA7Fh17PttCqQQo4Ja/Cvpk6+cDo=;
        b=pxJPZUo3ua3hiXwWwAWpHYDDpjsOAJPJUGBe7Fsliag7si3zueqesueiNUG+3UJ+4s
         7rW2944EzYzWe3ZRym7W/qf3WNRbbpK6w2iNNY9T0WRGZ+hJgqLQz0w5rmp5wq5mvHWa
         Lkj7s8u4H6ErQ4vYyy2v26E3mo2j0ghRrLUsR99Gw+smM/+69gRWqIJL/Dwoaxce85SS
         t8XNPKAa88g4NhrBRRXDWyoo1+5YMKc1OhoGaEnR77lGY1LzYD7RaBBQA6GpqUaBFdDi
         JYSDOnfsQkqLhGIPkXeoSkM28FpRAOWKFBDW0yL14JR8I/RYHlv5aex8ZfdCfRsz/GyK
         WKaA==
X-Forwarded-Encrypted: i=1; AKwUvBw2A+6Nlegvuys3vIHVlQdbnif/A2tmSGRf5ulQX9dvU3zd1sdfY1O7xcGSGX+YWfVY8CLIXesqFb0gnw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIATBYIFL8jmMzYxJRPiKg62sJXnVokMYYe4ege8YTSEU/e3tW5
	lzmNIuiokiqa/dAOMT5A19DLu1sclPGRGNo3cPVu6AkE1wta6J/yEzHj
X-Gm-Gg: AYBFou1dx3vF5PAyBwJUj4Ofk7QebjWRKAewQKEFJwP+dot7VHo9b+DNkxJK2MeZN+9
	5QDj7aZuHTQdO0AnP3AjWjL8Sr6O9oJQ4G7b03n99AgIgiVrMjKxQLkl1CD2ZI2thq6kagnUVwS
	vQrV+7QMvdKwfRuQC68tS6TqSNTbAholPF3xfFFJjduArjl/I4A+M2STERSuoKRbXr+/nu3SzCY
	BjXeoWeiP76DPjoIRVb5XCLj0qzZWC+8Z67hyA8ktoqyUg3iqHBrqDoEDtOuHxNwWjJyudezXqV
	hVDJM/i7YmkO/J4/3u+ORlGEh5fy4ZDsIIOEJOiXvnlQyFOB1HTqw4Cl+0VLhmjz4h1cd39EeSK
	rq2av/GcsDh4V2w29LIK5s0nX42TP7op/SjFfHzJzvidTMRoSs8d5GJHSrehjkO2i+wpu1RYsTo
	8XyAcf51d/zqSwdZ4Khn0Qu8Y9qSwzgVc6Q8xWw9+TR+9MZlqW1UzF831x2TEjwJKs
X-Received: by 2002:a05:600c:3b13:b0:4a0:2150:55fb with SMTP id 5b1f17b1804b1-4a1d75ad08amr139445015e9.4.1792345836539;
        Sun, 18 Oct 2026 10:50:36 -0700 (PDT)
Received: from ubuntu ([2c0f:f5c0:570:10ef:ebdb:1ad:9af2:42a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1d97b7bb9sm64505955e9.0.2026.10.18.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:50:36 -0700 (PDT)
Date: Sun, 18 Oct 2026 18:50:28 +0100
From: Comfort Oyewole <coyewole7@gmail.com>
To: gregkh@linuxfoundation.org, andy@kernel.org
Cc: outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, Julia.Lawall@inria.fr
Subject: [PATCH v2] staging: fbtft: remove trailing semicolons from macro
 definitionsandy@kernel.org
Message-ID: <atUG5LbCbePRNn5M@ubuntu>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove trailing semicolons from macro definitions to allow the
macros to be used where callers provide their own trailing semicolon.
Also confirmed that all current uses of these macros already include
their own semicolons.

Signed-off-by: Comfort Oyewole <coyewole7@gmail.com>
---
Changes in v2:
  - Confirmed that all current uses of these macros already include their own semicolons

 drivers/staging/fbtft/fbtft.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df1eb..1ab1658e8321 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -277,7 +277,7 @@ static const struct of_device_id dt_ids[] = {					\
 	{ .compatible = _compatible },						\
 	{},									\
 };										\
-MODULE_DEVICE_TABLE(of, dt_ids);
+MODULE_DEVICE_TABLE(of, dt_ids)
 
 #define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)		\
 										\
@@ -301,7 +301,7 @@ static struct spi_driver fbtft_driver_spi_driver = {				\
 	.id_table = _spi_ids,							\
 	.probe = fbtft_driver_probe_spi,					\
 	.remove = fbtft_driver_remove_spi,					\
-};
+}
 
 #define FBTFT_REGISTER_DRIVER(_name, _compatible, _display)                \
 									   \
@@ -350,8 +350,8 @@ static void __exit fbtft_driver_module_exit(void)                          \
 	platform_driver_unregister(&fbtft_driver_platform_driver);         \
 }                                                                          \
 									   \
-module_init(fbtft_driver_module_init);                                     \
-module_exit(fbtft_driver_module_exit);
+module_init(fbtft_driver_module_init)                                     \
+module_exit(fbtft_driver_module_exit)
 
 #define FBTFT_REGISTER_SPI_DRIVER(_name, _comp_vend, _comp_dev, _display)	\
 										\
@@ -361,11 +361,11 @@ static const struct spi_device_id spi_ids[] = {					\
 	{ .name = _comp_dev },							\
 	{},									\
 };										\
-MODULE_DEVICE_TABLE(spi, spi_ids);						\
+MODULE_DEVICE_TABLE(spi, spi_ids)						\
 										\
 FBTFT_SPI_DRIVER(_name, _comp_vend "," _comp_dev, _display, spi_ids)		\
 										\
-module_spi_driver(fbtft_driver_spi_driver);
+module_spi_driver(fbtft_driver_spi_driver)
 
 /* Debug macros */
 
-- 
2.53.0

