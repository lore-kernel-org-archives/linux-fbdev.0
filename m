Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3528AAEE
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766518035; cv=none; b=qF/IjsNdWBl3c41devvE+TusMMtgu3LeIQlkAX1CMt+XQXd5ZO5n3PMqEGlLm7OOZokcMesRaJxgCEeh31xFKNSnMKjsGEu8kRWJYTPWF0N9ML/KMPjLpv9W0JYB6v/A0G9n8VFm7FxhDGyx5CAjoh/BsupdNV9whWSo88dNoNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766518035; c=relaxed/simple;
	bh=Svz13no7Ji+bCzqqG+VAYqznHhuJawGZwtywOvf/dOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6XDUmaX0hHzZiIDZAH4IN9FzPpx+BVGeBZLIc6hjrncQQDoh+NVDjF1B0Y3wLRs0P5WuVVyOFDvsb6lqXknDwS9eQEdZBDpJemeQxAMugQVif6es9o29HaZ3V9/2kd7bDxfC68E5QKiGGW3399bhYAp3rsNE8uzQl8IZdatzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvxdG661; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvxdG661"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34abc7da414so4500107a91.0
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766518032; x=1767122832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J355jvWq3/NjdApMIDzGb+6LceMfHS1TaMoQRJB+idQ=;
        b=QvxdG661qYtlKoQ/YUWgrPHg8AqfUGPzt8N00lGCZ7OxUmYE1DYlcStZIXkRLR3KSw
         D9FNcGUX2vfnZD6IGuopEm9Oyu4aow1Odtw5rb3Vu2eAdOCutsitOOgSzvpVTxmQ/bIk
         SD5kUdEhLyxhCYlDFiPd/7yWkFzsQoObiHNAgJUz3qtWEBRSdrmohnfBk1Ewvp78x6O2
         4Ti/i2ibwNztbwFUJpMXDb1Z+RdSYFXtfgC0hLhi3YAZZ5aGA7PhTXKdX6QcGsGe4Hya
         lWfmxko4fErzE6VXgM6IGcuOC+AdFeMM+TOJd2N4kQExp4/7nddcGYqCLvRpHS9h/dZL
         n/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766518032; x=1767122832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J355jvWq3/NjdApMIDzGb+6LceMfHS1TaMoQRJB+idQ=;
        b=FCbixgeMJNQDXbkTjVFpOzgzYsJiuBK49evB9O/4EP5vfExDbC1g8XoUhwZgF6c1Zs
         0wzKk1FOKW/bda1s9AL/PTRSHqJjOrazOiIFoplyocqJkiUJLDxrQLvE524OAfg6SqyI
         m5+7jOBrREIQ4B3hgrh09CzPXUepgTfxsrQ8oNUJFEmjbF7wOdsQdpHCT/fkdcrpgOVw
         WCFabBTLZq109PqcJccVYYhLRuS/0q6jbeQPIIXaKAI0d+3o6GnqL3HBhgcGacI7gW53
         y/jcN8A/G4Pj45GVHNNuzAO737wBK/DXNLSOOw+TEabeIGDGIfDNiskYKPeT/wgSxb+8
         lXXQ==
X-Gm-Message-State: AOJu0YyjQbJGmZ6XR96Yp7wJ9ZLk0hUIIw+DZ3fT7NGNPYHR80zsZchZ
	dYgQDE9uw7vbt6LaYM9pRCQVCH+0Y0AlIRcqnE6dtwZ9epM8dNgcElEa
X-Gm-Gg: AY/fxX7NSYR6aeME9voEl/5+fHuKMXD62Kst55crE6euY20pzIX+e+ijPd76pQHykl4
	L4TJabGtNYgXwcyAbzIMfIjJFt1RWrIBzfDzFUNDb5W6a9/E74N9pjzL8E6VcQgco3IzHBhmgFP
	6RUSx8WwPfCLHbIlIkbWT/cX6/GJebRwCNvZxdTGyqppWYL578VcSqxB1ZZDtjdgsE8J8Sa2Y76
	U3tvZ87slh8Yr1AJDhM7KA3pUibNJ7v79aKqGe0ifauoU7W2UT+lLhoz+YfmZXnhHSSgvqCNIg/
	VBn/D7ecM56YAC4wWugK0ICip5TACSEAnhiGnyCUoCuU0NGRbu/Cwua9ijAnp/uv/WgcgrsWjJW
	7DyYTHg36E9AQsH5ExDICe/OgeKNpXvRQMTp/RvvCo+rNb1lzQCluLyHtfsZWgy4BQWn9hV+U+4
	zusk6XswnH/QsoKzp40gnSstZCti+aiOSTd/pVXtUkwUmq98FIdpFKWN4=
X-Google-Smtp-Source: AGHT+IGdnbW5Jp8U/OoPPmNzlF8Qxi8K/UNYf+BqIxcTuxX0qAIWv7ytTm6Qo9/hP3yu9sa0Tpnprg==
X-Received: by 2002:a17:90b:580e:b0:340:c179:365a with SMTP id 98e67ed59e1d1-34e91f6c085mr12620504a91.0.1766518032386;
        Tue, 23 Dec 2025 11:27:12 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:1052:c28c:d56c:4c53:fd22:65f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dcc4dcsm16518473a91.14.2025.12.23.11.27.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 11:27:12 -0800 (PST)
From: Tejas Chaudhari <tejaschaudhari038@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	Tejas Chaudhari <tejaschaudhari038@gmail.com>
Subject: [PATCH] staging: sm750fb: rename fixId to fix_id
Date: Wed, 24 Dec 2025 00:57:03 +0530
Message-Id: <20251223192703.16502-1-tejaschaudhari038@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the local fixId array to fix_id to follow
kernel naming conventions and fix a checkpatch
CamelCase warning.

No functional changes.

Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 15b5de33b..7afb58561 100644
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
2.39.5 (Apple Git-154)

