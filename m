Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDC3BFAEB
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Aug 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051852; cv=none; b=dti1Z4A0NCbuTm4RiBwG2bagJtwzHMoMQexOKbRsAP8OP1Kf3M+Fq+7EMwhVpx/7Xn2SZz9rx6B7fjgaT9Xff58dbiSZ0d2AlK6HBae24oH/swBZ6IcMlStqUiUyGdS6CVcJS/sDQseNJ4eS5jlVWcEO1hfNwq/rfa9iyg6rMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051852; c=relaxed/simple;
	bh=tL7b7vwmvwNYbRhTkUHjFj5QgbKWlQf9c4RVmRdSyJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCqC8a8AIy0NXaIH1GY3xNlCgUSKkNnlPyl4Aov8eLpCFUsHRcqu9bGCdJGmo6pqJjWhuzXXfMhQkn//110L1VU7MrnB9ZzSvNofWMKAIt1yBvlSyz/CGrZ31GIZudPa74/IwWnqf+o8sVEnMPPpT+TIalcGoNZwShvZ0pUt+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtluEA/B; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtluEA/B"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383cb94f742so5460118a91.3
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Aug 2026 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787051851; x=1787656651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP5hOVQLKudYfbAgDB1YvOAq7rzYSIU1ErM8W86kpjo=;
        b=WtluEA/BlXejyYMi4CoclplK3vYZ5O7XLkGWWJR0f4UGxKXDouFsyDqLIgQVCjZMHZ
         H2UJa3aqezCFK6BhacnkzJZsmWGetTV2ZUa7mc2QC36q5StkaONS1gU3HaYuFeu8czRV
         MSEPaR1lkcR9l+6VxQa41BCK8ueHgBKEBC2n9yMkbXY8k1HQqNzorUX/d+eLJncbHpKQ
         YnDeRObQO/bCBiwHOY2KMH2Wb4rU05YZZn0iXCJQurnpSLvilLqt633NLLsAhvFFVJik
         cJ9TLDj1efOybnp8IvXVQPPoiVuUDWNxC82VR3/zoTvE3hdl6TzEkyJUk8gcWY7ju4iU
         AnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051851; x=1787656651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP5hOVQLKudYfbAgDB1YvOAq7rzYSIU1ErM8W86kpjo=;
        b=stb+4S1JNantxwpmumayMzP4YJiNj6kByk+JvniKx0+TDuacr8vvhasDVXiF5MJsHX
         vHcBYaMpKe2ZQtznG4YzBhLXUMAZe0yO3m1SuCvVIVXTeEVKzU7bKh3c/Fx3EthWGj4l
         qlg/Ayko+/wxvXfaKrWPgpZ8M64Lg7rrdKBycbWvGNBYUFbWL9n/Z696h7fVxuQpEc9Y
         tGcBiAn4wn9SL/ekx+qNcBSW2Kj6G2tZmmCSgMaRvdMfmuDeMUhQu+clFb2ugtSDN96R
         roae/uC6KAX7bYQxmsyyqp+aAiM4wShtV32si3T7wqFWSYTmDEY6Txo15tI6KIfjdnuc
         7O2g==
X-Gm-Message-State: AOJu0Yy1G4i/FQYi3aY3kf6Bq1+u5p9/rKukHu1EE8bzOyOjbhlbRkJz
	w5vfVaIwYioLY2581G55KD9hnjSVXgNCwo8m7TmoDM6NasfuEgnInAy1z/8m668C
X-Gm-Gg: AR+sD12I5adMtBHp1yXzmIVwjiWc+XxpbPIivY4BW2zQs6nI172YQpW6T4BBVC6lfmi
	tWB3AtVHFCiPl+cILNilyeyc/a4CuHe7EGD+yXoWXJTtwtS5O8qE349VnhIIEzO8Tp+tXui3xs4
	/sJ/Tq0S4fX4B0yskGYju+twIffsd5iGOiRZImfdPly8E9zNFMJ4+NyRHbY09Bl/KADhOOBuBHw
	zDHweWD7mKD5+JJMpl6YM6k6x9NpLi/7zZB2maggsiD9jCM3haYg6C+pvAruycO1Mu7D/BLK/jk
	TJ4GlKayNr3aSH0ZcUqeagays1IV5OkREyfQNe8wv/Tr+cVsEXYcXUKz7ijXBxfuugCtAWmjhbO
	fJRsBCbJ1l0MpuUgGVItXeU1uPlEo7ILgmvUUInBzXqGqJYHBi/ivBBaMoUksJNGVLIf0ZM445c
	utLYD+IuPcA1pruLdDWilEqOrqkO7t/PKo2BS9Bc7PwI8BPK67lM4BLXO5yl+r1vb5gVbm9jI4n
	pY=
X-Received: by 2002:a17:90b:4ac8:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-3933e5d22acmr30926781a91.12.1787051850858;
        Tue, 18 Aug 2026 04:17:30 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-32678dd08d6sm26199017eec.4.2026.08.18.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:17:29 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: FlorianSchandinat@gmx.de,
	deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH v4] video: fbdev: via: refactor strcpy and viafb_name
Date: Tue, 18 Aug 2026 11:17:22 +0000
Message-ID: <20260818111722.471340-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate the single-use file-scope variable `viafb_name` and pass the
"Via" string literal directly to strcpy().

Since "Via" is a literal constant, the compiler safely executes
compile-time bounds checking during fortify verification. This satisfies
the security initiative requirements while minimizing code complexity.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
v4:
  - Drop the variable entirely and use the literal string directly in
    strcpy() as suggested by Helge Deller.
v3:
  - Restore the original "Via" string value to prevent userspace ABI
    regressions, while keeping the 'static const char[]' optimization as
    suggested by Sashiko AI.
v2:
  - Keep variable static but change it to a const array
    'static const char viafb_name[] = "viafb"' as suggested by Helge Deller
    to let the compiler leverage compile-time checks.

 drivers/video/fbdev/via/viafbdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 80f95dac32c8..dd9374e8ad09 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -16,7 +16,6 @@
 #define _MASTER_FILE
 #include "global.h"
 
-static char *viafb_name = "Via";
 static u32 pseudo_pal[17];
 
 /* video mode */
@@ -144,7 +143,7 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
 	struct viafb_par *viaparinfo)
 {
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, viafb_name);
+	strcpy(fix->id, "Via");
 
 	fix->smem_start = viaparinfo->fbmem;
 	fix->smem_len = viaparinfo->fbmem_free;
-- 
2.43.0

