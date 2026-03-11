Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443835FF6B
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237191; cv=none; b=QgLKpcH2aLm1+XQOZqRi/5I0m92TX0a/rvgCr7sgM/mMJxDKyWBwqGrMmQ/p/sh+Oz/EgAuFTQ78/1QYrThU56K9rG2fPZaEadYwAU5nZIvsizz+G0+sAqLUIsL1HoK6VLKQM50BcBWpbiHWlEv8cky1DhgjtQjQnA88HOOL+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237191; c=relaxed/simple;
	bh=yF5rt9iRq8hrQat1ucTgNI+On7HgGlfjNDReTf6j+GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFOW1VrJ/X62ZosRlbKAL5H27TFUxsgi2Wd+EcY8etM5/tqCKuFFO8N83p8ot+wDJyxNMV8Wp2h7RaUpa1FhiVKdoceyYr0DV1dGVv68QCq80WXqaIZpTNQchw+OqLhC0GUPs6IdqRKzA4/cqCZ+rjPWI2v26GORAGON5wX0gNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9n1UkVA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9n1UkVA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3599019ae92so5987885a91.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773237186; x=1773841986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rAOTE4KAFGKM6/rvrF0ZwMtwr3KkPnHMCpSh+ZuGrbI=;
        b=D9n1UkVAv75hyTcQjQbuzAPnG5+5jAK9J6HlQAJlJkNQeHkL/+xknsm5+RJ2VyTeW/
         kZt97WeJlxbwBk9C1a3LuF6oceHhPI3ovkleyjc3MKzBHPhzPtyH/iwIDieSBpXbO1+b
         qiF23XCgkgdkfN/RcHr76nOIaWJBGIEYuaCtMfHcQdajVWYitZIhN1pIqmAcTgxhl2CD
         G4la8ecfSscM8xdWLVi/e0JkiWAtJGlJ3IGv7R9O22ix2LCFpiepXhcDoFzhBLWZjbq/
         lZWrX0FLPG+nXu5UenveAZJT/oHvby0fd4mu6F5uVnfc5fBxYye9UvEneLugkYKr899F
         P0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237186; x=1773841986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAOTE4KAFGKM6/rvrF0ZwMtwr3KkPnHMCpSh+ZuGrbI=;
        b=RcdL0PUoYrtOLZ5iTzMgUQEImeAVU4D9X77RsJRo4VCflD8BCPAoQsenWj2OOPrH2b
         vTlGBPppuPUnmVB1Ku8b3PrJIQVPA1LefVnNouhFZXVr1kx5hDcW3m7qNalO2ylY2hkW
         APB/pR9GN3upNdemdvr5MjaK/iGZ1oMRXG7Rv0JpmOePzvTU+isIe6CDRD4+MDXz3PUL
         oqi+cjX++My+k2Cyq6qY9pPy4XyRRyBXrCkfx1Zft/gwVejV5OYke85pxkxECnnIPSYp
         QBN4ZpIperlAhSO0eJPB5jsg6fuFNDeTbiy9c5jt8ovyzgYO9KA5ok/bXtdLj4YFEJxU
         WEPw==
X-Forwarded-Encrypted: i=1; AJvYcCV1S+lEGYq9Zm7NGLvISuLJ+5Q9U+c78NC1u3Y7Dh/MvBvFpJ/SzsMEg9mWaPVU5+PV00+crAU61dkjZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw86Rs1bZJFYq5PMKPguPgYWoVTCvo4H4R5jBPbkp+PiYsjf6Qc
	nC+MPsWl/TB+yC5BrJqxTEzbMF0q2hoEZztnLJAh1CPtnMts2M8eJRCr
X-Gm-Gg: ATEYQzzPjKbekdihklETwzj4LzNqmXbhlQ8nTuLyxJ9ddvmTJQjFhi7gRCMENMmw8Q6
	DeR7z45S14rPe6aOjees+qOuRPDu19g+bPCpVBPd59q0qTwhjFeIvBYTZ3g05UziZX5H0zByON4
	WhYDyitkuWMHM5F2Ao7YiJOsURrknIPXlZQ6Qsm+mDUtpPICFNCl3rVOR+yVaxY9dGA8FTtD7JP
	UfoELKyPGYWW8cTe3ybFeVH4DRiiPY8riJFI/xL9kd127YuLCte9eDPXFXLk6hfJhuofjs7hvyT
	rX4QbIV2sVUG/1BHryFXCVjDuAjCJs5+wmJKcjWidib1X+smsmmIJUqMz+xLafOm70L8v8TCjU8
	kV+636G6JTBwnc5QR8EmKUr6IhxaR+PGW/g7ln/eVxYKnzjf0HtU1M9cTEMP4HDOo7v1M1UWjox
	6iJP3yb5IoX5zivJZOz1vTSPiHQXTAo6xuuiOdqg==
X-Received: by 2002:a17:90b:5112:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35a01286208mr2377581a91.7.1773237186244;
        Wed, 11 Mar 2026 06:53:06 -0700 (PDT)
Received: from ubuntu.. ([152.58.130.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0250f014sm1065992a91.14.2026.03.11.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:53:05 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] staging: fbtft: fb_ra8875: replace udelay() with usleep_range()
Date: Wed, 11 Mar 2026 13:52:45 +0000
Message-ID: <20260311135245.32730-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() with usleep_range() for 100 microsecond delays as
recommended by checkpatch.pl. usleep_range() avoids busy waiting and
allows the scheduler to run other tasks.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..d2400bb44f1c 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 200);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 200);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.43.0

