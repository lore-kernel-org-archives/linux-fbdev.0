Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73535E529
	for <linux-fbdev@vger.kernel.org>; Fri, 17 Apr 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421077; cv=none; b=YieK2JrbbPg+ravgwxRGuhSRwwmPoQgvg6gfnoOB+FFwPsBtxDRBRoH4WokPYsUsVzIYmGNfo6/fLRKNQtf374zOofmpaYllANtDc+tzUIahH37TiALU8ssDxvssojXQDB1ssz+PmxrBDWcJ7XV9WDQtVORGOAb0Pja8H4pxZig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421077; c=relaxed/simple;
	bh=wcBO9jGFdwwVPdrukUVB7ZxstBGjl7lPflRRPr6TIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILfCJj6Z1IpYiOSqCAnrjR2kGTMwvUppcmaEKz6eu7MGQsuTINEPgRJqMJI4i3FddonJmfjXH/iTJv+SjkO2PctvxH7tx55VysWmzmw806nX6tF645u4802Bv9pEcgaBPd/uw6OSG31bdcnL+D0QeGfzDZpeN2OMPiwLgjzEvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcS63PaA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcS63PaA"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so325552a91.0
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Apr 2026 03:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421073; x=1777025873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iE4usfHbukw4GyIkJMsnZ0QQYr3hxZC7HTo6J/YluM=;
        b=rcS63PaAl5wycejXH+F6YrzXazRcRMH+M5s2bUz0ainSF61LY7nebkfHVWqJCbI1jL
         kDaGgpTUq1z6JZy04NFt31hcEgxFUdnIudChvsrFjXcJOwex6RK+R9/xPWgxXpT4Dntr
         o7ZorjjAw+q5lGekA1cM3vyIdv3Az8NTTgGeGS+GHeiGbonr+pfEjc9i2AKQrGSxgL2J
         Dmsk0ya0JYV0OfkZ6kN0685ZFkjC946MNhFKPewWbAhiO7HRiPAcdXuNlHMVLxZJGDgj
         ooMMBWdH/tpsKTi3KcxcX4mLDfrEsnQnFt4HuiIEs1/xbQu+15QfCQC9URShk1KZ7Xaz
         6FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421073; x=1777025873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iE4usfHbukw4GyIkJMsnZ0QQYr3hxZC7HTo6J/YluM=;
        b=PUh806r2ua4n2RK+CkNF21EosHzghD7valRSnLO8gzo92yhWF3rUawOoSj+e9YovFb
         k4xWWkIppHA4aRXbduqAH7yq8mwO69nr3h6MsC8wQeP7F2SfNOa8SLIM0SI3WEk6dnG6
         DKufLtOYNjKtY3QBll03105GsYIN9uaUtOfjggN5mmnBVk1sPZjlQH0eVAt5nW7Ajy1I
         KI4CUEGnUXtDXDdOR1X4i8fveVvcbY2pj2nVBe/7FwlApq6BmeT9iYT8fWmM898kGDlw
         gk+pqhuywqTl94Z+LkghTYA6fgG+pjBQLWkP8zOQmBSpaLYmARcsRF8AX8upcJ9oxwJL
         VoUw==
X-Forwarded-Encrypted: i=1; AFNElJ/jRF/MoQNZx5HhmkvbL60lgH/YeJXtSUh21nL0wguNJ+XU0YeHuVsY2j0+otMpnIgxPCRYu7Lq6EvSVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8as0mQwFhKJeCX7NlL+RnKPOYPOEgh/P4IhF3rn66ujwA69y
	Dh74bF4gYxHSJRO2RA3wopJ9Frsco01F1hmT+dW2uDsKpoyCt8bAaEyI
X-Gm-Gg: AeBDiesCGOtlVHNgdOfhBJjnLsgdXvprzG7rpnnPXoafps28041Df9BatbYwqa+MK3Y
	KnxnvpuLjDxmBqniTbTEHsNM9fWbJeE465TdmftFdQIGI/3dkEdBH2yv/IrnfHWTKIvvlFzZ5m2
	O3WFQOV1f2XNb74U8yHe3SLWc5mzCHdCEOhjzxNgUr8sa8hcYX3oJEAkhqezqo5paNAG83hUs0u
	mpVn76U4yBTYVL/X2zku5Yb/5KHQGV9OQhpp+vZI9H3EQjb+tx9C+U40fNDiQp3pUToIxEP/QKd
	LPyXPPseLqPpCTnJWaG22vC3JuOlBJF7JhNxFiRXiF8ygS76sFTNpLDY4xau3IrFY5UkP9iYLAx
	NlL4WS9uwM86sIrYY8MYJCS1/3Z+xiL/gckUywdc7n+f/TrKb22e04ndJ0Rko4s5WaaDimhGxUW
	Uevr/mypYYLDjueMfF5GTlaV+qapDs
X-Received: by 2002:a17:90b:4a09:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-36140490614mr2164284a91.20.1776421073015;
        Fri, 17 Apr 2026 03:17:53 -0700 (PDT)
Received: from fedora ([157.20.226.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f370sm1280728a12.7.2026.04.17.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:17:52 -0700 (PDT)
From: Prasaanth <prasaanth2k@gmail.com>
To: linux-staging@lists.linux.dev
Cc: andy@kernel.org,
	gregkh@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prasaanth <prasaanth2k@gmail.com>
Subject: [PATCH] staging: fbtft: fb_tinylcd: fix alignment in write_reg call
Date: Fri, 17 Apr 2026 15:44:57 +0530
Message-ID: <20260417101457.7599-1-prasaanth2k@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix alignment of multiline arguments in write_reg() call to
match kernel coding style

Reported by checkpatch.pl

Signed-off-by: Prasaanth <prasaanth2k@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2..60cda57bc 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	udelay(250);
-- 
2.53.0

