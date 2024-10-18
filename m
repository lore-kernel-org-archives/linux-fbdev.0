Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7D76C61;
	Fri, 18 Oct 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264383; cv=none; b=g3vDouhcOrLbAfQG1fGMdX8Ldz4zGhPr3vX5FIwj3XMkIJ7ZmnTjvlrPRYZxiwn0BpdK9iopizsNRr3z0Xqv4XrxveTtxA/h5xZUunTuAPO+ZoyUCM6RqSb1EFegQjxyXwYWQaUwsBGSe0vAUqJWySB+/d7oIG1PWmgbNCEah78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264383; c=relaxed/simple;
	bh=4/LoPNWFMLOtRjQ2F1SWn+Sgmq2mlkEMHTBeAJ0+Sts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okygfkDXKPr1NU+hs72l3bW5m1WnurXFFCsYN4f9K6QTqg00OkXXbgbL9r5Oo4y9s11qpzlzLG1gBDgnRwH4ho+z8jYAxdr4GQe+4J4JBdPLJVyoZdqoe5spvYqldQzCJTUyIvAYnVAL9Qoq51Mk7dul7JFyIj+cbokwap6RHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf0eO50I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf0eO50I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C33C4CEC3;
	Fri, 18 Oct 2024 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264383;
	bh=4/LoPNWFMLOtRjQ2F1SWn+Sgmq2mlkEMHTBeAJ0+Sts=;
	h=From:To:Cc:Subject:Date:From;
	b=Zf0eO50IFcBdjC4gKtwzS+B/O423DZOxwfR0DF10Yo3ApzX7RN+qHkv7TV0yPW6UU
	 ewdR2DNjZWB+2ohT6qNOeXTkPsCBEYQ7XGd4dl5sk6tlRb5O+rfqPGZIZRqqk274gH
	 5ASnOXh1mTXoXKhMOzn9NBwK7pdNawa5OihBgornEmtLRXxnVjoH4ODymBWjwZt3v8
	 ZpBzxjpQI2nnxW9Gdllumxi16BE1BVUbJyvM7APCxPlD9a65vIirTwJNOmhvEyPtf7
	 nzlj5kke0T+exfPGWNCIGyDefFQvmG+tzrm8oqsFfaWQfoLG9/j1zGUclLcP9zEEeR
	 6Fmscvoo/0hIw==
From: Arnd Bergmann <arnd@kernel.org>
To: Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/wm8505fb: select CONFIG_FB_IOMEM_FOPS
Date: Fri, 18 Oct 2024 15:12:49 +0000
Message-Id: <20241018151258.3574617-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The fb_io_mmap() function is used in the file operations but
not enabled in all configurations unless FB_IOMEM_FOPS gets
selected:

ld.lld-20: error: undefined symbol: fb_io_mmap
>>> referenced by wm8505fb.c
>>>               drivers/video/fbdev/wm8505fb.o:(wm8505fb_ops) in archive vmlinux.a

Fixes: 11754a504608 ("fbdev/wm8505fb: Initialize fb_ops to fbdev I/O-memory helpers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 9957dde4a3f6..961d7f5bbbc2 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1388,6 +1388,7 @@ config FB_VT8500
 config FB_WM8505
 	bool "Wondermedia WM8xxx-series frame buffer support"
 	depends on (FB = y) && HAS_IOMEM && (ARCH_VT8500 || COMPILE_TEST)
+	select FB_IOMEM_FOPS
 	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
 	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
 	select FB_SYS_IMAGEBLIT
-- 
2.39.5

