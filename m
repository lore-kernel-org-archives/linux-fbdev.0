Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996D72632;
	Sat, 14 Jun 2025 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877867; cv=none; b=ObVJ6hpSBPJz2Js344Qyc6LqALUZQpa8f2UJCg2EE3WS21X6DRgoamo8VfVwtmSF0VSMJXuRj65uMSqzLDLJhYsPNNddcKOTDHkb7rhprFLnnRxQcqCVogiDEGLXKj1jtgwJFejDhqQkrtytfDFvTOL68qq9OwXzDaMFAvSp6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877867; c=relaxed/simple;
	bh=HeqKfwo7B1xwb3zg1fATfYw/vEiodp2g7tWXJuoT7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bhsl8flwyJAgkmB/PPSEB8gYBEMomDHd4QcKTYbQAh0yjBSNpkcrvV7XSjIM2VEAv9mvgvYATnqUWVtok3CiEuzHMSIKAu/c8N5vAIte1cJGht/5giYu6dT0A9OkwpvqWEY6KIY3MTgFS1D8uV5cfCfznNAG/vpw85FBW47vFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5WcnWGt; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5WcnWGt"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so2630266276.1;
        Fri, 13 Jun 2025 22:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877864; x=1750482664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHjv9BHr/Bsn0d/syXcvcyuTrhfwt4Dz6/Z8OFUN72Y=;
        b=k5WcnWGtj3nhumzb1itpgQj60yNLXf+B26D0djYaCvCTH6Sw53Vp0aNQa9BQNChXYQ
         vGnosKlo+zxnwCqt/ZtCiJHfv6zqso1tvDel8jQos8mQEyQCpPGMMHJFyLY8UU1rROoc
         5iGvNDcp8oWZHHiZQGDe69i++lP4B9qIT2EyEiFSkuWLLZRFVglQuHK+lst2EfkvKUAZ
         IsDIUBFy7VtXF2soYZvNM+RcO0tEeKuNA/z8PyhNAxDnQRsByUT8LLOsRFoLl3OVWNqg
         9rXFvO73McQQTMl7zF2/Ku5bdEThCIUZvHlZWPPD8t2oyCgHGYMemj9OOMPYntb0j6R5
         K6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877864; x=1750482664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHjv9BHr/Bsn0d/syXcvcyuTrhfwt4Dz6/Z8OFUN72Y=;
        b=OHzt7JrkZA5f2XQigX9WadfX1DlpaB0sy51duBX73lzYxa4673WSEjAtp6vuqxJREn
         YZ1l5Ko810gErKSdNz1AWZaQEghNVZRPEKMQpRCUe4Iv7AVInrFVlUVm65Apg1LpTfR2
         fevCrjD3SYec8f5hj6sm9A1L3GBQmIYXiCcPvA46w3Tr8bXdkb+fbSPG4nlLbRgR0olF
         hl4weiZBFqXF7zm1C7omPARA2SzHDcDrxBV5Gtze5MJ6wIlQUe1QWOQNmOV2KxUStpvu
         6io6z6hB1zKzXvBL+J85Uax84Q9/uDCPPMECkHxUWf2r4KcfgZpGHpY67CUYAGyS0kVg
         YV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDujlGgZF+pQfJOOTYGmZqUZZslch096NAqqOn/IxdBZyoRaicpTJ8h0Imi3Ir96zHsUIF+oee+8BiBL3e@vger.kernel.org, AJvYcCWrPD9bJTIC5qXT3R+XUyfxTkoEbjBSPT4rygpMDVq06HY+u9KG/GV1LiTZeKnO2KnHu6gM6XnyrOrBTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIkbUbq81BZlNongkZVVq25XS1+MfUEd0Qy5sioq0Xqs+7nHH
	IrLeIOboDgXNphhcPvZi83Ka22EV+kPQECLuvCY4t+ojAFqT+oEU+5j6iixIukR+
X-Gm-Gg: ASbGnctsaIX3lRp5TKrhGBewC5V4iNstbMX9de4hxIFv2TWHrxTK0Suu1TtyblfTam5
	dpQBH8BsgVOk5xyE7WwubC9IS4nVUtmsY3C0vpq8a1HDTvurTBGltsUV4TakJ6n7KL+VqSeisM7
	F3091vzDXgMuaHjNpKabRgJ93YU/8lsPQ5ZOkVwQRSz6FRFi//5a0uwH19IpsDAtT6qZyZrZ9Tt
	gwYNn9q9kL8+n0oEWj6Mh+ZbZuMXgOBKsHLNU6EJhssCpS0cT3KxwgMjH8s7xgAycmYqklOx/tW
	Crh4JaZM26mB/7Dsypo1ebeZh39BTPecYYFRtpFgC7CU1Je6tPjzL7KB/L696yzs+RaPO5q/0lz
	d
X-Google-Smtp-Source: AGHT+IEBZRhqEoaI9+qTaFDDjh/m2Lcu/ckWlS6mfL4zM53CFmqJYkhil3ZYqx46+B9QzyibLGttkA==
X-Received: by 2002:a05:6902:218e:b0:e82:54:5ae3 with SMTP id 3f1490d57ef6-e822acab8camr3466928276.10.1749877864466;
        Fri, 13 Jun 2025 22:11:04 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e099598sm1524227276.21.2025.06.13.22.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:11:04 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sm501: Fix potential divide by zero
Date: Sat, 14 Jun 2025 01:11:00 -0400
Message-Id: <20250614051100.3501316-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in sm501fb_set_par_common.
Similar crashes have happened in other fbdev drivers.
We cannot find the default vaild value for pixclock for driver
sm501, so we fix this by checking whether 'pixclock' is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/sm501fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index ed6f4f43e2d5..a294b4e1c4aa 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -506,7 +506,9 @@ static int sm501fb_set_par_common(struct fb_info *info,
 			fbi->regs + head_addr);
 
 	/* program CRT clock  */
-
+	
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = sm501fb_ps_to_hz(var->pixclock);
 
 	sm501pixclock = sm501_set_clock(fbi->dev->parent, clock_type,
-- 
2.34.1

