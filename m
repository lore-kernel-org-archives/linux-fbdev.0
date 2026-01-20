Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB74429803
	for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913445; cv=none; b=qCaVl+fpFdkAJSax4SPHIfZ4/GIoHLn4Z9Vvnr3+SV49RUPI8Qd+xIzsh1Ei0nR0ltHaUX3S21WB9yN7nBglQxbGy2FJ8bjg2S0bAm3ndB0Zku+tmO+rziLtfYIbNmD3+bxZgWNdjE5qvqR3hROipjFRomWGF6DeFjIgxy8BrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913445; c=relaxed/simple;
	bh=6sMqGXnBsWs7Qtna1yPZgI8g0wHllWWzrqehilIX0J4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sYMrrIpievmI+9LHYrd0iO51AeWQ7nryzH9gUdSta/V0F4W3rDtmJbref5Q3f2zAG2npfMSH6clKe02WmLJjKzOjSGI7jHzq1j+D+NiuAYGixhGIVHI4pHO8Wtm4l1p4hpgvMb6M8hNCHlVnH44bC7i8ZEt/KTP7oIgh7PeViDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYfjS2yy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYfjS2yy"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d6f647e2so52167375ad.1
        for <linux-fbdev@vger.kernel.org>; Tue, 20 Jan 2026 04:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913444; x=1769518244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJYUWQwQhgkeAbC/dM1w7lsNUkVncAvp21VUFc05s9E=;
        b=MYfjS2yyNT3EgyCloriC6EOaPE4vKXLkAjxfqTCmte2Ls/zCzZKJk9p90e7f1LquGL
         f2bCEOyOGziLUZuP8Dy7yBoTSV1DQ4AHNrPu5hkd7AeEhpDENNwKS+K8RXQctTUIg32v
         dKc+0oVX9MIM3ArcRR/EUH62OLEH3Q6H4r0mSJc36usfYJ06Mq6vKbMQUabZA4vrEU/j
         FqJ90OACA9cE/BAAwXL7d9LXUMBbJYl8W2tD2N9GagMb87LZWFPBgHGRyD0m/dd0/yaK
         eOl505ERFcC1/eT1VJ0GNBU/wU7TVP4mksc0q3lfd9cBRcG/ste7VDnx68psnBamMbg6
         7SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913444; x=1769518244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJYUWQwQhgkeAbC/dM1w7lsNUkVncAvp21VUFc05s9E=;
        b=wEHks2EctgkdmrXaAvQjqbBXdjOPVxtg74Fm/IlhRXEc+xpHeZdnOKs97i8NN595R3
         s2qPn3GEePDxOIbGabskftuW8x74b1yIuKCyBaBDMIZ5SzogF346S+JvFlPrw87LjcO9
         myktiJwZJtn/O+Dtul7pyLoi2/S54Lt2C95A1b+xnYq4qQUIJmp5OGVyFez4F9fibtXo
         o8FvQhRBdtL/c2CY14ioj+crffdnzMJcPruKZSo3MNmXtLJH7fa1HGs6T8PRUgwaf2gy
         Fk9osp3uIT4V/msH87alDI2CHw37MBGZxHaKgddLUZXs083NlQJDi/6f9mfMk5SoF5Ig
         kjcA==
X-Forwarded-Encrypted: i=1; AJvYcCXZVMjIGNv0PvMosmroZrjQvihYzQ3/NRrq6AxIOam2O7HCSoSsLg34M2IzP56beTUQIJYtNvxOQUESIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOl1fgon8Z/AboYVWliP2fKb9xkIY8D6LVu3glZkdvgUVzyXQq
	Rm2tjyN94J7zy0jdFz68sCN6S1ETDS9Y8jowdhQxlYrOZqIRgok7eAN2
X-Gm-Gg: AZuq6aKk9VWHq0DEmQowmvxUX9nUoX+COSAMTdgPGjABoN86abthLEz92z9h0+hL1cB
	vAHAeWd+FRT/hLP9Bfkg3QaMGJCbsqGYiB5FrGVOgf2F8kIwiA1u041vySrEHLpaLUf2uZIXkT2
	XidS613ggVVIYTqVCatY3hkHWnIRswFkDUHoPxCvp0FuuWd6DSRSrgLhwOyjpFqW5tvjt3HI+3M
	X/cbN40RVks2BJII9M0Wy2WBYh5YIitCRfJht6JSNHQ/71awPGgk8ysEiiwis5E00KF9eEqAoUn
	2AkYxvXBdw5qZHPa+lgjpNW/msxfNJAQMEsr6a/9GTDabq7JKTKoZ5/oCe35so11kEJo6s2WIWO
	4lnd+r0TyRzMq7/suEaLoKcmb1Nxkf0cTigDgivgym2VaT1MixxOU6Z97/+x4Oi5i7Gs2GWlylA
	38+wZdyBbB7oqivC0DfXpW3BVa9jMHap1AqYSY
X-Received: by 2002:a17:903:1447:b0:298:2afa:796d with SMTP id d9443c01a7336-2a76b26ccd2mr17322155ad.61.1768913443613;
        Tue, 20 Jan 2026 04:50:43 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd582sm124973815ad.52.2026.01.20.04.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 04:50:43 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: deller@gmx.de,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v2 0/2] backlight: gpio: add support for multiple GPIOs for backlight control
Date: Tue, 20 Jan 2026 18:20:34 +0530
Message-Id: <20260120125036.2203995-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch extends the gpio-backlight driver and its Device Tree
bindings to support multiple GPIOs for controlling a single
backlight device.

Some panels require more than one GPIO to enable or disable the
backlight, and previously the driver only supported a single GPIO.
With this change:
 - The driver now handles an array of GPIOs and updates all of them
   based on brightness state.
 - The Device Tree binding has been updated to allow specifying one
   or more GPIOs for a gpio-backlight node.

This approach avoids describing multiple backlight devices in DT for a
single panel.

Changes in v2:
 - Used devm_gpiod_get_array() and struct gpio_descs
 - Replaced per-index GPIO handling with descriptor array access
 - Moved the bitmap allocation to probe using devm_kcalloc().
 - Updated commit messages.

Thanks,
Anusha

Sudarshan Shetty (2):
  dt-bindings: backlight: gpio-backlight: allow multiple GPIOs
  backlight: gpio: add support for multiple GPIOs for backlight control

 .../leds/backlight/gpio-backlight.yaml        | 24 ++++++-
 drivers/video/backlight/gpio_backlight.c      | 66 +++++++++++++------
 2 files changed, 67 insertions(+), 23 deletions(-)

-- 
2.34.1

