Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6434364AE
	for <linux-fbdev@vger.kernel.org>; Sat, 21 Sep 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941990; cv=none; b=NUkin8fOau6bKFDk46u0mCSZQg9wNWQEYHDKW2nNb/m8UEh/CqUwvPgeY5bkdJ1WSQc+wgyc6iElp1eUMfTpMXjQG5XWMqDt8BChxAWHeK6EcbP3pHDAKRmF06d5cMYhAX7XdiVTwtYlMfZrhEjsiMXN5YN7LP//X21oBDyUqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941990; c=relaxed/simple;
	bh=xV7IefKZSXiYmu7IBZd5OBYJgnAsclhZjkME++M84kU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onxhw/m6mBvAUkawtR4tVpmoIb4U9DAaEMoEcClvqhTqXPApY++B5VHt2ejZ8SYFtTOAeCsUiGclOTQbfu/nrmVIRquTgJVFO26R3+jv9R07DYXBlmQEUUW+l9QLV4+qBGNVA/uN1NH2jwKTt9m03XnTh3yQN50sJCdVeDTpEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=AWAmYNxr; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=UUoGBLR2; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="AWAmYNxr";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="UUoGBLR2"
DKIM-Signature: a=rsa-sha256; b=AWAmYNxrd5xKkljEmErX5IK+FIzPTTqeha7MMEL3V7Lru9paS7VbsiReA+VtgqGm5qQo1RSaPNpFByDZlmL7HVhWmN5nV8wNjol8qEdqMxChj0gw7aENIgfpkCMVbTKRApuSzG6Ohq7qUvE3DYLnlm2VvviQWQvAqxSK7/8ysmladI05J4Z/+dSBSIi6cM5Eb6QIkXw/CCKJ2ik1lfvMyNHw5/r8jnz6Y15QGEzX1SE2H7Feltocm1gaUwhzZd9hjiLfMQ0Flj02vGMvJihYBO6iOdVZ5GqNYqRhmnzU1aGviSE9JVZUwOLm0LVBWx6ogMWuIuzfqQw8/4/nYGRmgQ==; s=purelymail3; d=lkcamp.dev; v=1; bh=xV7IefKZSXiYmu7IBZd5OBYJgnAsclhZjkME++M84kU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=UUoGBLR2WFVbwKksfFaAOMj068oXWUk1BLHRU0xHUcCawr4HSS3EdRvEm+91j6LbR80zuszZruLKCs4RlB3apInmxrzY+pq1/kHwq4D0wWCTnxiPVV5WXUG7qZD9/hgc+GPvbaWVa7latUOQmhlm7Lwj27ywGEpIkyGJIvAt1HJG2SG1tawLTFqq0skNf1E3CrdF6136FeTmCyeTpGVdQe6Hn23RMx0Ntrm6TWCYlM3c+6hQzPYDPUELwzbCDMDcsVLGzsWeomvw7GKOcb7j35XKw3RevC014hf4prZrGf5mh1VVlumBANyiPIUPVwVJR49vwMKyIiH2wuPXKnnqGQ==; s=purelymail3; d=purelymail.com; v=1; bh=xV7IefKZSXiYmu7IBZd5OBYJgnAsclhZjkME++M84kU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 48547:7130:null:purelymail
X-Pm-Original-To: linux-fbdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 278810204;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Sep 2024 18:06:19 +0000 (UTC)
From: Fabricio Gasperin <fgasperin@lkcamp.dev>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: sm750: Fix missing config in Kconfig
Date: Sat, 21 Sep 2024 15:06:09 -0300
Message-ID: <20240921180612.57657-2-fgasperin@lkcamp.dev>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240921180612.57657-1-fgasperin@lkcamp.dev>
References: <20240921180612.57657-1-fgasperin@lkcamp.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Fixes the following compilation error:

ERROR: modpost: "fb_io_read" [drivers/staging/sm750fb/sm750fb.ko] undefined=
!
ERROR: modpost: "fb_io_write" [drivers/staging/sm750fb/sm750fb.ko] undefine=
d!
ERROR: modpost: "fb_io_mmap" [drivers/staging/sm750fb/sm750fb.ko] undefined=
!

Signed-off-by: Fabricio Gasperin <fgasperin@lkcamp.dev>
---
 drivers/staging/sm750fb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/Kconfig b/drivers/staging/sm750fb/Kcon=
fig
index 08bcccdd0f1c..eca1aa43d725 100644
--- a/drivers/staging/sm750fb/Kconfig
+++ b/drivers/staging/sm750fb/Kconfig
@@ -3,6 +3,7 @@ config FB_SM750
 =09tristate "Silicon Motion SM750 framebuffer support"
 =09depends on FB && PCI && HAS_IOPORT
 =09select FB_MODE_HELPERS
+=09select FB_IOMEM_FOPS
 =09select FB_CFB_FILLRECT
 =09select FB_CFB_COPYAREA
 =09select FB_CFB_IMAGEBLIT
--=20
2.46.1

