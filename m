Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D9F1E47CC;
	Wed, 30 Apr 2025 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992628; cv=none; b=MuvEhzF5kNEVHgbV8Bek7ePEj79ldumMORVUqeaTBxeKxB6JHPaMbpBBPsCuO/8WKBFjRgdRnKKM5xBfGjFzxJe1djh59tKr/Ae2ytCLqWziq3GMjdd1xAKHZ3MdLg9ypEuRoByQIZ173fBAECtnLhhbpL5NYG7V3UuUYNGNmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992628; c=relaxed/simple;
	bh=Ok0vLnMs2cPHb7AazlsNmTPiFSkZuejxGCip6igXVvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XziUKNgimaGhkEbU6+jQryiiYVa3UrpLacK/alqtd7tZoLee/aFzYXVxvGIhtSSzD+/XG02jMViPk2Twy3Db/ZojQ/qxc1zrc7AYRV5oSsb5j5gn+h4fpZcgq+2tMANGUwvrp8UtOA2UUbxeWyXu8XCSheH/IH361olnR9LstkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTCkOl2L; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTCkOl2L"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-224172f32b3so15772245ad.2;
        Tue, 29 Apr 2025 22:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992625; x=1746597425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg19nM6sxGDDVqPg3PFyXzXPfM/4I/zlx4EFgMlc6d8=;
        b=HTCkOl2Loi/Z4/Qh+aQnxkKZWnHKDfpeh/ndPkN2O3Ilfw/bw2MuBxQovqhizP9I/M
         Jw4IoKUX6wcGJeM9IBMLEXWt6lbRBkPIYb1D5TSJcwEjOuQPtJktGaXzxp/Y8Fry+cvz
         vG/0W60EXx/Mxk4+cjXDFc6VcsLkmRajcyQ2p1mMmB1uve8z/XjLLnj+JhbeamBQn5oH
         rYCcb3jE07D5Z9Dx4RwCrhm9OnmQwJxCQn9x8lQDp/wxen9U614dZUXHUO93ckff5OWE
         7ho2etxDzIlRO3InQezN0Mc2hvuIPIATtYzBq3LinT4lY+1/oEQ0dAgrLzlSFj8cGAhR
         vD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992625; x=1746597425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg19nM6sxGDDVqPg3PFyXzXPfM/4I/zlx4EFgMlc6d8=;
        b=WBkLMdV01V93YsXpT0FieqNdLkYVGkIXYawKgeMchk0drxfEBGaK0WzjwJHyHSUSQc
         5GUy6wBkCtxAEbUg3SRnSJfqsWPN2v+7hSMphbswYqpCy+v/Gzrg84CLJcKNw5fl4oxY
         gNXBA6SmgbRKNdw8FmTJ8V6+xhBVojU817dEpilmu6jmzYEqRcE1YA/Y/RPLST5vI3ON
         h3WmL9xakdaLMsiqbDs0/NrAcJ0PSdkDRoPUhjCd7otK4jfDwba4lPRaoB7fqXh7IfSL
         ZRFAQeEODW4IwUCUqh1xxoFU0KASnWUX+JebgAGFSFvd7Yz8Z21R3GIpfsPVrwh5lZwN
         Mdwg==
X-Forwarded-Encrypted: i=1; AJvYcCWA7lv38WOG+OHrT6T324P9c9fTsNcMyJq2hyekx3o5BhfPnj+NhQAUdt9cwuISsuqPY9adE6KlGiukUzy3@vger.kernel.org, AJvYcCWGolQyAuP7BJZ3VfO2CeTsF1cIegYlGR32E1U4xd4YatUu8pwplVorYZERBHQZqPGaHB2BOvb7XYYdXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyECn+4TBVZOad9cPMBbLPcQFl4Pyy6rZkDr3VkusqwB5jS8fYt
	EtHQaI3OtKsIf0MY75a9oKHWxNXW/2zd4WoBGCj02CE/HFSJzqbB
X-Gm-Gg: ASbGncvv0aErjgec8ng980+gwVl2WwPLX53Y9y5qEU9BBAamSdroHTWM2XqOSvnKtKx
	/YCBxLZTc3uwr/YDB/ZEoZ4Jj21RVpfcduJHsxbnAEWmt+9KCN1DoMRSPIvZqH9PsX1ZKGkFa8T
	9p8Xrqg5bnYuGjgRPZ8oPMSAwVu0oUVBi7c8TgqYyfeG5SqJ4z8PXIAchX89TInshXp8NVJMkRZ
	12jGbzt7+syRR1qekR0LHlGeoJFtVnVkyrZynKFqek24xYPqfveEVn2DzajeTZTWFeby7WBphVo
	DWjU2rfM4iHrhQnT67yklKxBcPkKFvP9GpFDE7EH8I5pqXaYikN54v0x5oPk5DwwHGt2njLZJ5e
	/va79483RwN6Pdx6kMLVLDJLcwRZpgc+T8Flnvp1M1cpxEzT6kcPPwt0=
X-Google-Smtp-Source: AGHT+IHMwfMf6lRM9cj30ORQrvSHK1/wmWX/dBW3Kxu4UaCZHZmp0baJrqGCvprX+JZKltdzt6QDfQ==
X-Received: by 2002:a17:902:ce91:b0:224:1785:8044 with SMTP id d9443c01a7336-22df578aa9fmr7662845ad.4.1745992625083;
        Tue, 29 Apr 2025 22:57:05 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:57:04 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 2/5] staging: sm750fb: rename sm750_hw_cursor_setPos
Date: Tue, 29 Apr 2025 22:55:36 -0700
Message-Id: <bf20fba915d2f0139a55ada29fcdefb9fdcbc1d6.1745982772.git.ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1745982772.git.ericflorin.kernel@gmail.com>
References: <cover.1745982772.git.ericflorin.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename sm750_hw_cursor_setPos to sm750_hw_cursor_set_pos to conform with
kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sm750_hw_cursor_setPos>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 47c84331e3d9..8dd32aa6ac6e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -125,7 +125,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 					fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
-		sm750_hw_cursor_setPos(cursor,
+		sm750_hw_cursor_set_pos(cursor,
 				       fbcursor->image.dx - info->var.xoffset,
 				       fbcursor->image.dy - info->var.yoffset);
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3128ff3f4b70..a6fe241e7748 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -63,7 +63,7 @@ void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 	cursor->h = h;
 }
 
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 {
 	u32 reg;
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index edeed2ea4b04..d0ade8e366f4 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -6,7 +6,7 @@
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 			     const u8 *data, const u8 *mask);
-- 
2.39.5

