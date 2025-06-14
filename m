Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6F3FB31;
	Sat, 14 Jun 2025 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862474; cv=none; b=N1pIEHJB0byZQX8wMVAsaldCAs4yEABMyaSzH3+bJNbypcRAELMbQXwVWEtmSanc+Kaaij4llGyfNmXyO2USkVKKpQEmXBMrQiSfhJc+ruJ/cbRKEbQFFFcE5DpjRUD4ih0qDHH7d3FOSQofqXQSd8pM9j45c77BD+VvnLzYtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862474; c=relaxed/simple;
	bh=LK2lplB20s2GTVjFH5U9EI+NAX1bonoLmUGrd/rroRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AsSgd30SgzyVx3aA5fBGjIS+JQLaBycDdIh1LjuRrv1/GBlfvq20CwZ395SUSFttpmhV9KYH6ESlQ6W066okXB8phCWakDGb6fYB3pCmual2+jQsE8hNCkRq+CwXdCTQlxe7zzkvVmM6F3jCYMAV3QryMS0TFjFLUyZbHegyQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgahJwml; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgahJwml"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e73e9e18556so2597573276.0;
        Fri, 13 Jun 2025 17:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749862472; x=1750467272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6IOC5EkqQjku46aq+03ogzTal5jg93JFJeW+nRvKVJ8=;
        b=HgahJwml/E5gXEFF3xvp19W3JQOvNAL9wgBMXdzZcs/0JTwnwTZVHiIid7gBQrq0oB
         0HKDBNUWo33v0S023SGz6fJJWofGG4qaMbGZzBC8NCRzaGKJNcsa9Ys7p7ZGH3RGxrVR
         0OM9swHxRaVR8g9rOHwf3GNbhg2KAzVq+Kyq9xAKlAG4pG8z8pBTdK8wb0rixkltz5GB
         SQ4MZVSbb16gUmud4Jy/CiRE0n5hndnaGI/XDUiksiimxQcTuk8M7AEQYoIE7rZ31N0R
         5bIYmsvypbHK4BmfGMam2mtfAq2uCVcexthHbsen16YrNKVj1kp8Z3ut2Fb7PQBWnHqL
         mO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749862472; x=1750467272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IOC5EkqQjku46aq+03ogzTal5jg93JFJeW+nRvKVJ8=;
        b=TUOiH0oiJrvUYvYaPt7e5svdAV8JnEufXd0iVQNHQVZaa9n1OQT03gpY4eeNmV4z3m
         I/f/uCXRzpZ0FopAc2TmyIxT+t9WykRm4l/+6DUcYZBGHfKZmSEmu6mxscPVuy15MFYQ
         1Q/Bixa9ZHnaw7j8rAiFoPyPpEJRnORoacqXfp8R+LCHM/jNgheawK8BaeCbksuzpI+e
         VvXtHuBPkpAmoTppoZw4ENewXTUd1abwaXXwEKCw0oCztbayLWKJZJEcOmy+G1zpHJyq
         w4M8GjKebJgcSM+s+LNh/y6U8NkXYij6eRvbEk80NNcl9tUjXpU9PrpGhGVmGRusoDXL
         nbzw==
X-Forwarded-Encrypted: i=1; AJvYcCVU88oaFq+6RIUWCYCKXBwC7+8M6KFZVJ+aX0E8QgtaBmeNmyHE1NEb0l0TF8VWbYMVAmLo1KnTKTrIAnil@vger.kernel.org, AJvYcCXjFFe+PaQv/JT1qFB+f9VKdEBqXfUlAeEWqEr2k9jFm82L56gbyYNtDYpWkUeZdmEpoWA5+AbVrmYayg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnvYOvM/gyN7spNrRAYvHA0wQ9LIWwgIFfCjKmJeag9BnuGn9
	pcpAMZuUESQMUZOUvNRPhVszLH3SASpWuP7nrybG845yc7uXeShiYLo6
X-Gm-Gg: ASbGncvQj/IbIqteAZUb5T+GLTaBUdkIX6i3A5AgxHXbJxxPD/xQnTbcrtGNzlv0nSP
	B0fIfqgGU0nwhNSIQgzKLa6NWCBmxwrwJNmexRbOG3XgQdF5Vid5LjwmAx3cogQXNCcI087Z6i0
	Mnslb+feePNYa8nMYVXAgAmXr0wtC+0HW1hRL3JhV5lsPOjAl9j4aH7waSt+5PUftfQ1juPNdcl
	fNb1JB/ZVVe19oqoRoIL9EcHqc/D8JTCmBBL4p+1EjinQO8NVl2qKRxH81NmD7SuRRwTTA5aq81
	j/6IvBBT4FDRHF0n2idEOgSg3IGWMGoVPMmY9Mjvz8i7JRQZi/N6E4DCiKMiz/yfMG7dezoV/02
	FUQPzZfFN9Vs=
X-Google-Smtp-Source: AGHT+IHmyWIVsKa8zlkseIGQ7d+Nzek020p6s1DukOulLA5PqLXiuoVPhpDzKStteb5YmT4RgfC8wQ==
X-Received: by 2002:a05:6902:a06:b0:e81:2ab1:6335 with SMTP id 3f1490d57ef6-e822abf79famr2419866276.9.1749862471672;
        Fri, 13 Jun 2025 17:54:31 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e2be6bcsm1398678276.26.2025.06.13.17.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:54:31 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de,
	FlorianSchandinat@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: via: Fix potential divide by zero
Date: Fri, 13 Jun 2025 20:54:28 -0400
Message-Id: <20250614005428.3112421-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in viafb_dvi_set_mode. Similar
crashes have happened in other fbdev drivers. We fix this by
checking whether 'pixclock' is zero.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/via/dvi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/via/dvi.c b/drivers/video/fbdev/via/dvi.c
index 27990a73bfa3..0ba248b7b360 100644
--- a/drivers/video/fbdev/via/dvi.c
+++ b/drivers/video/fbdev/via/dvi.c
@@ -166,7 +166,7 @@ void viafb_dvi_set_mode(const struct fb_var_screeninfo *var,
 	int maxPixelClock;
 
 	maxPixelClock = viaparinfo->shared->tmds_setting_info.max_pixel_clock;
-	if (maxPixelClock && PICOS2KHZ(var->pixclock) / 1000 > maxPixelClock) {
+	if (maxPixelClock && var->pixclock && PICOS2KHZ(var->pixclock) / 1000 > maxPixelClock) {
 		rb_mode = viafb_get_best_rb_mode(var->xres, var->yres, 60);
 		if (rb_mode)
 			viafb_fill_var_timing_info(&dvi_var, rb_mode);
-- 
2.34.1

