Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC73B3C6A54
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645746; cv=none; b=gArWjEBeUOBk+W7Tx8R6DHJRPDjqSRKShpHZH8nSKNPfxn/iiTVKseH2B6cDb4+sVqiL2r2J5YaVIEk+pjDD37hTqf422uKeEB9CFB/rTourWlegcCu3YRSqRZgwosbhAdzLrcFFS6sghXL599mquUlXG8EHaWbu9Aj//0xDH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645746; c=relaxed/simple;
	bh=eaqazZEu6AIkOZfqaVPRfpOH5D/Sw2xabAJId3jlXWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAXF9Bd0+VkBl5NgpiYvesichcOSbVChp6llbVt8P40seUIYvVomNCnsuCnRgahuczxX5Lk6K75i1ytnNgMyMQyOAjzSZRPgu1fX6On8E8iCCeowKRk+x4y5m5SIcAd+u0iqQBpbhazZ3L0UWwwIrXVfNwR2fM0LnQ9hE4RU7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXB47+BL; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXB47+BL"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2aae4d2d215so16624375ad.2
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645745; x=1773250545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7JS5lz1a9Kx2ju5Yxda3ptoEB7aeLh91gAm/wQ+ud4=;
        b=jXB47+BLFvCvw3ITFjxiwEqe49TlKICQ/D1Wgvd7UPXf36juzOBUnZrw4e8sK0pvzi
         IcX1IzFADrKWynw1QVF55qyXY4UYlHSlz3ldo/VLC2BIK+56LOG1QYkrkdLazqFzF4dA
         lCZ1wCF+kURk3yxoFasMsbQsk3tiESrp2jyOlIy8gRAhXLxkmBI6pbTECc7LxpIFANUY
         KrY+JOX55xHzvMCisg6JzDuojMxflDf0IW87cdcBkIUYa9TrbMaNEbLXgA+tj1ovLv34
         BZn7Y8bphQEhrCBOZa0HabPGIPEPvqzmCB3Bvccw3Q7HtcS+7kXO54myZaZ1dpgrYXEM
         vNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645745; x=1773250545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7JS5lz1a9Kx2ju5Yxda3ptoEB7aeLh91gAm/wQ+ud4=;
        b=qqIRx11o0oOALJsoNJHaS18WopvtwhvYWeuAutM1T01CJAi+vu6xQ8sB4pO0V/v42f
         JzNY08/EXkFijnMkVrHFgDioVgEWl656cIyS1CzQ2jt7FAGerEA6ZZfFeayua3ozHHGh
         Zx1xFSeawOD5INXXDloOoO7rljBEGXkjiL9ox0wkNpb7FtK12RWJc6hWL0VfrSFlLF77
         VBZrLQKI8Y6UnibhjeOS07Pdj8QQzMSJsCfeMo3nTyUEaEzABWR2DB3CQeCjL4qW3WkX
         Tde+ziwTYmptS1zeQgmxIKiKTde8rrKR9s6J/qnT11Q65ac9iPuNJswfGCBptMQeP2bR
         QCIA==
X-Forwarded-Encrypted: i=1; AJvYcCX41XoytUB3MW0+KJhxRBLFs7OiQYXXtOHIRtFq07D0h6w3OJXGazL8TyyIxa+BnujU9/qAh019AG5dzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQPLW11rM8fFwDQsvnppLEEn31I6Zx9MY12TK5zEmHhaRSG0z
	EE/1qSUPdY97H9OaWWZsF4Y9Buwc9WZMAsqovzEXhqfHSuOQQXxZ5DWx
X-Gm-Gg: ATEYQzyWlVoHeGEnuEmfc7jB60VTzlucyazs9/2gdFW/Tgb4Ed4FaXjXG486yRQ1tTA
	R2nbD1qfFOfdeBqTXclW3uXcPwS36Jh152uk1P8IVdZKnNkoKP4fCRi1XrX8C3fLiUcaeADmuoR
	SCKoesEvgx5re1qhFHi+m12EfC9BBE0N/I7azteng7XTczStj1sbYZpePoXu4ZJve0STtdx4P6i
	kZLI/SaWmY5UcrRq0ZACxEafL/uQFGw0LTytjvb9ecnEhL7xYVf00H2fLiV+gF1KPKqeQm2Hptv
	LJSTaBUkGIugJO1c9jcPHTGCnQBHGwucxno2rJW5wotgKECFEZc/6PxVJFFnxVyzil1F+t/7wcU
	xDh3b2dqxDemdAEd/vwxrZD1Z1JPNg2p4Z+o+0EXxizmVyKql1ECRQQu/3y0QopTCE/9fpFvS8u
	qnp2LyRygSzqIhsmIUXoguUe/56ltOg3v9O0IRGljTtbdYXoM4KNTIswHc4CsoBvTUB+6TkaPdE
	giCmFxETWmNUc0=
X-Received: by 2002:a17:903:2c47:b0:2ae:3c43:b9ef with SMTP id d9443c01a7336-2ae6a9daa93mr17831215ad.2.1772645745110;
        Wed, 04 Mar 2026 09:35:45 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:44 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 3/6] staging: sm750fb: sm750_hw_copyarea: propagate de_wait() error
Date: Wed,  4 Mar 2026 23:05:26 +0530
Message-Id: <20260304173529.192067-3-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304173529.192067-1-officialsohamkute@gmail.com>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304173529.192067-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate the error from accel->de_wait() instead of returning -1.
The caller ignores the return value.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 1bd0502db039..f2fde011e7ca 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -152,6 +152,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int rop2)
 {
 	unsigned int nDirection, de_ctrl;
+	int ret;
 
 	nDirection = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
@@ -261,8 +262,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		   DE_WINDOW_WIDTH_DST_MASK) |
 		  (sPitch / Bpp & DE_WINDOW_WIDTH_SRC_MASK)); /* dpr3c */
 
-	if (accel->de_wait() != 0)
-		return -1;
+	ret = accel->de_wait();
+	if (ret)
+		return ret;
 
 	write_dpr(accel, DE_SOURCE,
 		  ((sx << DE_SOURCE_X_K1_SHIFT) & DE_SOURCE_X_K1_MASK) |
-- 
2.34.1

