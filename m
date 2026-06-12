Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E0B3D5C1C
	for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282470; cv=none; b=Zvks2KXCJCwznsJPVV/deFitEmAiP7gBUvhLSEhnHb6agQOrFPsrT5Yt3bIekT9yFgacITaI1s+uK1fsJS1iuiPFc4CEyDGQDegoK0E028XuNVA4qFc9J4ZNZkKzbfNbyLQsDpZ4vAwBgS2UoFB6AKViG/0BLDtMCDYIMR/b87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282470; c=relaxed/simple;
	bh=1VuwjjnibSEynGJZTNdWptD7eGQ15aIWeYvxHAlFM28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SssakNsrKlFR8c4/9CeyoZMthRKIcS2u5Ph/uthbonLfH514SOW1QcOhu7WsIYsI/es9j+USYaB8o8bsFKivG5UWW7maqRiIHdaYP0FCoWzthQsBhwW87CgqJ0AI8wwrllhJRjcE6BLxcQQ3N5S8ApdwxocNHHShspY2YWdhk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXoH7PdN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXoH7PdN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3966388b388so10042691fa.1
        for <linux-fbdev@vger.kernel.org>; Fri, 12 Jun 2026 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781282467; x=1781887267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
        b=ZXoH7PdNlYYy7/TBHZFkvY/Hr97FTqFqJv5g7RFgs0bXjii7CBVKPaxI74hGBgnPXL
         jCgE3UmX2S3OwaBbf5Oh0Et9Ny7oTX4Shlg2NBHK8Ow6yHyum6TGh/VJTQK1+VnYlwJf
         uhjQkRkpteOI7Jpn3wrla7CNOMArQ7ofQzkcOtIA2SKl6vWmjPhH3gEwz2sfU3YLCtUY
         moAkVI1CbJOD71dPPUIzOA1sH20/lFrc2sfEzA/CoHsu6sGCdLvtu3XCJdLMGwMJ4HTi
         r6XNpqNP8B7/9C1+1ULem5abFS4ltbRKKmUyd3BM4c0kR3C06fcKFzOTehJmLsGI95er
         BNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781282467; x=1781887267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TftuUnxE9Lrtjc/EIh1Zv1ggKOyOeIDF4rAIqHU2nvc=;
        b=lKE00Eu0WsNdqX8rs3X5B5GR4VDjsA7u4OidWTsSegO6t6PNp64jVGSqiQQKreXqwC
         SZ4ZMR6Bkutme05ljHT/VY5n1NRZN5k32e1M70oZzntzv9IH8nMpUkHE6J1zVadq4Raq
         Qe11w3d7YjYGPsozJ7xZp4YvpsWTeQwgPaKxP4NNavTB8cDw5WQTdVLZApPR0JvrDdqy
         6uatscmgBgse/CxH95fEHJOnnSJJGeJhA8iRprFrWjmcTNpI+OowpgUa60xffB4gpaUP
         QUkzzICHOxQEdq6f1QBYkmgj+Tuvh79ChklpVrfzoUuIOgTjI7NPfsv+uCmzgQWgEKWX
         5wDw==
X-Gm-Message-State: AOJu0Yx2IU89kt8ebdxl/X1m+5rbBdiesk+to9tk9BsBf459KsC0PYnD
	pgXSESuisspRjEwi1623KCw4aV5Ili+0ZIAopl4PQ+S4EsBUH3zr66BD
X-Gm-Gg: Acq92OFsQ4VjkReU3nHS1FHKPL6Ept/NvbzMAkbGgfCfl/4WXmkO9xnJUokOSpU62XM
	YHVwGIBwzKElmdBZLCClkkgvu0JDhKbPSe8jXc754isHvRf4hM2LS91qYFckkRmTYGdvnTDUl2N
	ZCsXBrgaa4InBJfRLqTFLDSnIy3oGiVKAmKbiRIjyitPKyjP+n8824sYzy257/tAhs+W63vahgb
	kKFW6VbLap7qOm4giUxnBirp93bigLLqrS5HdWN24oBnlgd5ii4zARPk8Fh0ouhz7ZsfLtmscAS
	cGuESePaxZYQhiBeXoiSpdqbbABvRBl/5++/sAVX2bz9x8wtX0lQCtvO5G3DjfEI8IQ3c/aWuSr
	+QRQghOp0/j1990vFX0+XM6WLMQnr94VirmOk6YRl1YV+umsp/gmt8A9/Yhd4hzMT/ucyIhimfx
	jAFtRINt6xKxuvpmPNWTGvKTactJjvQnCK7dxqkG04rgcSZbnNqWqyAgaOkXNBWdilEKQ/c8M=
X-Received: by 2002:a05:651c:1473:b0:38e:8357:c5ae with SMTP id 38308e7fff4ca-3992bdb782fmr8104031fa.9.1781282466664;
        Fri, 12 Jun 2026 09:41:06 -0700 (PDT)
Received: from maverickamd.dyn.int.numascale.com (fwa5e61-57.bb.online.no. [88.94.97.57])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-39929f18210sm7484111fa.22.2026.06.12.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:41:05 -0700 (PDT)
From: Steffen Persvold <spersvold@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Steffen Persvold <spersvold@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: modedb: Fix misaligned fields in the 1920x1080-60 mode
Date: Fri, 12 Jun 2026 18:40:41 +0200
Message-Id: <20260612164041.3652599-1-spersvold@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 1920x1080@60 modedb entry has one too many initializers before
its sync field: a stray "0" occupies the sync slot, which shifts the
remaining values by one field. The entry therefore decodes as
sync = 0, vmode = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT (0x3,
i.e. FB_VMODE_INTERLACED | FB_VMODE_DOUBLE), and flag =
FB_VMODE_NONINTERLACED, instead of the intended sync = positive H/V,
vmode = non-interlaced.

fb_find_mode() then returns a 1920x1080 mode flagged as interlaced +
doublescan with active-low syncs. Drivers that honour var->vmode and
var->sync when programming display timing enable doublescan and the
wrong sync polarity, corrupting the output.

Drop the stray initializer so sync and vmode hold their intended
values (positive H/V sync, non-interlaced), matching the adjacent
1920x1200 entry.

Fixes: c8902258b2b8 ("fbdev: modedb: Add 1920x1080 at 60 Hz video mode")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen Persvold <spersvold@gmail.com>
---
 drivers/video/fbdev/core/modedb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 7196b055..333b3d9a 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -258,7 +258,7 @@ static const struct fb_videomode modedb[] = {
 		FB_VMODE_DOUBLE },
 
 	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
-	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		FB_VMODE_NONINTERLACED },
 
-- 
2.40.1

