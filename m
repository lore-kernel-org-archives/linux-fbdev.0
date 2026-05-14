Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61C23D7DC
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747176; cv=none; b=qoH7RD8hqMrzVBrf075iM3Xr2a5b67M+IP3AE9aeP6bPl1i+TEXN3mF0vIM1BR4i6nK9GsSBcLkZRxx23equgB8GfrkgfApUs0U1rzsGgeriKr/s2vBNEFZATH4dIr/Jg5SQO1htKbBNy/wIbamhkF7yCoq7UacVuCHFFY1sHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747176; c=relaxed/simple;
	bh=Clp/7+dps7CMjUewVBlwf75eLhdxMdYd3dH4NKEEqKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1dBmpf6kdPMqXrJWwy0OMlib05ZPnDuilz5saEKLtd/r5gcyZZU408vB8i/ZAFIeyEeKgk0Nk4+mYICAtqbguncTdHCUV+Ak/+cHFTZEda2bPLK80v9SSkcZ4iPb1neVPd6S8mSmc3a4xbQK7LJFVPbiqe03WU/eZjp06XRE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=k91Y4giH; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="k91Y4giH"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c795f441ff7so5654484a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747172; x=1779351972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
        b=k91Y4giHff01yxWojuLia/M9fAL4RljVppDZPb60vAs3vI6vvXcysEMJ4dM+ZdJPRo
         rtJuyF9e0tOv+mefyYhoCtda8ZaXIoexCsB4eNz5j0k+9K3Mn8BRb6qBX2WdJLt3TIdY
         MMa/8DMmkrqKDq+XL0tX5VARTK1ndH3c25lmdhhLwCdBXBOk7e0MHxg6Cdjgqk+6WbmU
         yRmjb3iZPgkJU1SK4I5tWOlhkAQmhiiaZlqD7dtI27z3Bpi0At628qbrFY9zY7ImF7BT
         HgnZrsjVZT+3qpC/MUteJT/Jts/unfTCx8NcMF7rud8jEeF7LFVHMDnJt3rj7F2kutJD
         EAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747172; x=1779351972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GheaXfm6WhMIcKtl8e6E9+wMuBUvLISEtMm7ivNoGig=;
        b=IKiq5F0ZdVjcTMDI22wvV9y2IUkUBoYTDnsfye+eRplb2R3iKr6LiSrCzaPmVb3hE6
         nlXqoYlQ8M5bFbqGGBkPhNRk+03ZNZRkr84t5/MgxRVGrjMoSf7ggDeoC5EUZmFkKOnt
         nSc8HsHUvmY2L5OW8zU/g9vO8FsXftDumNvUXU4BHmYgmw3U1ErfG0e3lHuZ7vm74Vcb
         uMBL9/9LHbmEAvmnUtx/iC7MN8AG0VM7pd0GmIuyMB20Cji9ELBCLnQMLwXJW11vXBuD
         hppTAz1cSNCjPTi1F4nU0QiQRFycYTi5zcjRZpcz11wyzTj5uSxqNcImqtHiZELiVTRq
         wXJg==
X-Gm-Message-State: AOJu0YzSlED2tND6Ud5ZEal3pzBg4rCE7lCAjavKjX8jiU8fAyE5XB8b
	Fvljm/SCuS5IK46Xh5Tcb3yVOPYydq4VSiCtzLyU+EAhL4+lXP+CT37RwRomMlFcT+I=
X-Gm-Gg: Acq92OGto9yWTYP//WhTsi9Fa1z7p5Pf2uVQ5ZePVru0wZmpJEK5492Y+PsO6G+BWhq
	Vvlr8HRJ40QE5goIZnEQeYJvA3tiDGtOOfJ82Ygw1PkVBxgXLd9Zb2Oqu3LWtidmqF+jnX39a3L
	f1zqXrUhjqaC00IKY1onOFQW2k3ZPEPRS2KEBMYLQykhKU5lGF18H/IWq0DwSnUYh8q9qcDOHva
	eZoJPNUmtNCd6w1ABLNqDB8W0+MbxwabVPwspcUIBk/xlZwQYbHuZ+498AW2xaiRj/55qMk/25k
	dMr9VvtxFYWkOw035n/rqeB3Rtrhq5/cGQVkc3YBl/wqMaiRcQz2IAGXUUXfBAjwZO0sPemWXV1
	ofks0sFQKsV2z8WVN65hP/yXAMf2PYocyJosKtomf/VJRDjkglOL5f+OSR1aEebnHtAAH59EUOc
	Q6kHQ+veotr84H6Ovp9AuVHhrELsj1qUzSm5YcgeDJpAJbAOPv5PCz2CMPiIPONTjPP4HpSu3pw
	vJLScM4jenVz+UqSdeeioLQfMMXSepJ4XFnUrvzZXZi
X-Received: by 2002:a05:6a20:7f8e:b0:398:8002:8033 with SMTP id adf61e73a8af0-3afb0524b0fmr7156205637.49.1778747171713;
        Thu, 14 May 2026 01:26:11 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:11 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:40 +0530
Subject: [PATCH 11/14] fbdev: uvesafb: fix potential memory leak in
 uvesafb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-11-b3a2474fa720@cse.iitm.ac.in>
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

Due to an incorrect goto label, memory allocated for modedb and modelist
in uvesafb_vbe_init() is not freed in some error paths. Fix this by
updating the goto label.

Fixes: 8bdb3a2d7df4 ("uvesafb: the driver core")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 88667fccc27b..9d82326c744f 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1694,14 +1694,14 @@ static int uvesafb_probe(struct platform_device *dev)
 	i = uvesafb_vbe_init_mode(info);
 	if (i < 0) {
 		err = -EINVAL;
-		goto out;
+		goto out_mode;
 	} else {
 		mode = &par->vbe_modes[i];
 	}
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENXIO;
-		goto out;
+		goto out_mode;
 	}
 
 	uvesafb_init_info(info, mode);

-- 
2.43.0

