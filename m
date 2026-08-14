Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF53D8133
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Aug 2026 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690486; cv=none; b=CkASDtYtWTfgk5uORKAFMefNFvAGIKHWrxOVfm5JitaK7etZSe3HT3BfFsZN8L/08DakNF0cV2wOfPtdg5ngs9V0xRtjZKeeZ3bOgchiO/kESSqaozMZqI7wKADTdG7QTlbRirWJMvuj9NRyy5+LUEOzB8oJOwgIZ57RweicXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690486; c=relaxed/simple;
	bh=Zhxwg31ef2njwPKFdJ9LEbdw5I/B2cN5JjHPSCUU3Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LppL+eAyBbj/zWvvWJXBRHUYqRve0hKoGSLTl5QRr5Esarh3osPdNBimG1yzEO/UR1H3r7Z4GRONSlTFN0rjUNmzKSiztqtHKZ3xABKEyGLjUIRTwDzi128Odam1FukPlvZCY1hhqfWKd+ePZaXWzv374Dw+irdbBx4maWUQqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpGfI51J; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpGfI51J"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so392901a91.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Aug 2026 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786690484; x=1787295284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1PkZxLg/YUIIPhFH7X7edGrEemSCt8bVkd1Lamr5k8U=;
        b=IpGfI51JKl6YdTbo8MhA1NGW0xjJ/Mtkzl0BdXiR6iVUdQcYwb1ytX4yiMJzPYJ0mr
         UoRW6eB18lXZEhFlVuMfcP689OWUqr6QIMHPUB7zk4TC1ha7ulUZOjhEODw+FKV3j3ek
         ypcoBkcriJ1509j0QPX9nBCIdX/nCWHTI0LUpqvIcnwrah54DFLDp8pQAR88KsEXB1Kf
         Dl7Kb+iqRxztxAxvrLVAg7LRrVN5eghjylqkeE53xZtI7RbzvJEMuRzVESsetPoRlb59
         xPH4T/8U9uUswyxOvjBN87LD/wxEr0LfUWHvP43SnkB6q5b0iZfbQCVdf49IVPMuGHJT
         2+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786690484; x=1787295284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1PkZxLg/YUIIPhFH7X7edGrEemSCt8bVkd1Lamr5k8U=;
        b=r9gYWmWBmg+rCcvGjgvoN1CxQwBwXSn4RYksdHeCJon7lAA5tzpulLXlOXBlTkmXp0
         tpdmfmlemXhGo6dPwksjbJMHw0VukeoB5F8se03Xx3nxStukDWJtR4l612+ehsc477Ii
         KaSX3gdZf7QqNKI4Bjh0oMIWGjstI6A/w199j6ylrvMJrrnmZwu1OlA0qqzsT3Wwsv/5
         Y0aQL5LwiHb+bEWuNi/RSk0F33VJC40b6e5WKpHvcXG6Ku6mUFY6X5mZZozpGZ6omZKw
         I6N17I8nrQvTYfQuUtBsnHee8NP735NHGeZdzB0BIw5L6DxsaoRDZsNfgQLWBc1CUbE7
         UxnQ==
X-Gm-Message-State: AOJu0YyKuuE9R6YFTdF+p6evmIK8XO8iiIMdWAciZwmQEyLCyZdfqd2w
	7QyTOl23A8tpQG5xwa0xMSw/vuhdAwC+CjcceZ4Lw1ERMpsQbA+00jQt
X-Gm-Gg: AR+sD11BiDYP7/Md5TAULeRxjv3TkPWKkKtaXPo83X12nN+QnjW3D5ZDg71U0c05WRN
	lUrZCczpPhLorbm4AyfjcvIYhWOm5PrpPCH6gWUyrdmsmA15p2AdGoJBy0kJAFKREvumiNz8JgM
	yi+dhZ/EGU7175WA24qRZwBnupjIUtRbACYyZWQXYAiXjoNMsjPJcTrDZAtxQ3IiuZfPydxJmtj
	J9MLvzcewED9K50XgalVAp4FSkF/skEH2j9/xy7o3E539pFK4DfjVzBXMRN2uxQ4gTO5ZHOMfBn
	NmSFrAWWgAN5rk4hsvK1z/ME3ZgssZUxTZUivbLnAPS2vBij+X4G2FYouav016ulDDmDly01zMG
	64SB95QdMhrw+EinIJIZJqC8Ed1Upmivo5ZsqF6aB0+u/JC6QTexarJWOqSDj0pQwhzFuTFQDgi
	islGghASfzFfvXGr+f53eeMTs0PGWRMzoe3bfPpsKr06/vyBEpik83qkPA3funXaSclnEUT8uDt
	Tc=
X-Received: by 2002:a17:90b:4c48:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-3933b0d5cc6mr2450142a91.15.1786690483528;
        Thu, 13 Aug 2026 23:54:43 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-394ea9a1301sm1372145a91.7.2026.08.13.23.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:54:42 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v2] video: fbdev: via: refactor strcpy and viafb_name
Date: Fri, 14 Aug 2026 06:54:33 +0000
Message-ID: <20260814065433.269375-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated and unbounded strcpy() function with the safer
strscpy() alternative when setting up the framebuffer fixed screen
information [1][2].

It aligns this driver with the ongoing kernel-wide security initiative
to eliminate unbounded string copies, hardening the code against future
modifications.

Additionally, convert the file-scope `viafb_name` pointer into a
`static const char[]` array and update its value to "viafb".
This permits the compiler to execute compile-time bounds checking and
aggressively optimize the runtime string copy operation out entirely.

This is a proactive API cleanup and there is no functional performance
or truncation risk.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v2:
  - Keep variable static but change it to a const array 
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller 
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..b3a2e07b61a7 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,7 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
+static const char viafb_name[] = "viafb";
 static u32 pseudo_pal[17];
 
 /* video mode */
@@ -144,7 +144,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strscpy(fix->id, viafb_name, sizeof(fix->id));
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0

