Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A594C2500AA;
	Fri, 21 Feb 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159101; cv=none; b=mAvJI8WAPE6wXXmj+DiMp9Ba3wpqZdHuHTp+x+GH4DfUuV8t3edWjDIuDV3LhhYZ9weylKEbXRPJSHBX+ChRhBRfJWxhjj3nDIGkOr0DPSqN0MoCLTrekC505bJD1cRERZ1Qb/KsMYTA+ypF6l36Iacqv8SkVmWQeTrbr9W6gn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159101; c=relaxed/simple;
	bh=8/rF8J69+3gOYWulVtfv+etD5x/gFP+fkCXTyZNERUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caFT7Pz5a5zsymcVYt7JGVMjkdtU2Bvz5pS8ayI+D3ojgsoZfQ9J366PqJkZZnmXpTWpVHkb3s92qp2e81ANRJ2Xid3BMv2phqqqtPK/5t84Q0fVM8msowsJuM3HwuTKv0iCxPuiLVCvzKaij2HqwtaKFR8t9jTUT1FIDkuZHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mfwduxJQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfwduxJQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Y3q5SEZ22PIlzGuL/p51TBUcu7BuCGZLgTAPxKOn4WE=; b=mfwduxJQZv1iIbvGuFxS8NULnT
	WF/z8ONiiCdtuqi90QA5YkhyfYqGA+fhoJ1lHxGZkEretuIMA2HKggJF4cm8Xh0QK+Rn6CCwefAbz
	iCpL3spMKUFPtI1oTRdrar+x+WmshCut9jlUML8gwB0MVlOxJDmXG6mSCw4img7n+cDAC5wNlmVsK
	gSsgllRwaeVl5Efs1L52KxZ5StRZcjdQyKFvOy4Ril7jrqCGPm4wIkRnOQy30okc+XwiOL9gu7BBO
	cWkjau1NnIXmByPCpbr61A/9o9LVdQvEoaXTQpX9NIj1CItTGG66q+L/b0W06y1nPiXrm5/Cx+ap1
	zriGYDvA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlWs9-0000000EYtb-37Jg;
	Fri, 21 Feb 2025 17:31:33 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH] fbtft: Remove access to page->index
Date: Fri, 21 Feb 2025 17:31:29 +0000
Message-ID: <20250221173131.3470667-1-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to print out page->index as part of the debug message.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/staging/fbtft/fbtft-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4cfa494243b9..da9c64152a60 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -337,9 +337,7 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagereflis
 	list_for_each_entry(pageref, pagereflist, list) {
 		y_low = pageref->offset / info->fix.line_length;
 		y_high = (pageref->offset + PAGE_SIZE - 1) / info->fix.line_length;
-		dev_dbg(info->device,
-			"page->index=%lu y_low=%d y_high=%d\n",
-			pageref->page->index, y_low, y_high);
+		dev_dbg(info->device, "y_low=%d y_high=%d\n", y_low, y_high);
 		if (y_high > info->var.yres - 1)
 			y_high = info->var.yres - 1;
 		if (y_low < dirty_lines_start)
-- 
2.47.2

