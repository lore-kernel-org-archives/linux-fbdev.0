Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB353CD8A4;
	Fri, 14 Aug 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732958; cv=none; b=rFZpnqLq7PnTDuFxW105LS98xEeMZN2NvLqxHmfVIz0dZ9nZ8a7plBFH1jbZGasIk6N78V5po+Vl+KUZ5D2enD2nPpZCrri/Vu4xR2Ixne1JM07WXoFOT6nX63XmDfjRkNA2BAa/PgV1rt0Z/s+nvu3m5kwvEtZIXP65JJGUiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732958; c=relaxed/simple;
	bh=DrswnHRwBo2rjxH18CeA2A+LZA1/2HmObpE6QkRVNLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irI/+PNGRDgrBFL1K73q7B5bwKvrlRxsrzwPddhhTCFVbdt0EBKtW2G5lfDSC9sSsp/BIu2iAc5cWFctavedZGvCgdBel4iBPv5NAyGcfWofaTAuqZIIEO+OihaqE2DXwC/SxiDHDvukflPWsJn+GkEo3XoLhRGLyDq8jP09+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kIYah7Jn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kIYah7Jn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=f95P4MUmI1ujQc62rr5prDkoqcixRSf+PR0x1gpnLNc=; b=kIYah7Jn4yXU3v566aU3hWuQRu
	z4Fg/wejBgUV06X+QvqHtvL2M+oRX0jQfOVMUBB83kZS9ICihr/DaVuWPSFHQU02tpo2rWQpMg5iC
	dOkLm4KftFSFHVg/DQF5A6Bhe8Unz5N5KswmzYde1I8TcAxu8Fd8E/mbcexvw4Ue8Pk0B2FfPT+Pg
	QpbcRmvQOwqYixTLr4rg7D5aTkHraBTKjshe1HPZGk3T1/r8PzrnLDAtNKnv9ynxe6YMl9TBCwqlv
	DPDitbfxUgzVmxiC2jpTaN0Gkyz4IGJid9tJ72EqASUtMwQAXD7EpMuKIexZUjHq0zHdkcNfQGJNX
	6k1Fjj3Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuwrT-000000033V3-1SlN;
	Fri, 14 Aug 2026 18:42:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH] fbdev: maxine: use MODULE_LICENSE() unconditionally
Date: Fri, 14 Aug 2026 11:42:34 -0700
Message-ID: <20260814184234.3013510-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver cannot be built as a loadable module so testing for
"#ifdef MODULE" is not appropriate here.
Also, MODULE_LICENSE() is always available.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20260814.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260814/drivers/video/fbdev/maxinefb.c
@@ -169,9 +169,7 @@ static void __exit maxinefb_exit(void)
 	unregister_framebuffer(&fb_info);
 }
 
-#ifdef MODULE
 MODULE_LICENSE("GPL");
-#endif
 module_init(maxinefb_init);
 module_exit(maxinefb_exit);
 
