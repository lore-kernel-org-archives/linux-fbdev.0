Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B430F526
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Dec 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766438980; cv=none; b=Suxlyb7eyLfoVSSpZ9OtxNOznNmy6BYHd+oI0UX8vtoZadKO+G80VUOxEsVbczYKFF0L6iwwr5TfXLqJouLEF+uhro5b/kHqeZzOTC0Tj8SGJeYMo5y/Y17h4l6EvqcsVb3tPXRu/ZBCmY4DnwNv6Ss3wSN/Y4qIn8XqPXQ2o84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766438980; c=relaxed/simple;
	bh=pyPRbx6it1eRbylNbnhGgk0sgAAY902esWUARckU4U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejIacl8RJx7lHDSi8Ec25dttS4SXNCqH4+Yy4FLYHo5JQXGSCkeIh5pQP4P06rF2qfIOhgqDZmI2Hde8Do5hdCF2SfVVRw/MPLdnZq+a7iunnYQC8MOS+XtkO70EvXhyb48BviiIG3mBopJZAKuR/FLW65cRmEyEL2XrccXm3lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3no9+8F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3no9+8F"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7355f6ef12so778321466b.3
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Dec 2025 13:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766438977; x=1767043777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXWJIrQGSeCEefAdF6HYxUBEX9eBPbFxpub4IBJuCcs=;
        b=B3no9+8Fg5IYfRk3CwnLVCQrchwv9Y92hy/1I7Gnu1EVTpsRcN+zjnOhfSvvcw2HeP
         98Y1sssVOlYNp0NcKTpnhX4jsgk26BrrGduW26YHTmaqGao4WRxOYh1YakAeiuylsCBP
         FaN/URj25OZCjRoXQBSbhhA8bHHz2ZF5exJUmNAoUqQQxt2K053OP6178zIhWUHnBxLz
         ooJIP3wAspLpGnaV21noy4BTldDteOgfGtWtkN/DgLpQmGhn607VIf+9ZTu945XYv9CL
         UrpKzo1t+Lje4r0ms6du6sVXh6fEqvUVPjTusd0i9pP1vCF0kAkESjiQ8e2Q5oHDpqGE
         ygKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766438977; x=1767043777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXWJIrQGSeCEefAdF6HYxUBEX9eBPbFxpub4IBJuCcs=;
        b=EMomLsK4l5Inj5USvcmO9+bmf/w7gMhoFUtQ7YZEVwpLv3fKxGCCqYDhYsXEV4Rn9b
         dpaxkjM1+hwlfTCO2xKfH2NUVDRur+7AuP41xRbl+mn+jgzYzrPW3XjfvUDGoAmkdHPX
         oTf8Zwru8Wu09fNThCk9wnj5SSthhM4yeAAtAr1vEB0SBYVi1oLzGeTzntoT3/Czoo/w
         rFnomXJ0jVOH/gsYPoE7n1EF+/5cClGRROYFS9rhh/ypwFr8us+W+EaGY3BVwivxvchB
         gJ/MBgGQGo7wRqxkAaDR87y2fhfKICEbQ8dp23UtsaLAjvBZDFQtvEWFRurzD3lAwJ0b
         qkqw==
X-Gm-Message-State: AOJu0YzBxYLfe8Apw8IzunGOa1F2EcltdLq9wNdo2cFU9Rphe1E1eyYA
	9C30J1ie0G8jtxjvMqh4DiZyOGLSmpAPT47GsAPXYqHOmvrOPjsgPKrML8e7xA==
X-Gm-Gg: AY/fxX569Gx3DeVUiINm2kRrmwFzdHW/2ACDHR49WePv4wj5GWrgFxw8O3wPaOesURM
	zYsDKVQLy7/iOMQcpKFMJmc7YX5FoccS3O4UdU6q83OOJQHmtJkY2au3r+lefmzKGsTESthuRJG
	p1cALpDSPmt4CUY4MVoefVCjWoG14B/gu8mGkwWuciELiKvogpZjc5mzebjKqlVrrYJjU3JGn79
	7Or+IxLJddukKiCVthBQetJ/EIZXSMIZLTLFjziR6UDOxcSc6uonZzgLVPqtw3nD6OAr9AXDuPA
	siVqtwByEBTzo+CgleAqwGnNzzUDjOsY3jURotM2QIsC6lQbqnWOjtHxJU+mbB/TIlB1U+qCK6D
	4ox6D6p3yIXyZjnRKD3jfDF5yIdU1P004U8u9lXgg0YTn+1SivW9uFCD12e1zqbmmPkEMgbvAb7
	BNMwY/JkQ3H2XfEWVcN/I+nh+n3ZLgbS2sET9cw9j/hqFHeYgs4jgsPwcVpMeYew==
X-Google-Smtp-Source: AGHT+IGTKsTRfat4leQ78e123zhOg6UamgeVDxItHWdIQtPdUqEVFL3XYITUUz6+yg57k5dFN/i7MQ==
X-Received: by 2002:a17:907:3e8c:b0:b72:5d08:486c with SMTP id a640c23a62f3a-b8036f5a0cdmr1458907966b.27.1766438976936;
        Mon, 22 Dec 2025 13:29:36 -0800 (PST)
Received: from localhost (19.120-65-87.adsl-dyn.isp.belgacom.be. [87.65.120.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b912534f2sm11359443a12.15.2025.12.22.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 13:29:35 -0800 (PST)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
X-Google-Original-From: William Hansen-Baird <william.hansen.baird@icloud.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@icloud.com>
Subject: [PATCH] staging/sm750fb: remove outdated TODO lines
Date: Mon, 22 Dec 2025 16:28:50 -0500
Message-ID: <20251222212849.555571-2-william.hansen.baird@icloud.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TODO lines about "checkpatch cleanup" and "kernel coding style"
are no longer needed as all files conform to the kernel coding style,
as verified with checkpatch.pl

Note: checkpatch reports a false positive WARNING for sm750.c line 36
about missing const in static const char *g_fbmode[].
checkpatch suggests static const char * const g_fbmode[].
This was intentional, as the array is modified throughout the code,
while the inner strings remain unchanged.

Signed-off-by: William Hansen-Baird <william.hansen.baird@icloud.com>
---
 drivers/staging/sm750fb/TODO | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index 7ce632d040b3..037984801654 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -1,6 +1,4 @@
 TODO:
-- lots of checkpatch cleanup
-- use kernel coding style
 - refine the code and remove unused code
 - Implement hardware acceleration for imageblit if image->depth > 1
 - must be ported to the atomic kms framework in the drm subsystem (which will
-- 
2.52.0

