Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2683BE163;
	Thu,  9 Apr 2026 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741029; cv=none; b=HLctUJXs04TYWgHzIk18CWWQF+pstXmc06Cl3qtfDAo/rtXO5IGZyv+5hxIkgqH0M2k9Cn9nx53aB+vZP5EmECRM/qtqvgEbSzpyK8+Xs5NITqllPS+XHov1vugQ0pnlTkaBDC0k90wB49ci8eX4EmvK/HTd7BSK+PP2ieCqypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741029; c=relaxed/simple;
	bh=cpyLN38qyvMpYLDnGTZI62G7deRPujFBSc+WS6/Reoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKT8m4H4EnbFyevGg9fMJOnwKpeet9AzxdB8Zz4f9c/2s3CT97DRWoktHirvcj2BMnbbS1bL+I3fXDaUGaUtFWwDUkbTe7ljl9TSsxzPk+/bZ1Ohb4691ZZdiR9gspe1RAbOvpLqBEwEzmYlgv+4tcclIVIkQa7nkL9nfMyoJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbb/Zijd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbb/Zijd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A2C2BC87;
	Thu,  9 Apr 2026 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775741029;
	bh=cpyLN38qyvMpYLDnGTZI62G7deRPujFBSc+WS6/Reoc=;
	h=From:To:Cc:Subject:Date:From;
	b=jbb/ZijdRe/uXBIDZZsWPwu/cy/NBkCpykHfgs0Wu0Uxcsg2dadumQ9Cm0EJBRcSd
	 izmnooFWNmuTYoy9onLE1160mECFpfbnCdP34dAYEN4X5XrLPC59tmYHJePe3AmuoR
	 cIGy/nktl3J96bH4z8wJUJe1Eub5TVgsxsvfUQxI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bernie Thompson <bernie@plugable.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH] fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
Date: Thu,  9 Apr 2026 15:23:46 +0200
Message-ID: <2026040945-glare-devouring-f242@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cpyLN38qyvMpYLDnGTZI62G7deRPujFBSc+WS6/Reoc=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnXVyQKnrEVFDxSoR1x+KtPikjk3veLX7Nq/J+xUTZXi +289/ozHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRj9UM890+eq3cIfFHb8nW nKStfPxlDF9O1DPMTy7tmVty1YSPP1FE8rxuRFzz88BnAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
by zero error"), we also need to prevent that same crash from happening
in the udlfb driver as it uses pixclock directly when dividing, which
will crash.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: Helge Deller <deller@gmx.de>
Fixes: 59277b679f8b ("Staging: udlfb: add dynamic modeset support")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 3c6a9b5758d9..c341d76bc564 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1018,6 +1018,9 @@ static int dlfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 
-- 
2.53.0

