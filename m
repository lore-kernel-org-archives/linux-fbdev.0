Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E58F27A440;
	Sun, 15 Jun 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750012614; cv=none; b=pyO1vmnXW4wxbc3srhH7iLAo2NWgUvJroEW+s9km02t46o1YlL6IWco4k7GjFAHKZy1t8tODf50NvuyFClIHBSfSsC7TKbssb5tPe8/v8Qla3EKQ7pfm+mierxCMi1nv2yGlZZBqbh4EGcK1dyGYUQnh60mamQljzbmLerD4OYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750012614; c=relaxed/simple;
	bh=TWJRvcHTWklmzOvijC0OlvOxuM5CP7EWLUmMFgLE9lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pWJwAEvPCEsFvKW8MUROg5C+gwnKHVp7guOkw0h0J2Kc0MDS3uXiRzulujYCZw+9rKsg3Wh79qVl2ygt6E0qq3voZDjUwAeKgqDk78Ik85smkHJ/ZwQoHGxJU8TV4rAYGAi4T8/Fmzb+mqyU1+fks0JzWjxxbTcS3C9BuM/gykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iiuroauu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iiuroauu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jdRvIz45TiobIVRoK9I/4dZAaTqL0zwFTChfVWGgCUE=; b=IiuroauuajuokLiFGkEyvXKUgN
	Vzs92a1teLtDIMJrhiKPuhzYQ/bRS6pDCA1kqm2v7AHssQvY1ocLQ3mugkSu6/SwN0qwX4aKJjaB9
	1ijhaakl5EGsA5yMhz/Q8yMDPJv+TtgTRSSdM/9093A/NRbr6COzBf7na45pJ2QeuNZ47lkJMDzm5
	BS9v4CtII3C86KQ2THe2x1fLb7JMSkmLV571RhpebLjMysnmgbt9bTlzTzqB8ohOtCqp2rep3UYce
	xK7VIprKb9kFl+Erv8GfPtX1gd76qI7koNgqSj5h/S0kjSwCXEE8Gakisn35V+SqnAen3vK30FUeR
	e8xIgZqA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQsDs-00000002joW-2l4M;
	Sun, 15 Jun 2025 18:36:52 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev: nvidiafb: add depends on HAS_IOPORT
Date: Sun, 15 Jun 2025 11:36:51 -0700
Message-ID: <20250615183651.902092-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The nvidiafb driver uses inb()/outb() without depending on HAS_IOPORT,
which leads to build errors since kernel v6.13-rc1:
commit 6f043e757445 ("asm-generic/io.h: Remove I/O port accessors
for HAS_IOPORT=n")

Add the HAS_IOPORT dependency to prevent the build errors.

(Found in ARCH=um allmodconfig builds)

drivers/video/fbdev/nvidia/nv_accel.c: In function ‘NVDmaWait’:
include/asm-generic/io.h:596:15: error: call to ‘_outb’ declared with attribute error: outb() requires CONFIG_HAS_IOPORT
  596 | #define _outb _outb

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-616-rc1.orig/drivers/video/fbdev/Kconfig
+++ lnx-616-rc1/drivers/video/fbdev/Kconfig
@@ -660,7 +660,7 @@ config FB_ATMEL
 
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
-	depends on FB && PCI
+	depends on FB && PCI && HAS_IOPORT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494 # v6.16-rc1
