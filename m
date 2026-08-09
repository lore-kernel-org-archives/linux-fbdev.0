Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAA4B04B4
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Aug 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786253608; cv=none; b=jDd6rx1nFLhneY2r13YPmh6988R7STDkZ3k1Doy1J6BPnlHhz3VlRcanTatEsdEDgJeeajpPl0IK7MhB70ertJCOiseVKXyQ13PmYJ4K+IPEYyxQxmBll0tv515lmdW6jsfdcjZO0YSA5r1t28GzdbxpE7CGUbziPTB1DHnOvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786253608; c=relaxed/simple;
	bh=hgdPB8jY0/nbgIb+GxDil7LuMbJzymt/E6nktr5HChg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+wSP7NCaGCfOPW0XQcyUoXp29FdiYnnkJIUPDqwOg7SPBSao3TjuJa3FA20KlL0s0WWC1X06rxhS62qA4oefBBVTdtrE1hItEWlFCy3bNqTOkixGq067idwo2A1Op2reAzqN2r5yiaeGbaPR4jzCEpTLKLOuOGbBf26AB0cNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqWzNYvJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqWzNYvJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc61541f8cso36410785ad.0
        for <linux-fbdev@vger.kernel.org>; Sat, 08 Aug 2026 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786253607; x=1786858407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iiw60go6Fssc+w6jEvdK+NtF+fsX/PqKIb7cNVI3nSc=;
        b=GqWzNYvJPrOYcdN0xxKbdLqkcAfUYOWWGf0sVVYwEjq4FIqiLXEElt05OtmGYTDZee
         HU23wsmWW1ONBB4fKBAXuGSBMyefRe4ixE6GMOaP82uiG+YWr0hu6dzOIKckT98QdE/V
         eVR0xl4RQWku7XVu/jdYRWgS8j4w6TGYJ9lIIbsxiX5c81RNwC2ZWpCm2TTe6sR0BkkU
         WCDCq3DisboYdXX5RtqaPKWgVryOjcludmyVSxO/g4aeH0pOPOUX1iwhZapoiuJd/11J
         DnID/vswq2E05lN7jdPOnffVv41d7XKrqHf5YQjhv+mzI+fiI7pg0LwNr4km28NNCHv7
         G7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786253607; x=1786858407;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iiw60go6Fssc+w6jEvdK+NtF+fsX/PqKIb7cNVI3nSc=;
        b=sbShQsoEd+UlUsv47pqcvMB0ht5me41epPFZxUxj6hdFNzv05m9sCxu38ZZZpQ8EJk
         oi4z5LhHm13VK/sWQ9ecgKL0ajwVFgNoatpvgmWYMKAQM9D3jvr35qZltX7qHymJ2PDu
         TMa3tc7fl8ZgK0yPvSOKARkI9RnhNcdA7jvqN+nGmt64ZQhSymkFvBm6a6NudAKy3I/H
         ABHv/3/WUHUSApjXViiEtTF91V9zWEyBejkxMHY0AZ8r23JAIRKBfrDrv2nInubY3E2J
         5tMybStfDHMwLJEBb43prXRAsPXTq3rUq4EMaJ6tW3mPnAHPXX6VtRDPggf2EsjhMMUL
         Qk8g==
X-Forwarded-Encrypted: i=1; AHgh+Ro093Wnm5s5BeYaJQezqbRqs4UkT63pUgOJzfs4IB+jqJVIvCB9iOSd5uHHUPCwc/lLYQmq5kLBTvzCEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9js2yCOspueJObvrurgbDDj/ft3iuG1wyUb+hnF6VVYL3AHv
	Nfch058qzD4BY5iAQ2FeiCaBsvGqhGFKA8dqszWiDU6H/QTzPZTBh3Rk
X-Gm-Gg: AR+sD138DxgD+fzb1gI5lrkgSkU4imRdG8F1wI6jjPjZWgSV/1uSTFBzdMEgi7Gh+7L
	DHmvNUDbMF9+dXaCGlUJ9hNSBsFzQQ1vquzmobAk05tuNwpXZRlc2duCsVWiD/7M9TiHR8JIDFP
	/YNKgJ55lCyRKL+dabimnrWXGmz/Nk09aB3Lyp01v8ARVfRbVy+QDEuzJSXAm/MB03OrutH9F4u
	sifGgWDDCJNK/brRz3J/vO1iSqLySy7HQtB5Na1SCkm6RKvbDXQ8SIQV7PJmDU1XHlL5gUt/sIE
	xCFDi0+110NCgvP6k7BEMr3f4SwqF/bRcILUwiNDXPfVnT8Kg1OSeL9B3JnRyS+kUTYi/2i7cEz
	Ji3BwSHz51Z+JoApaie+ZdRQt7cboKiXD8hPBDWUPwYHkTCaF3gForI62UT80huA8ip5IKhCTEY
	RBfYEfYihj8uKjBp2GMDu9q0A4Tjv8RjPJkjP7YqMZyNtdqwJmkQMOk6gLGHGG
X-Received: by 2002:a05:6a20:7fa6:b0:3bf:ee42:192 with SMTP id adf61e73a8af0-3cbd37eeb4emr10610214637.6.1786253606859;
        Sat, 08 Aug 2026 22:33:26 -0700 (PDT)
Received: from preetish-pc.. ([36.255.86.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm44390386eec.18.2026.08.08.22.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 22:33:26 -0700 (PDT)
From: Preetish Amballi <amballip@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Preetish Amballi <amballip@gmail.com>
Subject: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
Date: Sun,  9 Aug 2026 11:02:53 +0530
Message-ID: <20260809053253.14537-1-amballip@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The file fb_bd663474.c is a driver for the BD663474 LCD controller,
but the comment header and MODULE_DESCRIPTION incorrectly reference
'uPD161704' — a copy-paste error from fb_upd161704.c.

Fix the comment and MODULE_DESCRIPTION to say 'BD663474' instead of
'uPD161704'.

Signed-off-by: Preetish Amballi <amballip@gmail.com>
---
 drivers/staging/fbtft/fb_bd663474.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/fb_bd663474.c
index 1629c2c440a9..c34f859043ef 100644
--- a/drivers/staging/fbtft/fb_bd663474.c
+++ b/drivers/staging/fbtft/fb_bd663474.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * FB driver for the uPD161704 LCD Controller
+ * FB driver for the BD663474 LCD Controller
  *
  * Copyright (C) 2014 Seong-Woo Kim
  *
@@ -166,6 +166,6 @@ MODULE_ALIAS("platform:" DRVNAME);
 MODULE_ALIAS("spi:bd663474");
 MODULE_ALIAS("platform:bd663474");
 
-MODULE_DESCRIPTION("FB driver for the uPD161704 LCD Controller");
+MODULE_DESCRIPTION("FB driver for the BD663474 LCD Controller");
 MODULE_AUTHOR("Seong-Woo Kim");
 MODULE_LICENSE("GPL");
-- 
2.43.0

