Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA03AEF34
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747095; cv=none; b=rpCFwtGQ3SoQ+P5OKz1YNG2MkrmA+fDVFIV0jG5i2QoOGr62fiHOiDjXjXxFrfG0CFtei5RoagHdNkhkt32gACfFqW+7Tdk5Ht6CQiff7Mt8Rj8tyDNZsQue4LUz+M2W/hfq87GtiJWMIZDttTcyrPF9G7wUuIVtPgmP+NcKuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747095; c=relaxed/simple;
	bh=WWJm/xpIv5plkf8LM1Nw9aJODKA1eKtQKr6e1aIxW0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuW10bH9Q8398ZVe9MTIpiylWq98L54CIsUa6NKuvxVADVT26KPkJ21Q+s6qr1TYS3b6L9vO56bmwvsuNsN8UADw9K3f/LPr76UaSzNsFrX4pP4I3c2JFTwELxztNSWxxCLLXwDj1TSh+wEk1gf4CMWmPJFcoItrsblCYdA1YFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=TyxvKzJw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="TyxvKzJw"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-369002b26f4so978404a91.3
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747094; x=1779351894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
        b=TyxvKzJwznLCqIX4SPN3uT5eAaPuDct5GAvbEtYAREL7n+a8AKy12pfQA2nB9wrAKR
         7ywQ1HnUcvmQ36Jn+igoNQtb2tk50CUT7LCI2A9/CL+hkR9Okzjt/fIDhDMAeG12iP9r
         vp9S3FFrPoAx9VFZiF0b5pV1gR/oYFD0fL8Ptua1cUhebkarmuTwlIc27gsaPQjeLGIJ
         vVNbDmbzXhhAxwcNUp0YZdmQwOnj5IOBZVqZ4wQoh/ZkMKhhjKyI4T62wbaUryRjJ+5C
         oD2NCTm2TN1X6fXNxoZJZFgy5xuteeCg4J/FkY3Y2j2fW4ouF9Lz2mKD2Nm+bl4FAK/C
         FPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747094; x=1779351894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XFQkelQQRKhZpfEoPGAVYNK0Hwvv38SrBtzyzwAZhUY=;
        b=HuIoeB5jK53mt8D4tS3FiDlHb6N5ebJB6aTPSv4ARKwZc/3YbpGP9N/S8oy7WREaUH
         PfUJJwM7RFQ19J9C4sTFemM48V4PA/+SArgVLNbl3rW9vEV3aQDYqCNFC8I++hvxzAmU
         qVqEkNMgKyzrFtkdB3BPWtFgXERnIxp5alwvLRfaqx/YnfJt5/W/bxeJvZHFpBlKhOoF
         sNUaqm+eOyssq5FtekJ4NFylkBtkhS/8h+pcp/yNGfVfQQsmXBMt6IhzpapJIjXggG9p
         3EhEa3np53dPIasF2z7ciO5aeDHZNDru7drfl7OL6a4F2fmAhtySoZm1Ak30V/E9huu8
         mOSg==
X-Gm-Message-State: AOJu0YzbDKDxw2ofZMoHR/qhKKMSdYa+D4scIvqISRasZ+co3QES1BC0
	r+X/MGgjA3XNC7jdjgxjlSb7M8ltA9+jLHkJY4QtH5XCqIVuSmLLZNy1N4eUp/V1aT4=
X-Gm-Gg: Acq92OFg7BK6auz9B7HU9pueCeCJaf6s2HKAD/trk7zc7nB7C+Nz4TSaMlVDzv63vaK
	FOLJqUY9bMjoLfXG+l12bhm5pWcfDUFR9ljb3Y2QhF/bWmsDsaX0zoRHu1IXV0nrHasvLNgGNxW
	CNajV/m/coRBkPmh2lOtsy+xofMHa3bOQvJ3DeJFIkvfm370LPWRZh8+asK2HAJGJHsVwh//w1J
	dcgyZYoWsglfbyKWsr4cENPBPp3D57h9jhde4N4e0OQeQhRHV3Kjpzz5Wd0Q9gmeypcvOmHpKD7
	7YxVWvqQKOxKaLiLtzX92RBPjda4rChY5eTgcW+ltS1yBu8qtvuQdWPIpknb2pMAhflIEGHyZZG
	k+V73g7mh4RdqnH+kZVr4XRAWYeZSJNl75qQqKxzzB/5dU0RBBLjv8nZDqQIZK7bS8mI+GHIzZv
	0Ryl8nKwuJkQznsY6T15tYPqUj8TFvWEObNIBq/0UbttSFSAM1CwX1Q9k7tCBSi0DHGPPr2ab7p
	MuJgl8X++aPJlZk64X6VaGZvsI1v+EMtBfj9YbE+EfV
X-Received: by 2002:a17:90a:ec90:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-368f7990c58mr6047925a91.16.1778747093565;
        Thu, 14 May 2026 01:24:53 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:24:53 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:30 +0530
Subject: [PATCH 01/14] fbdev: hecubafb: fix potential memory leak in
 hecubafb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-1-b3a2474fa720@cse.iitm.ac.in>
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

The memory allocated for pagerefs in fb_deferred_io_init() is not freed
on the error path. Fix it by calling fb_deferred_io_cleanup().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/hecubafb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hecubafb.c b/drivers/video/fbdev/hecubafb.c
index 3547d58a29cf..dd2af980f3d8 100644
--- a/drivers/video/fbdev/hecubafb.c
+++ b/drivers/video/fbdev/hecubafb.c
@@ -192,7 +192,9 @@ static int hecubafb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &hecubafb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_fbdefio;
 
 	retval = register_framebuffer(info);
 	if (retval < 0)
@@ -209,6 +211,8 @@ static int hecubafb_probe(struct platform_device *dev)
 
 	return 0;
 err_fbreg:
+	fb_deferred_io_cleanup(info);
+err_fbdefio:
 	framebuffer_release(info);
 err_fballoc:
 	vfree(videomemory);

-- 
2.43.0

