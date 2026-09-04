Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A737C106;
	Fri,  4 Sep 2026 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500900; cv=none; b=N1afhmNTVb1WLb+SbRSlQtDkSr7sqnnyV59m3O4amXDOjfZrXMyZ1+OfWYHw4BPWdsOvc4c50Pg2WMO01XFvKvnrNBC0Aue8Wn+WWYHwPPHZZ8xO7wjHvY4CVwJ33VwWdgTkib9LgGOvL+7OSNoST3cDzOKW7qVLdIgSlEAr+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500900; c=relaxed/simple;
	bh=nTRG8ZSZ4H/hiNYQ88c54TfPICLXerjHa8lyT2x1eog=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SquGRE1R4YqvdQAAaJ7IK2S7ovHsx5Ff4gRnsmsFFrxqycVJSxdjPACda+zOig9Y3KS6s5z5L2XbwtO3PdMsRKzb1z9UX1UUS1+dGSuwJWfWMEwiOYQZ0EZmvlDNb9N7I2/whXCwl1f4aF8bK4VU1lOBqnKhJtruzx7c8hPDd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iG/nZC+r; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iG/nZC+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788500887; x=1788760087;
	bh=kEUTSb9f+CkR7/rItg94sgkcqIObQKv/H0yUJzqRSp0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iG/nZC+rYj50IwFjr37KRIVc7vj8CATlrdlBzzBbKXaoNqMibXhrU4brpIwWgqJxX
	 fgMZETyDf3egWQPe5Cpuy7wo4sXguFnNEh+5+QE5hXoVX+T3blDvdzmzniInnA5v3N
	 VojCyF1txLU5NkKHDH+Ivn8Hv1HCxMfCmAQGPEUTyT8y4W9pvwH/pr5ZMPL/cu0JVj
	 xMzVIk02XBDRXzLmgEt1DYgoiwlHva5RKlrOID77Mx/5/fg87MH65oRQ1optLKRicu
	 fmtEEJhco0fyHY0ErZOQAhXBkSlZvsUmpnnDn57URiuztts9TSkeXbp2ig402oaTjX
	 Mro7sj3AYK5Wg==
Date: Fri, 04 Sep 2026 05:48:04 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: contectforbusiness@proton.me
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] staging: sm750fb: make g_fbmode const to fix checkpatch warning
Message-ID: <KW1s60gR5As9PdhLGq5MQYR9QPxr-tCZUn_dxvjME1PM6lW4ilRIG0gq8mbir7y9oBSlnEIhPq-EkEjHkruVnDNZpsJ-2OF2OIAEZLEZs7E=@proton.me>
Feedback-ID: 147676893:user:proton
X-Pm-Message-ID: f04f51274e6fa22ad2180c7eebb231b8a723548c
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

checkpatch reports:

  WARNING: static const char * array should probably be
  static const char * const

g_fbmode is never modified, so make the pointers const as well.
This quiets the warning and makes the intent clearer.

No functional change.

Signed-off-by: Vaibhav <contectforbusiness@proton.me>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm75=
0.c
index 039e2033f..f731ef53e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor =3D 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] =3D {NULL, NULL};
+static const char * const g_fbmode[] =3D {NULL, NULL};
 static const char *g_def_fbmode =3D "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
