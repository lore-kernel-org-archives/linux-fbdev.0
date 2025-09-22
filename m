Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF038303A31
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537402; cv=none; b=n1gIFdUh7AO3n/ytj985mM0tEH0fcz2W57QRmUGBxOVAaUX7E4OV7v1E21VFgRj2z3TFsQMHUbet690bBvpw5yo4buh5ctcuZdSX2egerWNNQcZmpiW4Ta1u5ku+ZygOcmWhVRrpucNaKOgDcI0mVgulq+zePHfWk+EOB59r8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537402; c=relaxed/simple;
	bh=RXgkduA9t/iaVUetjSaNFmeGS+3ycNLeNR6/iqQUeUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL0HDvTN+KFl9WvaiEjVvm6J7eiJ8o9C7jk9q2Okv7BNj7gWLj2wsjR6V8+bCOGoM+X8C6eROJl2QAK3RBAui0iOqCI0bqw3AiaVEagwh30+iXJcZ/q0ea7afhPCw2uaVRUuJfc8FztOf1R4OS4Ca9kp0HUevewvrXXr0y7EX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMB33dgp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMB33dgp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so3689481b3a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758537400; x=1759142200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4rjMybAXAfa9QQnXjs8aGz45/fsypTonY048qW3FBs=;
        b=KMB33dgpmNlqz7BVPEroDz5dLTVD3730hUo046jTKiVyM982ModaflF4GKDzUV8L9+
         AqjWmmlJWgvZ6lfFLe/6I73p8s10t9nkMRjVJ49TsA1xXF7QTBiXSnkbEbdyhWE+rSQH
         NcoXZ3Mf3CulqP6WHpRAwuqQIscgFYdHmpXkyCdS8tH2oFbFv07om8BUGSYKMftUQXQ+
         hOWWPdOij364Y2IqPfj5cWZYB6v98Qa/vYwqSGSOecPOR9zg/HsXRRTxD3Os/rz9DNzL
         dAB7GDSP5OVUm+CT8AS/HegC8rgBI9Z/dJzEm4fAKkt17yAkTrm8MQ3Gnqx+1Q5fpn6D
         ZZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537400; x=1759142200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4rjMybAXAfa9QQnXjs8aGz45/fsypTonY048qW3FBs=;
        b=A26dKIDdSO95juw53ARkf8abJf5WB8N1yx68j/hQ218d+dN0oKHh+Bll6m2eKomTSp
         xKXrg4oIPfXYLj6zQ82pP8ZmFj3tj21+duSSJnw7uv5jhavEa/r0cQIeSEIhnAbkVKLB
         lVKQuGOPIXG/XO3hazqDCBnZV8RRbPACN7IK7n0CagqGLXrnMIM7w/yoH48LoU/Hj2KG
         jQc/b8mfAA7OZtE2hJO7v5j6CZO8HPZqINHqi25tYHpJJ7W2PBwYDnF2xJMlUHVikaCi
         pqwrIxM9Dics/iwvkx1+uYLsM30zn6ImN3muQFvAlk//IlbKFEL6FNRBLw/RPpXTf3UE
         /Aqw==
X-Forwarded-Encrypted: i=1; AJvYcCUeoYaz6PlkmiVmY7FdL6hwKrzat5oca7N5CiJQFJNRk0ryxT3siz1/n+4Wi0++YnCZ3BonaZ6j+YnHZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMfqHUzwjWSHTEt1FSoGpHPyaPKbfcMsPsnFYFI6e+6W3pMz7
	3/Eo83sAcvqevArtkdj21neJfq/LjVN7uGRy7MZUH9spiUDESc626SHU
X-Gm-Gg: ASbGncsd2j0bW8bsq66HpkBGpw7b8oPd6UP29eaWbBC0unfwcRCmkZVaggFoAWcYFEx
	hkMbwUNm5xecGtiLMH/lsqpXCrksasQpingX2lX/oFQSnf03n2CjYixD3pRJl7NriyWuXbwhqU/
	UAuf+nEMpbKyvIqr67OIL2K2c/10fYRPZVYLzkBDUHgchYFAfShckeyyd5bAizz0NblQkxNhWDG
	Ji73HH6W0+1GFcPA4W9AVBI5s7p1N/S4mOr1TIwtYWmEHGmbfB/6JmxHsCpfpzbLYXAbhrYBKgg
	/wYHg4NRFNyRS4mAoVVHE90lYIsl+myWroZtELisRf4R3mLZbu2FnSj/j0LQTqINi1DkbtmB0pt
	+bi8Vxa+j+cQ4w8MhOc3OqQ==
X-Google-Smtp-Source: AGHT+IGx/AbAeHF8PEb0Q776W6z+sCUlCf72y7lCKvvsiZcqlsNVtOnkt+abaAy0lE0qaFDfobwBLA==
X-Received: by 2002:a05:6a21:e081:b0:248:86a1:a242 with SMTP id adf61e73a8af0-2920104846amr16819940637.4.1758537399897;
        Mon, 22 Sep 2025 03:36:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed27612b3sm15751320a91.22.2025.09.22.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:36:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4A87A423FA7F; Mon, 22 Sep 2025 17:36:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH v2 0/3] framebuffer docs toctree index refactoring
Date: Mon, 22 Sep 2025 17:36:13 +0700
Message-ID: <20250922103615.42925-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=bagasdotme@gmail.com; h=from:subject; bh=RXgkduA9t/iaVUetjSaNFmeGS+3ycNLeNR6/iqQUeUo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX1QJvvc6sv/jO0nqfj0DYtUu7tRW/7X70Km37Ao3pJ 2LZSxfwdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAis4sYGfb4Ctjv/7f6iW73 x8VKe54ssFz3ZU+RvmW++9oU7lMvrBQZGeYFbvq87d5V56gezZPWqSeFNr56/O5c3UIm2SlTH65 24GUHAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here is simple toctree refactoring for framebuffer documentation,
based on docs-next tree. Simple because it only splits the toctree
in patch [3/3] into two sections.

Enjoy!

Changes since v1 [1]:

  * Apply proofreading suggestions (Randy, [2/3])
  * Add review tags (Randy)

[1]: https://lore.kernel.org/linux-doc/20250919003640.14867-1-bagasdotme@gmail.com/

Bagas Sanjaya (3):
  Documentation: fb: ep93xx: Demote section headings
  Documentation: fb: Retitle driver docs
  Documentation: fb: Split toctree

 Documentation/fb/aty128fb.rst  |  8 ++--
 Documentation/fb/efifb.rst     |  6 +--
 Documentation/fb/ep93xx-fb.rst |  4 --
 Documentation/fb/gxfb.rst      |  8 ++--
 Documentation/fb/index.rst     | 80 +++++++++++++++++++---------------
 Documentation/fb/lxfb.rst      |  9 ++--
 Documentation/fb/matroxfb.rst  |  9 ++--
 Documentation/fb/pvr2fb.rst    |  6 +--
 Documentation/fb/sa1100fb.rst  |  9 ++--
 Documentation/fb/sisfb.rst     |  6 +--
 Documentation/fb/sm712fb.rst   |  6 +--
 Documentation/fb/tgafb.rst     |  6 +--
 Documentation/fb/udlfb.rst     |  6 +--
 Documentation/fb/vesafb.rst    |  6 +--
 14 files changed, 81 insertions(+), 88 deletions(-)


base-commit: 348011753d99b146c190aae262ee361d03cb0c5e
-- 
An old man doll... just what I always wanted! - Clara

