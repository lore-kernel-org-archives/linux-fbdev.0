Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7B40DFA4;
	Thu,  9 Apr 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740999; cv=none; b=KW6V7xuP0tnC1bvBtVunI7XgfmoRv2fC2n8c2C3xRDOC4HPm18tribjONmxRRC9dZmogeypJO+kXbpH+rRMRzwyfwZqce9u0S2C4YKifM2Nzw8vu3rOuXjYK9ynIjm4muiEg7LF7tmBgrQytQ31klM+jEwpCDaUjay5kRzpepA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740999; c=relaxed/simple;
	bh=beoClJMSHoxdJzdDvk8BWy/7r7zUQ1L8OLTWlMTphLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfUpN8VNOUGCqV1rlnTkpkgcTb3L9T3jTKgK1MVcP1S/sTDEeLiOTG2BjSsudyZhioyDOslOuyBNUOpnhI1rBU38qb0pQVWv8w+2GbsaC7D8dH5zerjqBlVAuI1YORv5/pxXkReVYU8GsnQGdjyFhn/RcdbzwuR4xvUlgR/jKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k6qDN9lG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k6qDN9lG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111C3C4CEF7;
	Thu,  9 Apr 2026 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775740999;
	bh=beoClJMSHoxdJzdDvk8BWy/7r7zUQ1L8OLTWlMTphLU=;
	h=From:To:Cc:Subject:Date:From;
	b=k6qDN9lGMnqcHHelhAtV6ZO1jU/c+cTqANfB5XearxPDpe0gMXG9lw4X2Mamnnf3y
	 Avc9cyjyZPuxAwzwyf38z2t/Fxo75zf18h9OCdp5qI7lcFZWSFOprZJz9dMnOciaLJ
	 88gkH7oog7jxZavMXnc9hlzo9j06Idr7te3swR48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>,
	stable <stable@kernel.org>
Subject: [PATCH] fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
Date: Thu,  9 Apr 2026 15:23:14 +0200
Message-ID: <2026040913-despite-entering-a017@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=beoClJMSHoxdJzdDvk8BWy/7r7zUQ1L8OLTWlMTphLU=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnXVzhufl+cOCN6ablScfK6B6GK/48abf9yUnjqt4e7M jcuz2qM7ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPGdmmGd3qNDORXimyk+B eIa0gF5BviVsSQwLFpdpXG4Sfdd3T+vfseU+wgblBjO4AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
by zero error"), we also need to prevent that same crash from happening
in the udlfb driver as it uses pixclock directly when dividing, which
will crash.

Cc: Helge Deller <deller@gmx.de>
Assisted-by: gregkh_clanker_t1000
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/tdfxfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 51ebe78359ec..531fb8478e20 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -496,6 +496,9 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		}
 	}
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (PICOS2KHZ(var->pixclock) > par->max_pixclock) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
-- 
2.53.0

