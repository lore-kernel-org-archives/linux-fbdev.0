Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C823F413B
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747157; cv=none; b=MeflYgq8HAUMeupLsKl6dVcICA+yJcNYsPisXlfHv7ScxhdxU49tUSmtRKCB4SyFONn9M2jRN3eHOVbkU/EF2c59SUh2Bw+72B9GOt53h+DDDmcWsE1ddUiTy8/P3VKHf9g2KliQDiX+B/t1E3I663Q+qxchW6GmwsWsYGtqA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747157; c=relaxed/simple;
	bh=+w65POPz1dgy2ppm++LcLkrxW0u0Q5eXVTqgxh2Ur5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nV4M8RpoFgeEcD4flkgHLgUr/7qnyIsF17q+IQergmmSCT5SQ8ZU+b7/yDHhjwjbqLebZ0CxEO99oMtJQeTVNgqueGWlwHhy3GaZPdSuZwOxpYzt4Q3iB3w/oNKGs8DXhhzsvQs3bJVJ2vEJ5DIyy+sNFoYbf2MuKjOB48Drxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=aJ7i7gWs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="aJ7i7gWs"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80148ae949so3399095a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747155; x=1779351955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
        b=aJ7i7gWs6k4dm+61wyPZwvwPLt1IPnRNPV55J3MEdeOdQzQETnosnYenYT94rhdRZw
         sYDRt0SXkPT8DJKm8dRgQQHIFvjH3MuAV7k5+HZjUuhL7gfiDACakvRxLkl8Nnz4WOoO
         Jgi/v1eOr7J+VY7nI6mT64Wb84/y3lFHIHqH27Oq5vhxXpe69vAXcJZlB/6EvkrmTQpN
         s3eGK09+7Yor1WvXUZVydNvyDNvf/D4dlT+pZtD6fJOIACoPImVWKaURXB5UTtNBR6rm
         WuLDIADzMGwltL9MDsEDTHrGbxMY2cp2DQ4HJNXhXbEvbxzKVCIAMQpp5wJmfCNslmqH
         T3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747155; x=1779351955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hMKbbNZvfD8+3yGZ0ruUDTcJofyUq6ZI9yURAX9o3WY=;
        b=myt8X92iN4lkTzcK3zaZv9UQv0N6sIezJN1nmiibDXPZo+94Pk+/WyMwyLKlGQqULH
         b3zLmLyE3S6wkHoL0xdurgKZS/Zvlut7k5OqQJF+13nKjltmSjgIONrjImPfh1IcmvU6
         FmiFElUcoooHbrQB6HC4kHDMQtSImiwO4Y4j5Sqkk4SgtwgVAmaJxxxiy+kfiRaaucpM
         9CJufP/6LoukTTj7g7zhABXsssfo8xwro9/CERyrsop+wsrInpg6EhqADD5SBI8LC49B
         DAq3TQKO6pzlly6/0yn22BWtlrE9n1qUqmZwwTV1TReeex+DsxNeJfDFapy4fy1Yg8Df
         BNIw==
X-Gm-Message-State: AOJu0YzaW0XeC42cHhW2y76+NRXJJ9cG++HaEwO7DJPN3qZ8nDYx1WqR
	9TzgMNg73IhQVzm1jz0OGKB2Ti6W0jcDm4m1lK7N2qXvPTX7D5AdSQpcBlG0HoI83IE=
X-Gm-Gg: Acq92OGwbcWP2qg/quq+xy6yRmmoYQ5w8qsJUqRo2JL9ahRuq/CsnqnFFsNXfEiQUwQ
	tejjjjhJoE3O7JY5R3kwv8d4ZRK8NSTGoy27n4HXLa+tZMoA3HG9gqIBYl2LPEAbUfgt+cjLQMo
	H5NXoAIHa93AHc59ko4JR2sdPiNr/aJa3Ak6GOnEtoCTlREykNf2BO8HHqhSDiPLWs6hOgMKnCC
	KP2yxQE2FhUXmu/Uaon3wzgwZb8PrO8wg9XMhBrQcrtwdjNFLR0F4aEiX3lmAdlLN6ajXuPoR1c
	Tjbk3p/mz9PT8UaZ9ftCE2+IFdj8rzFStaQqENEj8Rt5boWw3EmZTpsLNa1BWNa+k1nK1dKOMvj
	TJ6y8Ot7IjVT3aU6nmpNcq64w6FY+P6oVs3NZe/QmF0zKsLpUUw8T0NwQR3fxWOYhY7WZk7sgZo
	+vdqK+V20Qu+y0fjcLwwU94a5iIJvu2nVTQHvP3a6505JWoncmq4xSFj+b675xIHG4ZuYIF5mci
	1u5/ryGWCvqyF6aD2GVSD87TDbgnXneq664I2HBE7+n
X-Received: by 2002:a05:6a20:7fa4:b0:39f:2b9e:e472 with SMTP id adf61e73a8af0-3af7e835015mr8274496637.3.1778747155351;
        Thu, 14 May 2026 01:25:55 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:54 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:38 +0530
Subject: [PATCH 09/14] fbdev: tdfxfb: fix potential memory leak in
 tdfxfb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-9-b3a2474fa720@cse.iitm.ac.in>
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

In tdfxfb_probe(), the memory allocated for modelist using
fb_videomode_to_modelist() when CONFIG_FB_3DFX_I2C is defined, is not
freed in the subsequent error paths.
Fix that by calling fb_destroy_modelist().

Fixes: 215059d2421f ("tdfxfb: make use of DDC information about connected monitor")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/tdfxfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index a6b63c09b48f..cc6a074f3165 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1552,6 +1552,7 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_err_iobase:
 #ifdef CONFIG_FB_3DFX_I2C
+	fb_destroy_modelist(&info->modelist);
 	tdfxfb_delete_i2c_busses(default_par);
 #endif
 	arch_phys_wc_del(default_par->wc_cookie);

-- 
2.43.0

