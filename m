Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC04241663
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609341; cv=none; b=oHYQA2Mv+fhdIKIiBvzdzqQ5Vgc0Ize9EO1Hd5wqLWkg61NX9WBcICzDBamiYIUYndfkmO99xnetooFQxBbc4Tyhw7JzeI1nTjd3DVa9nEQkH8Kr8fdnNzwp0SGr0w8mTcbAvGqCIWdUKQWR5GjCkNqbSifHDGA4n/ehjdXhQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609341; c=relaxed/simple;
	bh=SJCpCSq3FqlX95u2sBnnu0Mtb6/2Df8CC2chPasHVH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNLitN3Y0IRND0VaKZQT/0OIenxO+olyVD3qLmg2aVl7ZmPT+aUfCo13tB+4+d4REPL+QKt41ZVN+DiS0/qPen04xvmYS/mtJ0vR61xEUWjULpVmWY8P8jpJUWhPnhJ5QUtzHqCCN2Rx/nK1dwXGN5qw9JYYITEk6XcQmtoDFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmpO+RVt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmpO+RVt"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so3532049b3a.1
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Jan 2026 06:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769609340; x=1770214140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0UboJ63LtcZ77ZQp3GiXhx2JgM+P9ZD2N90y/HehnAU=;
        b=fmpO+RVtiI4gARsBytfl2p5MQivvlUYCv7DZORcZWfrg9Tsc9PUiQrL7qDgIP4QDn/
         DybwZuRCcR7TOoScCTK204hsMH8DCYQ+Ir3hmVLrHuJpYZ8kvnZD8dcaiJHa/ANgVnV6
         WYxHLCsRT+G2pZY0SLZ/dLFX6t9QrGDKSW26Ub+AT4qf/+oNZ+R2cj8yXdMK/7YkuAsJ
         tND0miM3mt6sYIPfkATKw3FCvMV1gtEVFfUv8lCWy9xfNp0pplSM6vqEZdMMJJb2L/2Z
         ddrQDcwzTAUP/Tidfz9cwR6geG5k/fOLgV7hQOsfSR5IS7aQ0QZridhiZlvEyq1s+3f1
         i94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769609340; x=1770214140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UboJ63LtcZ77ZQp3GiXhx2JgM+P9ZD2N90y/HehnAU=;
        b=f1TsAsfxPoC4MVd3M8pWC0hN3H88XxnhCqbZZXXZZYSICX8jNc1dwrMROgnn5XYXq2
         HQUYVfKHwht+1W2HOC/muWmBCU4f0FeolrkNHEXX5sK95gnTfqM/FzqwNbP3GXd0HdQE
         1GYrWhmTPrA9y7fSJwQjnOz31hFIuVUq5oUlh+5qvFZsYSdaVukmFHtjBABnEfNVx6Mt
         RRa529rc9ALIFI7xn+HjkjWDqzJKA3gQnS/LqxK2KVzj/IKxJEGB83e6kHXXHsLIAubT
         02gQEmyp1r44/WE79CITqBnr/i1cf6hVrKXSwRv4eSVYVmBd8U8pNDkiOLePoYCsdla4
         Qdaw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8YVN3fL/WjzbGYteNf3YkncIU2h1ogsdFmPJcns7Z5XD5Myl8vsiJ4OWl1gSE/3KKMnAzq/l/3uUOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqdcZQ+j8UT3+9DC/cV/VUMqPZ/mbCWFZCP9TbbDpfGnEq1Uw
	sVKnLIz6A3NnvQG0YHL4muKA21oe5UwYqvCultjdSFovQTJYY6X0pgFFqE05egAG
X-Gm-Gg: AZuq6aIzokvvs/wnsJgS6y0FyQrXVUghmqFhJKB1iEC3+YUCnVAtbNnNbUUWz8tNCEu
	tPgE11n9mOwO2NOLN5VKDCH0A3JlKFU6vbFL5pdEvlYCN5kB94QYpdrX+1MRAIP1lvSrjDNjJyN
	PcVS4YcT07JwYFN6KVkcinnifCCF0JI4m/cVHZ5h4BZN3C2uHtGXir6p/ptbGINCWbJmU532/gS
	r9flV+YeOMcWsWEJXnWi7n28MLZd9jTB6mi9t5SyKjSJCtznKUl4qT966RIIlSXjeCDSgBNGDyS
	xyLJBIge35JRiyp1JB6KEyJC9aGuzHH8nxOddZggVUKvLj/8f6xK64jTSRRrmq4xdEDK/kdQ+T2
	PvxYTuCrjZMN3oj0CT1eAsfrMPI56zOXccdNKcUqJm2/EIM0g/bG/Olkl05xMqPFuajMWCh0R41
	afF260uMutGT+g5WEqm9oWQCV5zA==
X-Received: by 2002:a05:6a21:790:b0:38d:efcb:2e99 with SMTP id adf61e73a8af0-38ec62ddf2cmr4704070637.22.1769609339439;
        Wed, 28 Jan 2026 06:08:59 -0800 (PST)
Received: from localhost.localdomain ([58.231.102.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642b0b4c07sm2456786a12.36.2026.01.28.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:08:58 -0800 (PST)
From: ChanSoo Shin <csshin9928@gmail.com>
To: andy@kernel.org
Cc: gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	ChanSoo Shin <csshin9928@gmail.com>
Subject: [PATCH v4] fbtft: Improve damage_range to mark only changed rows Instead of marking the entire display as dirty, calculate start_row and end_row based on off/len and mark only those rows. This improves performance for partial framebuffer updates.
Date: Wed, 28 Jan 2026 23:08:44 +0900
Message-ID: <20260128140844.949262-1-csshin9928@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: ChanSoo Shin <csshin9928@gmail.com>
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

