Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE312E11D2;
	Sat, 14 Jun 2025 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749877064; cv=none; b=g9n7N9H75yFCyCbX+L5GIiR/afV3N3BlBKexo/QHRz4Yh7ha04yvKSCbFsjvmOEtEIbJsRuOf98EblzK0PxjEao2UGhL4laDjYhNjrf3a37h5qsJoi3aDwAiCmehB8zCIYKwbzSw8Lp/9mD8qna7hxINj4PA6umckE6C+I0VVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749877064; c=relaxed/simple;
	bh=DtwppHjTfcSMBtUJssTEucZHd0zTwbMT0R7o2qQc6k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qg4vb5g/XCaP20o/et2eKGaWRCmJjy+64GaPQG1ZpwJxWJOZUCv0Ix2vRVVt0vfHemJ6VWAiC1/+MX811SkTgJrKgama/DCdBGE6rbq5P3FeIIf02axFOYcT5U0zeaAkN2oqNalDq5a5btr2j+rb3312j6+Chbx3FGvnGdvoLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeqvFY+i; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeqvFY+i"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7d925ff60bso2495897276.2;
        Fri, 13 Jun 2025 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749877062; x=1750481862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3q2qVFEmbLsR2HxaXqu+Z2ORgyuH1IAkMrz+Hg3+zQ=;
        b=EeqvFY+iX439AlPYqdzsIQYcyo1TqkRb81fE9hzKmeW0Tksug51gq4dvVQqz5WtLwy
         yEyeCW6bouCod+efCihPGC2qg3ZfTWdcfhnBjqWPI3CBd8uuIDxsM+cOy+Y0ZLOmyPcX
         NhwejHcQxruNj4szST5Z76fscCJ5uHzLpqF4fjlxph8+vLznUYvc3lKylTBXfzWsTgmj
         QBvFvu+FHoOFxUBsIkdGLvWTg5zPl0NjIRq1C5GbeJs47Abi4ko0iGGu2fiz3ffj6wC3
         cYU7wN1lVJ/vgqD+hkwiaQTycGGultTGgoKSH2cvMbv6ChrKXZtMaiHPzyVS/YeU6cCU
         oBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749877062; x=1750481862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3q2qVFEmbLsR2HxaXqu+Z2ORgyuH1IAkMrz+Hg3+zQ=;
        b=CtTQ6bm5I37PQaJkfEXO9YbMiHNdgfk0wBc5OB5tfeIz/bQN5bAQJSOyocvALz8xk7
         cgOv9riiwV0dgYiIRjtfXuGYvbHkR9mTGYmHo1FouHuIuKOjKc+Da8Ad3y4UoXKSXNUj
         GZsBQH5S+gguzmJO0jADtJnP1h0EIdxoxXiYymhV4RM1w1oJy+G5A2ns00AcXGeJdsOL
         tB6lloovF17U4GSLZkWqwXHq8zXBlon0hWtfO9sa9C34fz3Wr0Az6GvQemQYhh+cONxy
         hokbrP6qL0Z6+tzvdE15cQIZDQ6j/MZq4Zx7U0sqlqNMs8/2rr492wofwIIonJZmQFDI
         Fg5g==
X-Forwarded-Encrypted: i=1; AJvYcCUqJ3M2poWWChV8m3fwAGsjRXPuQrgn8uO6HYM+4KAR6nR3t4+mJW9N3CA5lqKLI6lN5IyG91xYBYWdNQTy@vger.kernel.org, AJvYcCXzWKLbrdQL3NfcrJQyXCB9V+Wb8vYXb/58x0qZpUhkd1OcMjhpkGezV7jD1qRRxGzH8Ce4vUWnR8cQ1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdv9TS8spzJGkFQFEnw01RSZXmhfvajCSU3mxDZ4ntCwVfQSq
	F4KM7aU0JsBzhFsz1Y6bou4H0Kd8dp1a+eStysdU26WBlc/XBhvx8HDBKb2ENnCa
X-Gm-Gg: ASbGncsStN5u4jZT/H5rYgiWaMNw3dfJPIPh6XUZOTXPHquohO0yePHYdaplzrq+GzI
	k8d92EntMFo6GmlCNU1dnRnl9SQ66H9BkoneJWvnDpA4JHvmRkbGdZV+rGtEDtKf88317k7dbmQ
	UXUHIMYY/a8Q/i2gbBQp1KTZZZbn4pUd9H5oPhyDPsqUlktucxrRnJucKfNqFt+AggFDUsaxfoJ
	JbPj8R2S8AZ099Nu5WgjeWb5OUt+trkwyfbXos6ye8ApaK2Pk8C4VwosMUvcshyLAJFmuSl2aEq
	TqTP8Aw5HBnqMlWaUqhOfCJ+nfHBdYgvrMyD+R0w3VVSMPanxA6QSSurY/jt7UHFkPpyCzkFsZP
	f
X-Google-Smtp-Source: AGHT+IEV9Mmky9tjHAWVSE87xT+lR7tm5Ix4w7VEXf3TOBtMRYoUueAgNI3kbcVipyWMqOI7pqqzZA==
X-Received: by 2002:a05:6902:1004:b0:e81:f2c1:60bb with SMTP id 3f1490d57ef6-e822acc6e9emr2965920276.46.1749877061987;
        Fri, 13 Jun 2025 21:57:41 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e315dc9sm1523330276.39.2025.06.13.21.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 21:57:41 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: FlorianSchandinat@gmx.de,
	alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: via: Fix potential divide by zero in get_var_refresh
Date: Sat, 14 Jun 2025 00:57:39 -0400
Message-Id: <20250614045739.3487259-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in get_var_refresh.
Similar crashes have happened in other fbdev drivers. We fix this
by checking whether 'pixclock' is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/via/viafbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/via/viafbdev.c b/drivers/video/fbdev/via/viafbdev.c
index 6da5ae7d229a..5b58e93f8c28 100644
--- a/drivers/video/fbdev/via/viafbdev.c
+++ b/drivers/video/fbdev/via/viafbdev.c
@@ -179,6 +179,8 @@ static inline int get_var_refresh(struct fb_var_screeninfo *var)
 		+ var->hsync_len;
 	vtotal = var->upper_margin + var->yres + var->lower_margin
 		+ var->vsync_len;
+	if (!var->pixclock)
+		return -EINVAL;
 	return PICOS2KHZ(var->pixclock) * 1000 / (htotal * vtotal);
 }
 
-- 
2.34.1

