Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FF301004;
	Sat, 23 May 2026 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550514; cv=none; b=o47AWLwC3Qfu7cXinJGXfAVWgGhQz1o0Ydyk9qqQtC8ichIM45DRoPqyj6dWvU0kVuPMO+dMVxXvjDgWe6smF186qvIchTOnLvhSn3pLYUn5TBXX6sXH8hyytfqUIqFTAKThHmo0mKXAJmX7Jwpj8XifyVY1d38NpiNEJWImCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550514; c=relaxed/simple;
	bh=3vcOCVLKdI54zlOmLZt0nGUfq8a8iWY9e/guB2FnVb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=su9/JMx1+3//FxkGPInWQEf62ujvn6iTBysucgpTNAgDM59Vq3JC/G0gDszcpCO8FrU2TcdEpiF+R8hxohG7dsf3cnVkbBwcTLNHoKiuzwR5CUFzBbR0AfxxIPfYyJf3brWK7L6fkM0AzmDdwJ6XaxJJdT4hpqJJfKM+VG+a06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=CAeQzz8B; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="CAeQzz8B"
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 43DBCC0076;
	Sat, 23 May 2026 18:35:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp) with ESMTPSA id 1ZXKP9PgKKo0-Twycgy9H;
	Sat, 23 May 2026 18:35:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779550509;
	bh=gXRSUYFFhyd/LB++9bdkbtSCbhZEmiWnWAwAZLeNeRI=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=CAeQzz8BtAU3B2KkDDIgNnxslRiaQprv9FadRI31ex2aALuA6FUjoqyK8PwfL/INL
	 HBlnVFTgptKdQXbqwCD5zAGf7tjRqdtpEhWN/7DGnwRL/89K1X38OuDT10y15YptQ/
	 XJXtwXTV9scnPqU1MOpEjsi1fe3qvnV7DzycXn+0=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v2 3/4] staging: sm750fb: remove unused struct fields
Date: Sat, 23 May 2026 15:34:58 +0000
Message-ID: <20260523153459.177488-4-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523153459.177488-1-ahmet@sezginduran.net>
References: <20260523153459.177488-1-ahmet@sezginduran.net>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `void *priv` pointer field in following struct definitions:

- `struct lynxfb_crtc`
- `struct lynxfb_output`

Verified that no other code references them.

No functional changes.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
v2: No changes.

 drivers/staging/sm750fb/sm750.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..56d7e1fa4557 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -145,8 +145,6 @@ struct lynxfb_crtc {
 	u16 ypanstep;
 	u16 ywrapstep;
 
-	void *priv;
-
 	/* cursor information */
 	struct lynx_cursor cursor;
 };
@@ -168,7 +166,6 @@ struct lynxfb_output {
 	 * *channel=1 means secondary channel
 	 * output->channel ==> &crtc->channel
 	 */
-	void *priv;
 };
 
 struct lynxfb_par {
-- 
2.53.0

