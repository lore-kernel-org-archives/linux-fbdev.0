Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dwzm/gLJ"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB268D42
	for <linux-fbdev@vger.kernel.org>; Wed,  6 Dec 2023 09:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0vhy2fDmTy3/G2Hs+lHPkVuPzYxaie1T8xyfpSAP62w=; b=dwzm/gLJuHGYRGXaoWvDbKogMT
	kpOcumJb6nHE7vwshKXbsBHAWSf31QvzfB8dzxI0I5xHkTuR1S9w7Hy81EyaObTCF6QHbBQXKuWno
	CrA1zUTbCMekMcbV8VsfqU/r1JE4rneYPjB6tN9tSKm09oq1PUYodJj8ZZzHcf/Ahrajs2Ka/lgq+
	5zSXFupRsOj6lx2bAZUcHTtaeNxPCnnmhjeOVzSEopqWc4NZHJuqeMFOoCUx1H7rD0BFNXHv2HsRp
	6MOrU23s3TrsjbpYRBH0L4bcAgZNMTUEM0Ha5/ByBZ/hq1AebAImMm2Kd9mgYsIBIgiiZYTFhTVLk
	E3smi+6g==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAvxe-00AxPT-0w;
	Wed, 06 Dec 2023 17:45:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2] backlight: ili922x: drop kernel-doc for local macros
Date: Wed,  6 Dec 2023 09:45:25 -0800
Message-ID: <20231206174525.14960-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use kernel-doc notation for the local macros START_BYTE() and
CHECK_FREQ_REG(). This prevents these kernel-doc warnings:

ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * START_BYTE(id, rs, rw)
ili922x.c:85: warning: missing initial short description on line:
 * START_BYTE(id, rs, rw)
ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
v2: just drop the kernel-docness completely for these macros (Lee)

 drivers/video/backlight/ili922x.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -81,7 +81,7 @@
 #define START_RW_WRITE		0
 #define START_RW_READ		1
 
-/**
+/*
  * START_BYTE(id, rs, rw)
  *
  * Set the start byte according to the required operation.
@@ -100,7 +100,7 @@
 #define START_BYTE(id, rs, rw)	\
 	(0x70 | (((id) & 0x01) << 2) | (((rs) & 0x01) << 1) | ((rw) & 0x01))
 
-/**
+/*
  * CHECK_FREQ_REG(spi_device s, spi_transfer x) - Check the frequency
  *	for the SPI transfer. According to the datasheet, the controller
  *	accept higher frequency for the GRAM transfer, but it requires
