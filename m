Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7850276;
	Sat, 23 May 2026 05:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779513330; cv=none; b=pG6mepI294pz1WhFvTxsejMy3LsQRc3hYndoNqdARv5cx7ndb/mdCG0aaVZNLtSra4zlDDW/sw8hWPSAwc2v/0sJm3zR4drHa0FehLBC4DXKiyIAddh3pceki99jVMbPFrVowQoMB33+TXP//Yt6gZmyDyQ9JqU6DQ2kWSvlWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779513330; c=relaxed/simple;
	bh=rXJJ8vJ/Q3LUiSk2agOZ9I7LplORzBOq69KAPAn2nwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YfJxJPBBK4sICMR8cCfnMWiNFZO8nJbqSvZpKLD+tAlKfZaTecw0KosSeVJ2wsJPhFJV0YBE7I49DcF3ZrtK0emfuO2kY0+NvX99QNyBQnvA9HGmOg0h2T0Un4HJH4eT+Wmpicipdk+lr+kNbk0EI0VHp929S2pnyF+zHYDGQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=bwj0ySeu; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="bwj0ySeu"
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 820AFC0060;
	Sat, 23 May 2026 08:15:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp) with ESMTPSA id DFNL0fJe2Ko0-5t1CdBqY;
	Sat, 23 May 2026 08:15:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779513321;
	bh=a4zr0whGbEC/vxBsbOV/my1gAr3xzsNm+4oGW4TfPbc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=bwj0ySeuWW5Skj1MQ3hpyIaYF9LLN5dOuOugdZXEFzFu9lGvI5TUI/k7d1eck3QK/
	 WzrkxEL5w9zlQNORHDxqqZNQyLxUeR7qiEg4EyGBsSeC7dU2iNo8Xk1bPGfZx0xVuG
	 eu82rLtPy4e1qNq8GXDvvsisUobgHSH5glOyxX00=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH 3/5] staging: sm750fb: remove unused struct fields
Date: Sat, 23 May 2026 05:15:07 +0000
Message-ID: <20260523051509.166152-4-ahmet@sezginduran.net>
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

Remove `void *priv` pointer field in following struct definitions:

- `struct lynxfb_crtc`
- `struct lynxfb_output`

Verified that no other code references them.

No functional changes.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
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

