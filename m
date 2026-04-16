Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE12820A9
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358035; cv=none; b=a5xy9VgjmyA65P9l+TZLCylkibcoiembMq56xcy7JtshtlB4aBvAwaNDI4Y7Boc8mFf56V63YjI0BsXms/cTMeIjp8UA3PN6rza1FpYW5DhHTqqiVtl7AFQ6qyi1CoMVqTVGxj46Rup7LZi8bia+dozAMkRApxIzH7rSBj0ndFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358035; c=relaxed/simple;
	bh=ojXH2F7K02wMz912KjmCBclcAULE9xaANKl8Rcb1Jpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DZ10L6o78butp0e2U+icWxito+iEhRS1oftsbf439lX9FtaG5jOJjAO2+Kqqslnm52KDxLkpKRXjVQ0MD5JP9F5JkzKGsV6D6qVlu8W2DIXqU7vbsCZ2LV+sQGb+erD6UkSsT4oxHD8qNUHRRtUDYyNDC2r6y3srkK4z2VS2sf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvMq9pC5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvMq9pC5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so5672746b3a.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Apr 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776358034; x=1776962834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDxwYfpurj8xr015y/mH2mke+/hLRvGAF/fQ7dIVG4=;
        b=ZvMq9pC5HDzdx7/UfDFs7AsJoZOPZ0zxWfg8lc0fQFJKz3oEWcFnfXs0oQBB7NajeZ
         Ay7JyuvhXSy1NKXiPKiMetk9QOrVoXlZZE5MT2h4X4xKsA8f4CbqjA6YxxrTUIAicxTN
         4VKkBoBF/6KxNp/gMKRnFFDeU7IoMCvP+JuoxXZ2j/biEfPkEwwPxVffZfQPDadH6Nin
         Nw1sHmGpEamlZI5Uw+zYA4jwTBgHnPQACle2epExZJcysu0ZYQQmXCbc9j+dOY2sCcew
         rBRoXaZH3E0I1RsM+9ky5K4qi5dqS6XHHJBYMWrJr9/wKaRaC5yFXAHpIMt9vtDnqKnx
         WybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776358034; x=1776962834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzDxwYfpurj8xr015y/mH2mke+/hLRvGAF/fQ7dIVG4=;
        b=PNObWR38+1IOLM7/i+F/v0324QI7EK+NOruvCNcbwuyW6zv0EJabdA0Um6IJQA2miU
         4VfIoH7ygsBvUy92NuS/vDWaeqkskD8AdRjpBtBRWAVD1slmYiATCigS+53BzzVvJOZf
         QBj55LEEUSahoCxAGxNkiNoP08vz4HjFgdFmTsESwgWvMSuaTw5xvx7oOUA8SqArN4/u
         MCTV42FM0mZnHOBqXUAwrWJWmWT00aqMG8aUUeZcvU563zt9oCUvhDKc2WiZXSKEGLaO
         KrpZNXVJcsqHwuGdkjg6KxxHqWbWS3IC5aDpjRS49OW98uXme3BgQ3I3iMF9x5ISjFb5
         /GFw==
X-Forwarded-Encrypted: i=1; AFNElJ9KEOTAxPCGYvOcs4GsOI3TfZtudJTS4zPmp/2zBzNsNrX7v2j5jAMUTPbT7ot5TPmy5WWNNdh/pVIKug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDsDLPfcVX1Dbgkj2UpN1RGdvjnSjvYBbhkX19x135Zwm8Zv5
	I8VemmhObnqaudfbhhnouG5utmKeyBuBtcSqIiyDwfAA/YGgMQ3n9zsJ
X-Gm-Gg: AeBDiet7q8grWDOJ0vbGmzY133zahXSmBgGCmEFaknUQo1gw3/1Po5lw+LeYj1x0u+P
	io4idNMlTH8ab2P3VoHbu04dRpvppqk2Ra1MR/vdNlFfNLQ4ti5geP7o4fR4N+cjEfAn9PVH9wW
	CL9W2N9H4eO3x8N4VvyardBj1xmbOuwecXRErKW15S1FbTUIr9ohH42bdr/aZo1RaOv13rHjqp0
	2H8a3rWy+wp7G/3lA8Fr5GVfI7RS+VjKlVSelctTZAUMwD/PIIbhjvDZPanZiiAsPnZ4tdp0/Nz
	fMr1r7YCRMEIIXQS/+pv+idq3EfmBjeHbOxd0BbRNDbeAJRtupW8lTYRr+tpR5OmCe/Jp4piJ1h
	2rLQb9au0Q4LFJ54rqPqVFtJ0a9pG0Jg/xi4WjR11yyzhiWbQZxuPLqPGjma1nwuSFq7bI+H0js
	Ga0yNqK3BuHLQZXGhdO84EtQbQSJ70A1/iCz6zKXddowVFdRFJBPexkbpwB77QIe0cjje+Ue5R9
	FAHTBzjQGX1sLE0l7HU8fSVui1b/4jeWZg=
X-Received: by 2002:a05:6a00:21d5:b0:82f:2070:2683 with SMTP id d2e1a72fcca58-82f887eb97fmr103721b3a.21.1776358034016;
        Thu, 16 Apr 2026 09:47:14 -0700 (PDT)
Received: from lucifer-Victus-by-HP-Gaming-Laptop-15-fa1xxx.iitbhu.local ([103.151.209.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f88a57cd1sm28808b3a.34.2026.04.16.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:47:13 -0700 (PDT)
From: Sachin Kumar <sachinkumar905846@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sachin Kumar <sachinkumar905846@gmail.com>
Subject: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
Date: Thu, 16 Apr 2026 22:16:43 +0530
Message-ID: <20260416164643.153765-1-sachinkumar905846@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve wording of a TODO comment to better describe the
intended optimization. The comment now clearly states that
only the changed display area should be updated instead of
refreshing the entire screen.

Signed-off-by: Sachin Kumar <sachinkumar905846@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index f427c0914..4984aad9c 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -414,7 +414,9 @@ static void fbtft_ops_damage_range(struct fb_info *info, off_t off, size_t len)
 {
 	struct fbtft_par *par = info->par;
 
-	/* TODO: only mark changed area update all for now */
+	/* TODO: Optimize to update only the changed area instead of
+	 * refreshing the entire display
+	 */
 	par->fbtftops.mkdirty(info, -1, 0);
 }
 
-- 
2.43.0

