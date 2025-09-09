Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E41226CE0;
	Tue,  9 Sep 2025 07:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403795; cv=none; b=Z2yT+Mx/lRw8BB7NbWkepQBUZz+r4k2wnAfmEQcKsV25pJkpiKFrAoBaE3nP4WnTF/YMWz0xpPdCjWvd8LMmy4hOKhUxKe2orE4Oc+BG+4luUYxpkVpVVukk68md8Qoh70uqXYpI1RdkdO6hpqzvX1CW/cKwTh01eSD3ONrRjPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403795; c=relaxed/simple;
	bh=MoBoy2Gb1tb80bW4UxX7KW1FZCE8VWM+01Z2j/qLdmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwvFoLbOora+l2OgDGoGXZQqwxm8tI2YaB/x3yOsG0rFwoIMVDNu1zjUfpjuV+n3tWvmQ1hkBLJ5HoDnyQqJf/A7nwLcrbfduM/GzvagLcVDVtBgkOQLu9UvAj2OTcpuwWH6AKppYaV6+uJAMn1MoFYpoYT6x/9oa5GJrsDyOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmI0jEZ/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmI0jEZ/"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-560888dc903so3228899e87.2;
        Tue, 09 Sep 2025 00:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403792; x=1758008592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6ceq16OHTEiiK/PjlkFm8FKdw71IR8b/dY6PTnCU7s=;
        b=dmI0jEZ/q3gYaYdG0zyT6y9WyQhDZ7cPD6cd7ve5Dj1kE371wPXU4hxqttPlb/aEKz
         TZmQf98yg9b9p6tq3bNnyWQxrZwQfdOPdbSPEILdrBay0Yj4y1vunAbOaDIyDQ70aZev
         po3D8uKnKLDIqUegw6Xy3UzJKBKiTsKymV7p0PXx5L0Zz5iSHcqF2Cw+9d+tDkkWLQkq
         7c4Ug2XrOwPfQwOanl0eez4DfcQEu1CkNgb0uDFrgePSD8JDOVk54/fhY+tOkai3LfD+
         7V33CtoaTguvARZI5Q/e8/ZKVLeYfG6/sb4Jux83qXrQIe1Pu8OO6lePit+fnDzT36NF
         P+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403792; x=1758008592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6ceq16OHTEiiK/PjlkFm8FKdw71IR8b/dY6PTnCU7s=;
        b=LNtE0gk9TqnwQZxe1UFKSOTCV42HK1RiYy+IGVlH2rF6qDGDIZrXIFtCCvV070gcCz
         s9Z4IvSWl4fl3nsVKOX33KOPuyMyNX/580C8UGl8ax/vHqjOsYFPl0rzzAAe7AvalT/k
         rREnOKX/sSjgn11F6tL1gZP4HJp4yUB3ivPF0sEOQ9J7PiKwMjigaNKWMgYqjUDwoZ3S
         H1yi1d1tu7zJnMzLaVNRTp2r4A/qpiYBzx1NLwGD6KR7iqH7gjaKaZpss6E7OcgWdLX8
         krneNN+4SaDaTTtgvgG2wim/1MhpF6zs3N+Rya7Z58CGYwVuHn/ZN7m8vNn7SfxjFyj3
         nE7w==
X-Forwarded-Encrypted: i=1; AJvYcCUjMpDlwgdVHKp1eR5vWx6tAfn7ZAFerpINYs1mlMSg++sweUPxwP9MjHHSd/udNaHx0yekv0qJQmYrdOq6@vger.kernel.org, AJvYcCWdQjsyac5l5z+J6QFkacEIifuVgx52bPkZzCWi8nzaVw98uCBFMZHL9NDej4mq6VrERTokMjg0fANV+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/hN/PKr9IkRWqe/SUFJKZTNPojUHZSIymVKymsqBwkiUn9ZM
	bYX9YwdbCwgDUaUBLIHzdggacX3/QURr9vDDCneNBSirFCqlizKwiTMU
X-Gm-Gg: ASbGncsMuMZ8X6B6nFRnTwMzE2wC/7ba/lanoGNB6lCUiFC+f+uuB58zpO5YTlN3fTl
	fe1EgiUuELW+8I3CJ5mrvFVrv4+u0nX4366yyaqcqI1aYSw7SyLmnCvRCXYXXVXffFAcsQzZPzG
	yljOabv/UAg5uy971YW4wZEE71d7NI99RdNIDCkkoQPozxy/llkT8IzLmDsblxh6tGogpFPZBRx
	Etopa6obPOC1nTLglMgHcUGcoyGfXeGgBtlACsbMyYaauhUKk7tZDYlYb9HZR1S5ne3MYQjokqt
	GH6BAs98RBMWLfqepqGrTMvQmzVIz4kFppFiIDFv0ePmeFy75cTAJQ4qbMu2BkwQe7qUv60nTNY
	42b2TWaWx69sAHshHbgpuWAun
X-Google-Smtp-Source: AGHT+IFRi8AmkKYGEhg38SBSKdEs7PaUtZBlmSb8cC+BpN+GQNvSNoh0wZG/sjIP4r8/trgOcysyLg==
X-Received: by 2002:a05:6512:b8f:b0:55f:71d2:e5be with SMTP id 2adb3069b0e04-56264821195mr3031702e87.52.1757403791713;
        Tue, 09 Sep 2025 00:43:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d633sm333731e87.68.2025.09.09.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:43:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] video: backlight: lp855x_bl: set correct eprom start for LP8556
Date: Tue,  9 Sep 2025 10:43:03 +0300
Message-ID: <20250909074304.92135-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to datasheet LP8556s eprom region starts at 0x98, not 0xA0.
Adjust start value in the driver accordingly.

Svyatoslav Ryhel (1):
  video: backlight: lp855x_bl: set correct eprom start for LP8556

 drivers/video/backlight/lp855x_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.48.1

