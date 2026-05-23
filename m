Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B152C0F91;
	Sat, 23 May 2026 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779513331; cv=none; b=i9JtuHRpt/N0kEuIEXjEN9sQPPO7X+LtCPzg5hVFvP9i0J5kr4mR5xHXfBs8kaoFmNvxE/XbG0QVwr1kkIg3xVk5cPhRowWO9D08tsYovySDpZS96Mea7t88r4I4DyHEc1Y8l5FudTbFhCfxn/2pTqlrLgx4LqkvBZise/yn0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779513331; c=relaxed/simple;
	bh=0kZco4Rx+droJCiIqGv2f4c5UGEs1FVpatTaO6z03+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3s/dHvD4QgAuU6eOMDdsggXBSdjaN86wof0KoQL91s0YIKi5rT9EP84TIq4BLC1DPxPPHpHbS6vshTW6Hrj9S9vQPpQKIXE65x6amq2ptr6s7GLft0X1iFWHdxzHRoLKfuZaEApIhKByFGP1pSg2tQNWDNy+uduWLixbMTl0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=hi0BRUOv; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="hi0BRUOv"
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 5C49EC0009;
	Sat, 23 May 2026 08:15:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id DFNL0fJe2Ko0-5Ft7xLIW;
	Sat, 23 May 2026 08:15:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779513319;
	bh=HFjaDY2NIDRS7NxfGe2m2Ws1Ih4v5qRQzHSLIRao1FA=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hi0BRUOvqLCxcxXe6B56czpxwtfaCw5BdJrBKWk87uKd9zQOTtEwrNpDd/uB2TSCC
	 d6659Viz8Q8WhRIoyue0wp59VZrFmzOGnrMalQQu92jCrE1e/Ha5dqI7I0/F3wtpyv
	 5M6S5qbOPHWYS/q4QtUdGgEGzUW1B4Y12Us2Wjx8=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH 2/5] staging: sm750fb: remove unnecessary initializations
Date: Sat, 23 May 2026 05:15:06 +0000
Message-ID: <20260523051509.166152-3-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523051509.166152-1-ahmet@sezginduran.net>
References: <20260523051509.166152-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove two instances of `ret = 0` initializations since the
variable is overridden unconditionally before being used.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 02db1418476b..fff9c35ee7b0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -343,7 +343,6 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	if (!info)
 		return -EINVAL;
 
-	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
 	output = &par->output;
@@ -463,7 +462,6 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	if (!var->pixclock)
 		return -EINVAL;
 
-	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
 
-- 
2.53.0

