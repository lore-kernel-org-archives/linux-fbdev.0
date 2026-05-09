Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579581C2AA
	for <linux-fbdev@vger.kernel.org>; Sat,  9 May 2026 13:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332747; cv=none; b=eMoumiZBT/6aNWv7YR99/IRJBqw7BgPu0am48gaUd4nj35F3pNpuw7hvEl4k1djPqg7HZnDjc8LAA1LF3+mGKybrwb0UmQFg5lWjKVl/0ILhrIF5/Bu80rnqbeg4uCudFCjS2VXsa2QbrTBRLmJyFD49cHS8TI+Gu3R19yuSEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332747; c=relaxed/simple;
	bh=iF/ALznpeVvlc93tfAdBrhtXW9+7bgsYWkqXLOppNq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9WRsC7d6/aXKGXNuN5X0XhTbkLmDyrEMSb2BGlKKqKVMRnkzu9r6glG+LMsWfw4z7L+2QxcGexX+IFkp94gM5SvFDkIg+cKovHMhD8TGnR/TC1STJJrwd8DLXZO6BPrQ7Fco34K7p7MvsWwPbXQIWyjKGlWsuSbdvWMwyD+gFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7fpPsfJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7fpPsfJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so30096335e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 09 May 2026 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778332745; x=1778937545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=No5okmpafzlZdEog/24G+YrUBfbZYhR0LHn/C63TIY4=;
        b=I7fpPsfJeKUOaF4AqOWbd7A3xGj3M/Pt/6MlxM2m7bUTiEJWTTMR8HLAZViItG6WUP
         UY9/F4+C9K7liJ3WzVZLSVV8lOpiLUYBiM/CBKBMCp272P1Z259bmpC8AQ0LsAyCzsq/
         zeGacNmU3oqlvYdM5iW52HGj22ZyUaleq0Qg/3oM7tk2NBCVA3LJcbp5j6svZlrBxtCM
         nMwtJ7SRogJS34tGivM5rvWl8UKhICrc4HErJXE4UYfkQf6qAZquv+4TgKn7OFzP+Yqb
         Q7hFIsYYx+bnGv5v5/EFAyUrodhoXnNpE4WnPth2Bjn8v81QIkaq0F5BgfxNJhQKzHp2
         jk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778332745; x=1778937545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=No5okmpafzlZdEog/24G+YrUBfbZYhR0LHn/C63TIY4=;
        b=m4ZNAn8NMavTPKcRzLSyYOjclyS/S8gd4KdSxtlAu4rmelYmnHeu+5I19JAn10ugtK
         waE6QEAz0+wvXu/fruqIqCCqwH7d6oEUp8WQMZcIn8aHzDfysPR+KEuE6kzQAzg57Beb
         zYp8XBmFcZ0Y4lKelq33273Y9z6S65F/6WIpVQtYd9lujJHiJolNENW5y1/wevT34yJF
         GWJD4yDOVJEZGhROeL+4LRT+ZB7FuGoR1Hclf7FrRrrnN1RlKj/WwSC1k3p1Im/TNace
         hUL+C76pOZR2aEXbTmdpVD6SEhRrnjtghn+Vo3KIbvhnx0iLgEDsBXdyi+hfApGkXpvY
         gwgQ==
X-Gm-Message-State: AOJu0YwYPCS7xTUXXky/UPE0hT0mCaDqz7mvj3kW4y7K+PC9c/OjyAO2
	RsNkGn3zla2BI7Mxl2i5JqU5OVzrwfHKDbcrtr8qRpl04TY54o9uIsMolkAlJDCzxGc=
X-Gm-Gg: Acq92OGKckVClja/o92ExTyfvaHEmRxwtjxUn8LyDqBUlX67PHVQ63Aq8Fac7cSieHe
	CvxEKoydlrBV1QwaFk2j9fchPQWcHyMFfoOIdoXYh2C7613JgfIaDF5KekT2EffHk/4fXw1UzOS
	GjMFCUXCOg4ANMz5VrzW3KpstOqbw27R0lG4pfyRy72UuheDtiR/i+CKUHwxh9NygdHcNAoVgGG
	lZx490EQfno5rLJ7EMR9otWFYfTo5fS6haMqKqnBLUdi95xUhp6sUTvX68HwW/jDU6pNld94ve8
	jp+5gn8FZj1K7N6ZdmPuK7Ew3I+GhusdWucLOwP/U1hTHLfgVi30biqb7y4OrPGx1sbEmtRUoIM
	+e77r6HASlkcJ37xG0KiLGBigs3aMhQ7A90ptVOUk/x1ZRTrDj/TitmRdfBrbTv956X7vUWa0Ly
	dY5p2F2XY/0T3DFejg4sTiDMOX3FMKINI6UwuO/gJTKmGT
X-Received: by 2002:a05:600c:3507:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48e706ad0e5mr39164175e9.1.1778332744382;
        Sat, 09 May 2026 06:19:04 -0700 (PDT)
Received: from RM.localdomain ([92.53.30.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf496bsm31316355e9.4.2026.05.09.06.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:19:04 -0700 (PDT)
From: =?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rahman=20Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>
Subject: [PATCH] fbdev: chipsfb: add missing MODULE_DESCRIPTION() macro
Date: Sat,  9 May 2026 15:18:31 +0200
Message-ID: <20260509131831.1073-1-mahmutovicrahman5@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The chipsfb driver is missing the MODULE_DESCRIPTION macro which
is required for all kernel modules.

Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Rahman Mahmutović <mahmutovicrahman5@gmail.com>
---
 drivers/video/fbdev/chipsfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 33caf0b99..946e30fcb 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -526,4 +526,5 @@ static void __exit chipsfb_exit(void)
 	pci_unregister_driver(&chipsfb_driver);
 }
 
+MODULE_DESCRIPTION("Chips & Technologies 65550 frame buffer driver");
 MODULE_LICENSE("GPL");
-- 
2.43.0

