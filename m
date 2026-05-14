Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8B3D75A4
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747112; cv=none; b=dfZwqTr0VOL0YFda5pygFJcjEzvch1vLVhZtpKJzO1RbOphaz1dE+rpq5mmDvuIXRSCC4jzQKAFDXZWdkWgOkp3U8vkQazhLsOWsCRm/o5A6tzRDQ6G1PZCR06RlMjdOS9dw5URG//Er/8/iQhAqzWgiIU1D7NDqyoK9Eq2Sr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747112; c=relaxed/simple;
	bh=dZgpmxfLNwwdiD2CNYqlBA39ykctJlwlXlveZmO+QuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfywQ/lCAORw08aocEjs4vDR0yYKpWdlLzP9NaQhjQUReezQDvHlKkiMi4qMnIH6mySiy6eSAuypqvew4DH9HLOsPn6RMAE1T8TlU5KI/b3KEQMPGphzQtIeO4y3OTxuj5+XDHT6jWLe5UEfAuLxy1CFCfTtBaArGKbAMlQQ8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=bpD81+ur; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="bpD81+ur"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8173b2af32so5657883a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747110; x=1779351910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
        b=bpD81+urT8tGzlWXOLkwEyRjzcJDmonJiyLuddpCUYmRUbh/Ahg3UmGKUho1sh0A+4
         eqB8g1aDp5xAZcKkgF9RBAvYDJoTyy8nDjBNE2WAIlOA2fiB0n0nupwUr3jlYdy/beHZ
         Ax6tms5oK+XorZvCST8na+ycm/LELSDAcqhrX7KJaxYmQF1exF76x6RVZKHaioA+JFg+
         2L8SsxpUjK2wmvOi9l+T0P49L3P6WEVnoszJU2cK07UXpPWIkFn7gatX70b0P1by4eOT
         N6BoQNUXbpzfRvIgivOaxgCPcsxc5j6KkHOYRIVPoYbXuUB/urMZtejpqOH+V4cYSj1K
         C40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747110; x=1779351910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cETLUD+cFYpJj1ZB4GUnM/Wn7jURn1pWYkE3ZLuZekk=;
        b=F9JoPaAzI91o6TKcRryr7jrn+dLGDp21A/UzFkrWcZE2yDdKQLva5boXKTEKI+pzDo
         rOU2gK5iIys0Q2Ar5TrSglE+rEtSYfQv+cH5zbMWRosPg7d2Nw3fcnN9tTESXxmb+IC4
         LsU5MHGfWFa+Mma2bycWcXiBaq78bmJnUAv9tAs42ckON2Q+jZlIe2chG4jxJskLkxzd
         Pfr8CiZSizyEo78DqU/sj7I+WEdPXwucWsK0+Qe3nef1dUDh6czEfzW1DB2CTDxpRcDJ
         2M3AetqLCsSJuuYaxy+zyyK8eBYCUvlFpHOGR/0+KrPYnVXbCNA3AwPSsuEHeHMwwG3P
         RtBA==
X-Gm-Message-State: AOJu0YxxyENMVAsIaLtJxWWb2a+RIESFWIqVZlhNwGk5KjZ+sRnAYteZ
	CBJC0iAFGpgC6UNJVjsn2YiYZoyMpg0d/xRodJlwgeKlczBmRw4oObkJZUd+7yDNkME=
X-Gm-Gg: Acq92OGZvW5J9BJeVR8kiycblnA/mRU9Ygmxi55g9I8011PLXpEnKoXI9qXXieb4g4s
	ZYQRX009fgEoJtCwfJfCEbFoN6sGeiBb0DOYQIZwuV+xr2OngCwy/cAi74cCBWzbZYBx8+Dn8R5
	7pn/PcqjQT9/Ado5GvOkk4xtjLlqCRXvGp4DMkzwFvmJZO7qzimhQG72ngQKVkNwZGnpxpXsWSp
	a6pHRjWvnRLuQRlZR+4M6v8oT0m2gY/sHK21lEY+n8054LSkCo9ikIdYn1Iw2XFWEY5AhhQtau+
	x3yqOYGBUt9ZSHlEHP+Es7PsIkXXZgm1IJ3UiHPw4XWn8CtIcTi7Y/BP+eW71GvZaRUafHwF/eF
	QX7K2NdWWk+XlFckl+8bFMyO04n5HF89RXv6kOX81hn769RdtwO7te2xtrNBE17IMq3t2iK4LxH
	cbAQXrVXtEzdCt9PXxMvXxrFO/Dxb+5AGvD4i/crqICGPlS/pJeJDEl5On2yTHSkQkZRR9i+/rP
	AG9A/48qJZLm6Q9kYocwNJlRDbdXyew+5HCwypE0PSG
X-Received: by 2002:a05:6a21:4ec4:20b0:3b1:8cf6:8f79 with SMTP id adf61e73a8af0-3b18cf6979cmr603100637.44.1778747109771;
        Thu, 14 May 2026 01:25:09 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:09 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:32 +0530
Subject: [PATCH 03/14] fbdev: metronomefb: fix potential memory leak in
 metronomefb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-3-b3a2474fa720@cse.iitm.ac.in>
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
 drivers/video/fbdev/metronomefb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 6f0942c6e5f1..83c614963a0a 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -645,12 +645,14 @@ static int metronomefb_probe(struct platform_device *dev)
 	info->flags = FBINFO_VIRTFB;
 
 	info->fbdefio = &metronomefb_defio;
-	fb_deferred_io_init(info);
+	retval = fb_deferred_io_init(info);
+	if (retval)
+		goto err_free_irq;
 
 	retval = fb_alloc_cmap(&info->cmap, 8, 0);
 	if (retval < 0) {
 		dev_err(&dev->dev, "Failed to allocate colormap\n");
-		goto err_free_irq;
+		goto err_fbdefio;
 	}
 
 	/* set cmap */
@@ -673,6 +675,8 @@ static int metronomefb_probe(struct platform_device *dev)
 
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
+err_fbdefio:
+	fb_deferred_io_cleanup(info);
 err_free_irq:
 	board->cleanup(par);
 err_csum_table:

-- 
2.43.0

