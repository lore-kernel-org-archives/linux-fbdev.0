Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253933AD9C
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590654; cv=none; b=TfBg1M8awLhd97/w+jsMw7K5B3Uq34GOVMxYrH+69mNZzKCUAsd99o9U1AA2dk+zgzUa2wQTh30WusMtVMT2FE+fEyfFftSIqSMOaZDjc1Ap72HmEM37PFGye9Wx3B20e0C64mUo3SoT0TGGYLzMAk/QBq84gil8P2Hnr1I9D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590654; c=relaxed/simple;
	bh=figeAjqhG1svupWcxk1Grs5RKQrQQRzXLgakP8DZC9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuQbmDcYliEd8Vwh7GB7vIwLq7ve1HJgTC3+hhzr9WYmlgTCGKxqipQDEZazCrLKj8aiwzpvW5jB+4s/XfNwmLmAlCqls6QRRXsFpqkBj4fDSe6qumHK3G2NtVXgLooagd3ynZUqQdsU6B72kzralKUJ/zi5aibfQnaiatpJ11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw+y8zuU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw+y8zuU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0a95200e8so45128505ad.0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769590652; x=1770195452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEOJgPmuwRbV12LBE88Ol+uZDUf/K36dFJv3SsHLtYY=;
        b=bw+y8zuURMvfHLbiGZyVBqtNkvGcWvva/IQas3oEYmml9GYXFx8Jqz25k9rHcvo/kt
         uJgxMq++0eJytZ9laRe/CSC5nHvKDqU+b3RKwDrm7gE5pp8KshRZqRhaFQFg7oTBqKcH
         Q2bY2YZw5bOjsYoAdmNG6qFDjh5dCKaRSGKn0cmmtZBchkDB22wo70FW9w18SC1jYz57
         pKwTiMctfivRNb1Uj1YWqdvLXc1ipdI2ubiXhGN4Qxw+703P2AJIOtS2TvDiN/Bmk87D
         QWOa//gQc4JEFXFp8IfqtVK6EPzHv/sPaKeMKPoYW3FiZvjlUOurh+sfYlpxSJ8lGSz/
         d2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769590652; x=1770195452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEOJgPmuwRbV12LBE88Ol+uZDUf/K36dFJv3SsHLtYY=;
        b=bYf61BXqUW4YsRea3g/zLxUBE/vd+mHSUMjIkEhMvxJjouNnvbZzXJN5LNO64LeYwY
         dSMuKB8B5xIXx6+EvbwQFie+zkjJsrkeWOEQzm2aWkG5blRJj4+C2yV8QMa34g3sAD9T
         k2uuPS8qnX0dhi8SeJvXzz8YZvPelzMP6oin2epkCQpCyx2LUi6zrTys+DAU0/nxQabo
         rMklNQyy83WYem8NL1RI8Uwf8J1l2YwBJkN97TgYsRtS2o1uW0esJtxMObpSVmpSsKYJ
         /O/KAUTd4oaOsD4n2Z1xdZuVvsAfyBVj7GFZzuNsLV1OLWv+HVDsPP6TqW87rWjYXOR1
         pe8w==
X-Forwarded-Encrypted: i=1; AJvYcCVvGG5GE+CaWc0AfzcDNd7YDJmNWkQjjfHZT3TKRBOpQu2vjlGeEyKGhXyKIggcECql+MYNCHD4qGnrXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGhoIp1dvQHN/I/fnNe2MjM19lB9EjhBm/DSdE2StA9fPTyuR
	cIlraca36EHl4ogIXHRXj1HmNbJDAW9TPIB5MSE6TYYkY65rhXItRSUXnmUf0H75
X-Gm-Gg: AZuq6aJ57UuI7zbcejsguOIA8QlFc8anzwUGhMjoY3UY36CIpDVRK/zi6YQ3wTFc+S6
	Wov0BbPh85AVVfvDU8IQVKh0HmNR2SNVeO0nEcVyrD7gSNLX0xMLzhUtVjw2oFl4RjHVJWbRZAn
	DJSh9pgMo1lMDWiHEhTY4MOJcofvW+bK3ZrDz7R3gy+myJvFcGTCB2iMGk9ekut1YTHjT930swR
	aHH3XcyaaQqbIl/b9eq2QcQ+HM07pk/g1WCm8B746DobxcEJAYGn0VsPwu1WDNNlEIhTUHemmlF
	+cOmxTvt6O/kcgJJ8+L3sYFCpQfQKeW3hGHaziPToAG3d2EzTUd8TSTOPYi78jnGcj7SGizeedl
	9OANFPtVge7oBaCUPwaWiYa9+Nd9Tt7C6tf3fRBL3Tc5+xDKMC7LSybG4URT8oVGLXJ4sd/M/cZ
	FoOuebA6v6uPaab4+50kgScD8jVQ==
X-Received: by 2002:a17:902:ce82:b0:2a8:7814:47ca with SMTP id d9443c01a7336-2a8781448a6mr38415535ad.0.1769590652450;
        Wed, 28 Jan 2026 00:57:32 -0800 (PST)
Received: from localhost.localdomain ([58.231.102.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4154fcsm16707795ad.36.2026.01.28.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:57:32 -0800 (PST)
From: Waffle0823 <csshin9928@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Waffle0823 <csshin9928@gmail.com>
Subject: [PATCH] fbtft: Improve damage_range to mark only changed rows
Date: Wed, 28 Jan 2026 17:57:20 +0900
Message-ID: <20260128085720.862399-1-csshin9928@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of marking the entire display as dirty, calculate
start_row and end_row based on off/len and mark only those rows.
This improves performance for partial framebuffer updates.

Signed-off-by: Waffle0283 csshin9928@gmail.com
---
 drivers/staging/fbtft/fbtft-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..0fbdfdaaa94d 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -415,8 +415,11 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
-	par->fbtftops.mkdirty(info, -1, 0);
+	__u32 width = info->var.xres;
+	__u32 start_row = off / width;
+	__u32 end_row = (off + len - 1) / width;
+
+	par->fbtftops.mkdirty(info, start_row, end_row);
 }
 
 static void fbtft_ops_damage_area(struct fb_info *info, u32 x, u32 y, u32 width, u32 height)
-- 
2.52.0

