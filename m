Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DF21420F
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Mar 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012805; cv=none; b=WqVca0DAkWZlfP2d0rc5vS7u5LLq+1F5Iy3JRJjXbddjewvLpsf/NWVPGpM3FeybNRdCq4+BD0yHcC9RTRFK4CGHe4JjhR4FwWf3BEy6Sx2q906b2ux2drPxBuGygSgFMbupSl8IIkfE0zpGix3HBuizQ0vGX9Yu9FYE5I1n4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012805; c=relaxed/simple;
	bh=huTITU+3NLOlGIQKUO1Q57DNwMMY/Xb18Ro9MUcuAZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oSyo91ebKXTfmxTsBm0jzGFEl/AV98tU0QQ0L6kKOOm4c2yG+TijSai5M7ykdCSbz0KjjJLq4PbDQdG2weVyoInq1Ziw2tDIAa4bgCbgiIlKnP2uRAv1MKG3JxCkwDHp0FvtdQLv0atdcMl2ELQ6VROj37elJuYS2AZEKvRQ43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTJX1luz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTJX1luz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390eb7c1024so2512746f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Mar 2025 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741012800; x=1741617600; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=dTJX1luzeTmtWi+dFz9agN48SvJXrKpiLJhBzXIU4vnMm/QGn9sE1ebGiC2PWA4Vm7
         W+byrAciKvEzUmYrnNZnVTvhN8H0i6Enllf4Um9v5AnDxpbSnnqJEth9ze/KBUntGs7y
         ZeNQENI8t1kg3TiO/bQgBZDoFe/B66F2AwEy9TOEF3e5i99vVIrwmxG2ZWmkyM3zr1na
         Ir69Z7r3ylWpWVLJXEzraoDHnMiWiY0ok8UdcNDiQk8wkB8qGfLWqaulKvAtqX6zxxPU
         nI4N+p0rNJD6T1fInxNHi9IzyP6T5nR1r1P8GgqRZ/N3dlcBrJg93oKDT6vxow5Rif2w
         xgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012800; x=1741617600;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCvz2PQitaL3G15KvIJkAOr8tNO1gvVwjPom0Ibxufk=;
        b=HXwj6/VjhIWHK1E1kbq4SUG5y3FN4aFHo31ohK0Putu+lSCg/aANl5DjIaPbAXAEfU
         kbgNUBjpqpBBgvAo/rj/0dGQBKcqa8iJLEEMJe3X6ce40iloWr+N5dLhcP6Eto5ewoEd
         sog517F5Oi1yN1gW9cYBRiv5r6DLKInEvb+ZBAUwNPRSJ7BNUw/kOvYG+R10M3Ge8Fqx
         7hZK8SZhG6lwftOHbUbFXD3NuJNQck0mFEu9oOctO13r4HvULQVbjHMS2xk8Pyb67Pd0
         E2/f9GuS0HALjs2CFx6AykufFBNyIh8v21eHGzJUEb87x+U7ET+2FdwvqfnbBxipUp/L
         HreQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM9uG0mFnuiM6inSTePhhTAEFsuJLPAo26I5BD0rys54Y5vlzBtCM22+QmSC9GPPBnnDATtquvvBE6iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpm3xXyrmtjbzPHjz5cv0Vg4tR/yqX/XlEfP7W4QE59rHriTDp
	WkZsqZ8Ar5aMMTg4VlivftDjOGyCsBNPAtd6E/Ix+v87YR5Rj04qK7CNs62kUaQ=
X-Gm-Gg: ASbGncvn6x+MZaTQBR7cm6tgSUI3RgeHw7tA4G16/XyrAXYJltCR0+kWFtOqtBx1V+R
	UfIid47t7cSPlGVMo8VGvvjVe0Zb4mDFK1RPLjru0L/Z9FQqX/OAPS1C00m9tsi+GtcrXjrTPN1
	cuf1BiW7jztGtGAf3iUeEb2mDCfAj54jzP7XyfQqYyfXSywnE5vwOR+nfLQwcCNmt69sEJufEZ7
	vohx8BFx3u88zYOFoXW6DbUIK7bidXPsz2DmBR1bJ031/MhW3tpkCMgn944wh5RyOlJdd/4GViD
	m4j+j3A1FU7Wd0I3b7DoyJs9V+3a1vmOKt9/WB5D8vZw0WzWsIIlbpEavTVbCNwFYUgEXCI8m6Y
	tFbTGWWHjkwx6RoLlgiN2fwugzTHo
X-Google-Smtp-Source: AGHT+IFGoay4YJM6YSXz0DZ05o3quafyCNLOWh8vQu4Eq4apk6qCX8ogXLL13gs5Zle+ply0NrLrLg==
X-Received: by 2002:a05:6000:1f8b:b0:391:ccf:2d1b with SMTP id ffacd0b85a97d-3910ccf2dcdmr2532910f8f.49.1741012800564;
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
Received: from [127.0.1.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm14394801f8f.49.2025.03.03.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:40:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Mar 2025 14:39:57 +0000
Subject: [PATCH] MAINTAINERS: remove adi,ad7606.yaml from SEPS525
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-v1-1-a4e4f1b824ab@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADy/xWcC/x2OywrDIBAAfyXsuQs20Qj9ldKD0bVd8BHWEFJC/
 r3SwxzmNHNCI2Fq8BhOENq5cS1d7rcB/MeVNyGH7jCq0ahJTZgdl61D0lAo153QBe7YWc34dTl
 hlJqx0drMaDD5gL6WTWpKJLhYG7TXSzTaQY+sQpGP/8DzdV0/McmlB5AAAAA=
X-Change-ID: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a
To: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Remove Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml from
STAGING - SEPS525 LCD CONTROLLER DRIVERS. This was likley a copy/paste
mistake. There is no bindings file for SEPS525 since it is only in
staging.

The removed file matches Documentation/devicetree/bindings/iio/*/adi,*
under ANALOG DEVICES INC IIO DRIVERS already so wasn't just misplaced.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This falls under FBTFT which is currently orphaned, so someone else will
have to volunteer to pick this up.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0e33544fa373a4978b7dae18c040c..215dbaeedced8473b5b339329b3596a2fbfd13b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22512,7 +22512,6 @@ STAGING - SEPS525 LCD CONTROLLER DRIVERS
 M:	Michael Hennerich <michael.hennerich@analog.com>
 L:	linux-fbdev@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 F:	drivers/staging/fbtft/fb_seps525.c
 
 STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

