Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C582236E5
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Oct 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704412; cv=none; b=c3CxImrKF5BE4gvjobrw6b3a+xT+9kv73u9Ab/xC0Oezyqegoc7u448/8zaq8/Ny2StYLxsHcB5yfgwTd2AbOV7Cnc4ijyc1sQBMRLPzWFZIomRreM/afXLzOWA7hP8DZuaMWkeAEew3aaPBB/tuB35yFAs5YuALNDPgr/6uX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704412; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emd1hXhtWoZXANzRKSO5cz6pNfIi6LPq1qFtX21BpdiWS54mq7hGArHRIpiLgicUAeDpNxNQQ73niId1hH33CGd7/YAMGPYR7meaTeG+nPRy239qXEMgthr83IFjW8HidufDcZlmaH7w2fVUslK33XkZLBgYOszudH4pH/duXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXQ9GI8G; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXQ9GI8G"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74526ca79beso4596558a34.0
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 19:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704410; x=1762309210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=cXQ9GI8GaXG3PsVhMVz9992qLMnPA922qcSi8kd7P9TWazWDx5Jf43OsPhs8YXx5o5
         3YPh5VrdSyNlSiCKLrAk4LgGdIJV4ApNYmNoKRDrl8tMjT4o8VWakYI3Td8yYS8NPMJi
         67r/roK5jAH+xLP09T+2e9yMS+BD2U81n/YDPuAqR7VP09lul21cCmfIj5ooUQIIy+u9
         y6NYMCXZVUbMHVuoC+jOOyJRbTwvypojCIaNwvapNHJ6Wtt+5Vz3yGfTFBW2G+gFs4An
         ffmk9EzDq2S0YSGsXmPRFe7rlROL/I4y1l83i1AHlkzSypWFjMueU0RWn1N/h4giyViq
         sExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704410; x=1762309210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=SHL1kUnzJBGKFxNnxvXSyr2lx6fvQYvIY2TkxTNUef5KpX0el915yfboWTezf5pY0f
         5BH5+XvmIvGj+PfuB2XDMcmSvdNKv1wAocV2WoS7ZOBCdwDuXGMdJjXPHNbGTqKhs8Ms
         mpFnrPfRPWy10Oj6CoPwI7yvuuP68K9XQRj9kSWm44GhDPEfIizcePnl68G4keeME6R7
         efmNRrl9LjcAIf7prYDT0a70qHJZAvfsbiMyjbcocCcn3jEhPsUprx8JgaN+DvFOrGva
         wBaCjerq0y13IOyNMTjwXJ6EnoednXxQH0776D2hSWXN6TEHgxOuQJiX6DcUCMJFdGYY
         KcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmVvjkZO12pLeAjCLJ2BaiS1tGu+HP5LZMngL9Oji7hGJTxn8WQ1X3W8btmwbUy4ZqqHhC7V10lSc9XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytZOjHEHrOYRNcmldgT6YdtNIsk2mjKJFOBVImkp3lvNeL3Tcx
	vqtzuRE0SMhatfjkVvVZCYW+LV1pV86RAa3rLHxYLVSmCmfA2QM3M0XcI2PXLxmA
X-Gm-Gg: ASbGncuVEtTsI+syTIeIkWn0xuSdKmlbTELMUTO1hUCDTvnjK/T50f2aCcqIT9dWNgR
	7SU4BGf18roSNnpH8U8oaIgjpSDiaUcXwgBMRNPe/4tgLH2E/Z1c2fI4vlY8ZZov36c5wNQjMmA
	4JFiyKFMN9MQrovR9HXf0xz0yLJmXx3X+fP3MjNBqI3TbFLCYw86wPTLvwh5uFw14xExG4Bhi98
	snDp16ZwAmXDDtbsYj7sHF9fO8C1b2D9uLwplNEFiY06t/DwIMY4tVzU8Df6mMkVZoC2LE3ayIi
	M0nnu8Q++F6pbZdRI8QR7V92rlEieQMZrtezkU9XMC2h4dakrUxVxe4EKmQkgh+1DzQn5dr9TNh
	m5SQ1IqB6DSymR8gyCxIpC9r1c1xYkfiSmyhM8drmNTZs8WrwC7l52LRKqH319CdilKQz5GcboP
	bwLpwnGN+KuRiniFT+Kn6q7Ez1pB7rilUo
X-Google-Smtp-Source: AGHT+IG8RadSfTV9b/Jcr3hAcs46CGuklm2tmbfKHoIvqZk7EadHgn5d3EWjSr6/j4EfcF3GDY6P2g==
X-Received: by 2002:a05:6830:7107:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7c68318995cmr940907a34.32.1761704409994;
        Tue, 28 Oct 2025 19:20:09 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c681eb5595sm499344a34.3.2025.10.28.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:20:09 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: sm750fb: style fixes: align call and split chained assignment
Date: Wed, 29 Oct 2025 03:20:02 +0100
Message-Id: <20251029022002.5812-1-cristiandelgobbo87@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Drop previous change that made g_fbmode[] elements const (broke build).
- Align the continued arguments of sm750_hw_cursor_set_size() with the
  opening parenthesis.
- Replace a chained assignment of red/green/blue with a temporary
  variable to satisfy checkpatch and improve readability.

No functional change intended.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3659af7e519d..94a99af4320e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,8 +121,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
 		sm750_hw_cursor_set_size(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
 		sm750_hw_cursor_set_pos(cursor,
@@ -538,7 +538,11 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 	}
 
 	if (info->var.grayscale)
-		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+		int y = (red * 77 + green * 151 + blue * 28) >> 8;
+
+		red = y;
+		green = y;
+		blue = y;
 
 	if (var->bits_per_pixel == 8 &&
 	    info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
-- 
2.34.1

