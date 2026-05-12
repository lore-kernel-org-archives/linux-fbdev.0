Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE13D5C21;
	Tue, 12 May 2026 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604491; cv=none; b=YT1rB+LuMPdPqgzXUlh3x1n8yaiTXXL2sOreJKsmk49HnJQuo/DbKvwwjwy59fR6gyciCaXTAoMXY3Uh/kOhI8/8PACNHw+kkpcbAmDQuc3T0T9WxpaP3MXkWrZwMU7LjVe1xfc4n01MK57D+N4I9cQVlksjTfydFnp5R0VxpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604491; c=relaxed/simple;
	bh=Gnn1Do81QrR5wbkPcvYAjV4e1rUZsyWvtIaNJyyyrU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRFoPplDTUJ23zrwI6u3P/x9uuVc/pscoqVMZlSl7D5rFtiOsSevUrRtBe2rWOupgDcnXlW8gc1WUn65JOoNK4kaJQehiO2ih02Cu5gM1VXFKOcI0jtRzoMiIXz1K0de092Ks8KIMmKOZr6lRPnrIiRMYisyNB7R+U9YrmqY8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=c4Ykpoxy; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="c4Ykpoxy"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 35EDEC005B;
	Tue, 12 May 2026 19:47:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id nlNSSYsRFCg0-fwHlyR5l;
	Tue, 12 May 2026 19:47:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778604478;
	bh=5pWz9nArF2Zrub8NMeqq45B5mVOj7NGAOhfY1XGqvNc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=c4YkpoxyJJxnCYNd2svB5nAgROxgnj6jRI4Xip2K2QiCFTqhZTGZRv7YMNCz9LiuN
	 Xh31D9zWUkWN1QrwSPe1lk3Tnh8dvtQUkRlXi4XmRiR5Tz3Ey5I4RhsCTYZNT+7uac
	 vFWDNyw3dJRaAhEqXuO84LJbQetyUSu+LREnl6Ig=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH 4/4] staging: sm750fb: remove double space in assignment
Date: Tue, 12 May 2026 16:41:24 +0000
Message-ID: <20260512164124.188210-5-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512164124.188210-1-ahmet@sezginduran.net>
References: <20260512164124.188210-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove extra space after `=` in assignment of `reg` variable.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index f695a2a61c28..e3225c0c320b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -26,7 +26,7 @@ void sm750_hw_de_init(struct lynx_accel *accel)
 	write_dpr(accel, DE_MASKS, 0xFFFFFFFF);
 
 	/* dpr1c */
-	reg =  0x3;
+	reg = 0x3;
 
 	clr = DE_STRETCH_FORMAT_PATTERN_XY |
 	      DE_STRETCH_FORMAT_PATTERN_Y_MASK |
-- 
2.53.0

