Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC2280A5C
	for <linux-fbdev@vger.kernel.org>; Sun, 21 Dec 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766331089; cv=none; b=WSFQFC+N/6J/6IY/SLCbS1rLjaQJvY1jnm98cvfpgLndzy6t6jGQz47RRIFiT8q+XmYYnOf9J+8531/c2Pl28VeoiH9j+Cv33iJCZwQ/Y3tQQ8FQzqNVTar/zyrHOyoPuSaf5PuXInQVImZJO1W5YR+BGloY0XAU9aYJvXfljS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766331089; c=relaxed/simple;
	bh=GkXEKImhZDeltY1IKY52xL/hPVVMAkBaQ+g+36vcwzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE254uhYSYDk/rxMg+fO0fCGiBQ0K2SP/hthOiqnJREgg9h+6KK3iJJLlcAzMPVdz1qTX0HkYrbrrxQnhTBiSeX8RPhj+2pvrVwjHPowS+glvGvyzPHM1kbLxocZM50YKTc6B9bn1SxclT8rPtQWbbh83DkGp0wilKc2eK4riPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt1aN6ia; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt1aN6ia"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7cee045187so583138266b.0
        for <linux-fbdev@vger.kernel.org>; Sun, 21 Dec 2025 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766331085; x=1766935885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31JTYOJ68zQU7Ygr6vWGrJQgZrlwNQc62R8gkC5DC6I=;
        b=Tt1aN6iap9AOSbem+64b20ZSoVcnPhBWCxEE5MKB2jvXFz2wTEC4sztNow6jifmVaH
         HqizFvnbR8q7nBpnJD7UhW1/xvtPMSaEtVo++ob+WAyEOmGj8nT41Cy1JI9UD8Hz9fKs
         FoGiRmmgcCc9Pf0LGRFjWIOCiCT7Xz6sq53NH7SlsABuaZsQzwxI5xpmK/TUIXbilwpC
         Z1DMwWxhLh1/I+qnhcyU5TiuKDOgxwxCijt3LyZk1jGbckr/Ltt+tv9746jl18YMKI+1
         vraPon6+NTOcXeMGry9PpoJSkEY26SSJ2OL7lcyRdCq/vwQXgHOEUnZtOiK2Sd0jYpNP
         wUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766331085; x=1766935885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31JTYOJ68zQU7Ygr6vWGrJQgZrlwNQc62R8gkC5DC6I=;
        b=YeKv39CsLolKOA1/0wHd+w1Wq1wDIO771vjFq0yJF7fnjZCfct+5AqpvfvQTPudSv6
         MSJrUE9REk2aQzVu7x/tWvDue0qsU3sE8zif9zXE/GB6cxsS5i375qaZX4Oag+eA6k6B
         y/hrUdU5DZccyLNE+UcNKNtOJOfV6IrlTtV01yzHoDCpuj89GCZ/tzOofPQBv2Pi7JVC
         q5+7CxuL3Lc05Mih6Y/otVlpIxprEGj9CHTfFWIgP0xO1TmxWIUbqF5Y1c4moNIT4umj
         IQtfNLhwDwrsm6SQt/bloVTQ3+bhKfMznwI9rmNFgzSLbp6z2Sq8kg8VNFgZOBdPktk4
         M5dw==
X-Forwarded-Encrypted: i=1; AJvYcCVuFDOSBfZb2SNOX7OQl93Gh1LzIwFbHNplxCqdkbcHpNBPzpOU3IYxn8sOGaLaKgQm/ZRY2u80monfLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBqTJRyINChMCyZosxjLvYgMYPmd3ZjEiFIBkbHBnlvrXspDb
	kmu5Gg3xPxpYTak0Hi7mnYYjAWSy/tlaKtcBqwxsicDWhO4oBwTxr5GK
X-Gm-Gg: AY/fxX5f6WLCubvgu7luwe8CUS0sZMwdNuhI94Jmes60DvGAYeUYnbbi74sPZfBv9V6
	4CAd9RlpLBXe3X0+Xa2O9UFyRRJj8ZKw6B5QM9y9+si5aeaUBexs24DHU1bgaEMSQD/VQGVKzRZ
	SMPJDCt+mb8ZquA5zlsR52anNzbCtaeBp0U0HBWvGmVQ7GinPpDXJPYtYFqb9/nxD9lrYIq2M8N
	z4KaH6UHQnyVKhNyzISFVVZ5mmiW/nKEjAdtfHwNEWTp6vnQ6HJNvhKEoHLLX1egjFGMPbWXj34
	IgWj9c9Lax2T2LbuufuG20F+7ja+e87JFKOeKsLghi505KS79lvmbj7mhy/4GRZNu4m7C3Kj4Pu
	ZE/ewy9ZXkcb+DqcnAc9FB9GimNBcNEBi6JCBO/u/jxxYwP9Bdfk5OD7Et9IoW+9jVqvX4LO67I
	U/O2s1TfWKxQSxyhBBBb+mrhYJ8em8iFko6ct9GhDZwT/UKZgyS4a0acTI1P+nxgIv
X-Google-Smtp-Source: AGHT+IEWQw6scbu4XBuN0qhvATX1MA/714hTCuzyU3fnZ6I3hM6XzvuN+URTkBVTkVQKVp95ua7aPQ==
X-Received: by 2002:a17:907:3e12:b0:b7d:27dd:9a54 with SMTP id a640c23a62f3a-b8020634a93mr1332188166b.31.1766331084895;
        Sun, 21 Dec 2025 07:31:24 -0800 (PST)
Received: from localhost (2a02-a44a-2a80-0-8c2a-39d0-7ce1-2682.fixed6.kpn.net. [2a02:a44a:2a80:0:8c2a:39d0:7ce1:2682])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51144sm801623066b.69.2025.12.21.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 07:31:24 -0800 (PST)
From: Tim Wassink <timwassink.dev@gmail.com>
To: timwassink.dev@gmail.com
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: sm750fb: Rename CamelCase variable fixId to fix_id
Date: Sun, 21 Dec 2025 16:30:45 +0100
Message-ID: <20251221153102.38178-1-timwassink.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable fixId violates the kernel coding style, which prefers
snake_case for variable names. Rename it to fix_id to match the
standard style.

This is a coding style change only.

Signed-off-by: Tim Wassink <timwassink.dev@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e615..d100b9e1d3d5 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char *fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -862,7 +862,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	fix->ywrapstep = crtc->ywrapstep;
 	fix->accel = FB_ACCEL_SMI;
 
-	strscpy(fix->id, fixId[index], sizeof(fix->id));
+	strscpy(fix->id, fix_id[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
-- 
2.52.0

