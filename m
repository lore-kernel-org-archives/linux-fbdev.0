Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C990568534;
	Wed,  9 Sep 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960939; cv=none; b=abmLtQ5iupqNZWolM4jtv+3KHdJe+KhQgu8JTXI5WO2SMYSa+Z5ySR/vnEWY5IJ2IyqiVENqw5DheGjwt4M47iVmOyaWdtHsbmpoGJt8Ml8QGOrjijum2D5cdoF5luxIPq0Q+Yl4A9Lsmc8UniSKJOCOT7HwrR6/8W6vTp1JvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960939; c=relaxed/simple;
	bh=UvIq/cjJV1hrTOlrWNf3iiQyvG0huFuuj7qysrrM2u8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BiOmMJTe1QglxaQ2B3AydYVnhCpqXf3UWf4G4b7vH0yz+htm3kl4Guy9rJbwAksSA6Yk3TE4horf0gutEElwVPaSc27eZmJ/0W/6MbHRk9m7fEQbz7n8NlC4TqrT48prKuHC5BdJW2xOi6DjPGScxPXeMKI9HXbzRNn0rtP9Qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IsLU78/n; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IsLU78/n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788960929; x=1789220129;
	bh=8FP9wEWR+OQlwhcDhoPZ/PVqsFTANFAKvO8FGTeDz5s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IsLU78/nM9lNpcWcpMwTAnDNWCElDiEwffkCVgRIlLxY+ydaX3ujG/Jn2RkgzL1RR
	 OGvyg3Euo6jRpusAnLX/2f8npgfJrIBzDY+KfffjCPgsdJ9/q0OTlCbiYIU5z/J/XH
	 HGvp/n8XCPpg6Si3CqoLAoy4m7LridPSe7iktxNZhFKKn+zTWqqdgJtwQF0CLOmL7J
	 t+BElI4ppSVVzYWzhyJ1vXThJGxqH+9hBy+fXxIz03TQfT9ozGpJjrYKSPZvbbqFA2
	 gnqG2pV3HaKkqbWz4/zhHcMVZ0uf5RWCfCVOD7lE+ICfdPjPDHxRa7u+v20ceIkPe2
	 fC855vEIag/Fw==
Date: Wed, 09 Sep 2026 13:35:23 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: contectforbusiness@proton.me
Cc: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: sm750fb: make g_fbmode const to fix checkpatch warning
Message-ID: <z52NAZ-Y9CZbDesqE3fyIEJdUIJnqeIXj6HhArNIjnT8tw7wQcT6uhT7KdZlC7h11AB5X8AQG1EG96GalUwNUGtCy6XFKqCkeazSTpmEzPk=@proton.me>
In-Reply-To: <KW1s60gR5As9PdhLGq5MQYR9QPxr-tCZUn_dxvjME1PM6lW4ilRIG0gq8mbir7y9oBSlnEIhPq-EkEjHkruVnDNZpsJ-2OF2OIAEZLEZs7E=@proton.me>
References: <KW1s60gR5As9PdhLGq5MQYR9QPxr-tCZUn_dxvjME1PM6lW4ilRIG0gq8mbir7y9oBSlnEIhPq-EkEjHkruVnDNZpsJ-2OF2OIAEZLEZs7E=@proton.me>
Feedback-ID: 147676893:user:proton
X-Pm-Message-ID: d48efaa0481a959b39cf2c693198d246cb67d856
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

Signed-off-by: Vaibhav Agarwal <contectforbusiness@proton.me>
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

