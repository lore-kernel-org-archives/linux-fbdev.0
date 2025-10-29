Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11641E2307
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Oct 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704299; cv=none; b=d+WCSWFmN8a3YIfCej/+jvTF1d+6/5KfrRvEp0KIVuslcYpLE5HIydT7OdO/3fV+Yfj2q3lacszmjNm5drdSRIy7rOSxWZuzcnW1WOiZuFENTR15TdcRfyqNadpRndGXFcZdvngSIJTwIg2Q6ptEXKVK3I1xbWx2zDTwCH+PE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704299; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tObxEuzFNyYuLSs4vvJFoKSgCQanlinHqwbjnjU1GjezStUKSqmsA3/ZdGd510rR/ii+5P1vczp9iW2ER0i0WOcrVjk/Fz75t+pOauTYMLSkpLLQPVCO7k/lh4bcapHeb8DMIkkLRkQR80njmSkaaUOT/cPFdvBV5I+QqVwX57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTuw7Hrr; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTuw7Hrr"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c52c19cc27so1469942a34.2
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704297; x=1762309097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=CTuw7Hrr4VfHhrxGhNhvHw4iOzew1fD4Gp8yMr2j0jqA6Br8cQW7ng5CLjfw+HIwUw
         ULc+k/IEV+E4DgE6U/NFFvgYiV3Rs/MjMGT0CFQnqo9bfmqJMycNoCOmIZhqlAvzlJYF
         nCSMt6TtA+FggEavGNdtFVGi845s4bE6JuCxgxmsD0ezfQVMUO53fWLtvBjr9UOgSbEZ
         eoHXCnlUZA2hRcKCuvFBgNlLMaQVkOj/v2qfWLimMhIQZDae8C464qMVZ883+Pgtols9
         tAa0dYOKvCJaBQuUEMmDahf28cGM1QJiY+q5e4t+Yt55FTclkLm7+ByyDAHiHSuruYhW
         rVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704297; x=1762309097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=qNzAIqgPvKa+I4zrKy9V64Awak8k3rg91ZRJwExSVcCiVjSkQVE2+V8G7Nqoj3t7cq
         +Tx1Lsg0cjxBUIBybDzQl3+wYBYsbjnOn655QR1kd+w2pCxLcTqS5Ze57WOyMwIEylKe
         UuKChjkONR4nxKGy/t0QP0lgJ6wA6mrv/LJhutRtPEfHzr8kKrQVanujQv4zhbrhMo7l
         XXyPqkAse3UWfA1zVJbH9+mPKCTQRoowFGDVgYVIySjS5xYdP48aPGCyyOWqIcv1u+yr
         ph8EUa7a12LoDsVgtfqGNlKLd/cjFvnMzUd79KfFkyFhM52CbKl+4BUnZ/4D5J2n+NA6
         BcAg==
X-Forwarded-Encrypted: i=1; AJvYcCU4hzK46MOihgMk5oYMu2TEUarFV3/V+bVFAsEbxV9tzB/Ql12Ch07AvPBc1rf1xgZsARixn3f4HTSMhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxnH+qY6SoJNbv2Ek+dENIl/RQhOIEN86GkXD+DJfxLdrnfqs1
	w61RzuDWpzOaPWT7RhKEljU+4NJKbEwAw6dqjDrXA3CsM8QijZ8T0+Eo
X-Gm-Gg: ASbGncuqK3jpMQrra3NNDBihkxWC9rPi6gV9fWViRjpxri5ayaipaXkwcWjdSYU2w2P
	tzUgS0W24r5HVauS4Mwh2ArfNAgkgmUbAx/VHgSPMa3iK5zzFOPKIX3JTU6DvvsFSw+Ozzntlx1
	27KakK+RYWg9h4UI6BbmX9fF9mwtM4SpPdOA8VNXTyBWxe647gJCXA5GUyc5x1gfpn7JiIZOG3D
	BvIpjWJtb33skhnMWrGrl9QfrFouBBhQtOPDDnTLKd7EZxBYWrKEnUOvHRWF2pBJremhNr0J2Al
	ReEj9zCdbgIdSbOG8z6HbYqv+vWDPaK/RhdYTjvERP28iXhy5TNCl31jN6CcYvPVFZp16ccqgxs
	eduGpdAK5r95qN2xqOnX6K58Ek48uxxOO28KtMIyaUPt9K4qDGYINk4gl1PC7a3nEYlkE8WAUt3
	RJUnMMpKZB+zoGMGpOo0Y0IpUdpA2TgRQv
X-Google-Smtp-Source: AGHT+IEvILeiQZsY9hQI4HqxU57DwTh96/ZaoIpzYa8J3J/41J2DdiQ6QFO9Fmvro7ru8YzzqFGlBA==
X-Received: by 2002:a05:6830:631a:b0:7c5:2e2a:d394 with SMTP id 46e09a7af769-7c68329cc5emr1033173a34.23.1761704297050;
        Tue, 28 Oct 2025 19:18:17 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c5302068a6sm3732034a34.25.2025.10.28.19.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:18:15 -0700 (PDT)
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
Date: Wed, 29 Oct 2025 03:17:56 +0100
Message-Id: <20251029021756.5751-1-cristiandelgobbo87@gmail.com>
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

