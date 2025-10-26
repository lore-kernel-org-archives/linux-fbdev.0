Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAA27A477
	for <linux-fbdev@vger.kernel.org>; Sun, 26 Oct 2025 23:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761521700; cv=none; b=Tl1ba6DkbMqVq2Kns9BbJAnYQAT9qM0dCVkWJZ33+Rfrs6xXJtWhnLnnrkPfotHbpIs3kMS5YWE2JumeSdlfO5KOlgy8vwUDAb9Z1oyE1LUzBDUv2zcChpK4Yx4MwHYmFP7GupmE0z99bwrh/tllLCySC8V5Wwjp3DjjLFNpsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761521700; c=relaxed/simple;
	bh=at/67SzS/p3gsLpJ5YF0J/wwgPW9IOdgdRXKzYCWyc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pn2LdIoeGkvl1QMM0lxGhmNqM2eGW30hM/KZ+4md8dzRYGKflQqTW6Pq9JCpMA7/5arWPierJs/434J9Cj66m657yg/mGw+1niIBUNaFMzaQhsFYm11M8VSbLeDsqSroNNLYej4djFAvzr41HZv6E40bCdnecrhDWwnvqH3ffk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUGu5kuo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUGu5kuo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c2846c961fso2260232a34.2
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Oct 2025 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761521698; x=1762126498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjXmcOnCPMZhVr3FarSjpJslIfc1BLVEl3PoT/jHhcQ=;
        b=NUGu5kuoD8yLc3pGsGS/0F3+5rhS8YdjqTOx249l5dG03TzEg+MB35wS4gc+i4EZWo
         8ES4GSHyhd9oxJVMfUSign0guAD33MxLeyPY0miSZ1m0NzlP4BzlESh7wrWfJv4aD172
         lWZyyzywmXb6Ui5X+CqTyqRW5jk4kzJI/NTOgqBLUS5/lkbgoLTuJWHzQcjTj0KurS1d
         h1jW8xIbQA8bN8mmLG17i+yCzp17OTaCfcAHDxeO32cGWC8J7LhIy/txCfCsmiqutD8Q
         sxT/ZGTKKgEGXkmlP/cGNOyjQTrdZen5Un4EvRJnn3C4T4UK9ppKNqikgFSadQm1Mtyu
         a2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761521698; x=1762126498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjXmcOnCPMZhVr3FarSjpJslIfc1BLVEl3PoT/jHhcQ=;
        b=X2tRvGDZBRV/WhPlxG1YZROLIDU+mesF3ewC5hNPeSK4MciRzA3H489xmRryl1Fg/Y
         ZJXA/kzR3qCT8pGP6gacqcmNvfZ0t4U9YmgprRmUz+yB2ftZwVYQiEh/2tDa2HoqBxFa
         FgewFBqZBl5jG9uoNwP8IEtzg3dO4SaktTWj4DtYA20gspYVX2PBj/80Yap2m/oMNwd3
         atG5dHY9q4amYprGoBPweL2lBpeEkLeo+UZW9qE5heZDx+uyJTd4nc17m0M/WmFuBLu6
         3S4ZAJkSm6J4fYVFIG0p+yjobyTDEQWICe8R5IzK4zh71CQBlZiDX/QrmFSqT3QBjqRX
         QLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlMWIiS+wvvjzZJzos0lKA7Hei93j+GkNcotZuR9HsnfaS7q/2U6UXBk5/NHa9Ry4qjwtS9d0CbgY3Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+SAbYs4p3iMWq00BQDmDSml04KgaDsB1iooU+XB7H2yf41ko
	F3zMlMYeCS5b4pqo0SdkSDckm7/uvIuB+KpQP3MLs8+qxYCXLRyy3z2u
X-Gm-Gg: ASbGncvUvOiX/GJsk1lJlm05K+8Lf+wiMHwy7Fmzv4lchcFGzgw70dsPH9PDGwwj/mB
	//9V4pYEq2agZ/oGgVVKKFFi28exo0zrqByx8XR0s9veFzrpM2FFbN03TRW3HCqDzQBoH2bDs2u
	IXI5nc80tiUmsdSERz1k/paDf+oZxQha7wDZvqHdJvpkO0UpMMZB707ysHvN2L17MP8DobostNt
	mhQVy3zS4jAL4pNmoAM+QTfXyNWXs5WJWow/Mzic5s3Sh2bIO905NsEXLiO7Gs54fNNcpPLI7bH
	Bou4H/ZLOPjis4jhm9DUUscgKOBbVVbg4nDGkusSvFiYflG6Yx+pwqClEbAtvrrFP5W3GaJ6CBv
	9MhGxGSRv5bNw2WFrhAJUgsFAkJUX+kfIHhcxWiVvPWc5slUkYi9TcaqGXCw0DyxqsRsaHHoXsx
	nbmj2rgq6s2mRu3EcAlMDDonJMi4cyELrU
X-Google-Smtp-Source: AGHT+IFRoVxA8JDxaqFZaD1Z5ybzyAsPgQl8ptpUfUhfppOKQNfzWK4qTEYWo1gQA8fuuCYqe0XEzQ==
X-Received: by 2002:a05:6830:83ab:b0:7c5:3aa3:4927 with SMTP id 46e09a7af769-7c53aa3554emr1369347a34.25.1761521698127;
        Sun, 26 Oct 2025 16:34:58 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c530134ddbsm1691602a34.8.2025.10.26.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 16:34:56 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
Subject: [PATCH] staging: sm750fb: make g_fbmode0 an array of const pointers
Date: Mon, 27 Oct 2025 00:34:32 +0100
Message-Id: <20251026233432.1707-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change g_fbmode0 from 'static const char *' to 'static const char * const'
so that both the array and its elements are const. This addresses a
checkpatch warning and matches intended usage.

No functional change intended.

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..ceb89ee99ce0 100644
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
2.34.1

