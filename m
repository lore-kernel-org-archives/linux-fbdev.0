Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8D3BB127;
	Sat,  6 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777650; cv=none; b=RjbLQoQCcYG+fgoUx2V4ca9ZYKBuFKkBy5lRyxrExmnN76+8+URRVBx1EtHcEpOhlOnc9V8/vM6p9qRpDTHJ+njdABvsXuTe7isv8PBOrYIPv5Az3K/0xDIEuURoeILlluI4Gv+dp5d5PYeO3Sq0FFob5obV18brwVZDKMoCeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777650; c=relaxed/simple;
	bh=/obGCQ4u8raCYCPae1B0gXZbWF6zDXsp3DFcxfmptzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfPvJu2+azQT7tGLjN9C50yC69M2lfZjezazgMxOD+9zUgaiMBDCHHr+j4Omtv9bhOMsx6ZEbJtfYS+sxCTBxQdmzV+d9qU6wkN3I85E19nXVcqsvUaii1r9nsL/yqLRmL85j2gtfzHVJoc9jjpNRH29iQ0WG3K9yCm2bxpZCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=EYyX6Exf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="EYyX6Exf"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-007NQB-Nh; Sat, 06 Jun 2026 22:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=Bq1xhh7PjUom9z8+i43NNOjTalhx1SZFLg0nAvj3jLg=; b=EYyX6E
	xf8oq1VVUdQGCcKTuaRuELInd3fkWIuPvhbz/MFHNUClONED4J6xm4P6d1wyaJnbpCv79F/9x1rTY
	F4VpxPlUgz/KR7PTeEVvLQ2fbtj6H0S3MbYKdWruRgXZhm8HKSsTTFW6W0/gT0QeyeQDJ1hZ+K0hT
	Q2+Dlw3tSUv0vWoS+RxCDDKAZFEy5RI7CvjRiS9KnSMnOt5rGqpM5eQZsXzhdQkJl2q2fh/LDlvJi
	w0uvMQ+7NzoZ9AMBlFzsvlh6iOH6iwztrnySiAHp8C/elSyiuaydG2Xw4l2Kv6oALH0qmQGWZ2NSz
	dyWN7xhyHkak9R2KCK/zZgEsL/sg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-0005CH-6I; Sat, 06 Jun 2026 22:27:11 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbj-006V18-Ch;
	Sat, 06 Jun 2026 22:27:03 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/riva: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:19 +0100
Message-Id: <20260606202633.5018-25-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/video/fbdev/riva/rivafb-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/riva/rivafb-i2c.c b/drivers/video/fbdev/riva/rivafb-i2c.c
index 6a183375ced1..5ee59be01850 100644
--- a/drivers/video/fbdev/riva/rivafb-i2c.c
+++ b/drivers/video/fbdev/riva/rivafb-i2c.c
@@ -91,7 +91,7 @@ static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name);
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.class		= i2c_class;
 	chan->adapter.algo_data		= &chan->algo;
-- 
2.39.5

