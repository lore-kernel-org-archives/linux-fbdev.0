Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276331CAA79
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769273202; cv=none; b=KSAzMPwCvnH6oDW1g2989ev9btgeaUlEH5in/CqcAkmp3qXylLoaiG3X+IeQxzYNmhn5wmCO3AuJc3G7E5ubCWPB8fSQFVEOlhedVkm/CwoKRdlQm8i2I0i9STgSV2cGgL+Ua/9cQ78O9mQNSpxerk2OKk+ORN61x6nffesYpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769273202; c=relaxed/simple;
	bh=kcHW8sud6NXETHS0u2NhE22Vg1E1E1VV27IzyPYRMDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oX4iAWzOcKx5A1NA6c0KtjK46s/ICOJDP1uU8tKChW2kybwQ2/yiCXTo1AIRop0xg8InHPotSmJEYelOO+rArmxwNWZTyxqOg5x5ey3fDtw2x4ziSqyAT5OLN5Z7IVMWMJxzQisEAlHabo21hr67IK9KzJTSH4SOSZktRF/gw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo0aGbQf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo0aGbQf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee4539adfso34912065e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Jan 2026 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769273199; x=1769877999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OUYnmJjUSoTbjfBFrV7WRaFdxNtImiW0cSkzLarl3c=;
        b=Eo0aGbQf1HCNUOWHNyXO+W2A/084cewn/CeT5NXgUtAtFL7krbosVlNFsYCn7VZSQg
         /7v76JsPkKBXniUDnMo6NI+EVG0nGpuTcg7KM3UQYjkZIwBoq4WGABZ5e6DKXZPSL27O
         5NSbHi+3gLGVsadNXXoS1iKY8IvQq3l1ZJrDFfQ53OQDuRySXVjbDtCimxlfta8cJQ+a
         1ZQY82lCfoTbQQ9KiPTtnIqVNWx76AvmUq6wTUjyDh7esPlBx890jKUBym7A3XgcBp7p
         TioNvSHd7YpyZQUk9m0bWYkGdjnhP+t/O4oPUjoABDmomd1FCgH83kuYj8Db8QLRMJDn
         u3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769273199; x=1769877999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OUYnmJjUSoTbjfBFrV7WRaFdxNtImiW0cSkzLarl3c=;
        b=bgqcZ+eHAVlsOfRWnUhJPeqHx/xw+1eMkdZ+FJP3CfEaqh4WsLWjiVKDEBbK+Ku4vm
         8oG1aZ9C5ph5su/83o0ajana+OFiAX2v+2GHlNJX6tPDX9+isk/nhf3fWA0HaMrYLXrV
         VJBC01xl+6g6fxM+zFobPiu+6blee9BenEIfDOa3j5DziIWV6qU4LpRiZxq0OzY5Tx2i
         7InEUaz0GqWijAD0ryt+1NwhDqcobYcdiRX1FhKfsaoJHIP+uUcAMg1HtxowIJT4f+UN
         U20lRa5rPDPTgS0m1PG8vRp/D7UBc65JYOZov1u+Dk+/wtU5PNAZuYZhSo+GEF+VEiXc
         9fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX75Nn4XF25mN17bpy8wkaPthnsbBIAm/oISdz/Cx3WHeiw2Uv3fjU79T+GVaLTblYyRjJGHYq1OInGRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoHo4Ci3tdiG6K+Q2Kea0URNk8onb3F7U8iBY/ARkzLoauHvC
	QRjnu9ySZaaPhJ9pb+C++LwoilsAJCRABgKvGvZNLhWE0mTJOsqQp0jF
X-Gm-Gg: AZuq6aKl4hMXxftvGWfOV+wFL/wlqwnE3wCbAl6YePFbnwlgNeNimhaVrLcMLx2vi3s
	ICO7xG4Du5vlQY7t9sYhYTvl+nMDOnx1mkWHOx3rEJHp0GVb8Z5uKlkBKnmwb+H+aTL0euHIaoQ
	QuxmO77Mgso0wuTB6uOoSDwr9FIPXo++xLpehiJxtCC02MpTPZpiSmu0Srt1hhKh6pRBaxeb1H2
	8lGi6K/nLrREuT6WKyXEb/I5x2gSh2zXRWO6XLKESIyeRmPb5X9htm1IbLWzCAfA8vLrBXRL1jF
	+XBVrE5aS8dfV3gPjUlvSilGiinizZXiwPOBqw2yjA4hozBoq17dNDSfCKgzcRmswKYBQLa/avH
	r1KCA22/2B4ZHz7cXzdXjdu/9ByNC70MvjkxQoI16JuKBtGyVCVKiGlNgbm7wa9+u48jN8Px9bD
	EyLkRjNYmoVBSFfEi6ylqW1sAg9EM9e2xzp1k3ZeJxMiBb3g==
X-Received: by 2002:a05:600c:3485:b0:47d:403e:9cd5 with SMTP id 5b1f17b1804b1-4804c959816mr99179385e9.11.1769273199342;
        Sat, 24 Jan 2026 08:46:39 -0800 (PST)
Received: from osama.. ([156.223.77.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804dbc0d84sm52711215e9.6.2026.01.24.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 08:46:38 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lee Jones <lee@kernel.org>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Yongzhen Zhang <zhangyongzhen@kylinos.cn>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Subject: [PATCH v2] fbdev: avoid out-of-bounds read in fb_pad_unaligned_buffer()
Date: Sat, 24 Jan 2026 17:46:30 +0100
Message-ID: <20260124164633.20444-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fb_pad_unaligned_buffer() unconditionally reads and advances the source
pointer for the final byte of each row, even when no bits from that byte
are actually consumed.

When shift_high >= mod, the remaining bits do not cross a byte boundary,
but the code still accesses the next source byte. This can lead to
out-of-bounds reads under malformed geometry, as reported by syzbot.

Fix this by only accessing and consuming the final source byte when it
contributes bits (shift_high < mod).

This fixes the KASAN slab-out-of-bounds read reported by syzkaller:
https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d

Reported-by: syzbot+55e03490a0175b8dd81d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=55e03490a0175b8dd81d
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2: address the real issue (shift_high >= mod) condition.
---
 drivers/video/fbdev/core/fbmem.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index eff757ebbed1..d125c3db37a1 100644
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
@@ -113,15 +113,18 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
 			dst[j+1] = tmp;
 			src++;
 		}
-		tmp = dst[idx];
-		tmp &= mask;
-		tmp |= *src >> shift_low;
-		dst[idx] = tmp;
+
+		/* Only consume another source byte if it contributes bits */
 		if (shift_high < mod) {
+			tmp = dst[idx];
+			tmp &= mask;
+			tmp |= *src >> shift_low;
+			dst[idx] = tmp;
 			tmp = *src << shift_high;
 			dst[idx+1] = tmp;
+			src++;
 		}
-		src++;
+
 		dst += d_pitch;
 	}
 }
-- 
2.43.0

