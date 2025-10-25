Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781852D46CB
	for <linux-fbdev@vger.kernel.org>; Sat, 25 Oct 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761432137; cv=none; b=G4bKvRdR5Z3rwD00e1HFzkbm0r5tDSpjQWBz4nEECXFqYAaOBMzc1Twipf4GBxw9Ysnd5n0AbKpD0FQz/skB3hWxi3bEZNIpf9ak43WYv8Zytbqy0cxcCtfLATkh5vqi8JX2VUEm9FJ2ZkWbuAZ4ZZ9qYSCJ1zI1S6TsFLh+p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761432137; c=relaxed/simple;
	bh=4TeSUUQyzmjI+AmEM5j9GI7xFhPjauS254ia4GjX/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBRfO3pkynqzXspBEFrQH/V+bdMWuP0d+ncwBraI/2CNtJrpHxGK1nqJrUf6S+PJLN736+NiRmlpB0RijyIuWJU+9PSYWD4OvcvlR7UQ+BX4ioRw4rPs/OjEizdZoLpXdKGfDqGxHNGC3bqUsS9akDnp8FJfpGtDJoEvocvgLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtGPljA5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtGPljA5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3049934f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Oct 2025 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761432134; x=1762036934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=YtGPljA532L3+1QTNRK8ucyMfbMjuy1X4EvYe7fZ9cn/Sf/vdvXVFXJ3eVPRmRCf79
         wsD++hhvwDxz8P0UrlzVVZs+0eJSfSZAFPd7uskAKPrZZBlIPrfM63qU12Rc/lbgHQYz
         ccj4DqwGnTj7lMuUbUoe1lfRT+jYLyvl2NdBABK5h14/NEklRqPk2p8NYEbdvuseB6rd
         /4SCEemylkOzoyMOO+pQNcaxRrxq3DoZB1XSSpI+zn0XQGkPl9VSegx76bUCtwyrU1Yw
         Mo9xL+BNqgDkq3lIGGQrVw8b0yUOoxqo4MNFHnH1SQsaGuUaa/jWeTkpY+ivKSyp34jW
         hiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761432134; x=1762036934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXq2mQ4sAJmwho7etnf6FLZOIO7gybFmwHnhQ+k6dI8=;
        b=Y0/XnQ0UCfFzu+S8Tr6behTtXoNY8CPyJgAIlJCxkuo7WNWS/k3wl9xSkBnW/OJkpR
         Bav1iWqdSiDNoorAsfi8B5s4AtPTTDYonpzckDHzoWkhohV8Lp/WJsb2m7FRoE4KOszW
         b/p8ANeTgG7vVhDwG5gnswVjS4vxnh0usBeqWckW8qg7VvdhH5LVh7qc9ctWMEVVh1qS
         d+y93RmALrF6Nn+ovmwLUTiC3wZ7cuCsA0YTiMpc+VpvIQBmZvWl0E4OLk040lWx0JBV
         a0wECb9On42wul35ebht7NtgYbSM04VMAWh2E0C7W/MmqljwcLbMrZaHs8PP96EKkUFY
         7G+w==
X-Forwarded-Encrypted: i=1; AJvYcCV2ypPtbOQORpfZne6CYW98vumG5M4erqQLDwOLcybCTQEoop/j3gM4Jmrwef36nRV+Xiz3hXvKWtT7RA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mATBfh7LbWMHdxFQJDDZp2VVkbuJAFi1p9UO4uSTbUyvUnbY
	peoC8LNnWNFRpxktw4P3izGSzJeohVL/53Buc/lbtWohRNqAcPx+scA=
X-Gm-Gg: ASbGncuwgX9cYs3FC9awksJdwSab8Ou56czlodvpvkZuC857JedaciKh+5j06p2/inG
	/wB3lIVrp7yDfBaneQZGkeDNmtZS4SjyVyCAnrJauWiMLZog0jU6wluLABfjYm5qzyXhNOa8pgZ
	BdGr2S3bWi+FBoSNlidE2cLqkHX9/Le8zpqIhetUalHKkm2SKAU1bKwHQD6he7wqiNvevLqNwGL
	jPf9a4XSipbodQJhleuKJNtppqyD00Ma3F3JgQ2ivB0ELxxSSqGOXiIw2/5D5QMNBTwxBmZK70Q
	A7kI9MRKcGnPwsK8py3HKucCp4mUqrjbBKhR1J6Z8BW2kX7y9GDMaWau55meIj0nbvyz4WtYGeO
	ugx/TALjXks5ARMpc9k/Ymdm4zQ9BU8lhBYlxVzaY8hP7jWrnhZV4OnT+15/M6h+jhPAvrpUyQx
	O4Dg0L4f+GHTZ0sIkzO8Nc2SuH85TzOVUzNtWbpbFCSufXA4WZ4vgqun4iaNv9UUOk2t3Dp7jFr
	f3WTsE=
X-Google-Smtp-Source: AGHT+IH5qEmI200tfknZM3nb5ovcfV9MSsErH9Gyktcj7nN/CQ7b7jCUO5zA24B4gpxH66kEW1MyEA==
X-Received: by 2002:a05:6000:41d5:b0:427:666:f9d6 with SMTP id ffacd0b85a97d-4270666fa57mr22253037f8f.39.1761432133628;
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:bad8:a439:d5f7:21de])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cb55asm5742091f8f.17.2025.10.25.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 15:42:13 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	fuchsfl@gmail.com
Subject: [PATCH] fbdev/pvr2fb: Fix leftover reference to ONCHIP_NR_DMA_CHANNELS
Date: Sun, 26 Oct 2025 00:38:50 +0200
Message-ID: <20251025223850.1056175-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e24cca19babe ("sh: Kill off MAX_DMA_ADDRESS leftovers.") removed
the define ONCHIP_NR_DMA_CHANNELS. So that the leftover reference needs
to be replaced by CONFIG_NR_ONCHIP_DMA_CHANNELS to compile successfully
with CONFIG_PVR2_DMA enabled.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: The fix has been compiled, and tested on real Dreamcast hardware,
with CONFIG_PVR2_DMA=y.

 drivers/video/fbdev/pvr2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index cbdb1caf61bd..0b8d23c12b77 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -192,7 +192,7 @@ static unsigned long pvr2fb_map;
 
 #ifdef CONFIG_PVR2_DMA
 static unsigned int shdma = PVR2_CASCADE_CHAN;
-static unsigned int pvr2dma = ONCHIP_NR_DMA_CHANNELS;
+static unsigned int pvr2dma = CONFIG_NR_ONCHIP_DMA_CHANNELS;
 #endif
 
 static struct fb_videomode pvr2_modedb[] = {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.0

