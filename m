Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D23019BD
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537399; cv=none; b=Jc+i6AqNZrfgQh3daVoQpAlLvxQ3RQovpbE5hb72CcSjx7Z2frFHYfLdb18HTRlx/5uwgFzYUGcwGtGqVEfomEXPfp7VwtUsAxhlaVAN8nvzDw6njl0hCflST+FW1yVgxv6q0VQomLfdKlIEGr5oNE+vYbBA0t3hrZG6lUZzUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537399; c=relaxed/simple;
	bh=0YwIDNcM8Gu6DduxYzaPysxCd6Y3vQAF9cqA61KQ8WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx8h8EkgyWg0y/e+rUafauJGDJX6PwvupDXlLJjYJikWz/IXUv+v1fnH414Pvj11fF05xrWZyVgvzc9hgDkrPesIpZVMFHUd4NVrXXo4hCq3YZI0BZXo4F93k4vChva/wRgVcslWLOovxKFKPbFJrvwfgPUmKK82Z+Hixdni7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ8dhDOa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ8dhDOa"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77d94c6562fso4110907b3a.2
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Sep 2025 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758537397; x=1759142197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+9n632otRhZijt2C+vVcISfhaawIfWAEGIOaCRnvcg=;
        b=mZ8dhDOaq22B8poapwaBJm5HHg4Th5d5mTW5fUJYZvW9bOj91V1kPBuLJmY1UpkxVW
         ZqhFO7cKnNEZm3lmB7DbFqo9IPIDM5jcukPm452Z1PFYu7DrZPpjcpeLFA3cFfsbkSxD
         QSut333Rnx1HgNINlUVVA8sfXmSsJPFtpIXcw8SEcfUf8lVq7Rr2Phb7ctHd2/qA8xU9
         1SR8/rnUHfnxsrgekgkq/wHf5RYWLJZEMUH2YDjcl2dgaMAK2BxCTlIs5P5ZxI/kZAEq
         JuxZ2jb2VblYlBPgT5xcPrtu1TJ7zF7cAaI+qwtYGvL77NNd+g69LQ4SaJiNQ9aj5A/G
         vCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537397; x=1759142197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+9n632otRhZijt2C+vVcISfhaawIfWAEGIOaCRnvcg=;
        b=xDJkG57OY90qIT4fL31xyfxy/Qf++8AHQ4rs99ijqRC4/QDDtPLm7pGcWoberqLOwZ
         mQGPWbRc1grcaomKS+CmWswwZuXfuXawFtupuMddnbtAMTpYtNkMarmv6fMpGQz+jKL6
         CYk4L0fT+i9z3EC4SpVUpdG9PquuPFhbBlkp2b5UVjEMR7MGZBcoMlMt2bN4FOxnSAc9
         RVqJ+RDr0Z9V8YwS1V2HYDH6Dn9fHziLuVTho9H5cWhq7qQ8LjlF8TFmFRsR3Rr2mVxN
         EUvJejy671s7hHW/OOzUCkXbgEqX30SQYcxiPZzHEmmYzNJR++r94Q/I0gjxBM3kJydI
         XqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcKQ7fAhxSKE8/UtsREN/X48ulT4qaY4KRQHPH2PXupl8CCJQeUWBUSjh9jboaDa/roo/UTVXMmNKr0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxenUO6SGRulbeyPoCqrRLFqeFdVkt3Hsx7/Q2zUiSfIRGZsBU
	hzUUI6mxyy18joMQgjZ3EPFDkaKAQDe91zJxZZLv5dPuyIvB7UpAcFRu
X-Gm-Gg: ASbGnctVvArGAlijRcJozL7cItV3SeY2ezZNnOgRxSRPbITz8TIRogOKA7Lj5EloABa
	uc2pqcicnYOkRMN8ud9+BZPKpGSzMIbFR9eiguWjucrc3QizsMxQFIU56+YwLYJaafF2jXcBPoy
	By44DExu3SNueMEumumbw52/LuRvKEUTn5cmvUK8F4SnhgTXvw6hidY1WY1f203dx3eZcBx061G
	KpK7lDMVs6SFbKMyM1pTyDkfabbB1V7SMAqnr6nLnLofqn1TqZWkPK+cdzQtAIwFhZG3VInjezi
	uCjX4lBw178er+PdPT2yQZ1bqgp1BBJe7XojYavkcUXfEaPkkiYdRMBHixMp9qJwShlYd8Asunb
	wAej/Skxr+HPMvemEbQqj8w==
X-Google-Smtp-Source: AGHT+IG7ZxvvTr2SI8V/6MXjM0DofGqWRIdjLfLiO24Xsu1dt/6bTU0M6VuI2CCXGER50ApZGb8/7w==
X-Received: by 2002:a17:903:3846:b0:24c:82ad:a4ef with SMTP id d9443c01a7336-269ba511744mr183795435ad.32.1758537397151;
        Mon, 22 Sep 2025 03:36:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800541adsm129353965ad.4.2025.09.22.03.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:36:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B5F5741A2EDF; Mon, 22 Sep 2025 17:36:34 +0700 (WIB)
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
	Arvind Sankar <nivedita@alum.mit.edu>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 3/3] Documentation: fb: Split toctree
Date: Mon, 22 Sep 2025 17:36:16 +0700
Message-ID: <20250922103615.42925-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922103615.42925-2-bagasdotme@gmail.com>
References: <20250922103615.42925-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885; i=bagasdotme@gmail.com; h=from:subject; bh=0YwIDNcM8Gu6DduxYzaPysxCd6Y3vQAF9cqA61KQ8WU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX1QIVnK5u3dp4tidRuGuf881Jk7v7zsfWPt73O/Ri9 apqG541HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIhGeMDI8SoxyYZS6dTnK7 etq6N3aKr5lKZ/RF5kOyy5Y+F496ac/w372CuVbCyfvaFfFrDydEXvnpY/faY8al8qv7FeKi+oO esgEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Framebuffer docs toctree consists of driver-independent docs
(e.g. API docs) and driver-specific docs. The latter has much
more entries.

Group the docs into separate toctrees.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/fb/index.rst | 80 +++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/Documentation/fb/index.rst b/Documentation/fb/index.rst
index 33e3c49f885695..e2f7488b6e2e42 100644
--- a/Documentation/fb/index.rst
+++ b/Documentation/fb/index.rst
@@ -4,42 +4,52 @@
 Frame Buffer
 ============
 
-.. toctree::
-    :maxdepth: 1
+General information
+===================
 
-    api
-    arkfb
-    aty128fb
-    cirrusfb
-    cmap_xfbdev
-    deferred_io
-    efifb
-    ep93xx-fb
-    fbcon
-    framebuffer
-    gxfb
-    intel810
-    internals
-    lxfb
-    matroxfb
-    metronomefb
-    modedb
-    pvr2fb
-    pxafb
-    s3fb
-    sa1100fb
-    sh7760fb
-    sisfb
-    sm501
-    sm712fb
-    sstfb
-    tgafb
-    tridentfb
-    udlfb
-    uvesafb
-    vesafb
-    viafb
-    vt8623fb
+.. toctree::
+   :maxdepth: 1
+
+   api
+   cmap_xfbdev
+   deferred_io
+   fbcon
+   framebuffer
+   internals
+   modedb
+
+Driver documentation
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   arkfb
+   aty128fb
+   cirrusfb
+   efifb
+   ep93xx-fb
+   gxfb
+   intel810
+   lxfb
+   matroxfb
+   metronomefb
+   pvr2fb
+   pxafb
+   s3fb
+   sa1100fb
+   sh7760fb
+   sisfb
+   sm501
+   sm712fb
+   sstfb
+   tgafb
+   tridentfb
+   udlfb
+   uvesafb
+   vesafb
+   viafb
+   vt8623fb
 
 .. only::  subproject and html
 
-- 
An old man doll... just what I always wanted! - Clara

