Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723CA2FC01B
	for <linux-fbdev@vger.kernel.org>; Thu, 20 Nov 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645035; cv=none; b=cZVP9JQONQEHZ30ZloHWvY96/4t+RzzKLFj5eupGoZiz9SPDn21Vr2MpHdeOXZAAqkOZZGcYkoOTkHH7FGV7C3G/W13PfictH9RD+xQ05OgjxcGMxf+4D/R5RlFpbSw4szUU2AxEgpYboK0IRNpIoMM6QJJtHKbhQQqweF8L6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645035; c=relaxed/simple;
	bh=YSU00ga7d+Uz+wuDzlUl85sns8rEILdgv8RMxvNbxBY=;
	h=Date:Message-Id:To:Cc:From:Subject:Mime-Version:Content-Type; b=lKQh6Jf5qN4vHxg1RilgJaqI4jxC7Tp4BhV7qgTDAZbON1w05+77HIpZHBn+EqRYFeQWrd5IiqhQiaOi+Pqvy4Kajmghgh+8iaMPzxi5JBzLqSv7he6q587I5thN5Su1uaQGyvMA/iquVdOvv4YhhT8XCgvjw0SUm4dRaYDerHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=R0jCHmsL; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="R0jCHmsL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:Subject:From:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=sMPhvuy+eqjkG8nXqlRk2u8YuDLk9jfSVaXs7X8YFPw=; b=R
	0jCHmsL3AT87gX5j3u/Yzsc766+M6Q6/4xd0g2UDzVosDx23Il78cJXCVbgm73HSbZNazi41Q7rL5
	I58Cers80gXJyrXariudoHrhE6Rfh27JcCMCsOm7Qqg8EKOkGSgFz8RmzYMuB/hYeaPV0yUtkVC9B
	JIb4X3kkqpCCsGfu2yBA18iUnexDwguParWS0B00e8RSzyvtoypo4xr6u3KfRoNxt/n6hD+zwjkmq
	aXB41k/xPJK/aDa/g0HFd6gQiUn18UwoD89ntxs6kq1kq52YFoSirtf0ZnstF4Yl3l5WTNqpN/39V
	yT7dwoYDRLheFuHV1rsZqoM8JDJtMJlCg==;
Date: Thu, 20 Nov 2025 14:24:00 +0100 (CET)
Message-Id: <20251120.142400.712755331607709755.rene@exactco.de>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Subject: [PATCH] fbdev/tcx.c fix mem_map to correct smem_start offset
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

403ae52ac047 ("sparc: fix drivers/video/tcx.c warning") changed the
physbase initializing breaking the user-space mmap, e.g. for Xorg
entirely.

Fix fbdev mmap table so the sbus mmap helper work correctly, and
not try to map vastly (physbase) offset memory.

Fixes: 403ae52ac047 ("sparc: fix drivers/video/tcx.c warning")
Signed-off-by: René Rebe <rene@exactco.de>
---
 drivers/video/fbdev/tcx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
index f9a0085ad72b..ca9e84e8d860 100644
--- a/drivers/video/fbdev/tcx.c
+++ b/drivers/video/fbdev/tcx.c
@@ -428,7 +428,7 @@ static int tcx_probe(struct platform_device *op)
 			j = i;
 			break;
 		}
-		par->mmap_map[i].poff = op->resource[j].start;
+		par->mmap_map[i].poff = op->resource[j].start - info->fix.smem_start;
 	}
 
 	info->fbops = &tcx_ops;
-- 
2.46.0


-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
