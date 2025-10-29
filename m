Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A412D4807
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Oct 2025 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704101; cv=none; b=I781NpGxy20UvqH3ajBOqxOj/MX6gBr2qq1hxFlVBYB+7dzklNJZP2QnuE7Z4TGZ1Q5CZsr7W66rnUBfHpNUjDAu53c1gC9cfKRwgQ8PVjVFs6gR5tmbVPQs528gsgM7fuDevd72RbapjZBW9XWwW1OOAOKr4Dd7JEjOEF8zh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704101; c=relaxed/simple;
	bh=12I7O+T/BB5vXrNWDf+G6+4oR7EW0ESEut/5OnczsIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cPieJbL9vnCvqeEaKuwV8R9pnxEwkiFL+IOSlcRe0ymTg3+C58qsG12gjtK4oKeFdw/U7GwYzxzPeGb3A29QJfIFeKQo3fvASz1fWy+7bZSE95ZDHtzFo9uRudbEP69CzUVD2DyWKeIoKBnOqGZ9iKACCrNHeuTirKws7r//ZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaYS9G2N; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaYS9G2N"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3c9c379af8aso397551fac.1
        for <linux-fbdev@vger.kernel.org>; Tue, 28 Oct 2025 19:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761704099; x=1762308899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=SaYS9G2N/oElX13SfAdvY8/BgZwu0ui3SYNgp3wdNQCcmBOAGAlzAOzohWApxeQIOc
         ztScGqjsVpASOAoqa2jizOtqXp42OW3FN06cwIMXPmHUSeCPIVMkzxnGmFZ3nJHf+DWq
         1eAjDLHm/EUgGQS4ohX41jM1YW7GLV/A0jv4ey0+l3Tdi8zamaXtv+G8xhpVlajvBoX3
         6bZgjWN931Vk8HZLxaL+b6Q3JO01U8vyFPIenCE8ZeeZlCUb0468763dw5QebwOo2hZu
         IWL9YHupwKnt6kIqlBlE2+QWHYS8Se7pysLcN4/rgJU3ZQNwSZ+90GQDGKBGvtvqhKKr
         DwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761704099; x=1762308899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHoGag4qYuBHkU394iiXcv5SpnjOGE5n7s42K/stQF0=;
        b=PmwDMSVxbgh9NonJHJXlXfBXc9UqUEZrs3Feh8Jf49lMlBPb1sdppYlkD98PfyNn3g
         h/242zoYjs1tu1+JAhhRGmswNNZxQDI807H7k+j9yfzE55LpqPMGbu5/eeUmoxy4b10c
         sWKClfbZMRsXM7T4st57O5fVAnQQvy1NDEh+XWd5zUFuBnxhpzfj9vJ9+xNI9y/zK3AP
         Kcgjk62oPR9NC/SNBTn0T/mqIzzK8r6B0UJ3Oy1MAqXp9KbMeN+W/pKojaF7lkjNrfd5
         l44BnsRFL/lMAbn7ZZrAyqvftYVr6rTzHqTJp7oCaY1OPfVjOkf5W4wDsY57ILvS2o36
         dWmg==
X-Forwarded-Encrypted: i=1; AJvYcCWs7098dO/7u/GS522zyRqpWHoXf7VtBaNb5JGveqWeU4cHJgfTmFqnJODsUjwFMqGqIUYkEFyAZFR3gA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6vqeLFiz4vFhqwu12ctDxNReikU847Rb6oZexdnz6z4LJmMI
	+/d9vJh0o85Vg8Idozfq39vnDK/8BUxYu4EN8aAFnXLJfXAmZIGGAXXR
X-Gm-Gg: ASbGncvRdqh7BICc5PgltiEx5O6caVLUvbJ2qtVs3B9S9pQMgXHXfDC9FeOAdOvhb06
	+zrL78aI3pVxp96LrZWWQONZfH42t5kVPWdQVo47orUwOu+dE7aM0VpZmhK+WtK6Ln2V0CXvFNA
	NFo3wD633cd0E6Rc2qqO63MFJfzuWqF1Zl7Zhlw4rkQW/VVEAsru+p5jZSbMXT1QKbXeMGt/kk1
	iOk7WiiJkxQavy15gFHvh2BZ+PXPEfuidc+LEXchFGlbw4+b/AGaWM/yuod7bo4dUoYWSVSfEA9
	paTju8jmbrGbEHfD4JcndcbZTQv2/7J945p0GudOGJr729OIHmXKSsa+gjOCUepfkJo2+bwygnI
	aVOstJV6mj9/41+jubERyHBFFn2WLBpbZhSiHVeU58lma6A7iHvRvUx3JN5pT2icf3gMsowj0D/
	X9MWMukbZ7HiUNiTi+avUnjkY3cHHZA5lx
X-Google-Smtp-Source: AGHT+IGfgTz8g+xqtQI6DArhNfNdTHyjQWmRw2+ZzPnzomIZgLnkO3eFgWsHbdYW5iK7yEBnpMbcNw==
X-Received: by 2002:a05:6870:e99f:b0:3d2:3429:b243 with SMTP id 586e51a60fabf-3d5e7264ca5mr2344497fac.16.1761704098667;
        Tue, 28 Oct 2025 19:14:58 -0700 (PDT)
Received: from localhost.localdomain ([104.247.98.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3d1e27123d5sm4190377fac.7.2025.10.28.19.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 19:14:57 -0700 (PDT)
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
Date: Wed, 29 Oct 2025 03:14:49 +0100
Message-Id: <20251029021449.5420-1-cristiandelgobbo87@gmail.com>
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

