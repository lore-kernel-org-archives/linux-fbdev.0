Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463552CCD3
	for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168169; cv=none; b=YLlFNS0plPwoekceDpknatE3sQquwzNnsXRIb7StSjgePYID75cVC9yQq4izGfbJHEif3PddapwlAJdI5UsulP+xqnf6YpgBaMl/kiR7+uUKusxJbaKpZNpopfW5ZCIEGgymzxeF8U8aWTIlhSKdm53tGZPYgCr/vg+3wYbuZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168169; c=relaxed/simple;
	bh=VhR0j1HKTwNSIioD4L3f7wFrhTcLCMcVT3/oUEbt/RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIsYy+3dNt6LLSAkKbV0Z/mmgoldoPVrbPzAbNMTo/cjk4Exf0KXPnOPfqy6pyHHydspf84c9LRaGczgvIWhddkh7UcQk4NT9xGOmTfxiK7k3ZEZDLVa6pacqCSUyFhVwDC715LpFs69uuOpuIo2jpLC3qpdYCh/5+dmFLBrwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5eqtnxs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5eqtnxs"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48de72fc832so19941f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Oct 2026 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168158; x=1792772958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOC0Tt4izqijGr6CwbYBXFuZxdub0c8E+AAfI2tlm98=;
        b=p5eqtnxsy2WWJjYnI5bNe8HKhdjapL/R314I6/DhwaAxxcff1cLEVu/zoGeV+RzA2a
         VXkek1gTB80X66WaVdQjL7FBc0Q/QgNHhOyXtDV1pSNFmwmJmD/JtBOrzEYQncNSwpgw
         BEms1VQH2qeW5kvARan9y1+YdEdkDxOeWTP8FyJ15Vh9zq+6qOLrgl0cSG+abUnkl/Xs
         Z15dSnMSryDYpCtn0YHPWacLeBodfE+7tSVr/4a/3MXcbF8qr8ozTJDGnkGri0iMdntj
         o5gMCklR+WuPjWmTw5+TOKlLKjDbqw9q61DQGhb1j9t/YynZFw76+p/U7qUAkJFQV4nH
         e0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168158; x=1792772958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOC0Tt4izqijGr6CwbYBXFuZxdub0c8E+AAfI2tlm98=;
        b=QubCniKaabBQ6nzvrc8amM5WQQHXUS9x61P140vDA0IXNxjYswfeaBn6HJXOg1oh0O
         FX8I5XyVbajXIhT1aBDm8WRG+neI/sLnIRmYhN06hUXh6Ak6MWsm7UyX7UpJD5tfpBWG
         MKIcMZZBiZhSorBDJu8ipr3qX7FoytZSaiSe6VrjsFdjzsEt+S9HyxPc171ZY7JAhQ0G
         VOJsghWHTlybC+uhfqcElGV58uW50RryVPlS7hUThPwOAPG5RTyQKudZQbLpoI4ahdGz
         LlEKB4DaKRqOLj6OOHcpJxCsnfhrfJx68wzcAa79064mp1gO0IqcpV+yYFdFwjouw9Fz
         flmQ==
X-Forwarded-Encrypted: i=1; AKwUvByjWJkl72WRYNG8jApXsd4Qd+vxhVoOQcZCVLIRkE/wIR+ojDYTPZzP/6fUEgTKwzJo1XeTyzaJImYEkw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKp8RsHDZ+8vXBJeNtJMUCzp6OTWC99nHc83RQyZAsA07Hqy+es
	IqwZpACBCIIuH61sZSxSfVnSSezOQoMmUmP8gATc411ZXOMlTRMOpisW
X-Gm-Gg: AYBFou0FOdUBBXEV5H6hDFV19dYM9rWACVuAEF+Ghm8fJ8UVjhLf9lDnfBhiuOgdTtf
	Jwp24MdjcKyITtYAlspePPNdEORaq9pjf1WSJRpyuYTsUUnjp3vIahQ/6R6Q1mjh2rKZzj5Aqg4
	vewoTG4PY70SgZry4tm6jyON6M9lbo9TQXxegI23FiZB/JxOO3NYpc4wuOffiEM+NFU7zu31MGs
	Ps/M5gKd3Zl/Kt087Qfd8vpGt+rI5YCnnU4r1vGrJPmWJnJnR9uu4Bt2yw+dEUrrFZDgC08Lrw4
	5NLBRSe14JAyqj54XXT0qAjLC/g+2AcDxtOz7NoZsEC9/EEGePz/LKwO0aSQ2FqjUjsEN2+y+DV
	WCYX8feh5RbRlugdrQK7uRVpjpbQl8WQPG6G9rZDVXEjcFUPQQo3xJqOlCbdXH9+sexLvllfTRq
	o+gr9v8ZOJzsekHkLiTzIQakcWlXZDEi1HVVQrGRY6nnNmDQE6u5Wa9LilOdF9ErdL2ilzzwDps
	Vzy+PWHjZclmdm0SzPsVe0lsqKBx1djSKjrdstu4xQkbUAJF51BwSj9BvKa4njUpv9T3+dMFuHC
	0Odg0b7NCV1R
X-Received: by 2002:a05:6000:260f:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-48e07988925mr282504f8f.8.1792168157866;
        Fri, 16 Oct 2026 09:29:17 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::103c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm9404317f8f.16.2026.10.16.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:29:17 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	pavel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 0/2] backlight: Add Awinic AW99703 driver
Date: Fri, 16 Oct 2026 18:29:10 +0200
Message-ID: <20261016162912.64581-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Awinic AW99703 is a high-efficiency 3-channel WLED driver with an
integrated boost converter and 11-bit brightness control over I2C,
optionally combined with a PWM input. It is used as an LCD backlight
driver in some mobile devices.

This series adds the devicetree binding and a driver for it.

Tested on the Nexphone by Nex Computers.

A board DTS using it will follow separately.

Luka Panio (2):
  dt-bindings: leds: backlight: Add Awinic AW99703 backlight
  backlight: Add Awinic AW99703 backlight driver

 .../leds/backlight/awinic,aw99703.yaml        | 131 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |  11 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/aw99703.c             | 583 ++++++++++++++++++
 5 files changed, 732 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
 create mode 100644 drivers/video/backlight/aw99703.c


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.55.0

