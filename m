Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AE15B0EC
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Oct 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760537341; cv=none; b=dJ8rKMo8zJAP2FNruKhpWn9PTPvGFhGQHeIAnukrW0IaF+gYseTokY1ttQqV8HRYY1USgngPemE/TtlaGrR4Cg3qt//mCLXF0AZKckRIsZYJNw2+cUl0VBf/IeBFAHy8AsBzsH+aMFzq81B5LRK5ovEEctknpYI6VWXgnsAENkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760537341; c=relaxed/simple;
	bh=psVvFbur+V+VuNV4QnzcYrS4EZtY583QSmPdL4nzXFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vb3vLRfvssgw3HznyWB3Nn1tMv+kt7HuPJ046yC4vvtSHb3/CfFuJJZJVUDj8tjStVO+G5xtT5KRKFf9yciGJ3SsPfXhyIB/8SSQgunanoqK1wSFjYsondvK54YPb86BszgqrCMptJqE75fQcNVZD5HhXU5KcVewUK9lMylBBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9dVDPZ5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9dVDPZ5"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so8478362a91.2
        for <linux-fbdev@vger.kernel.org>; Wed, 15 Oct 2025 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760537339; x=1761142139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDEVuh4N5QxnjfWl9GfHaiYC0Bn0qUwYZnFQleExTuc=;
        b=l9dVDPZ57ZIGmuSK8pfM+yW9fN/EO4gDGWiujyrBXj/rvyWdlB5rSWikZPLfT8aj8e
         H/Mm3vxCWpz/hMIiX7w964fAvrjz7nde29lTSsnEITu3TtSiXy97hWpFOhW0dmTg7M8r
         3wukUdncmUQaZmPtS5Kw2FHZStVS5AVqgL1iTNP7vEW254n11dZFJps+F+KXW5ib5OWD
         P/wOsquwIzKNEkTKKDJMF43PdVvgY+HSBYNE17Dax9nMPYYZSfD8SS1sr4OTP2MFGBov
         4pVKUp8KThlmRUeZlrjr8t71GFA0fNIRGJy1HEkF16D8vJxzp1xjOOu9YAGxMrbD7FSI
         1ULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760537339; x=1761142139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDEVuh4N5QxnjfWl9GfHaiYC0Bn0qUwYZnFQleExTuc=;
        b=XoaGOPxTHykymx/PNC1YATx0a1qsknWdHorJtnxf+JO2IgxmtlyWK+WDfEvbhIIbPA
         JzedWpiQ5+hhlwFAKh9yFHTTikHCeZB5JGMcT/FaHVqz1844U7fLF1ezLzmfl+ZogBCN
         ger+sKDtjLtE/3hUWgjEEf5KeyvvyZstycXM3+ggBGAN7URaYzGqEEvmGyXcxSMAk/nM
         TobUSZ+ybTIsN0Jv7VxAsDV3NPOdvLVf5tyJv0aD8TbnPndi9kgqzBzGx8Ijc5PFWMiE
         vyhi9y3Cst4OMobHo0slGCYFrHxuddgO6957oeMePIvwSTQkbQap6KdxdaDJNOimAkIi
         febQ==
X-Gm-Message-State: AOJu0YyQw5VNXln7rl/SptWA5U8SAbjau6y0BYNbAuPYbfxfew4c7Hgn
	WXsEsQY5gL3eqpoDwekWljXsprLnqEnEXWQp+1lNWyeaBzPx243/Z4PgVyIwGA==
X-Gm-Gg: ASbGncvr161asT+TybeCfG9jl49UG41gdP3Z+NWgL/+Mu7taW7XxUWPjvX74BUhdEgH
	OGL6VWGnAntMOHqZl/+0uKgGx76CYu165G/o/BpN44bLNnw5HZDqLllufqEkKPlEn69sX7vr3TZ
	iUN64Detw7gW9h9QTSMpQ2igtPio8788G2mARm2HJxBQIRGJa0sYyF5Jk2c60LzPbvYUES12mwF
	QA9GVFVxUZLm/OGC4gwT7YxEL+A9LOzfd1mNFBxwjyUSv1NrfNjF/XsRC3/PEwko+wzFr+/u4Is
	seNY8c1ENoWHLXE/fQLGb8DT9FuoiQEP3AI9tywYd1AuEX6hhb6SpAqf4VtuD7m007iRzwSY7cS
	c4GRHOMJ99VQCpPONQrIi5O5b+TOmM8cLbs5sRWVZ8KBNHLjpJvBcBK3qEQ==
X-Google-Smtp-Source: AGHT+IHrOWHiUm/F/+lZtbBia8s/2w5x9paCeR7fv8SYDyLAYWcFv8myDkJZHNDMxMSeMJWGxY++Fg==
X-Received: by 2002:a17:90b:4c4c:b0:32d:3895:656b with SMTP id 98e67ed59e1d1-33b51112266mr40262461a91.12.1760537338313;
        Wed, 15 Oct 2025 07:08:58 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:12d1:7eb9:cd0c:2129:1182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6192995asm20043418a91.0.2025.10.15.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:08:57 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	deller@gmx.de,
	adaplas@gmail.com,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [RFC PATCH] fdev: i810: use appropriate log interface pr_info
Date: Wed, 15 Oct 2025 19:38:45 +0530
Message-ID: <20251015140845.31671-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use appropriate logging interface pr_info instead of printk
without KERN_INFO with it. It could be updated with proper
logging interfaces.

Legacy printk() calls in the i810 fbdev driver can be replaced
with the standard kernel logging interface pr_info() which will
help to allow proper log level handling, making messages easier
to filter and manage.

No functional changes to the driver behavior are introduced.
Only the logging method has been updated to follow modern
kernel coding guidelines.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/video/fbdev/i810/i810_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index d73a795fe1be..8c4b9eae151d 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -2137,7 +2137,7 @@ static void i810fb_remove_pci(struct pci_dev *dev)

 	unregister_framebuffer(info);
 	i810fb_release_resource(info, par);
-	printk("cleanup_module:  unloaded i810 framebuffer device\n");
+	pr_info("cleanup_module: unloaded i810 framebuffer device\n");
 }

 #ifndef MODULE
--
2.51.0

