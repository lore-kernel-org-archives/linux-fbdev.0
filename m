Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404C25F7AE
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415497; cv=none; b=jkvcX7baSO3m02wEEk5WPXCdii7IFYoBfArpNKdeFZPmjLoZCRSuNwpanMlQLln/aDMVzFKk6gu15VUax1rs0B6RHgKmWvFGySwlETgIo7vJWfL+xhERJt1UYGQSML7gV3J99BG3xyCtdjGwsG/s4PVKZ8VxVivfCBLdq+DgkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415497; c=relaxed/simple;
	bh=g/vzD+cOWNqqj2T/TniSFBbEUCUdsEigkFpQHb857BU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qOUR3YNrUSZrUcdq/vn3nzAS95fDjDT7C5CQetxHqgqx6oq3q+ED8d87Lac+eCpE2t4m+hGlcVQQW7DjdurVxFHdJnA12I+M79Bjps+uV8FGflXt9R8xqmd9/HLbc8+7/9jzH4BBqMXqw6x/SPxZiqNRqvZs+zlRz3khAvxD0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=N/8NpJs9; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="N/8NpJs9"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb5ec407b1so282299166b.1
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 03:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750415494; x=1751020294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1muw2blYzxaHAsDZg3IXNPfcSbqmSvh2KRGWNScsj00=;
        b=N/8NpJs9dg3pyarbLXvUlulb9TyRFA4p5WKoT3XPptUWkRk+VIsT0rya51KAtFIiHd
         14+zus8p8k4Vnx1cwhHZQIjaH5yhIxK41rOR719hPjp5oVnsAgaHsSJWdGuv/hhXHMZl
         dUUDe0z2/9fHLpk8ATboBfOnM9O2cH7sbgW6bSd6ov/Sy52bt3Yv8c5qvcfve1UQYTHS
         PPkcALp99j4Av66Wh4ULIEW3M7ojVdPDvYDdXW0dlcedhrjxSW3Ey/4Mynkaz6lM7Fyn
         S+k1cd0bWeK53RtkJEcX+/7wR2XasPPNB4sVywcjZHv3mMiuUuBbbss0j+8BssX8CJ5X
         0T9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415494; x=1751020294;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1muw2blYzxaHAsDZg3IXNPfcSbqmSvh2KRGWNScsj00=;
        b=DFhNIiCaaQWCy4nzU1nSW13DnRL8EtwiNKwsNMr9eiHKx4Oc6+5CB93Z4MTyap0l2M
         TXXyc2s6qIcNzz0rYWPEIAap4sx/4g3R2ttIjQnsHNdp1a3cqZydbhN77hqyPw3Q/NPl
         jmOyBYrpDg2Qz0ukNt0Chc3xGqxuelW7oArny8cQOOYCxJ65qXXCkmENSxwTCqzPwY6n
         WwegbvJtci5t9aKT6LAMt9uxaOMQlAGPlg+nLQMqLoDTQVAfRieLhoPDmf9aLijXldDI
         yVgDa+eQXvt1ZpmAx7VOQsh3yHByKmGKOAhGIfSnDUKLDRf+ril2tFgX3Phs0wdFGuTm
         hIew==
X-Gm-Message-State: AOJu0YwX0ahKj4lho7ktQOfzqA23sU0fS7rBm1nt1z/c3VXrAwyZRPym
	oDKHjv0T2u89aoOc+IyJ2SXvrYY60IsN8Mwjizd+QO11UvrcaonXkXUqv0MXJs7G3lE=
X-Gm-Gg: ASbGncsaFX0MuA77jyHcmAqLvD5I1K/QWl6nqCvgtWo2fdgPQFifgoJWGhyEIGfYdWv
	H2mk9cA9cYjjRF1L+P5H9rnZk/PvrnJuC8lrz46T8k3J+RGumMAYX+k49bAO2Cyo2HymhiVdsv3
	+rfeObbcg0rtLdtFa66rfU97jtf74hMCjIqBoMJHp9iDTKEzTbl/AJuwRTvfjghACVLVQZkBMEX
	nr/3kf/jEZYErt3qWcmGFXrxkkoFiXV2mh4YUs7cwcNjDKQm5G5Aj+fVQMI6qNsaowCOy4LZVe8
	ZLuW+wSIFC1U12D1vdKW7mT3A7+uUQVtytmpm+lJUV0/Izqau3omzqU3fc4uzrYpwXi4+wIQOi/
	wfXU82xIoH19umbosuVuQmsLUYz4hswwJ
X-Google-Smtp-Source: AGHT+IHoDGaWZ5BrbMFRiOuhEj2IF/mLQzBgFpihvoZBrr7fr3ArCX7v7z9d95MM7gVJZXVieJjUCw==
X-Received: by 2002:a17:907:97cd:b0:adf:f8f4:2001 with SMTP id a640c23a62f3a-ae057bf6566mr224474466b.49.1750415493718;
        Fri, 20 Jun 2025 03:31:33 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6f5csm138047366b.122.2025.06.20.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:31:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Add interconnent support for simpledrm/simplefb
Date: Fri, 20 Jun 2025 12:31:24 +0200
Message-Id: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHw4VWgC/x3MTQqAIBBA4avErBtIS8uuEi3KxhroRxQikO6et
 PwW7yWIFJgi9EWCQDdHvs4MURZgt+lcCXnJBllJVWnRYuTD74RLONDNyNZiZxotrFLGiBpy5wM
 5fv7nML7vB1pWCE9jAAAA
X-Change-ID: 20250617-simple-drm-fb-icc-89461c559913
To: Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750415493; l=929;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=g/vzD+cOWNqqj2T/TniSFBbEUCUdsEigkFpQHb857BU=;
 b=9cYc3EXbQ33AMBFKnPLXHwMs1U5skgQNdQEyFJ2oPbg7cPoKkn78i6p8FdCpi4ycoC0PtPnwr
 xSeaoEOjEGfB4uj+AatP1PQpE65PFg2JOldcgkg62kv7/usFdeh7zaK
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Some devices might require keeping an interconnect path alive so that
the framebuffer continues working. Add support for that by setting the
bandwidth requirements appropriately for all provided interconnect
paths.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      dt-bindings: display: simple-framebuffer: Add interconnects property
      drm/sysfb: simpledrm: Add support for interconnect paths
      fbdev/simplefb: Add support for interconnect paths

 .../bindings/display/simple-framebuffer.yaml       |  3 +
 drivers/gpu/drm/sysfb/simpledrm.c                  | 83 ++++++++++++++++++++++
 drivers/video/fbdev/simplefb.c                     | 83 ++++++++++++++++++++++
 3 files changed, 169 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250617-simple-drm-fb-icc-89461c559913

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

