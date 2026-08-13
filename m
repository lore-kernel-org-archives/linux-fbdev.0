Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB063CD8A4;
	Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663792; cv=none; b=EtcEbm2ZGHKlFsxkV0WJv+qU/B3bUvlRDrq3cF11v/Lwpg95HeIo7p4K8YVHwPVorey8DJFCn1r0aTDUUJVLzxlPw6VQS1BKrvG5XlyivFA+RA/4zNTf+9rkOOaoFV2QGUIXAnDoosqa9QDgfmuZlFBSaE6yD9kfwPrzqy/mzKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663792; c=relaxed/simple;
	bh=c8y50wvMrO/x2QcUvtSYsEz/WyNIgpJCN2AzBDqh9oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMbhun55KLwBiWaAj5mrJVwFtx2ZE9ZzWxtGZ6IsIFn4J5koN2TOpzDF7OptKI1gkO2OmRfciXt6uUd7FIZgcdihms2Ex9xVE+DK9Wk5FSm54II3kFv06KqOX4MCEEQI+Kdhlj9aP36DEqqeKEIi+UaiOzPu50rbwH17cOp1mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=so5yq1AP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="so5yq1AP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FnV5OU5FndSzEfnBWZbVh/mfI5hpBGsj+wc3TOdgS8I=; b=so5yq1AP/aUOJsu5w0nbovZvaU
	sU73CIh5jiXovrEwD6q5v/moZOBz+nQooq49zw+kt5Ij9CaSDO4H05nz6mzkhFFzOTUW/Vvvkx0Tt
	91zkN5vBZvHHtBoqOSq6ZpucSxbyUlrinVNy5ELN400PYS43pAVnF9CCkJC7fBo7mv7+qeiJyk4KI
	tDYpXGCtZtKjzWwanIq6Mcg11CnS/1d6EnhVOnWGSsvlOgS/Au2zenFeEv70icAH5iq1Xe1vompMl
	shouza6IjclEoEkoTSq5wH2JfJeFYFJvi9gLoGsWa7mW/wcwC/5qZ2MkM1cfcMWyufqvv7e7ziAgg
	/TfJcUcQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuerf-00000001k8D-1KBy;
	Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 01/03] fbdev: maxine: make functions static
Date: Thu, 13 Aug 2026 16:29:32 -0700
Message-ID: <20260813232934.2718291-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813232934.2718291-1-rdunlap@infradead.org>
References: <20260813232934.2718291-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make 3 functions static so that they don't need to be declared in a
header file.

../drivers/video/fbdev/maxinefb.c:64:6: warning: no previous prototype for 'maxinefb_ims332_write_register' [-Wmissing-prototypes]
   64 | void maxinefb_ims332_write_register(int regno, register unsigned int val)
../drivers/video/fbdev/maxinefb.c:74:14: warning: no previous prototype for 'maxinefb_ims332_read_register' [-Wmissing-prototypes]
   74 | unsigned int maxinefb_ims332_read_register(int regno)
../drivers/video/fbdev/maxinefb.c:114:12: warning: no previous prototype for 'maxinefb_init' [-Wmissing-prototypes]
  114 | int __init maxinefb_init(void)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20260812.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260812/drivers/video/fbdev/maxinefb.c
@@ -61,7 +61,7 @@ static struct fb_fix_screeninfo maxinefb
 
 /* Handle the funny Inmos RamDAC/video controller ... */
 
-void maxinefb_ims332_write_register(int regno, register unsigned int val)
+static void maxinefb_ims332_write_register(int regno, register unsigned int val)
 {
 	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
 	unsigned char *wptr;
@@ -71,7 +71,7 @@ void maxinefb_ims332_write_register(int
 	*((volatile unsigned short *) (wptr)) = val;
 }
 
-unsigned int maxinefb_ims332_read_register(int regno)
+static unsigned int maxinefb_ims332_read_register(int regno)
 {
 	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
 	unsigned char *rptr;
@@ -111,7 +111,7 @@ static const struct fb_ops maxinefb_ops
 	.fb_setcolreg	= maxinefb_setcolreg,
 };
 
-int __init maxinefb_init(void)
+static int __init maxinefb_init(void)
 {
 	unsigned long fboff;
 	unsigned long fb_start;
