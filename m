Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606AA221F32
	for <linux-fbdev@vger.kernel.org>; Fri,  3 Oct 2025 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476768; cv=none; b=Rq4aIR2/Vtw6+CWM29GuLVLiIwRGzdBswEGGBOw+3zreZzJzHDgilCO4FFWSkQm0o2J+e9AuDM78wWzKK5WU/+8uvjsRvuN4HqsLFBs4+YZ3euIHobY/+3DzmgLYC4r4P1CdrmKEJ81SOT7V4KOrWgUEBWw1fzy5hDoUlninBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476768; c=relaxed/simple;
	bh=dB13rD4BON0Rt3jBbs4Om1ygZ0xAs0OxL9lNKFTx8f8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz1xFgchXb1BKVNTmKMNK1F83TqHqP2CRYbG49P6fp0zu1PbXci9O4g+lj2VpbeqSOTJshSbe5tm1ah2oXZx3xkTwoMAYArI3vqfgF4urfrsGQqwRFxgtY3NGaU+Qwj9YK7kfrd8RanmSm20jwsh8U+vobL4vSMNDewzQV+W46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht2b00o+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht2b00o+"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-81efcad9c90so22808146d6.0
        for <linux-fbdev@vger.kernel.org>; Fri, 03 Oct 2025 00:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759476766; x=1760081566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyM65ZzKgdxvaKc/F+b3wo5trSbYBBSP9NHa584kBnI=;
        b=ht2b00o+e39LyPenjbAZqmpeS7myXZt5+KZWL8K9Xg0nIkLcsf4i7s3EGnA1dBFCeK
         gJ4c0zr0dA1fL7wOXRGCO7GVmkoE2VZnn4W5FNSEUorEyTRmBynzEiGs6sSGzGmfrAJg
         6AEeb9Snsc0rrESmzBmGhuT1XZtWvlHaRpCa9Nt50XIPXogNwib10kUzAhkCX2bLYmQl
         MQ3DjfoQEhexmkXWb9K3kR9zN7RIQOawDx99KQ7BwlKtAt0AWOwRw3gPQBuGU6P/CnvF
         litAex1B1mTe6IFYWYLyGr7L7etHy1igByeAfEl2jVL11D1i+jZ8JU7DVPiUsWdMm3/f
         JoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759476766; x=1760081566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyM65ZzKgdxvaKc/F+b3wo5trSbYBBSP9NHa584kBnI=;
        b=H6ggwXMiNqPFV2zpESRnFeXmPahyjdf2D+JFdh4zfDLiTItF11m1DL3kPfCS445yIp
         Dje43Pj8+K03xtWGG9ieuqiWIoQeukaqkLYqM5IbXlF+Pud71zTpD0yvXI91OxGpk8qe
         FGQtI5ByqAayydsOqgAWSzIlt5u75KNiUEIg09W7nElzgvXkm3z24PfJteh0NshbCFMc
         U05a48LIuwCWxjv9qJKLc3W/M/J5Sa7hZ9+wT5EDNephhivY+FWpLPSe9/X540DnNXAI
         Bfyfsnhx+9NAdGXcTJnblgQipmWHm6KaE50IgpLBjHjHGZMW2T0IMs8vftyncy64/xGS
         ANRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4siqystW1w/P6gLGH3Y7w6pJp2NX7/yIRnpfaWCxyq5ClY9YKZKAEOLNdFMMMG3vmP1+i1TqEGn6TRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVizT/h9OuhWuiqadEy7xHgIyEkllI6lD9upW/MXZbsZHFmyUg
	zU8KKnswBIzDrmbsIOYbJukPLKrwuCHeOLuN//8u5d/47DMC/+jleUXE
X-Gm-Gg: ASbGncuofUNmeSiH4J+AlrgSBdxhRSqrwat3BYxUojaL1Z0rPs1BIUqCwQb2k4FVVYD
	GvToqM7I6xAhjTy05jYC4n4NSVQ0A9aRKfVKkXMj047QWMetB6eLC5t4WrqWyDCSCybxrjBuACN
	udelZxcbRaiq79TGt+LaeIN9YtxJ0TiVEvg25XYWEhAkbBf66Tz4qFX3fVIFB2WeACwQU3ZVEys
	QWNwHVPjLeAccpKYzu2KSaBF9ozlGENrAUPYLqSPa7c78Ps0bA62dP1baFioXUm/Q/RONFNAIsr
	moMHwNxPhU02yqhRrzme8/LrnIzkL+lFX8kPLoDSFteki7cemk6frn2mRUMh2Z/Sw9JV4/SFgxX
	RMv7ZPK2pkNyuYDbToZq3LSJfbSFi3SKYsI4fHFhJ1g==
X-Google-Smtp-Source: AGHT+IFJEtnee8hdoiK4Tw0t8nSenoTvWsb65RM93NINnRfX24oL8mVWKjS9LVhDM5/5SH+GxeshsA==
X-Received: by 2002:a05:6214:1946:b0:818:f4ef:da96 with SMTP id 6a1803df08f44-879dc77bb37mr29478826d6.2.1759476766258;
        Fri, 03 Oct 2025 00:32:46 -0700 (PDT)
Received: from arch-box ([2607:fea8:54de:2200::9c5c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb4469bcsm32889776d6.16.2025.10.03.00.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 00:32:45 -0700 (PDT)
From: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
To: Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Albin Babu Varghese <albinbabuvarghese20@gmail.com>,
	syzbot+48b0652a95834717f190@syzkaller.appspotmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds
Date: Fri,  3 Oct 2025 03:32:09 -0400
Message-ID: <20251003073210.48501-1-albinbabuvarghese20@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bounds checking to prevent writes past framebuffer boundaries when
rendering text near screen edges. Return early if the Y position is off-screen
and clip image height to screen boundary. Break from the rendering loop if the
X position is off-screen. When clipping image width to fit the screen, update
the character count to match the clipped width to prevent buffer size
mismatches.

Without the character count update, bit_putcs_aligned and bit_putcs_unaligned
receive mismatched parameters where the buffer is allocated for the clipped
width but cnt reflects the original larger count, causing out-of-bounds writes.

Reported-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190  
Suggested-by: Helge Deller <deller@gmx.de>
Tested-by: syzbot+48b0652a95834717f190@syzkaller.appspotmail.com
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
---
Changes in v2:
- Partially render when height exceeding screen boundaries instead of skipping 
- Update character count when width is clipped to prevent buffer mismatch

Link to v1: 
https://lore.kernel.org/all/20250927075010.119671-1-albinbabuvarghese20@gmail.com/
---
 drivers/video/fbdev/core/bitblit.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index f9475c14f733..116b4bf5e94c 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -160,6 +160,11 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
+	if (image.dy >= info->var.yres)
+		return;
+
+	image.height = min(image.height, info->var.yres - image.dy);
+
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_ATOMIC);
 		if (!buf)
@@ -173,6 +178,21 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 			cnt = count;
 
 		image.width = vc->vc_font.width * cnt;
+
+		if (image.dx >= info->var.xres)
+			break;
+
+		if (image.dx + image.width > info->var.xres) {
+			image.width = info->var.xres - image.dx;
+
+			cnt = image.width / vc->vc_font.width;
+
+			if (cnt == 0)
+				break;
+
+			image.width = cnt * vc->vc_font.width;
+		}
+
 		pitch = DIV_ROUND_UP(image.width, 8) + scan_align;
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
-- 
2.51.0

