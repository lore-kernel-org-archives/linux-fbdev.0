Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AF32BF41
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269877; cv=none; b=TmNhudBGjoAV+J2q3NKse1hbN08/v7Li+jTOBgApFzHS3Brum4otYo8o6BBgP1nKh5OeYeHLfoQUec2FRwfxFGMnia81OqvF9HjXIRp4IR6PvNbzZ9HM7UtlQ1dnsh7lxk/iehNaZfCEmaTTCdy1drVXosY3LBU1pB3A8O4X8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269877; c=relaxed/simple;
	bh=fNr3b7fw70sqLgouWfcwXGCaFZJWVHHM2iEuT9RpR2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQsp26liz2sBqrmJbY1Uew1Ak6aIPuQR84KxYGXHNQB6fbGlAVyHIPWIINFQaEonQEy11de8PqN7ovigaG0bZZCzLlkmHk8ug+i8opHQud12ghv6I8S+pxmfO3KFCsZbtHjn1aP1Xhi2lVVUeHUhIpgC44eRWyrhnZTK5SZ3hH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1ljUaBi; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1ljUaBi"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12c565dd3a7so4374878c88.1
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Apr 2026 23:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777269876; x=1777874676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFigvvanWv8vhl/O/OuGrd11IAkg2hPEA62yM/WOpfo=;
        b=S1ljUaBiYqxx7iVbpU7ZLqb2CqszaKCbP3xvv5kgdMar3ih/Wd5gblG86cH149Dhik
         MQ1gJVDFwGm2yv0d8alycVmmuZ50PaBJf7NnwHmlQPJTvM+CJLqmlsxkBYtNkaSLflsi
         DABl3ZivteYqLAMLRkdy/KDBH4U6VAGtSRtv200RtKHbh+dxtzkW1YM1f2/NP0TjuAp3
         J4eSuDtUTUyarXWfi/J5gQcV/s54vHYneSzh0HypnDdvpqcTCeZ28/12LCZst1/kUWTJ
         l1RFAFTnZRu2Ltm4eGU2PVvfqVOYk+IauO4cJE0o05HUiQcvCNsa+JUQhaiBBFXu5XzX
         qo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777269876; x=1777874676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFigvvanWv8vhl/O/OuGrd11IAkg2hPEA62yM/WOpfo=;
        b=hbsgsm3RbcFv7CPbRVY+kCrHri3q4WJ9U9YhRpcP4aQWgJq8CVHjApy3esX6nLOqVr
         oooEpDi5KI+5Xu0TAUa5PRj2eE7L28K2IdAGwcEoCF7LH6O/Uwp+UnH9diz0zySy3QB1
         WF6z3yV/jOoxCShet8JZmN3hdDTDB/v7L0F/F/BLhemwSbuABQqt3sqR/Q4PTW7gntOb
         Fywa1+8TuyqvQu75wJslRxGJ9hd7wTrLYOBSIAAYc+2HaIUOegstGGV9Bi9F3VY9MQG8
         JD3HZnbfykeZfqHJbWO/RP20wcuIWsk/NVZ0YIhS060rOegPb9VA2OWvuqavp3mtAc7v
         rscw==
X-Gm-Message-State: AOJu0Yynlmr2gyardXfVobnKyEmEb1qFHJugfDNcsSRxy+CkjflryJ1i
	WH8Oe22k3M/Eta6YrIqn8LdhDBOUjU4Z49CE/zoOksI8ONT9jjhsrmqb
X-Gm-Gg: AeBDievJFSsFO3Fx2VywEdTAG9SncIt1D0+D9Ch7wN00Wj8UExmlYurdoE3N8lMT9GW
	9MNX4/uHbxZto9HZGTPPynTx3HMSdQGbSpGRFnIGy4uA/bS5YNPVpfzf7r0jQxUKmw51/uLTe6v
	Uxhx3rBFixJYsgP1fc8rUnnlPgCJGRZmBnmWlUAnBi4/cpAZf1q4ONOehN6WNIXc242EnLQ12cr
	XL/DZArAfAw0CMFx6oh7P3p6zZf0YgCMOO4MWC4RbxRPgbxT/HEBFI9w7FzyW5BO12bex8jG7Ai
	ex/4mJfOMUguel50jAf+NVwj9D3Uw58OlbMiswCXzSrkMuZNI7yOydxFvI+/QEycfRT5bRUHuYO
	QgjzLU5rV+B39uj35Lb27ZLg0cKfvXNf1Dbpm6dWTWut25RhDnp8i1IzQ2P6OakkXq2ZNY5cn5B
	UJKFnyeVFed8SXkIBBUqsZYzE8BpqPcHTEpRecJ5O1r1Rw8o4BwIjFdg1KPJ+OWh1r7w==
X-Received: by 2002:a05:7022:6728:b0:12b:ec67:3529 with SMTP id a92af1059eb24-12c73f781e0mr22886533c88.14.1777269875596;
        Sun, 26 Apr 2026 23:04:35 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12da8b8fbc4sm42459501c88.4.2026.04.26.23.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:04:35 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: sm750fb: fix typo in comment
Date: Mon, 27 Apr 2026 06:04:20 +0000
Message-Id: <20260427060420.1076-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in a comment.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0f94d859e91c..5c7bd1ef25df 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -93,8 +93,7 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 
 	if (accel->de_wait() != 0) {
 		/*
-		 * int time wait and always busy,seems hardware
-		 * got something error
+		 * Timeout waiting and engine always busy, seems like a hardware issue
 		 */
 		pr_debug("De engine always busy\n");
 		return -1;
-- 
2.34.1

