Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3E40E8E2
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949381; cv=none; b=DERS2ZHivtK6m4BhOaMsFaYH39rjBbm24SySn/4PGMT9reGZKEM0DDkoGUlNNYnTfeqveioLmabfcjcc+5josdiqsr/uD3v2b+UB4kUG9fP8njB0Yf7W7DwM6RQi7W0wxrg9DUhcVgYwGmKZdqRUH9G0NjKf0anFh4IjGFNfGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949381; c=relaxed/simple;
	bh=WnsrtSFE/x7Xk+CkzGyBv+fIdfu0V4x8ofh2A/QrZmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2nUXhN/zppDFlk0pFimxIrXJzzC6wlU8J1S5r1BTbilJIUs57Y+bIYxVgLhsjJQEe041X2gioKNjH0ivK5yZBWimUVDI7b8FaZPEmsBrPbY53Bf9dqY2zb46Sz1m6fO2AlLszSu0XAtkPxBFisvn2Q2TkbZVA68SyJu7Ii6EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lerfMJd/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lerfMJd/"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39669bcaadfso12460971fa.0
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782949379; x=1783554179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
        b=lerfMJd/h25uX/XEW0yBsPtRT7r2G41b5FkBJLeW0IILN2Id+fMm6WyUts+ov8Pkp6
         vGxHnpr4RDw8cyBYSHBI8FYJ5IqU/MjYa5qGYwkiWOJQOwwb2eSeh6em/eFXRl7Cz0mJ
         MwtSy7mS7U3IKqKPwOUuX9cTHKaygy54GrndVosP42l2NfuVw2NBpYs4e4izqA6gYd8C
         RmvobQejefX3Qb983d5xKE85I89cCNz0Btt9ChiRnZ9DrAy72iUg0B84SCPbDiZEb7Ff
         LUNBG+33KWCWpzVa11Z1GJyt7w21UQq5Eh1275oezPjEl39qfksyOEqI/xYMZLoMAJiA
         jF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949379; x=1783554179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
        b=CTChKfIoUCpxtXi7CjlxBUjwGnHgE35tdD4X4HEH5kFvjs35v3wSq5yChtv0hC0gLH
         u+p315ULmzSEzKTogdQb6eXs95PbjSmHsQJqMWsIxKaEtj4ytUdk8Et+doAWUtbp8/p1
         kZgd2kABQZj3Bg6S6EdyUcmZQPHwl3L3JciItlolcs/0YWx8VnZ6iVW0ApvJRoeeu7l5
         G3/+XEXy2u0JRpWJXVGGb9cN4w0thbWw3m2G7UlLRhGGkJXYrM7F44cdTzt5J+0/U/8l
         srPu0nfJ2x4ZAmwhoik62wpUppbEs0tU1DKYfh2wgnQeOVCsVQFOQcC4irmhkDArydgR
         sTOQ==
X-Gm-Message-State: AOJu0YwFGbjAdnw8G4bQJv5yRRkDwYdEsICEwgRDKyNreppkuFUhWf6i
	SlOZVe77NKjYO0KarJS/BBw8ywjl4Fan9s3jSjHbJy8l0e+eB3AY6Laz8Ixede4UjJw=
X-Gm-Gg: AfdE7clunR63BRa26LTlP0jo/t+YqH1Icb6nkAKrp///mCieLQwvar0QgGK+aMsYPOi
	yN+/N5lSLstOsWPOhsKNmIt6VsfeQP68iA3eSXFofWuGySHo4QxcQfGXWyzlUOwa7lFrlJBTFQX
	/hhfDxRDT/A/cikGf4eft3gCrz5zd9jIUGSNUX4avVwbd5NlKHDr3gx1LuBM7eMqcZnFDGQyjN1
	2Qu7u9prv0evEuMDsgorknfN3xunt0ZtpU4F21ON9HEBNNO9aQ2XBkV04nf0jdKcuzEfa+EAHZM
	taR+I0kzo/hulOLBKh/8Fph0tdg+1QEvq1wtXRF2hUou1s3TNSxQuHGDBicm1S/Wmaj3SAndnzI
	4i712FWneT0GPwmm2KVHzaAydalpr3C9iNZy2JVnnRIihAUv/VWo4mNpsRXjpiXc0eF7ghiJD1F
	OYlrByNtUqk3kTWeYOADewq7xO7hAi/nA=
X-Received: by 2002:a05:651c:889:b0:399:87c9:459a with SMTP id 38308e7fff4ca-39b36de5658mr6680111fa.9.1782949378486;
        Wed, 01 Jul 2026 16:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:42:56 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] fbdev: clear fb_info->mode before deleting a videomode
Date: Thu,  2 Jul 2026 01:42:47 +0200
Message-Id: <20260701234248.236023-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fb_set_var() can delete a mode from info->modelist when userspace
passes FB_ACTIVATE_INV_MODE through FBIOPUT_VSCREENINFO. The code
checks that the mode being deleted is not the current info->var and
that fbcon is not using it, but it does not check fb_info->mode.

fb_info->mode may still point into the modelist entry being deleted.
If the entry is freed, later mode sysfs reads through show_mode() can
dereference a stale pointer.

Clear fb_info->mode before calling fb_delete_videomode() when it
matches the mode being removed.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2f1c56e5a7..c8aa163b0e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -246,8 +246,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		ret = fb_mode_is_equal(&mode1, &mode2);
 		if (!ret) {
 			ret = fbcon_mode_deleted(info, &mode1);
-			if (!ret)
+			if (!ret) {
+				if (info->mode && fb_mode_is_equal(info->mode, &mode1))
+					info->mode = NULL;
 				fb_delete_videomode(&mode1, &info->modelist);
+			}
 		}
 
 		return ret ? -EINVAL : 0;
-- 
2.39.5

