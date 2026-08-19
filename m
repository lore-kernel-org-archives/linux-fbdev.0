Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BF3BE647
	for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178536; cv=none; b=tPAm8fW/T5CxbFSB6+3kaT0c2kOn4vai9/2EJTBYZRRRLeC+nzjNZTDGBDsRmScUbSoUVftJJdstLgXzngyDoIu3mDiFMNy797damAnPYO+1TtWVfWEo49qAcvyFnBgclrmijTzS3MslVPj+J90iW3oEoJBR5k2pjbOmIWJnwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178536; c=relaxed/simple;
	bh=zY+gW1lXxfK7kqtIXgYpm9NhsrQnedavPShq5FhgfcE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OWm0/iTKgxHWicHjjuWkddkfK2LshhgtMr5ZhW6YTANT6dx5/qHNmHNELSOdJIDi8CHntCjxBWllFkinhbiJvFC5YyOrzjJm2tvd5Qc3P0ZPeQpsKBSzLR0wJQKt4MuWM0x28lDPPo0M7C2LRX5h2W/NDsGXha7pkdh2IlIux+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoqZQC7A; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoqZQC7A"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf27856f9cso14929305ad.2
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Aug 2026 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178534; x=1787783334; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyf8P0B/y8zIH+Mmhiq8iXp175Fg2OnIXEWNkWxUosA=;
        b=NoqZQC7AN1VOjGunB+DXvheM2lqStZmscomDxYqCca5uAOn3sQy9GYy70XVGN0WQgv
         g0C5Et8CurQoWg//zBfQIyKl9HHPGiCzUxpgfqR7NdOHFdYJiwdf50AZkS1HezglKxpr
         yoeONI+oZX3ItzLCtf3ccQmECX9JcXT8r033Ud+5bWUQm4iC2+4+oc6uejWQDHqP5Ugs
         Y4Tv4Pt7R8q2GXGOH8fxBc8YNgdvRl8qKF0TALeGvikgniRq08pX6KXrDjRyKw38mJPw
         5P+3vNtwyXaEAZTCFaTQFXPHXEOzOiAPO8ehGJbGT8GtJFlwujbvmOL71Zc/qszBUdGk
         VWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178534; x=1787783334;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yyf8P0B/y8zIH+Mmhiq8iXp175Fg2OnIXEWNkWxUosA=;
        b=oZkL86S+XlU3TDQyCxOornLBBezkcaTXgRhB02Ihb8y9rdkcgB+eWqZZEFjjcpcxxP
         ym38pkY2RYhCtvG//Oskn4Rc6ekvVJfJxCybZseNvJ9IKuagMDD8qVbCFsOSVyVsRkE2
         hhKy40RyD4gST8ynFZBdJJU4NP/NIk74Z2CmeceMMxynXb3FMvqufjDkgvsZTHBeiG2G
         ZVKZElIDT7NmIrnN2At7VENEa+Jeks7RhvIUEKlp0LsN6FmL5w8sL8bV4guGT5tJ/7rN
         pRiHKOnF4IEmHO4OhPfDxTrVbV36S9S8TjHWJgEkm7NxxVtZcjMvI+7TFjY17vLC+lIo
         olrA==
X-Forwarded-Encrypted: i=1; AHgh+RqYo24ww+JK6RxzUVZ62LWdhNZubtww0Cwqx7bo8mgHK7erRQygYea2pzEOGwKp4CHA9OgCMNLerbyiRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k1yx2bfmtu0d4EmmEG87c/DTN4dDyQpt4voslpEB6hlfW9ysd/
	xTFypkmYI0dcqFONXDyYi4oBVW+LEZWOs5s+no9tiicmzdKn0JumhhF+
X-Gm-Gg: AR+sD10bI9Gbfx9lmJc5uJ2YI0LkrYo3K6HmrCCL8wJlTGs4kubJbuN7Ag8W7wGy/lg
	hqeP2J3ElrHL+FzGkgkRFol5Wdi0Ig7oIGDByqPbee6bqvL4nL18AfpJPmY6cEsSDBAt4tHayxk
	VC6akIrkETMrymUhfcO5l1uWXHfUjYco+ihf9WOYveRsQgsepXZ/auLZA0ebPs34JCj4qBlsPn4
	TqDTQ9zjn+4qctak8JenG7dAl2atATvpnkk/Lun8YtQTmkmMNThf+UXJ0tD5jQrYs19igiMWWDL
	Ul5gIY/HITpHvr7dTzE3Z3pfF5KdveM/TyGohXO492lsK1+XN/mQ51h0Lc2NmCWQQjEXRC4G1Qj
	EsiYeE4q4OVzlJfMr8u4+9pF0oUeJhE9RHC33dxDSZUl+FzGCTCHLtWZ8TkeH3+XtpwK2MLGVVV
	194fLyfuFHuRaiCLbcx7en1pKKBh0h2/lJa9uz4G3LKc6crFqDLUtdY+UwU4+3YEsN8yrkgWx4Z
	siEJnjLKyarzHuA48qI4Fd0J3KPOrbDqW3qvOlBm9eeqFlsPw==
X-Received: by 2002:a17:90b:5624:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-39580a7c3dbmr15590880a91.6.1787178533810;
        Wed, 19 Aug 2026 15:28:53 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad564bcsm10629116c88.5.2026.08.19.15.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:28:53 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 810D436035C; Thu, 20 Aug 2026 10:28:48 +1200 (NZST)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org,
	geert@linux-m68k.org
Cc: schmitzmic@gmail.com,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 0/5] m68k SuperVidel patches
Date: Thu, 20 Aug 2026 10:28:33 +1200
Message-Id: <20260819222838.21256-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

Version 3 of Miro Kropacek's patches for Atari SuperVidel.

Patch 1 is a bugfix for the Atari mouse input device driver
(miscompiled since v6.2 with use of -funsigned_char). Geert's
suggestion to change the mouse interrupt function signature
adopted (generates equivalent code as seen by inspection and
testing on my 030 Falcon).

Patches 2-4 are fbdev hardware support patches for the SuperVidel
blitter hardware. Patch 2 has been replaced by a version addressing
the root cause of the missing parent device (i.e. atafb failing
to use framebuffer_alloc()). Patches 3 and 4 have been updated
to reflect changes introduced by patch 2.

Patch 5 is adding support to make use of the ethoc hardware also
in the SuperVidel. Platform device register error handling (reported
by Geert) hopefully fixed.

Cheers,

   Michael

Cc: Helge Deller <deller@gmx.de>
Cc: <linux-fbdev@vger.kernel.org>GIT: [PATCH v3 1/5] m68k: Fix atari mouse movement

