Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B72172777
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Sep 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465678; cv=none; b=WLVVVY79T+acj5x7+XH8ZFs3LZYVUF53WZen68fKoD7SIS+tqwBPqeAKYVRaRthEzK6+ttEHwIAB/9tiBG347MAvkF9VzugL6AYIXgoRZfXakhyg6BAwbnkiJwF0fK0N5JgvxpAZkMg6SFS5EKsyAsSCAgiAL79zNfsO66TwYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465678; c=relaxed/simple;
	bh=69YOQWzSC2bqH1BrOBpaojGYM3HqDuEomSdv5BxvE4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uVItg6W+lTXBQHyvDPW3fJVJQyp3pxHRTmrI+ROy12pxmpvDwEFSWkP2qT5/XTfB/YzdP/+rOQ6Y49rhlQuNBZdoRhduQbgMjQkZgikp1NRx28TnoOLOpCLW+gNm0h7Thyjic2Hw2miuxIJh3MwVCzJ0lTszyA1Dskr8vMtxnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=EXJyxVaa; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="EXJyxVaa"
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 80CFA1C0CE7
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Sep 2024 22:34:32 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1727465671; x=1728329672; bh=69YOQWzSC2bqH1BrOBpaojGYM3H
	qDuEomSdv5BxvE4Q=; b=EXJyxVaa8hT+LSevKsqFES6UR3Iul28RR9B58KsWRQe
	Y8V/+gx60+uPo991G9l+6CO+dofWm498GxEn4AhHqwnSclqlHn0HZ9P09Hj8vJ27
	LbXxlOvjimTxrNFmDxCzUzcZEVZjaFFfwIoe5RBEFMudFaTDJWaO+9F1t/UnzULo
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5A7TeO1yyYvV for <linux-fbdev@vger.kernel.org>;
	Fri, 27 Sep 2024 22:34:31 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id EA7D81C0604;
	Fri, 27 Sep 2024 22:34:29 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 2/2] sis_main: Fix strbuf array overflow
Date: Fri, 27 Sep 2024 22:34:24 +0300
Message-Id: <20240927193424.3934247-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The values of the variables xres and yres are placed in strbuf.
These variables are obtained from strbuf1.
The strbuf1 array contains digit characters
and a space if the array contains non-digit characters.
Then, when executing sprintf(strbuf, "%ux%ux8", xres, yres);
more than 16 bytes will be written to strbuf.
It is suggested to increase the size of the strbuf array to 24.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
---
 drivers/video/fbdev/sis/sis_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 03c736f6f3d0..e907fde96ff4 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -183,7 +183,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 {
 	unsigned int j = 0, xres = 0, yres = 0, depth = 0, rate = 0;
 	int i = 0;
-	char strbuf[16], strbuf1[20];
+	char strbuf[24], strbuf1[20];
 	char *nameptr = name;
 
 	/* We don't know the hardware specs yet and there is no ivideo */
-- 
2.30.2

