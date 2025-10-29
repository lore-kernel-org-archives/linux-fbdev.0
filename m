Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338F226D1E
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Oct 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704494; cv=none; b=PyqNMSLe+g7+ut/gZXTL09DWICWol5UelWsZzB9zh/H0DrvD4ImmvkgZz6VthkmFK7nL4qffoIY++/EFhHhdsnAoeHRGauFQ2AETuHRvv2Id7+g3K2Z7QCgjaiE1j9p6XHRhFIeIqrACOHewYHdzrnzmpz/VphYF/JAS5t6nmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704494; c=relaxed/simple;
	bh=dbwZvu9hhIyVuqMTWNgr+/TO7f8rMnKkqOT/atxJsyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZCM3KmJM8KXVkpDPUmAbXsHQ7TamzeV2+tVPFV+/xptHsX+56W7SIpnG9y4TRPH5YW6mzUuJtXOfzv2sS5U9wRMFu1OdMPD+/QfhkOGttzbNG/uDwfQG+WeSmq/6gbfJEEoPrdfcvSfeSmBiw69LCs9WgE+Sl3/YddnSkLhr7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIUYjvd1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIUYjvd1"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44f44a1a515so326029b6e.1
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704492; x=1762309292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cynnkWYdpDtStoLe2q3qh9uk2uD/o/JQhJvnV67pO8E=;
        b=CIUYjvd1hWpiF1cJjy0t3vPEtSPY8+Oc1jO0dz/SZjHAI7qM6JQth0EgVFPx4Gi/qO
         YpRNmhAgBU4tgOKxuANw4hSBCZeAdrUtCnSA6rJmU1i/eBe9e01DIK8j0wwhHEcEBmsQ
         VByvLn6TDlCPFnw3YYiPiB6rz5Pc9PE2ETXWOvLddBHaOsw2IyIEaG3yTOegdA/5wtKo
         SJh40ffoOSiwrRQWAV6S2IXA9EapIVHZTX015ple5rHkQZPi1hqAhGxJhMh0kXly9AFi
         lxbWtArjaShKYBpk/60Yin7dpnZs0Y8UCiWQ5nuPgc8wYPmE+D4stnYHNy5QctdRqN6q
         gJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704492; x=1762309292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cynnkWYdpDtStoLe2q3qh9uk2uD/o/JQhJvnV67pO8E=;
        b=wJgbHZG7ntEq8w5r9Q3L0XdwoRMhk2CuT0x2tJmpbzS59EAWaMCg1jLyIRfixO2BKB
         fMu1hgDI3pqBcFllln/3V+V34alfGnfqgfjJyBqJv5Hav9r45icxvu8gSL149H7q+vI5
         MN6mJ5gkKaeZvIclebp25g4tI+PFihIMfOngmNS7Dj84yXwJzmAEpCUGYtWqnTErcfA6
         cJtfUFNNu104Ag4rc81IUK3CtxpQl8MqviDGZ9jxN06BRYX+NdwzGXwieJYLaqG6PQ22
         UrRjfFhlOgYHDUoFCNL17AZlMDswL8kl0dj8cpFf3sO58AR6nIFQ2ZTCkYscBVbE957K
         BbEg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsEqpQaykG4neoKnBZh9LNsn87fVN+h8N46SvXz6XzNusi36lszg2wCbGduFIHXd3q2dtRwBvFAtNkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZFsOoDn2KE2GWNhsX1HCyLzBrqnmo+8GMpnKlIFXwj9eXUla
	4GBwuU84XbEixW3ZqIsaVzC87tFikLgiJRLKJX4RJYQCVfE8bQBJv4CZ
X-Gm-Gg: ASbGncuZXN3CSr5Avq7edXfFy/xWKU8yIPq3Wj0rBO6M0vRJb8iu/omRnqGUdttmQ9m
	f4X4LJWMNwKoIUqJaLOc5LNW51KrxsxmrnSI1KN+bCob01k05o0qdSr1mwZbod5b3BMAJsjGgU6
	H/xBENunL/KHrBh/EsqhKu+0tJTP7xbITnNhCA7mo+ibC9D3mOXmpw0AllchWMrFCYPVBrlOBPv
	FMsDc6q2lpW0LlL3juEHxNiwp6fk9SgdYn9CFuejAU4Om6zpsZy67yflZ9GATQhUiGq2tFbLk/j
	Erg/y8xd715ijL09jFdqEtNHTMbd4+bdUoHkeIg6gg6TtvKwyuLvBuwhvKR4Oc7djh1gaszU04I
	juIMGFXOpAjMa9Y3P14qqKgILosOY+v+EVAFx/T/r8ULRmibzEEQeCsFGVR+nxc3M7YdFkVrwFW
	yuFYaziiXivJKeuXXoTQO29S3Gqg5xg1Sly5DyQ5UGWHA=
X-Google-Smtp-Source: AGHT+IEbzvH4doyoZTsME/vt7Aop2SgS9zRyrPlNBrd6OpJTwf4P0pZiGzx+zwlfugi8jpvZSSIqBg==
X-Received: by 2002:a05:6808:3191:b0:44d:a5cd:e803 with SMTP id 5614622812f47-44f6c79f9fdmr2633390b6e.20.1761704492254;
        Tue, 28 Oct 2025 19:21:32 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302203d2sm3775042a34.32.2025.10.28.19.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:21:30 -0700 (PDT)
From: Cristian Del Gobbo <cristiandelgobbo87@gmail.com>
To: sudip.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cristian Del Gobbo <cristiandelgobbo87@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] staging: sm750fb: style fixes: align call and split chained assignment
Date: Wed, 29 Oct 2025 03:21:23 +0100
Message-Id: <20251029022123.5829-1-cristiandelgobbo87@gmail.com>
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

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>

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

