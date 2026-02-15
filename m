Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829E18EFD1
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771191110; cv=none; b=F7l51Ex+g28xHLbHeyRhxSnQlFV2WHNg3MS5b5mZeUxk60YndoxjEmCgnfOZ5xIVWc/50dxQJR/2E3gh3xZ3AaqmXwWR2+hwYDH3h3dylvtbwPL+UE5BiV1aZwZZXu01PlKMn25KQ4s1RYVFyePazSNEgFNxb6CxD72uor9OOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771191110; c=relaxed/simple;
	bh=gQy/b/1egfYrwgYZ0DBKSUt3Ls40PsNAWB70tfNtCoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BENGaEpMarmzRoqOoZSFonews4i28viy8ZGfVGH+weGkclKyKPnLq34HtwEIizN129SqKYvSbR9dA4LADbOJW/lCd0Ycw34GAdL6Bk+bM7sS1sFZxiy3hO2BDWFBOx3/I1D9wycJwitU5krYrwX9RWQPNMQ7KcUnf03rNjg2KB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9o3qTY6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9o3qTY6"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837634de51so7402455e9.1
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771191107; x=1771795907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtamjpb08URGw51gXUILK0bCRXlO9PLQJCpvmJ54odg=;
        b=N9o3qTY6sHO7xPdulrLVgb6VVO4qVpxr0OLMscWyXFbW2TLz5k5iZUsYDKCHmUVR0c
         Q1Pj9nmDLbNJlQUFibZYqj0JM0mis79ONjygf5JEhpVmoVmibai/4nnzjTwyHjtkgSf9
         QX4R9lOurDNWn0aS4d+++qXHIi9Co/LyKdYwaGpZbK4FOeoBMU9itT1UMxRdK9ycXbHd
         H7dI6hXIbze0dvkJ0+Y5zsjltNVme0ViNhcaMc7ptd+I3tvxUO5iPxKSb/fLv62s4qGU
         LLY7Jfaxc2R/+BvFIySpYedZ7e2bUByU4aHSyf6tULwQRgzcaQjfAkhVQtkcGBFubPmL
         4Dlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771191107; x=1771795907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtamjpb08URGw51gXUILK0bCRXlO9PLQJCpvmJ54odg=;
        b=JIzQd7djBsXy+Z5K8gdFgXGAHM6IK7bNrV+tU6SXypK/a8Er3wp/yxR69DvHR/h4gO
         xi6kV1abCKmL65fIo3GP+1vY1QzG9IxoYr5ZvcAI5yn2xXT6Afg1OzsbldmN29LsVRm6
         uxikKyBBVjF58ga1bPCFLcurwZPceMVegMiGVikgr/qTjpTrab1yXVBmyfgyqRVs4Ug2
         NgnJuZJogCC2YYmAFIM+ReeTR9xiBD4gJI8f6YRXW+uFlwwMX4Z4WwBdqJ8ITgi6RU97
         naSfBeAQ73dXCZOi/GTpxEr21jIjEljAk2KflOYMrPOzNDQPHrHVyTZWJv774hNgnkIn
         /s+g==
X-Gm-Message-State: AOJu0YxxtkhSELe7FYh8RBl/OUa/4+CtAFd9wSNnQ/0Fe7uyYlvaATbQ
	B2dVB5FmgN+sEfcei75c0mX7uJpkjwOAFtNzRX9inmI3bzsUhISC+0eS
X-Gm-Gg: AZuq6aKUmAfT8atYxXkjUG2EqWnuTNtnXBPLJRBO3VMNC+RDcb6BeDhXPkQPQFguS8p
	pKcSqdhp6q8sDqeNRbuyH4RmCP54qKHjGz56gLv8oam21275dPjlVksP7PYUG+6Kh8PvynpHqCl
	4DtLNZAhiB3OE652KzhntyKzRbSkkA5DyY7iCLSvUUruhJVHJGZe3zqy+pbDLLwEzdTZQG/PlFh
	qV9k3uwjVEZ85kW+qVxGUTqPCQJV3AWuqERJfCLqSxl92vTqyWsuC4XncGBzyc/38rUJLtiMbnj
	xpLnOOLqjeXUKM8kR3UDgoYWDgyCsXuI2ZxAW4l4rT266DFq7hGyVivjmlizme7U5ogs3SE2fW6
	KESs68YxBVmwfpFF7bnDGtbBN+5ZZshbW5ersYraD/snl5RYvHTNpUUqrS/94Xw2DI7PwJguwhQ
	iC41+Rzhc8E2MytBiGHPvOS0tBiKRrS+2JuA==
X-Received: by 2002:a05:600c:3e14:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-483710904ecmr139760855e9.29.1771191106908;
        Sun, 15 Feb 2026 13:31:46 -0800 (PST)
Received: from eyup.ktu.edu.tr ([193.140.169.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm418778915e9.4.2026.02.15.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 13:31:46 -0800 (PST)
From: =?UTF-8?q?Ey=C3=BCp=20Kerem=20Ba=C5=9F?= <baseyupkerem@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ey=C3=BCp=20Kerem=20Ba=C5=9F?= <baseyupkerem@gmail.com>
Subject: [PATCH] staging: sm750fb: add missing const to g_fbmode array
Date: Mon, 16 Feb 2026 00:31:02 +0300
Message-ID: <20260215213102.111117-1-baseyupkerem@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Checkpatch reported a warning that the static const char * array should probably be static const char * const. This patch adds the missing const keyword to g_fbmode array, moving it to read-only memory.

Signed-off-by: Eyüp Kerem Baş <baseyupkerem@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e615..15b5de33b8d9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.43.0

