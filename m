Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7B82E64A
	for <linux-fbdev@vger.kernel.org>; Sat, 21 Sep 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941988; cv=none; b=FibxcHq5m2zczb2t9vn/O/mzqEeCbiYEwEkAtjVPD9yWK+Bi5cx5sSyF2XbTQhe3kI3lj9OvzuKkixR6Oif4agOYhARYtd+IsPfAWSz683MCIHotXmXQ4sDn3Kjge+Ybp/knNo4r6VDMvJTCDHDRBWcigebELYF2jbbmiyeBxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941988; c=relaxed/simple;
	bh=ba6wvRgxcJKcWDv5hOT5rtYcvN4Y32AJml/EXdH5rGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YZn8wHJ778/CSJfVAixBQ/sNEeQvAJ87+WclKEYf7wXhPHsh3GOfCqZSImRKcWbBvsP6N6Ktm/GBN1Z/y4slN7Fwl0Im9XAw7sgv79S+JKVjFfjsOhcji2gsV6BOHITQQOdUOyUypb6nGcP+3N+7aINaj7/p4PKd974nXUxweB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=FQnnCXGz; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=a/lR+ral; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="FQnnCXGz";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="a/lR+ral"
DKIM-Signature: a=rsa-sha256; b=FQnnCXGzBaCVCsqrUeJHk536eVeBmnAsAQud+K70w0PW5HwKFihSbjyIFO+3TOxP0k3KmLLgszowt9F2fkRfW1jPV/FPMwMxvPanLhVJMYJHM5x11cQpBeOog6Uyk0TlWenPUXfoHWezIgjRMd6xpSac01ISvHsVft62FnyPz96gnp/Hk9S1ALLa5vAXFLHL78wNNemk05OMY+cNtFCRMELljPF6UNgfNFJ0Vvyu+Szi5hc+P+AslRYSsS6OPx/bFguQud75MmlKDewHCFbthVnz4nFpVjWde3XbEX3tQmoL7yZ4B9btsdSK6hjh2hbxvMtyPgvMwKdH03kt8oKPUw==; s=purelymail3; d=lkcamp.dev; v=1; bh=ba6wvRgxcJKcWDv5hOT5rtYcvN4Y32AJml/EXdH5rGY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=a/lR+ralPwgrqRmPsD3A4H1cdMs28Bi6WQCzHGWJ9iEmQO1dvZWPGzxSSvvYi8LSM+yQZC1QbOWcYeZ0C9/OoVIMweUAQ56gGl2zlGdsPv5sysiMdMeJTPDUgwgiH9gi49aeCYcV2gFzXbPPJfT1X+g+oZ5a7oQIVaRiAnnbgAf5Ly6qDxz8qPdtASpZL0p4cPU7t65BmxiJAz/oAddbjbe45GTq8msRLaxwPegFq+OmlQuXA8d7848Pts/X8bjEjg6rGSgAS3ijarR4TDCnc3izhHP4cpYpDatxmxof9xtRSaO4etV+M8Ns1eAPlc6ZI1smnhNPn0BAEhrJdz6rsA==; s=purelymail3; d=purelymail.com; v=1; bh=ba6wvRgxcJKcWDv5hOT5rtYcvN4Y32AJml/EXdH5rGY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48547:7130:null:purelymail
X-Pm-Original-To: linux-fbdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 278810204;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Sep 2024 18:06:17 +0000 (UTC)
From: Fabricio Gasperin <fgasperin@lkcamp.dev>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: sm750fb: Rename function sm750_hw_cursor_setData2
Date: Sat, 21 Sep 2024 15:06:08 -0300
Message-ID: <20240921180612.57657-1-fgasperin@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Renamed from sm750_hw_cursor_setData2 to sm750_hw_cursor_setdata2

Change made in order to silence the camelCase warning from checkpatch.pl

Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
---
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750=
fb/sm750_cursor.c
index eea4d1bd36ce..e95f39b51a2f 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -131,7 +131,7 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor=
, u16 rop,
 =09}
 }
=20
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
 =09=09=09      const u8 *pcol, const u8 *pmsk)
 {
 =09int i, j, count, pitch, offset;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750=
fb/sm750_cursor.h
index b59643dd61ed..308c57e836a7 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -10,6 +10,6 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, i=
nt x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 =09=09=09     const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_setdata2(struct lynx_cursor *cursor, u16 rop,
 =09=09=09      const u8 *data, const u8 *mask);
 #endif
--=20
2.46.1

