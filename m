Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA44A5C59
	for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105961; cv=none; b=APmJeNOP+kVi2JiHY3gJhKmHQHhi18/5VRU6TGz9j0b2fi6gNPSRb9VxIAXYR15sKpGPBp/kRQvQXymQo9EhcgWs+xdJZR1lg8z0CvTCL3mGmnG1v+SThxixivNRIIpkdDG2vXdJkzBR8KAlY4Tmfa5xYA48ozVCsXa0d15D0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105961; c=relaxed/simple;
	bh=K4wKYbY7lU8zUdU+RI5QB9tTpmwS75+tA5THD4vU4oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM592hyjDtzhRYLea7AMS60R6SpfEbAbJMn9S7qJnaD+8IJRUgEdmGVhDjcS5WlvLkTeNX1+y6p0D1VKEqiMEI72j/Bs6dwxxONP1DEyAnVIqxhh20YVwcQYa5D5cM+6lNUDQjm88LRbi74bvx8wKYq/w1i19pq5w9B3uFb5MVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCJ4d+ks; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCJ4d+ks"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so1103005e9.3
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790105957; x=1790710757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nL0RZ42dVFFkNwcOaBBBW2RIorolWqyGdNFfDoBAeZI=;
        b=SCJ4d+ksMF4vTPq+zMjIotBID7PsPO/J5xwvxjUjeVG0C92sPHyNFFhmD75HRYR7BD
         LN+rz5FZISR4+/5HzCoZPPZ0vpSpm3+xquCeDdWkrsPyHSHh9iVOo2fACtRKOy3+/r71
         rTmgOk7Pss8n+ulQgOYg79VH5oULUc+ywsqHE9fvGpZmgHbsl+PhJS/SPoJYEb2mS6IV
         1AIbWdq0mxIlth41dyV9O4XqI7lIWyp9w7WdZzrO5jHw32GfkAXANkxKRGji6gK18bzw
         U7++CwytXygz2Kfzz2qDmuCvWBLXuUgP97l3ifC71v/NgwPKOLAdCbgr8wnt9gRFDWmo
         U4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790105957; x=1790710757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nL0RZ42dVFFkNwcOaBBBW2RIorolWqyGdNFfDoBAeZI=;
        b=ZNXprvEHKK48zZtGnLhlEWRWeCYBudQv6VqoGN/X7dYp1vo5KPFYBuZoYxoCJYnWEp
         y90b82LdTCNqskWFfnegjymetKZVtVc4UGN2y1clTgBr/OH5ZDkbYYctfZE8/Cr2+3Mo
         Ilb3SFUbeEH+6vGO4S0l2OfjwNHZvD1Ft2O7Er++z0PF6VYwbnVqHLXyIM0OzA5UMLVi
         /VpqD8HnEFhNvzVXIpqNZh5OUsWk9JxEK/ggSWkzZ3F49sqSham0Sd0DmWVh9vhV49bE
         +NIfbwgVn3SF+3o9y10+pWFRaneAMCDO9GlQ6b/LeroCl1G50yoHXzC53KABaLUSrrgQ
         gD9A==
X-Forwarded-Encrypted: i=1; AKwUvBwvC49+83MUvKtgqbWfUmf9o9pKBY3G5eBs43LHGy8dBWudIb0F6n6FYmzrNAQWEQIiUvXfJ23oHEzE1A==@vger.kernel.org
X-Gm-Message-State: AFuF++nVjZ1cFSy3XZ4IH22KuyiZixPL5C+MzZ8W8aviyzk5+oj/Yyit
	gR+bPGti2odKygsTQO1MYWvqALRwU1KmErD+Id7qNzeQ+A7rNu92CiJk
X-Gm-Gg: AYBFou3hOxpmT0gACd+YhkTlgYNvy7kpg76I1hSEiNDuqouh3W2J3RnYyAGk213WX9m
	rudeXh2D66KO7NJ1rBvPz7Qp8y1x4L8ksMsPA00dZiZr08rygXFrGK7pOjB1/r+jrgXUKpI12xQ
	DfxHTnLxenLeWAMhqFhXbxlCkA24Oo9vR+AaxSlc9eHEQxVMpdysq+0DyVQogUKhOtZ6fZH3fCs
	zn7gyy8mvxaPgcie7OpkX7CLV+f1MrjP3kV29BKBAIFtROO9kwU6SKLAGj5JaUH23tGNhLwxtCU
	HftqrMttM0yM5lVoyP5km5+KyUBPNdrs7PN+/HvPrlT3Z4YzBwBjHuYR9mRORdTIBZVdy5DGdHI
	l0L2B4B0ByMSTNe+jNKxfaKFS2nYxL8SqtRyTsy08nlfzivTnx3Zvjfm8ky91hM6QvUjYgSBSha
	GZIhTlH4oUgMzYipqBlQNrJm5gfnyIMN5+9Ywxi1elT9Weolbpg8wCyfq0sYohnmkhqXlaH6jIh
	mfUZncDhEv9UiAWDsmHiQ==
X-Received: by 2002:a05:600c:8b64:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49fdee0a0ebmr2558085e9.4.1790105957383;
        Tue, 22 Sep 2026 12:39:17 -0700 (PDT)
Received: from localhost.localdomain ([149.7.5.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf157cdfsm2494235e9.0.2026.09.22.12.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:39:17 -0700 (PDT)
From: Vladan Kalaba <vladan.kalaba@gmail.com>
To: gregkh@linuxfoundation.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: vladan.kalaba@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: fix const pointer declaration in sm750.c
Date: Tue, 22 Sep 2026 21:36:53 +0200
Message-ID: <20260922193653.16086-1-vladan.kalaba@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix static const char * declaration for g_fbmode[] to static const
char * const as reported by checkpatch to cohere to Linux kernel
coding standards.

Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 1ea3dd8b8f28..79d0221cdeae 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.53.0

