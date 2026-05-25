Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A113E51D7;
	Mon, 25 May 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699728; cv=none; b=VzkRm7f0mrm++XF0f4tMB6+s0rRvAfSLFTHtoEAgt9Wj1xkACaA+4meoVt5cNggL3IyKhTB7LXmPfl81L0Ru+Yq18eVGMosAXAPIB9go1l2F67UfqOcf+PdWX3FBC/NNdR37OBjYxKlTQ2YdRVSFbBI4FZNqk8WcgvF/Mc2XlQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699728; c=relaxed/simple;
	bh=m6L+WfQLukfJ22CKlgkSOtM5gPXeJyBJLhrq8GT0VB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si/WqFXbAa17eHrpdNBnwoorUgTA2HV8nHwm9OwDeAs0IIt2x8rhv+cpjqiZ74q2ofI4M7LVXATWLYOthBj5AFX1aHnUWrGQOEyYjiIhvM3AhrheZ4u9SQmD9/PD81EuWnZmqTAzHtLAXFNyv7Y8ECyNvYBcmOk3GjLfV7iP8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=o3IpaLG2; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="o3IpaLG2"
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1f87:0:640:a06a:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id AFD5CC00B4;
	Mon, 25 May 2026 12:01:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id m1TmE1aggiE0-zAkZ6PMF;
	Mon, 25 May 2026 12:01:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1779699718;
	bh=I8w+TyAHpYs0JHwiH+Wa6bU8NvFSAdJAPI4qLhqSZlc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=o3IpaLG25YDSvWN7xJO6mQ9jDK/S6XIhP4VYuftrrCiUuzbB4V4rbHz3xH8jdhRh/
	 t/ADFxziA8KOuA/1nIgKPCTJggAO+YdQvLNk5xF1+pkX+QW0n0DStyW13Kt7ELNLgf
	 bjc7uljHc84nG8Dqx3lncZVLQcdOJtFeA1O40CGA=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH v3 3/4] staging: sm750fb: remove unused struct fields
Date: Mon, 25 May 2026 08:58:07 +0000
Message-ID: <20260525085808.171974-4-ahmet@sezginduran.net>
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

Remove `void *priv` pointer field in following struct definitions:

- `struct lynxfb_crtc`
- `struct lynxfb_output`

Verified that no other code references them.

No functional changes.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
v3: No changes.
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
2.54.0

