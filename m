Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99833BBCF
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692705; cv=none; b=QFBvrYkDQk4xThCICJ0EW+FQKWhG29XlpV2qG54XMmq0WadjNEoU+9s8eFPTtk79eWuBGjSpZHhm3B6gyDjA2hQNsn2efjJNsYnuG/9FUE4uctq++P4dKyGpl+wXzyfqdIN+HgVZIN/CdAlrIlRY8lMrAm8MZmaEL3ZGktp3f2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692705; c=relaxed/simple;
	bh=bkq05G9gfz2sPa9VoCDlTNYvuBGJMtnOkyfp8EXvcwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ReceASKkUTilTw/yIGf89gfHBiiVosPEJd+IoADa/GTBWJrc3neJm4eBc/G4Xys9yYvvFc2WbtqE1+Pd3gnIeF1+tDKIijAiRT+77hrP72eAddU/gqly8ku4dB0y5DKaFgEiEZXLmoHTaJBx9RnE9nSiTFBTj5eQyZPOmevTNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXulVndi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXulVndi"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so21773825e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Apr 2026 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776692702; x=1777297502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrWPe/JKeOuhvC8+0ejqxf3TznZ/FI4EAfyXVKA2D+g=;
        b=SXulVndiNtzpXYWouPcjNZVoNO1ZdvxiIh+fBMlcIIdWUVyhG0LOvYbs4bSVEhQbXS
         R4ilYIoIOjStuTfshxTn1gQiKMtCCzvxm2NTxYMwEl6x775WjRPsNTiBHlozNT1WnIfM
         i9xIa3VnTQzqOFsUSfKcp0DkmPeySs1gkUI6mxffe4VW4OgOShr5DVszapA3Bk9UcD01
         Txq/4FAhVdQnQOMbPd1A9NhmU72JRYqEDi2K4r+ezQl2tnwCm/6rZ5JbkSloRpfrxkWG
         VYv8TridMD0Umtbhzp8odsGjTxFaPc2jEv+m9vOxGNcpGUWj1RWrl/7MxUFxTKkMCHhx
         bHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692702; x=1777297502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zrWPe/JKeOuhvC8+0ejqxf3TznZ/FI4EAfyXVKA2D+g=;
        b=DdtpQJfd70RKKGfcsy73SGVQ4REuWhRcrgC1sbBQPcdEbTUaGtCsYhJceoFKaOMC/t
         NThs11vdzE86p01h+OCOkteByL9QuO6Ki5RQ+6KdQeWKYZ6xv5AcBl196j+LxyS8Gbzz
         /A9MLZn/pzQqmRs4HW7c6QMqYnOaCcC14954b2LDxVUyFZSrTaaIyObKOacbR5V3Z38m
         O8fm3f/7imXZhTS9o3S2J2Ikp7dwCuSScRzNVTZoUMBwssC8WNcCvR/Nsohf2IwII+DP
         +wU0FH8K5cEJ9235ieVXIpypnrdyGa3Z/EBw0Lpm9sSvCM4mP27u/MN+guihU/6y/o/9
         770Q==
X-Forwarded-Encrypted: i=1; AFNElJ+XkmtL2lkqVq4OhhaJAMve4MpEtr+NYSdlvMp0N2Y/JhrSbiB1uSE8PbEiOswpy8kub0DV5p1saa3iZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLmGhXqSc6Pi0ukUf/avwQjpjWmiAJjLeFkTLgwEijr7c0GCX
	OmvvePOhAOL1sKXua/mL3QvXSzwVuwVUDEgrQlkmMiGRXfm9vRRBXZypiqUzcReU
X-Gm-Gg: AeBDiesQq9mqv1mIH/cHEOilXJmx4LU2md07YPJoQnN9GuRt9sg90juq+K7OI76vfkz
	1YPnAUcgxfNDQK3Yn3xuPGLQj0ccFdLUa1X3MOzpMtBPbIN4jsapjPuOrS70AEX2H8Xe3KqfC2G
	qyIRwo8Z6ZYDYpaA7GB/agI18VAceaxwT8LRadFh2XGM0S1SCY2a1gDqX5+G8DXcAyLCa3Ktr0m
	/6VFk44z76cKUUZMksZZiF0Dl7Idf6A5RlO6YQ+f4RYXvdn3Gs6lMmraP2U7z1MkRJsNERf8pcO
	oiYEB0uIvZIwy1btUOJsOfMfTcSoN24mf2b9Hi7twGXmjd4NWzjZkLTfozHcL3GP1g82xm6TjD8
	01VPJwUeiJZISoRX4Cu2oSoFUk68twcaDeb6Lt6N69Md/K+M6InVOJ7QDXk70DUQ8LpvUSeQ9Ot
	NEsrEAoKY2lBCVSK08XV1TX54hea+qDmrEnbpMK524
X-Received: by 2002:a05:600c:8183:b0:486:fe39:28b7 with SMTP id 5b1f17b1804b1-488fb752e3cmr161475825e9.9.1776692701909;
        Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 2/3] fbdev: clps711x-fb: Request memory region for MMIO
Date: Mon, 20 Apr 2026 16:44:23 +0300
Message-ID: <20260420134424.77494-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_platform_get_and_ioremap_resource() for resource 0 (the MMIO
control register range) instead of open-coding platform_get_resource()
and devm_ioremap() separately. The helper requests the memory region
before mapping it, which registers the range in /proc/iomem and prevents
another driver from mapping the same registers.

This makes resource 0 consistent with resource 1 (the framebuffer),
which already uses devm_platform_get_and_ioremap_resource().

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/clps711x-fb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 5e61a349a4ab..7a7db7100499 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -216,12 +216,9 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	cfb = info->par;
 	platform_set_drvdata(pdev, info);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		goto out_fb_release;
-	cfb->base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!cfb->base) {
-		ret = -ENOMEM;
+	cfb->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(cfb->base)) {
+		ret = PTR_ERR(cfb->base);
 		goto out_fb_release;
 	}
 
-- 
2.53.0

