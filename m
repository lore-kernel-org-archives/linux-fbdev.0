Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3733D7D65
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747143; cv=none; b=CZ59CfbeEAQRqizLeQ7vuu6d7chbGEFjsrnBqXWgfkgNe8ksM5w4Xk21k8hPmHEHIu3I1kaIMi+zYnHFxWnnunFssHvrqD/WtcGWsDFMsu4WJ+CFjWa3eypZLSDTAXSNHQapQ7WkVu3Y+XpE7AL3jzBzeFvOjCbXX0vfpgu050I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747143; c=relaxed/simple;
	bh=UAStXm3OSu9RI1NNHAXC/tKQ3QUcpDehqql4Ja1eUUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9a+j8vP7NraXuCEbBjNMa3wW7vLVFKhAgZg4jcmkOxhXQWSwOBVTWsq0vOnrdb5c5T34pcJT01layygaV8awbAQbQ42FTxREVKvgHhenAMQeOTHA4qVNUAO2+ffBs2e302yTRL6az5rHYGclVCCvpKTrqFWYX0DvXY+WdUgKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=uMfigl6P; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="uMfigl6P"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c801912c903so3649883a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747141; x=1779351941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
        b=uMfigl6Pt73NSZmj0+Pz4EcgcXP2WXDNJHMPSGy3ceT/co1nGyAEN5723UIeBehawk
         moiC/5qdGTNM/TFBRMtR3YwWH8126Rkqv8AEnWMPEenONu0q+MfBJKUcHcWwT53Yjxmq
         j886aQMsY3N55sV5xIeM+nft4qMYUFtQYbSaTu4CKUKKoQOsEkfCd7yUZBCU9f507bVl
         YYM4OnsIC0vS42/AjzFvTlgyzP/XypjQEziYopmglIbO1bKTWqbefWsE0/8trDyDznZu
         qYngcuRkA/HrhBcaIKlSWUPLfTxOfgskTm4hWav0LdXJrnOh8GgrUXRcdpqcFXBPmGP5
         Kk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747141; x=1779351941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqQpLk2INDxanrU5EbiD7pVjr54bhFQM7xaG69RB0RA=;
        b=k0FMA7j4u6LFgIjHpdkzcX8NegYflPT6LagCKJA1Sxo1fUAz4Qbgt7BxK1Bi+TrfYm
         2Oqh1k9pXVLcN3g9KDYFWCJ6BI7CyWS/gDNX80VID+gg4j78rJT98+Z06haum5QyiBve
         ESYXzwNBQr12QT2Q+RYcjEUXbw7CvFZal4Wm1iBFyJTwOboV5pIa21R+Af4stwQBkAz2
         8rA5Wj7wRXoO8mdz3JY2MjcDBEsFzqEH53LRrOnVxAUnVHm4ETzC3KtlPV4bcUMnY80L
         blSMZikL9xiM4emx7RXVe5Fn/r/FHC7es41zOvr50vEnXQGwITMOTWA01hI6SoUJn1sI
         sdZA==
X-Gm-Message-State: AOJu0YwShLzd9T7od1A7Z11ccUKXDjw2DJkh9QxvV/gBJU8ByeqNyu3N
	qxjeYcdjUSfFIoWjJdzbYtJbW4pc1maxFK/3hbRqh0akZO1a/3UyXbosc8gtgxEZkOM=
X-Gm-Gg: Acq92OGgC2zO3aOtq3nZVuUNrEtJd5f+iV3qrKijH8+Em5yVd0v1IYzWHtPLVN828jU
	B/Zw0yPgLSeUDkremM/dejnFVlZl/HusP+zhjPyqbn/QWecfzqqDkmFC3cDVw3MC12DiOlYPzfk
	scdIP+8U4O3cyjcH0Xv+40o4uE1K/ykdnUUFVJf6UZqBKec4pvt+OY90XGhiL6pxHXJe4DIxirf
	OmcoRisonudi2RVA//kcCkqWY3UHkqdqFjbkahnrF+zami271dWixZNmdrhfGSLRP85K6oVBbGW
	5Q0X69s4gE+/LcOuk5lfDF2u0hOXvJA0DQG/vG2rsDPBcQ5q1gTWQ40DKAaRGfVzHot/DmhJQK1
	wV0sS4gsaKuUY18uXYpVKDh3wrYdieq4IkVUOiQ516wSlmCS2KGY0shKqdKnyoDmZoRtEHx5jO0
	aiI5qvjrKitv/MjlMcir+k0W9xXVNLrmFIeuxwC7q7wo0WcDHQEBhG/jXx0NYq/ym/zXZ82CkVC
	4RlvcxDr8BOUQ2NIGsnXp57whv4dFKZwY6UVQAk8o9F
X-Received: by 2002:a05:6a20:431c:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-3af7f86f95amr7286510637.18.1778747140737;
        Thu, 14 May 2026 01:25:40 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:36 +0530
Subject: [PATCH 07/14] fbdev: nvidia: fix potential memory leak in
 nvidiafb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-7-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

In nvidiafb_probe(), the memory allocated for modelist in
nvidia_set_fbinfo() is not freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index da2d486022e8..7d20c4087aeb 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1424,6 +1424,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 err_out_iounmap_fb:
 	iounmap(info->screen_base);
+	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);

-- 
2.43.0

