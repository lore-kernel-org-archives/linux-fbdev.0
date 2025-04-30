Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417831E51E0;
	Wed, 30 Apr 2025 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992629; cv=none; b=c7ndLH6DKOoToCrwONTjOcLomEhZHKRuMMSDGMGtn7VCLiGIKya2VT/vMPJxA1bnHL8zkTrbCinCjsIQiz/g04DNC6nf9d97ykjyIjcyG9/988LepzL2c98sCSvaJ0vG3DkOoWL+UD+ZijiHHXMj3iw+2gMyvUhvmiPNtmH41fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992629; c=relaxed/simple;
	bh=Q8oRezpxhjtbo/i8XWyshLvllP4XgKFGJRaq7eiuqLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIPwbsOe1UTEIUsW0zbYs8rQ0x56ffTN9VbF8Btn35rPbQX2yCmjQKb8Tnek1lByv41Zm0iyNWzP/cy7wfG27cd79BJfB6uxo9sceQwKM1BN+a4BJf8jYbHVmKUp3B7EB1SuCU7JeKo9A+5Vt2KIL9sWqCYz0/OS6ySSLwvyfW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOI7JyEY; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOI7JyEY"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-225887c7265so12911275ad.0;
        Tue, 29 Apr 2025 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745992627; x=1746597427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxqpYYyqRc/LkPwuRTFKMCZAvt0yI3GNo6xrU1qo1uo=;
        b=SOI7JyEYsevocFGOmGLo1vF19UzFEN59F7uFmJ/QsGzM6s3niNyAUSa40Y6sw3gtdU
         xcQk/PaCb9nM0vHI8wAp9xmP7d4NIN7QsDGrWtmn/8tFiJDlxec8eKkpmQ7lCBKIl4G+
         2Spabo3T1tAheTRHDopPflDB2LMlb+JRM7DEfK0LYUulVyA9ZY3JG//+HF14PJi3pzQL
         z4PyhCosStnFgZraj71O5wqVvvS9AdjadbvaTyOfbPcib88Iar7Y1D0PtC8UGfhvtzLY
         fkxx04VYiIy1XbCnsG/TZgqY1DghgPfXIW5r+DcOS4JH84FLVM3IFL7ohG5VKcO2bl4X
         JcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745992627; x=1746597427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxqpYYyqRc/LkPwuRTFKMCZAvt0yI3GNo6xrU1qo1uo=;
        b=nZ7w0985JrinRxZmJwP24eLKYZYsaS/WVg8njyUwXOY8hC8nfIVlBMBHV6BfCdZa41
         iV84y3S5K2q7tF6EEcvt2tnuUxMviV3c8i73IkaDa9+mPIZioKPVYw1x9yuYTd6Woy1v
         6xXP8GHZZxcQo6cLO5A3qXf4eojAcEFU3BNimtLNzWdcWWzISAwXJuSXpjC1nnJrgHPN
         2npbSJ6/0e4Hsct1S3qk0aqhYiu2sH1Ads1MdfgTK46cv2go6lL/Uxs+6uvyFVF0fBr/
         t09kLWlqKvdpZ6yOm4yXYLjVbLbPo7K2nrkwAdMMcpjyMDf2X766H6E+tMaQVdQ36EgD
         m/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUw/UHYzRePW+SNxCFbVcr3hIRXPkgLMzeOJOWRASnpHe0hMLUvKV9z/pTrJPeHV6S0f+fEBXz2syqLyq5I@vger.kernel.org, AJvYcCV4DvT96dbIBuwA2tL9AXZ7Th8v2Mk0MWMPbE0vJBnsvrzMVwVTilb2j+RpKiLrsISrSh6XtDYsJ/vzcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rKTtMSD7prWGip1XH/MLQOOR/7uI4sQfmw+su7Zn9r6uQ5Dn
	4/+y5LWwzRtNwopwRnz9xYkVmTwWZQPhPeMZ+y70/P3xqZtKpola
X-Gm-Gg: ASbGnctVMzNDOTLWsO4q1qbnk/bmeRWBvk+5SFW2Zo8C8T0dI5a8srTL4S3ViIsAMDQ
	vssneQS+6AVpbE718oi6zHuL8GUxEufbq/vg3O/yhBHHFVAWCAXU4kn1+0KLupgkr8BvAee0fLo
	LX/bkGz2ffMUYdsbPEvHRApjC1RV3J8N6LU3c85mMo8D2V09SF3XlejJrdPj/26N61Dnd91LIvV
	VtT5UvN205aD8u8Ji+FeHDDuXwIjLWwZBGO2rWY7bL7ZfuXUn+62JG+i89T5zYPD/Sc1EAORMcY
	mHU6SJrsea9MQ00F+IMlI4URSSzt8JF3HklvkTxTpKel9AaX6UImT/OzO5DKAzs6qP+OrpSyH5u
	7oueJY7q4N24b25n/B7wKZEJ6kmtDGgj/GyXcOL4Q9wmYB/RZRFikDMk=
X-Google-Smtp-Source: AGHT+IHhIvAwTelVq5EzRdwK4Z+rMEnqowV4KnHaI0jJZJ22/eMzZEknVetHiEUoNLoXoVJhtkSEGQ==
X-Received: by 2002:a17:902:cecb:b0:22c:336f:cb5c with SMTP id d9443c01a7336-22df34ddc12mr11240725ad.6.1745992627314;
        Tue, 29 Apr 2025 22:57:07 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221a82sm113383895ad.257.2025.04.29.22.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:57:06 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH 4/5] staging: sm750fb: rename sm750_hw_cursor_setData
Date: Tue, 29 Apr 2025 22:55:38 -0700
Message-Id: <1ce4ddfd5ddf0443fd5a01ea5a4cb76a90e8cf30.1745982772.git.ericflorin.kernel@gmail.com>
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

Rename sm750_hw_cursor_setData to sm750_hw_cursor_set_data to conform
with kernel style guidelines as reported by checkpatch.pl

CHECK: Avoid CamelCase: <sm750_hw_cursor_setData>

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 6 ++----
 drivers/staging/sm750fb/sm750_cursor.c | 4 ++--
 drivers/staging/sm750fb/sm750_cursor.h | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 483a30841c77..d74836fbdfa3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -145,10 +145,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
-		sm750_hw_cursor_setData(cursor,
-					fbcursor->rop,
-					fbcursor->image.data,
-					fbcursor->mask);
+		sm750_hw_cursor_set_data(cursor, fbcursor->rop, fbcursor->image.data,
+					 fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index e80d6efe0ab1..3aa26ef00011 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -81,8 +81,8 @@ void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
 	poke32(HWC_COLOR_3, 0xffe0);
 }
 
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask, opr;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index edfa6a8202cd..cbb896a35160 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -8,8 +8,8 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *data, const u8 *mask);
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *data, const u8 *mask);
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
 #endif
-- 
2.39.5

