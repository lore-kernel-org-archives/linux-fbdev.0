Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2D1DC1AB
	for <linux-fbdev@vger.kernel.org>; Fri, 14 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132449; cv=none; b=MyqEeqw8PLhzPF/wjoJtorUlrj23l+jDn5HXWEjNlSFVCzEnS8+Rx9kzhvqd6i5iBXxYt5NCd2aOftb6akvy5rKuYBTvuvfoA4PJk0ajJHTDUua5H8q2f2qcTpUKThvaBPjz9cx3vXc4e0LdFQTrrBasJ3sA+RdcaXKZ9q8old8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132449; c=relaxed/simple;
	bh=IavLmV81RgSxpyTV6H/B6pdX1uCnUgUUTPbCMrGXbvE=;
	h=Date:Message-Id:Cc:To:Subject:From:Mime-Version:Content-Type; b=BkYT51RNTevVnZo/O6MtBElg5rmLvx6lbcLD7SjxdqHuOqkcvFM9aQYSlhkeu4G4dliNvZ3q7wLi23c3+O3lnR7Bra+rMaf5houv/O3jFLae8FswBSMbamgv0nQZQBAnOVI1hC+zoUqWRcGZRjdwp3kYF+pEA6mHSaw2n35XUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=by0u4IcA; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="by0u4IcA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Cc
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=pxQBMLEEtKCwuorK5zvIQ3hE/hrs1Ey7CRdZ0gM/kGU=; b=b
	y0u4IcAxzmbUrDnmjoNZiahTo7IJtZrHHXPGm9JhSXy5+ENdFpLSLqAIfcY3xXGL34ISc/CyPxiL2
	tLCrLcAnf5QZBsTTOwFFUye+34vyH5sNXU8HGqqrFbtx6q1oWK96V6GPXTz247bMVA+LG9sgH6scq
	3+L5riA+8SqWAjiTHEBHyAwUYMhUmebjYog3xOesXUTVLbGgly/qeqyuM7oxf1FT9umDlUVRRTw9H
	EDewrMZgqc5SgKELfR7os8/yNXvDzqSJ7szWwoWV0ELdfqo9IzOwxqaP4fPEZWFJ8Z5w7jwA1Y2Of
	DURwRVYHoi/hlpzytRZLNBT7BxaqXRoTg==;
Date: Fri, 14 Nov 2025 16:00:42 +0100 (CET)
Message-Id: <20251114.160042.848790184211544497.rene@exactco.de>
Cc: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org
Subject: [PATCh] fix fbdev/gbefb.c mem_phys
From: Rene Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

While debuggigng why X would not start on mips64 Sgi/O2 I found the
phys adress being off. Turns out the gbefb passed the internal
dma_addr as phys. May be broken pre git history. Fix by converting
dma_to_phys.

Signed-off-by: René Rebe <rene@exactco.de>

--- a/drivers/video/fbdev/gbefb.c	2024-01-07 20:50:29.647506488 +0100
+++ b/drivers/video/fbdev/gbefb.c	2024-01-08 00:28:01.651948701 +0100
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
 #include <linux/fb.h>
@@ -65,7 +66,7 @@
 static unsigned int gbe_mem_size = CONFIG_FB_GBE_MEM * 1024*1024;
 static void *gbe_mem;
 static dma_addr_t gbe_dma_addr;
-static unsigned long gbe_mem_phys;
+static phys_addr_t gbe_mem_phys;
 
 static struct {
 	uint16_t *cpu;
@@ -1182,7 +1182,7 @@
 			goto out_release_mem_region;
 		}
 
-		gbe_mem_phys = (unsigned long) gbe_dma_addr;
+		gbe_mem_phys = dma_to_phys(&p_dev->dev, gbe_dma_addr);
 	}
 
 	par = info->par;


-- 
  René Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactco.de | https://t2linux.com | https://rene.rebe.de
