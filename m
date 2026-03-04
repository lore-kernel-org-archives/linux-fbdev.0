Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8443C6A2D
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645743; cv=none; b=CDppXoZwX56qTZQU3nJtcY1DQ2BbId2MUWzZGUyfgbzGpKkRRx3XJFRFBmUqY5BlQYn1wMXzfSuYkgNBP/0t8SbyKdNC4do95kYhvYkPImfuF2OvBFfq3NpPVBP8jtq9+6LGIpOFS6G2Mj6KEhYutKbA6BubhumNRtjb7kAIaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645743; c=relaxed/simple;
	bh=26HnA6jr8Gpj2ARL5WF/0FOSAJ8I03Q+Uhhb0MqsB6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4Kt6kfABL0+IHqD1SW1v/QSIQp3ixnfXKQA57G0VqN/QSCH/nyPOZ+aBru5L6pC2QI0WIZ49LfqpRygk012enqj/n9f/Widr5vJtaBc500Uv0ocRCZHuzgCoSA7kWunZ3HlN0c2K4ePr+udlGQgyZJhxBWzTqVEwFlVDdPDYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5oQiTIN; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5oQiTIN"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c46d4a02ff5so292032a12.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645741; x=1773250541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q74EyZl/rBv7dMbdQMZD34TxKD7igp3TSZElWe8rZoE=;
        b=i5oQiTINKEbMkOdaj8tUz1X+afjmWrhxEUNBvYDC+5dCnjNsne4VI8qyFbxISLlkpn
         EBgQdj24CWSywyxjHWLWRzaEGQUQfhHE/CbGD2bHt/TOCXs0HUe/9YmTWS+/jbhnyhj8
         XI/NNdq0TiyX3PyCaU5iQFj/fkKxtFLkTK4HNQFcX3IlMQanUZKYs6ZLFp5bIy70TDKQ
         Fhgp2vkwo96FJijv2GzQeXqt5oKngOT/DU1mHetgQ0Z7n3xz8Y6SbMl+4TnqkDzp9haE
         TnPg/OP2RfJrP2PP1Dv76qpSfAANu0Tl+szDBzTTSBhwe55sOx2J1A8Un7opDJVDn5Ur
         e++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645741; x=1773250541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q74EyZl/rBv7dMbdQMZD34TxKD7igp3TSZElWe8rZoE=;
        b=vYsgooZlD2M2P+znAHGVKIDXtytLGgzlEFHdn2AO4TtQelqgGMYr0M06rb3+StfLwZ
         v1DEo84DeMGBNfTnGy3h7eka+ko/PH8oncF/ydNvN0LXtM9dQSeJusQ+EMYhdWXT86Y1
         Q+Y1nFBcVTe6GcigaxV8AOVFETIJGT2FSCaOssrxeLgWLdNUF3Ce6YLK3VvdHImgtXwq
         +i8+ZeN/U+SMj+7VKH64NK7dInJ07NKZW0nQrgRgojyYNHpvu6SOBvx+A/D36QSe++Jj
         fVQG+ixTNjyoSCGW/dCMLUsTDyI5sa+E9aeRlE/ZDmPxBs/W9Rii30hg49D1XVE0Ge2z
         1prQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHOlXVExKLtmIMAM3plm1bIH3PjMUrw+xn9HkC2d8vhpwGFREXj9f4ZdH5xuyhNrqFODQKLRfdTlqFTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAOOS/MKDtHmJnunv5/lfbx35lw1mCb7iETMbkAkTNxbgwNBE
	H79Z70hdJONDQ6gQY8t1NTXsCTvaqRuqDVAWy+Qsmo2CUC8qSZB3qFxEN6dWq3+F46o=
X-Gm-Gg: ATEYQzwtfd9/SuR5XnPwjlVmjt3qFTv/XEFGypsV3zhlzRbl85a/s9Cvm6QxPo/fV9I
	+Hx+e+z1PJimpZ/of7I6djchE0FnhImCGCX3eoQ53wThZVdZWO51SVk1IBBofIS1tqz3HSX3E9+
	LM8n9xfMO5s3Tqsn/geFqbQ1pnEwgIz8SkuV1swNGuFovc5Kjh/IoscdlhCxeBDT4acgnurFJyq
	0CzVioC1BJY43vZB/X7f0WKSjJqINDGIeXOh6Kmuov3xAPjsyFe5Cme0Jbjg0kIc//pMTAiXOGv
	ttrwyRV/hN1dKgKn/asrmeWGaPJ8WRjjR5Cu9gydx49M+HS5O0VAO6kdFk+kNATDeSNqZcBvDUb
	c4lCPo0/N10DpKV0iKwUC3vZTN/YjNWWlJC3cju5xjzfz/MwPUeAkfnOe2c3eaOglJIB+eImh6n
	UahYpn6B0zKT2kJRiFSJaiRTX8gzLOQuOq74THDVFqF5sEcTRPvpR8tbTz5vjCuwGQUWUCYuMOi
	9iy/GuZpAj864s=
X-Received: by 2002:a17:903:2443:b0:2ae:5127:3d55 with SMTP id d9443c01a7336-2ae6ab18e06mr18985915ad.5.1772645740630;
        Wed, 04 Mar 2026 09:35:40 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:40 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 2/6] staging: sm750fb: sm750_hw_fillrect: propagate de_wait() error
Date: Wed,  4 Mar 2026 23:05:25 +0530
Message-Id: <20260304173529.192067-2-officialsohamkute@gmail.com>
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
The caller treats all non-zero return values as failure.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 046b9282b24a..1bd0502db039 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -90,14 +90,12 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 		      u32 color, u32 rop)
 {
 	u32 de_ctrl;
+	int ret;
 
-	if (accel->de_wait() != 0) {
-		/*
-		 * int time wait and always busy,seems hardware
-		 * got something error
-		 */
+	ret = accel->de_wait();
+	if (ret) {
 		pr_debug("De engine always busy\n");
-		return -1;
+		return ret;
 	}
 
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, base); /* dpr40 */
-- 
2.34.1

