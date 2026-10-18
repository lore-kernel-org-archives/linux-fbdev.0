Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0C396B9A
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337878; cv=none; b=Cg4QdbUNgMwu2xTUI09h+r4e3IkoqdxKkWicSz6HulaAtQZsxBhf2BmHZcbsXglkjCe78oWBFKdGXOrHnGJ0aKquVn7FetUqBo6NH10a4HlQm6qcdJq9Y6LqUtfnVJMOth9Z9631eJ3+uBLbc23imWCzf52Zu0+llPX/30cxobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337878; c=relaxed/simple;
	bh=9NUrm+JR+AwAKle6F1upGyUXgd9H6U/Ig9Dkc6DFvyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o/mghNhACFZZRYbbYJDLhKpNE/VVTmnGTmHyHXHk7CrQi7n48ABBM3fRIU6lLEipAcO/LqhTmGZzdpN4Q4sncyqOBGDp3ouoWjS39CfV1slfPBJ+A1WvUDQyHQztMOSV2YXYGS5XLu3l2E0gcsE+18fb3ytRMdrAYAsFvKJHxrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTX7EzRM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTX7EzRM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1e3b87ac5so3388995e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337874; x=1792942674; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RynPPvVjqTV4luxl9PBymJrn2D7Dl4oqi1D5yk6iPS4=;
        b=oTX7EzRMBQn/JjnfvYFxNcrEOPdeTp9LppDxeiA8pUmEUO02LeU6SpuLRydlCZoCzA
         TtZocVRLJRfpXE3px+arx/lbax/dj0gwbjuCdTQjlpYoYzTHplxiw6I8TUCqzatQBcNE
         0GdWLbv5uC0T0ukej5kgxrMnhYjUplVKhENEq+yoQSEHCeZ31D5GBCDmtmmPPNOh/kYg
         oxN7RHARrXRzr18tcHszFNsBAzJjSsDw94Uqd7HaA/wq6fcJ+4GgKFC80qt/lw0O1lt8
         LjoqLJHgSHtuZc4+ZpXkli27CyLwZlIyfd0i/RqI7lqdiYN5i9Vbew4TRw+/7vPJNOzJ
         BIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337874; x=1792942674;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RynPPvVjqTV4luxl9PBymJrn2D7Dl4oqi1D5yk6iPS4=;
        b=1qeo+drxvmKvh5QVS/9tJb4ugaogXpb4BpDPFv+veqQsDbkg5q6L/LTU+gUZVfJesh
         EpSg4cW4egYnLQyXHOqBUXe7dpliBg45eyjg35OVAKs18PsDE+b0/8HXJ+6Ob0eiLcD6
         MEGxs6+g2M5cMDoNEw7h2s329N6UmoixVkUQX52l9HOBd3XCFiaIBCXgaqrJZyvEhW7I
         aN+NUNfzgD1ARCQ8RTCayNi5sv7Us1G2rGbv5OtVzhFCjOapAJQr3sTifqjhzmBaPnWz
         f6b5UxtayFvDc0gS8Ey7qUJ31TF9Vf74T4r1PCQ7wb+Mroj5KjYJwGSnB2SdvAvzcmkw
         7f7A==
X-Forwarded-Encrypted: i=1; AKwUvBxTXLJBPw610HXY24yJuOYVmcoUB6Pxyxfl0JKcs331nqJgLUE3IAMNG7Pu/2XHO1fiDs2Bos0ikfQ6iA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmzhGf40F5oFS1PCzhRk9z6rlwhkipXPM/z9ZA2TAd/Rzxmj3O
	cFl6aYsrwiXCHfD9Zck5etK7YVCmLHEnIFM99F022GkXwGxuR0FZ/IJBy6wAO2ttjVlzyw==
X-Gm-Gg: AYBFou1cb+iuSRhjmIfDwm81fD2PHqn0eg6kc76ZPxPwqJiDhEvddb48paNYkWcNF8O
	h78jXV5lcxAB/Owh3fyclgWy9P8ITDabaLjyg66ToQM6FZkeW4iW7rUcYhcPZXipAzktOtbI3Ja
	pitZS8K8A9AvCWMnDCFcoU4L/MDvf911NZ2UQEwI4NUdFWUHQfpPZ108Uur96caYm49r38xmfJK
	cX0hVn4zUN37v+GDnA0kF0Cgx2MoF2oftHYH3oaMbFBatLN8BNXK+Hrj/4cSxm8hlPpk0wd2NRq
	cQ47xdq8/AgjCXpf0y1ufdLip4Fi9c5fxlJT1ZFgYG8M+NlW9yUSUSSyV7jPmK9iVfNtop93BAg
	pOA0Q4h2agXdPojJ4sUM8vFR/diNDoVn1BK1SJ9/iTMzK2VQhTvg/2Fz/MT88SpcvQiHfKOCwG1
	Cl68pCo8i0+V1kGDqcFAm79aiVSUe35+EbPWm19yUIVXH0qjzGlei960MYW3w=
X-Received: by 2002:a05:600c:548d:b0:4a1:e250:b191 with SMTP id 5b1f17b1804b1-4a1e250b1c7mr41260495e9.17.1792337874062;
        Sun, 18 Oct 2026 08:37:54 -0700 (PDT)
Received: from ubuntu ([102.91.81.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503862sm17479115f8f.46.2026.10.18.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:37:53 -0700 (PDT)
Date: Sun, 18 Oct 2026 16:35:34 +0100
From: Comfort Oyewole <coyewole7@gmail.com>
To: gregkh@linuxfoundation.org, andy@kernel.org
Cc: outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] staging: fbtft: remove trailing semicolons from macro
 definitions
Message-ID: <atTnRr-JGIb9eLQR@ubuntu>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove trailing semicolons from macro definitions to allow the
macros to be used where callers provide their own trailing semicolon

Signed-off-by: Comfort Oyewole <coyewole7@gmail.com>
---
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

