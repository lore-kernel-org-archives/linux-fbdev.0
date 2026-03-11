Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44458360751
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239068; cv=none; b=MUHa0qS/lMs568/8SUwVbEy2mhxMdLx7Cvncl4yfavwbe3kUFfeMDbhidyLn759IvnIXiByIF197Uf8oevVwOwcXUAvbipV7ROZBSCA2/kFSHreL0UOP/cw44mas3jidCtIoY5vwzb/3CeECsoqXD3FSSl/mLs7AVDf+5LM9n4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239068; c=relaxed/simple;
	bh=qxuc6aZ56T+xnzaeHprNxYhwYlFIqbF0a3n93get2js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2I3jNGLq4Sbw21UVhOg50A06WdNICC2w0PRWQxuzxZ3TzNBgQhx1mz4edRhb2ouK66woc6IbZDvnUfeLRyxNyq6pZSxAt5Y2aShitvi4oHASGejYDAMpsUirhUp0oKj0YJap7tG46Pno4oUsx69ZUv3jTsok7Phpsy58LuSqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YitB76E2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YitB76E2"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae146b604so99838415ad.3
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773239062; x=1773843862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yzQHobrc9BT4KEtSHYUs3e9/ChyfEojgCvQAMRjcdo=;
        b=YitB76E2/SJ9Ez/yiZU7uWcZXsdu6A4cyZvORHter/prQBM/wR4jLkrarw5eKtE3FQ
         wMqm8bu4+/i7sDkzCn71aYRMzPo6SEOhNe4wEM8UsBV5FsVqUD2HoX+aQPmbwzFqJwIA
         icUssXSAdK0I9RjfpUinsn0JoDJZoHS6sZOGj4o/sV+ZZAaO8RYbw6wmzeI2eYvlTDmb
         p5aADpLjjd0cLQ7G0FidORnnfOcKuGORlMI1FSVdA6/x1qfUv67a7DrzPf+nUWvgJDhd
         w0yfmej6cdfgA1siETRIR0Ut41KWg1f8V0oBMjFyhwPIiGqZpX7DP/6f37EWBP/h3Dvi
         eD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773239062; x=1773843862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yzQHobrc9BT4KEtSHYUs3e9/ChyfEojgCvQAMRjcdo=;
        b=MyCC+ssfdxIZvjqYmS+dFE79CB+4mebz7FiNM2vsgvuhodjKJJyiZhk7pAsGNUaGOn
         fvXRXfKFqR1+SwtJCn1PqEjNGy3WwWpdpztgPSicHyBz87E1e1j47rC3mrDjoTQsrqw6
         OnQiX9BuDH5Y9MSYR/h+4ro9YGULIY4K6Ga3wBSL/pJ5uXgy3uYukhgQjYv7ndTJEefB
         OJqdSDsWbp70nPZNeEFhpeBz8ZSqLraKV46b6Bz4GDbpNmVLu/QCnBG4BrC0/Qzo5LP8
         SGFvtWk62cdRlcC+yjfPpFivzUo4pnQiSqXPK5m49HhunaxjlBpJeKykXgQQKhWwmm+Y
         KyTA==
X-Forwarded-Encrypted: i=1; AJvYcCU3/BrbgzCQ1kCJfBz1/9bCoeYtbm1CZeeo+0zn6cvYwRYAhOoJQZUUux+m/YhzkBC3OU1fnR3rb0NnsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5s1yfJeFoBhy05yXQpL3t7GgWIkDc1OMfC2wbeXNpXih9sS1H
	2lVFg3SmUmqt8Ur02ue4Z/Eou5G5kqMyt2uWBhD3N6EFDV4l7DAoBCrf
X-Gm-Gg: ATEYQzwpA86VLf+hW1qKUDaELRIYvFgrDou2kv1Yx+d6L0cxoUya+8UUH7SprehIyof
	W/ln8QSi55ovdLNzeFOUd1vi3CXh6vgj8wkqFdfsxr9VaA039gNU3EquipqAsvHarHt4y3v1F1h
	su9RKdW72RxxqZi5u8qo3GosHGK02W6QZNqE7QvtrbDfD1qqKxQGowZByhd79hcp6n3tMZyCG5V
	6TUw8lFISr+m1bOropGbBcKr5G2f1b1Hx1A9hku7FeB4J1b4KOf9GpUvIQZlBS5Y2Z7Vo58f3Fm
	8TUEUTvbHh9wZCKDTYduyYSyEb9Ja704Ulzcrs6mFFQ9XOZTybj7sVQmNT/CAygXHAFeFByi51R
	CTSOjbgxUr3q9PvY5c+jZMHzD/NKfMNyzLxMSp5p/PXbuRegHK7HleAaog+6cLZJbjdspZA3UBb
	+J+U+UvdgfrypVCgjU2Gt5auwV+sw=
X-Received: by 2002:a17:903:2349:b0:2ae:7f49:8e37 with SMTP id d9443c01a7336-2aeae77068amr28402225ad.11.1773239061611;
        Wed, 11 Mar 2026 07:24:21 -0700 (PDT)
Received: from ubuntu.. ([152.58.130.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34d93bsm25395405ad.43.2026.03.11.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:24:20 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with usleep_range()
Date: Wed, 11 Mar 2026 14:24:07 +0000
Message-ID: <20260311142407.35403-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() with usleep_range() for a 250 microsecond delay
as recommended by checkpatch.pl. usleep_range() avoids busy
waiting and allows the scheduler to schedule other tasks.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..51e6493b050f 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,10 +38,10 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	usleep_range(250, 500);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
-- 
2.43.0

