Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7836EA8D
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542271; cv=none; b=fvNu/B8BB77X30KfuhBa6N0Z990tmmvn2MZDAFHBQHhOllixYfYj+xvxuRxNN+Y4elVL55SbtJvCRL+5K9umj3qsDTWP6Z5NnJNeRhlCuUrRl3uVeRtmtswspj6/DeeABx6TqeZn3/z4JZtMnEbcCveo686lCMm/Z0w/+qJ81Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542271; c=relaxed/simple;
	bh=1uuqXACzTQ3CiMiOD+I6d+nojH2qadXF+SzTDbJvu7s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r5tdy3Mi67mKIXrFgXjOkjjlXeImDMNWuwr6wfE218zj9I+JnvCxsLOohJa8egLeOyTWXn1Kd32F+6HR3o8mi5xpwgy4dWdJVRWmGQ2X+r9ZEDYLdlv1mf+lZpx1+CUqiGLRYxwH1Q0RhcNvhtQPiH6fhAha6itXxkAr/cpZQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnPvmIMC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnPvmIMC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so7236315e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jan 2026 11:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769542268; x=1770147068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sMwtm90/syzq9VdHssr2kJ43f/6cM72Zzm4oH5359UU=;
        b=ZnPvmIMCcqtiC9EFnG9xIwnl5c/bG2hwE9DYifEHl8XEQG2gfhO9JM29uDMnxD3Tza
         DhHq1iVXUaDoI4xeqIiIX7zZLzVKrR5NKknyrBD9LMaX/Yz8Nmoz8HrnfReP+gHKSxE1
         LOFat5MbUkKJJyTGki6d/AcZ2OlpFCfgFp+v99/eNjnEeu1dujQV902n0eTjOC5QrZfM
         Pax/1ANcsAL0jHJ6wuPBq7JCsYk7R/2p3VzRge//BzpXoqxBqLjT365PhJWJEB3T7bb9
         x2jmmFlrd4Gk7OTz749KGE1Y+WupJTx8cipnnerNZWwJ+Z49j25HMBAt2RN22SRMd5X1
         8d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769542268; x=1770147068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMwtm90/syzq9VdHssr2kJ43f/6cM72Zzm4oH5359UU=;
        b=iBo2pTmR+BdgLBYksWsjxCKbm9O5nRhN71qfXCyMDbSWDgu6hWn4jgH49vAq1RbHHw
         VMaPQcF9ztUGzo1RXJqhcFAMvxVnO+rxcJocqV+Yoe1I2r/xXVW44VOzRqrEJEeDUFb8
         NlUhfeA25efEL1GKHQFBaYjlH39UeyCCRoQnu8izatffQspvYVUH9S2vpCIaByy8ROor
         O6SDv9zRY7n6RBgIH/PVbK3/w0jVD/OBelNuJSZDbsujz1OVFnSslV+JGoT7YsGoy8bU
         +x3u/24vnNW9taQd/hTyvtgbjU+gQx1zOOScV8TZ0fVCPK6wmQmSkXvQ0X4yVGh5JMzg
         VfLA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EGronGAEVaaV+PipSQw7blPwGe6iL2pdD/D19HxpEOJGE8NmKQBY8KoeA38s5EnM4D9worP+M7PHCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQmbscWwKdKzrM9PNKvbofgB8Q5/YEMBuYKXb575CnA3Y+7azb
	FVgr8dVtRbyoLU1mBDwmh9FKJTmoWWPIWNMxJdx5MO1v7kZAQf7SDnZI
X-Gm-Gg: AZuq6aJ+wTearQmAF0FqqQOaYndwgMS53G+F0XCmLsL3NmAApf8tTxLLE8CziT49+49
	BuXGQnuh6PX3SILpkJ6Q48QQpaUWhd3LOSilRsVk1il3Gthz3Mg3NdWIc4k5j/ZnZu10TzBuqBd
	TUMp2EYGcILTXJ4bhc0dSg8dSm7i+fgXIMg2UAw6bZ+rubMuRxsTlCKlyR+Sl/tKIjaaPJ6aTpD
	1psbsVskCnuRD/ekqOIQzSBLjhpDx1MuqTKAmz9CciqcEmLiRJTSZjCuu0rhctnLJQkihMoyO1o
	9l3KCjeULCnWMFYGxQ/WkloRFXbyfi9j1ZiM/jNk9FGfjB7X4Jhf1JYMOlqS8b6am2l0mAVPG+3
	KmVqJ1Zkq7Jyv6XgA0aXRRdC/m8vatemQYrF0EJ23kJViwmdMj1XCyKnVBjWLVfX7EDK1Dsw+sN
	kf3hS416L8mDP7S0TCrFvRb3t7l05BjHZJWkOH6vn1HA==
X-Received: by 2002:a05:600c:a47:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-48069b9b106mr34078175e9.0.1769542267818;
        Tue, 27 Jan 2026 11:31:07 -0800 (PST)
Received: from osama.. ([41.37.41.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdeafffsm12014625e9.7.2026.01.27.11.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 11:31:07 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: fix fb_pad_unaligned_buffer mask
Date: Tue, 27 Jan 2026 20:30:55 +0100
Message-ID: <20260127193101.12343-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mask is u8, so it should use 0xff instead of 0xfff
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index eff757ebbed1..cf199038f069 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(fb_pad_aligned_buffer);
 void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
 				u32 shift_high, u32 shift_low, u32 mod)
 {
-	u8 mask = (u8) (0xfff << shift_high), tmp;
+	u8 mask = (u8) (0xff << shift_high), tmp;
 	int i, j;
 
 	for (i = height; i--; ) {
-- 
2.43.0

