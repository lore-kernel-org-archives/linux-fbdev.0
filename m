Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552653FD1;
	Sat, 14 Jun 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749878322; cv=none; b=rfelhsAFaO9ohi7xejON37airUdvAWGX6Sr/rxw++CUEzJisd14QmzWMwjHqidtr+N7HvgIKhd5nUSYj0/IJ9A44PaYI6ipWW9uizKOYBTgY7PLi2VQLLAJur7oLmYJjsGScji2dkD0/geAigvkPNfmHdnCq3vgoPIMZlwnAWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749878322; c=relaxed/simple;
	bh=ed2MROI+FWbdZgJ5lAGv1Zm8VIghdRtNkrbI/PG9qxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohrUoI41qbjxAtFr4zke+F+GEejSGhRdqkFkEwV7heDAmEPwmcJ4c5pkBNWn17nlY2zlrJdM2W5ADnK/xALBIKgFP+deJb+Azjl7TQDe00uV7FJrY7Xit976SPGzm2CuUaBN19ok7pDMTrxR2kwMuASqvY/Ax1op3bH/Q0Jie0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5M2qw5E; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5M2qw5E"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710bbd7a9e2so22680007b3.0;
        Fri, 13 Jun 2025 22:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749878320; x=1750483120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMjPr38MMTrzz/Xm8WMGiTwr8Bo8oZuUFexoEu0yLi4=;
        b=O5M2qw5EvFovOx9VIConYWkjwCEaog4K1LNreZHJklGQE23cvYlDGoR/VGoVJ6UdF8
         5gJqYUwbIroUEjjZoXhRXrlugaki6FNwSXfWsTEf7hiSdgSds/Mi1EQo0t+ZJyE2id1i
         O2cRLOHaXVYU5E9H6g1My3EIT5nUvfegHYjKI74WBpJMOjq7HF6sO1XsmExanjYMLqsR
         81nFZTtVQ7WL/8cDGTJumsCmPYuEWyw18KjhtiXmmHPP/3q0bgFRYPvg0KnDBut8KhqM
         jkO6rlVRYyZ+H4pWpOQfYtuaPf8fDiIRvmRFpDh7IxAgu30/ZE4ycge5K3+8+HlYJgUi
         mjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749878320; x=1750483120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMjPr38MMTrzz/Xm8WMGiTwr8Bo8oZuUFexoEu0yLi4=;
        b=NsUdt5Ftn6VGogaU0J+A4aYix+vHwcJui8B7vV9BuOcNCK+r4m2S7INLMVmJc1d//i
         ZPkI82JjJ9TnxnX5wYBTY0ddeUHipHTqK1QQVlIXY7W4sjrOPHMmxgMe4ybq2htCrcRQ
         NE27bZDzbwKl/aC5fNuJJbrC1bnYS46eyz0M5LIdd9RVRdRt4xsaaeCVqmrY8KpIVCIn
         kufsetw+p0nG1PbsJbLdczrVQerbHcSSHd7VajIWAWlUKtp2o7nAWq2ZOUNjPZpwYfDi
         1ZKw1+fstGz8+gCx/NFNw9di5MCUEAMVPlHTIUztwlKmLRqYR0ZjgUqYqCuOhjOXdrW/
         lPgA==
X-Forwarded-Encrypted: i=1; AJvYcCUKL/ITU9CJF7oB5MUezlb3G9Flm+lRUJ0zRLCKfpCsN1yOdYYzC341F84PGuP4ueJYd7GFeRBrVzYHhSvw@vger.kernel.org, AJvYcCXj8peauvPsdPwKut+D+czusA8fcFIuEnClWXYZqU8LiD2iNNZYhdESkLYalfBG98Y5c8qioH6kq6S3Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUORLhimFCfA0zwG6XyqtEX8SFAPikJAL1iaWOboxn834AXN1
	m40aY1FeKHv663XZ64Idabi0y2IeWSozxTADPAPHdgALJ6UiLbI68PBG
X-Gm-Gg: ASbGncsQeBe94cdgnQ1xJYk6h8+oNr/K9YUCTufTyXrNIVXFEyNOMyPlNp9GAufo5qL
	DwFwKw/dS9yMHKBY8muDQO0WNtVQ3OpppD/57LO3W5eMg6cJWjLEwb1ZEnp1H1mWVeHI+94GNH9
	YMwkoGaI1z1z1Namt8StNajXs21Bqfun/Mkm5WeO+4TujvB5rf0AbFZ2JiMFCQOJO7NnDAft8cy
	2wCrt0B9kH+NhHjTvdIAr/wUKN7P3amVoCdZNLqzxM7h031jPEYAenrWhn6+ve+nWI14oHxxOhF
	gRyrnLUSlB8gJFXBznPA/3GbQQqHm/ZNjd3FkC47zrkiGs+kRNF/LFJ3bLyM40tqedDLBeODYCt
	2y7D3Za22K98=
X-Google-Smtp-Source: AGHT+IHPPNCglDojXqakv009x9m4y56MpUvTI1MTS11AFS5I1Ld+rh425NrfRt5ZeZpbopndV4+Qcg==
X-Received: by 2002:a05:690c:680d:b0:710:f39f:4d43 with SMTP id 00721157ae682-711753a1ba2mr27302607b3.7.1749878320216;
        Fri, 13 Jun 2025 22:18:40 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152793e12sm9004537b3.64.2025.06.13.22.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:18:39 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: i740: Fix potential divide by zero
Date: Sat, 14 Jun 2025 01:18:37 -0400
Message-Id: <20250614051837.3544959-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in 4 switch branches in
i740fb_decode_var.
Similar crashes have happened in other fbdev drivers. We fix this
by checking whether 'pixclock' is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/i740fb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index 9b74dae71472..861e9e397b4e 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -419,6 +419,10 @@ static int i740fb_decode_var(const struct fb_var_screeninfo *var,
 
 
 	bpp = var->bits_per_pixel;
+	if (!var->pixclock){
+		dev_err(info->device, "pixclock must not be zero\n");
+		return -EINVAL;
+	}
 	switch (bpp) {
 	case 1 ... 8:
 		bpp = 8;
-- 
2.34.1

