Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDB43634C;
	Mon, 11 May 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519895; cv=none; b=CEDAREeAa48oJKi7aU1McNSE5n+bXKEkekrOFqb2oYZf3oVg2JWg+WrAZF9TjgOAfBJKOYdZkaDv8ev4jB7k2Vgc5e3cMQyyLZSBJ6x9yRjbignauq7odr8fglddLMcIyxQxeiSc6genrBGJGv0PL/3wYhc58zeR1HWuC0YMiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519895; c=relaxed/simple;
	bh=3b1ey4s+j/rcHtrlueColybGTzJobJglJFXkqb/Z498=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lgS5LjcUZ8q+l0TB+O0ga+n7NhYRwLutdv+QMcgzVBIK1iXQkTJUF7lUffl9FAiPrqyaEUd06U3lYThHg2Epufnn+4EQy1B2nUoex/vNoFbCyyZWab3O6ARXEzbgv0bJK23ELaE0U6N2Bvn6vu6r3WPz10xwYsW1rm9kgON/JDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net; spf=pass smtp.mailfrom=sezginduran.net; dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b=X1XPaZLp; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sezginduran.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sezginduran.net header.i=@sezginduran.net header.b="X1XPaZLp"
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:2e1d:0:640:64e7:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id CE08D806BB;
	Mon, 11 May 2026 20:18:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp) with ESMTPSA id wHNYhLuS98c0-Dh88qiOc;
	Mon, 11 May 2026 20:18:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sezginduran.net;
	s=mail; t=1778519881;
	bh=ZwCHnhMOtidX/cU4ul598k9ai+zQLtAAXVLmm5J9OXo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=X1XPaZLpXGd0YmJjmZcaN3+ceNFWBcDG2uCdKFmKPLhk1N4pbqXqNCty5yaN/y8Ly
	 0Pvd+yAn0IkRHAHEvztj14mYbtgr6c0ufxURLg8GoIaVQ0QZOovZ/NJH8KQ3cM6luS
	 orXpmWi8AfpVArEZN6eqseRXP7KD/itEtEZZIra0=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@sezginduran.net
From: Ahmet Sezgin Duran <ahmet@sezginduran.net>
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ahmet Sezgin Duran <ahmet@sezginduran.net>
Subject: [PATCH] staging: sm750fb: remove unnecessary initializations
Date: Mon, 11 May 2026 20:17:45 +0300
Message-ID: <20260511171745.79646-1-ahmet@sezginduran.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove two instances of `de_ctrl = 0` initializations since the
variable is overridden unconditionally before being used.

Signed-off-by: Ahmet Sezgin Duran <ahmet@sezginduran.net>
---
 drivers/staging/sm750fb/sm750_accel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index ec2f0a6aa57d..5ba1af274730 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -159,7 +159,6 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 
 	direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
-	de_ctrl = 0;
 
 	/* If source and destination are the same surface, need to check for overlay cases */
 	if (source_base == dest_base && source_pitch == dest_pitch) {
@@ -326,7 +325,7 @@ int sm750_hw_imageblit(struct lynx_accel *accel, const char *src_buf,
 	unsigned int bytes_per_scan;
 	unsigned int words_per_scan;
 	unsigned int bytes_remain;
-	unsigned int de_ctrl = 0;
+	unsigned int de_ctrl;
 	unsigned char remain[4];
 	int i, j;
 	int ret;
-- 
2.54.0

