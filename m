Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352840DFDF;
	Tue, 28 Apr 2026 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777346460; cv=none; b=nL3vWCW7sB8ZRjsZuz7TRWRkIVL058S6sKVBDn0+cvLWg+gOXMU3nq3LeLDFLfcjQBI3A2GG+mRfYs3O+D0VCYmIc3aKI06fXPOWjE0e55BzgcZWAW5ylOfqlFZw5wK6M9nRoe/Y3d6Bl7bCGaKCN7ZPuvJyYhmQk4InUuc2hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777346460; c=relaxed/simple;
	bh=y1FhYG2ykr92saJL2JgEtRdrApd1V0XXBboWrwsioFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCLLVEA0qqtY1dtLREDmPsfoenHDWeSrrKc2Cdl4YkYUKWBLHA7NDA53HHK4Gpo8hCxRHMYoyiQHlnI3rm6S1P222evEFWzzc98Jp4R6swkeHw0tvk5IXYfxdCfTtkZRIPTTIlJg0ta1i/refWQrON4TmiUDEcBeEbKMsNopSe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABHK+KUJ_BpfJxnDw--.6814S2;
	Tue, 28 Apr 2026 11:20:52 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] fbdev: defio: Remove duplicate include of linux/module.h
Date: Tue, 28 Apr 2026 11:17:25 +0800
Message-Id: <20260428031725.1013103-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHK+KUJ_BpfJxnDw--.6814S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4kAF48CF13ZrW7Kr1DGFg_yoWxurc_Cw
	n7urWxGry7Gr1IkF4fAanxA34YywnrXF1rZFnY93savF9rJ3yFq347ZryUX343WrykZF1k
	WF1Dtr48WryfWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU0-eoUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of linux/module.h in fb_defio.c to clean up
redundant code.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/fbdev/core/fb_defio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a12dd25ab697..fd00b86e1ae6 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -14,7 +14,6 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-- 
2.25.1

