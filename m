Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EA17A2F6
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Jan 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744062; cv=none; b=IhQ/fA7m5TNPgQbJXGmPTAQm7tZ/sfepRHhlQWn7+hx3AqgMLlACbg3mvFFC7doRaILYf9U2LS8AsYB10gtSNS+K7pWWIniu0D84g0z40tEOmvdGYCJ163mUBYRol3IIJ0Xd+/oidol+VuJOps2zU5dE9edjUwzWKjAFQhyF1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744062; c=relaxed/simple;
	bh=KwI4aWMejc3VwhFDloCtuClboDOZTHXW7r8as6MLqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUSxTSGNoyjPxnmBiAUxCGJ3ASWaag7e1pymbMa6mkY4Ndc17gWoJYe+VKK+w8XGckEVKXAAek5qBwjTxsVZkJKCn0h9S59hblMXe+WfAZDubP6D8Yf0HDYlc6tb+jNflHRGIpEkVnHEcFNRercD91vfZFZnap/aRCFI7PLx870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5dt8hrY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5dt8hrY"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b87003e998bso765628566b.1
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Jan 2026 05:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768744059; x=1769348859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ublW3cuNUWppPpbTG6MuENxN8Gi/6c1TykFddWgBrwg=;
        b=b5dt8hrYTGil8RTy+VG9l0Sdlx64cOjs7JJSXlCophe7bfMNTWfa+RhQ3sDyiYGqwt
         zBSEHxKDZhLwlrcAftAJVoRtK7DvLbG+dIyWUglUKVrs3DYICNK4Qtxut2+D6+D1o9MB
         M9cX7tyIgJUHyFkg9CfMFP14tgMj9WLesQuUnHsSCXzsltww8iqvfavRXq6IhbeyQ+UL
         Ey3UIaY6niUWrTrAorgIzWUKL/vsOMi8YZwniRUWajf3I8RKLnLkpBxSkYR+Ug9UiEUu
         TCIvZq2uHdVMJm09uIp11Vm0vVC7PXhKaJ68zgWs2biMoN2f+1oWT/WGDlPYWsoAMRom
         O9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744059; x=1769348859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ublW3cuNUWppPpbTG6MuENxN8Gi/6c1TykFddWgBrwg=;
        b=I/coiGPF27u7IAFlS+abhG5MD/EtxAViinq9c8RWBRULbcJJofijZ2Q9/B3AtO8uRu
         +yT3MQbQWGK/0gqZMr01fR219Nvywg/sBiFzxSRDY5iYYTf53btH6JVglCo8YQEImaMP
         uIp7/YzfR4BtxBXdBdfh9pXdUw8FiQQiKbazy92OA5E6uheYXu0U0bMYCGNa/cwyMNI1
         NwKKv5/oOPkGSpul5WN6Tgkf64GlKV/QdK4yYF80sMnhM3kDtOeyBWyv5zd4ufL1NfUc
         pKktjQaZA2T6T4njsqh7RynTQgCko5IBVu6ZvrRPwT1QdSPf/IicWspfg0Dgjhgc2m9M
         jk8g==
X-Forwarded-Encrypted: i=1; AJvYcCUJmjFsYV6wel4IzlJlA1n9cpgNvvs0WuPU4+D/9ebyuHMG95MuiMOrVOgkY0ZihBWTUPebeP1r00So0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIkW4Lpn8W0ezboFscOCQaeEcKQStSZ8rMcItdqshiBoEbzAG
	TBa/FmEMi8puZrmgOhYbtcbAHyTswTt0qvc0yDFkVrJhbtEQEpdv/XcY
X-Gm-Gg: AY/fxX5v//8Ee90Js7FTOZf7obK5D3c0vCJvQi1yvNDO1v+30+rYVYeKCE2yZVyQ7Py
	eHi7qVgkLTMeMxHjkZ9Zy8kuCLsiB3Vl4KMP6QjDcG3qaJSa1vZVSEUjNYxiCc3TWHMD4ECWexI
	vL1RgAjiEY5r0/mRy2g8byNeZ9F2J59ebkdh4+F1bCQwTGEKrHtIx/NGjU2+fUDRYJMkZHwbw6f
	w0Y2Y91g6LXHIDqYe+pdRhPvROwd3VUksqUDFSnZMUsSw7RYmjiNhzG+SLX6UiPFoKcJIWZaabZ
	ipZDk+36oHeUc5Ba0xkNPmw05XBtD54CF9A7MlnKlXkzG1t6zhLb05UHXz2Mf9im7408Ucjm20C
	0EXhDRbWjgxm53+ZIN23iqi8a+xIYX2eTqIDmuTf9v029Hbhu0ofvqLbPKEgAt3HM78+MUwS5JC
	EKaWqQgHSJL3YnQ8M=
X-Received: by 2002:a17:907:7b82:b0:b87:65c5:6036 with SMTP id a640c23a62f3a-b8777bda8f9mr1003253766b.21.1768744058727;
        Sun, 18 Jan 2026 05:47:38 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:85a8:ed04:ac09:e3e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9a14sm804992266b.45.2026.01.18.05.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 05:47:38 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Subject: [PATCH] fbdev: Fix slab-out-of-bounds read in fb_pad_unaligned_buffer
Date: Sun, 18 Jan 2026 14:47:28 +0100
Message-ID: <20260118134735.11507-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function fb_pad_unaligned_buffer() was reading idx+1 bytes per row
from the source buffer, but when mod == 0 (font width is a multiple of
8 bits), the source buffer only has idx bytes per row. This caused a
slab-out-of-bounds read when accessing src[idx] after the inner loop.

Fix this by only reading the extra byte when mod != 0, ensuring we
never read beyond the source buffer boundaries.

This fixes the KASAN slab-out-of-bounds read reported by syzkaller:
https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d

Reported-by: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index eff757ebbed1..a0c4932a6758 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -113,15 +113,17 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
 			dst[j+1] = tmp;
 			src++;
 		}
-		tmp = dst[idx];
-		tmp &= mask;
-		tmp |= *src >> shift_low;
-		dst[idx] = tmp;
-		if (shift_high < mod) {
-			tmp = *src << shift_high;
-			dst[idx+1] = tmp;
+		if (mod) {
+			tmp = dst[idx];
+			tmp &= mask;
+			tmp |= *src >> shift_low;
+			dst[idx] = tmp;
+			if (shift_high < mod) {
+				tmp = *src << shift_high;
+				dst[idx+1] = tmp;
+			}
+			src++;
 		}
-		src++;
 		dst += d_pitch;
 	}
 }
-- 
2.43.0

