Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A863E317D;
	Mon, 25 May 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699727; cv=none; b=C7KwC+vB8hDtstVu9/4hIsuEg163S4o1oMMrGYGpIV4PhJ9DsZ3F/xcgGVvoMrZlRGGH/sIlOXTa7QqU0pecVAzhMSTTMuzrsh/ujrEt623sEaYzUDztzlQFCwXV1NeuWQB+Lhb1SZserKl6v5TuhdRQ6ee1NNxxqNWk0OTmqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699727; c=relaxed/simple;
	bh=MIj0J+AW53RCnzQ+5qg7U9y5+MAjictSABnZwTrdGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8TnvrLH9BoE7s9eYGr0XgRkK7cyaiVtX3NeyOpe2lW2ARoIdCJer5Iod3w3TT3LVeVNmGTjHDGGo2Uilndd6vQjE7w6UHPHnOayCHmFNx8+QfjogptTT8IZg+YCvD/C6hz9/6dm8e8Qu/OkZj0Jzdi0OzzbWVH3EG2ORtdOj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=lWafVoJc; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="lWafVoJc"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 21BB980E48;
	Mon, 25 May 2026 12:01:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id m1TmE1aggiE0-bYE3IN2z;
	Mon, 25 May 2026 12:01:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779699716;
	bh=ENSooiXn9MHBTXc9FR2h8yvwp1L27CN5h8YNsJcPXi0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=lWafVoJcpHXztLyxuw4qQVNhGy1fA7uee7cKcibV/x/+eHzf2/Sln5zly4hS71hsJ
	 +2DexTvZM5pfefkZ1kwhhHXqU8wE9Yv6lvpZlC8z/Tu10vObeqiQRdeFw8wBeT6Of/
	 NZEMuRu2xZ2ElcIT8KdtNUEVA7qFIAZZAlI3wFfw=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v3 2/4] staging: sm750fb: remove unnecessary initializations
Date: Mon, 25 May 2026 08:58:06 +0000
Message-ID: <20260525085808.171974-3-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525085808.171974-1-ahmet@sezginduran.net>
References: <20260525085808.171974-1-ahmet@sezginduran.net>
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
v3: No changes.
v2: No changes.

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
2.54.0

