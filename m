Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB0AD2D;
	Sat, 14 Jun 2025 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862611; cv=none; b=UkUEr/SQSF9PBwBeSzQeP4eKaAPAF7i20BhzLNYq+UIVWes4Bom9VXHxub3hnfw+7ugobIyBPIA5HR6zuqMZBl0LETT1RNyGRB08/AhZE0RkvXCl8iW6tEZlwIp2OJuKtcLc2H2b87475nN3soQj8c7Zy8wG1iDxGwAmTiuIzKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862611; c=relaxed/simple;
	bh=cH28oUw42DzBeaLaj/EuK3GKRfcpbSOAyY7iuTgLE+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOlOtn185eYIFYXrSBZjbekMV6Zwr0YdIp4AGbxchClioXY4L+qxn1ZH/2dsD8PJ+7E8dUlldxfbsMVEgOvjt4udjOL8WI1AVoKCJjwcAFr3ZNp5qV0jP4/7wNV8ehsHErPv+tDxh4BHZa85y2roE9k/9WJVSMBMmVJsB2OumDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQL4kvtu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQL4kvtu"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-710ffc7a051so25004387b3.0;
        Fri, 13 Jun 2025 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749862609; x=1750467409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdIKn3wdJO2XExN/WHdwt4Lo65I7MBUrtS2tDyrRbMg=;
        b=kQL4kvtu5Ho95pGKYPoaGr86lpUd5pYMu1tofmkyAmQXksuQRWV6rgWRSpi/OJ1E4r
         hY4l1G5DiWhlSpa8OXqI9gQcEw9a0K2tUZce+3sxMb1p5Ndic9VuDz/Pbt11VzHyxBNQ
         pvs4BynHueiY+4Hso9pt1+j0xwiEh94HlpOwyXRSki8RafyfZAV1+FNaRxtZ4f95gwmG
         B9OoL/6b2dke4dyvO6s0j6a+bEAg4SFcDJ8triQ3HrqKZtEh4YX/sR7lNTE3V8VBfAhY
         rBUNQ+LxA3VoaDv0MydX3g1Yg8vOA8ebFECuTaOXKDP/DcSM0V0lXyPLDyeFRb4lT8Lq
         X2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749862609; x=1750467409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdIKn3wdJO2XExN/WHdwt4Lo65I7MBUrtS2tDyrRbMg=;
        b=AilhAtrYbyV1rhsYWv5S3Ugf94sIFXd/JXQHQnXf6G62eF3dYBrLvtfahfLNJdg+T8
         7skU1N+AhYbU4vl/SFQsu4VJCUJ71JjKpclzGuFgkf8CK23irXH7Tk1QmzF/8+Fb0azy
         VcnFQLVOh4IQ/SZv13ZnecpHg+ej+lOLCIOFCBkHh9cRmmQL0tF9NDv7JOkc/VHxt8Ks
         O4CGkG69ThicLgGaCAgiIZAagngsrALQA1OAge3YSbWO0NMlbYaFNZPZbfpjbI2okh3Q
         nfYvUcgLsXgyw3yGXehva9zt7jR7LCHgIXTHRjHHyjW93KVQFNYi1H7PM0RLZof1O6gI
         44fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB3BzZ4jMLxjQgKY2tQeOgdMEVCnwj+NThrDooJ5ntt93l7pcMwc4I5Do2s5Y5TH9j8KnIGV5pxnB3Og==@vger.kernel.org, AJvYcCV6xvuLQcioA8MpZX0J80N9dTzO2z4Uxx8EbXUNfXzi+tknV3b3GMleDwVhiJmAYGJQa14tsyHQ9ZzDS3Lb@vger.kernel.org
X-Gm-Message-State: AOJu0YyDA70f5z5LrNM2sfekW8A3U0uyDNuZ46mqmtTb7RhSJHqc6Xan
	crgCggZcAr5agK+YMPKV2GQieBt5u7tp5ATXmeZaAitTVytqposO6gTk1JQJ5YhK
X-Gm-Gg: ASbGncthJSLKSOqSaZ+4XKjGA3PYaeGlL9fUb25K61OK3FInmuKtSVEuLaif80OzYlH
	jnfLr7+Ruhrr+L9mIegoK2OpMns6vPeheQQ2BavfXT4e44GuGVtFHDyOY/qv9eYUZ2zA4pYEAXk
	HbkkTYGwCAzsZYrigw4wI7KLWTpBz5ZVIZvTEQkiGN9watvejWNc953jU4Gak9F4ODGFQdv0Fgl
	1xmBP/HVkEqDSBCt9moKcH7uZQxJeYz26XLMK34Nk1kwUXdVjoAHnwS/yXZPfmeosvgTJIph7rS
	GijFWNUQ8JiNqtyRwzO2+hmBOe438VmVY6NkL8lSRlU28P9cWRtx7g/E+l6wQoIMtenFnNi+iOY
	T
X-Google-Smtp-Source: AGHT+IHLuKsPDjX21BdIOxWNUoG6I+EDot9WFeuTidGb7Kc6z6wZKt2memdE+eHsyv1q3F406LRI1g==
X-Received: by 2002:a05:690c:6c0a:b0:70e:6105:2360 with SMTP id 00721157ae682-71175508ef1mr21399277b3.24.1749862609220;
        Fri, 13 Jun 2025 17:56:49 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-711520bb0aasm8618007b3.51.2025.06.13.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:56:48 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: tdfxfb: Fix potential divide by zero
Date: Fri, 13 Jun 2025 20:56:46 -0400
Message-Id: <20250614005646.3117593-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in tdfxfb_check_var. Similar
crashes have happened in other fbdev drivers. We fix this by
checking whether 'pixclock' is zero.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/tdfxfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 51ebe78359ec..2100857fa7b3 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -495,6 +495,9 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 			return -EINVAL;
 		}
 	}
+	
+	if (var->pixclock <= KHZ2PICOS(par->max_pixclock))
+		var->pixclock = KHZ2PICOS(par->max_pixclock) + 1;
 
 	if (PICOS2KHZ(var->pixclock) > par->max_pixclock) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
-- 
2.34.1

