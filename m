Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDB3BF68D;
	Sat,  6 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777647; cv=none; b=IA/HvpvSzHdwMtIociQIUreu1NDcrqLu9L7/bpx/pMTxLAyh1CIn5X1f+Gu4kRW7vn0Qgp7BO/IxqdNWcxAXJW3KG3DB6bUbJLyfrtpY8NezEX3e7VwERdqquwZG6i0lTy4hvncYzSyHHLxm0BzH737LoDdq6tsqOnVjem7na8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777647; c=relaxed/simple;
	bh=ckkvTfERwHzMxh6ptV7qX5VqAfXAwWj4TTSRPvdIa8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NL/kIPMLppVwaw6LqTeliCjK+2BPMOShEMoV/gWiKbxwPWiSjss7Rp7yJ10tWf9casodkhBV/paz4Yixzvi9nGlbqAJPTQ0rqSUaaKMYFSmXX6HqOSITmcDw9iNd7qKYh9hccGMadL9xTKHEVtMxyDOQHlr2Fx4pUftbA9fGOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=G+5Ad/Rb; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="G+5Ad/Rb"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbr-007cFk-AS; Sat, 06 Jun 2026 22:27:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=52nPAU5BuYLsnCWku9EMCSnlzqXrTtwWlol8CDwVW6A=; b=G+5Ad/
	RbzXCZD6FU0iWn8B0kwmJtKySu9D0VSRuUEcP97GNH7HB8At+f0pxnbOns5atQncafcfAboIqSd88
	dJhijefRc2YpgdhZFop+9ANNDe98TajYQsgb1wU0ZCGsoeWXCLJQPbzfGf7V0QSpjbmIPL7dgLoUJ
	tHuyYsbHjvsKZz7xMBO6fi+PMZWtoQbRwMMWY7VKrOrwA6+h8TctKGHsITaJF2+ecVRykY6Cwdzyp
	pQjbUVmZHvNSAVysvc0ae+Ff76Zp9ETtTR4I3a9HniYVzjINBuUsxAHw1G9TJbRCW4s6EglCgkkbi
	xFCPHeMSzjuPdkLatwso5E6xmCsQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbq-0000tE-QN; Sat, 06 Jun 2026 22:27:10 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbi-006V18-LJ;
	Sat, 06 Jun 2026 22:27:02 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Russell King <linux@armlinux.org.uk>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/video/fbdev/cyber2000fb: Use strscpy() to copy device name
Date: Sat,  6 Jun 2026 21:26:17 +0100
Message-Id: <20260606202633.5018-23-david.laight.linux@gmail.com>
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

 drivers/video/fbdev/cyber2000fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 2d12f8e96c7e..8fb26e85270e 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1384,7 +1384,7 @@ static struct cfb_info *cyberpro_alloc_fb_info(unsigned int id, char *name)
 	else
 		cfb->divisors[3] = 6;
 
-	strcpy(cfb->fb.fix.id, name);
+	strscpy(cfb->fb.fix.id, name);
 
 	cfb->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
 	cfb->fb.fix.type_aux	= 0;
-- 
2.39.5

