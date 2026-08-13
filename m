Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C13CB2C7;
	Thu, 13 Aug 2026 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663792; cv=none; b=bsB8ORnVGnq8wo1S/P8dqDpIzL0K06EI0ecnQQc8jkj0wSWTiv+WbNoojoNKONSHPk3yJl+/Uy6om1aC3evj6t0fn74Vf6S+JBlcpTAtwom2voYcDd08OmnIE8ZQrELRAivfw/ikfLRTBM928F3EVkMUDSMM+UYz+Lr7xRhC9XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663792; c=relaxed/simple;
	bh=FcJxeYeA8CsjKL3qpHQ6+0ih7ry8XJgrKuoF2oVC9uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkInMYJTOO+wnJn/OztP7zqITxVyFrxxygnL5Azgyyc9s1uDde7UagtDYiFuWwclk0HzwxGheGON1AGpBYbYTajyRXvICE2UaOAqZQh/eiiFADiiWXEv1ibmmqyK1Lm7SR29p8e6cc+bau2TeZfmsCK+NZbunHVnxInd/8ImS/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EVliN0QM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EVliN0QM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kM2TD3DfowE2cKLzEA2GjNOhlCpAPeFQCX6hfajS8yc=; b=EVliN0QM38cMZWlTNeL5gCPy+K
	VZf8RdAyKQjW0nqTlXmuuoXsdZgBvHa+6IU2eXU4o674tbZdCIK94Ii9YpzNDXNw6wjrvuiPPOE5P
	oqUUHUayH/SAiYnNDZBd6UJHN7FtqEEhqudlkncym8zppzWnzi21UWxzeFnbzM6kCj5ndUglmNsJO
	MhFIONmM49ulnLh/6/wrfaeVl2i6Um0RCx0ad+KaMtRYNSx6m60aYvjk68vvlodQIYspy3yMm5kNw
	aqMWFt0FyKO5/MJksDXnIUsT40ZmGlD9BPyoFeZOlBXwZ+0zzE3mdyUm0lE7YRswTyNXIyh/U8wLp
	K7JLJeVQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuerf-00000001k8D-2Tqz;
	Thu, 13 Aug 2026 23:29:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 02/03] fbdev: maxine: elide an unused function
Date: Thu, 13 Aug 2026 16:29:33 -0700
Message-ID: <20260813232934.2718291-3-rdunlap@infradead.org>
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

maxinefb_ims332_read_register() is not used, but since it describes a
hardware interface, leave it in the source file as documentation
and surround it inside an #if 0/#endif block.

../drivers/video/fbdev/maxinefb.c:74:21: warning: 'maxinefb_ims332_read_register' defined but not used [-Wunused-function]
   74 | static unsigned int maxinefb_ims332_read_register(int regno)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>

 drivers/video/fbdev/maxinefb.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20260812.orig/drivers/video/fbdev/maxinefb.c
+++ linux-next-20260812/drivers/video/fbdev/maxinefb.c
@@ -71,6 +71,8 @@ static void maxinefb_ims332_write_regist
 	*((volatile unsigned short *) (wptr)) = val;
 }
 
+#if 0
+/* dead code: leave here for hardware interface documentation */
 static unsigned int maxinefb_ims332_read_register(int regno)
 {
 	register unsigned char *regs = (char *) MAXINEFB_IMS332_ADDRESS;
@@ -83,6 +85,7 @@ static unsigned int maxinefb_ims332_read
 
 	return (j & 0xffff) | ((k & 0xff00) << 8);
 }
+#endif
 
 /* Set the palette */
 static int maxinefb_setcolreg(unsigned regno, unsigned red, unsigned green,
