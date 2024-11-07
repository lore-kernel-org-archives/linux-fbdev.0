Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835F5216DE8;
	Thu,  7 Nov 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000672; cv=none; b=muKC8TSm9LYqUKqQqVtubYD2CtN+ABzxBrfA6JkXaWlbenM9nP70utY8uzXq5lPjxe4EsudkZVwVvX8jxHu2IidCspDqKHpNeMR81lq8QmrupWY+iIm5gzptLiESZAt24boZEFDe87h/YBlpUAgInQS2PKOy6PqvhoLYC7LpoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000672; c=relaxed/simple;
	bh=rGm9TKtC9pG+PyfsDAV3zcBspMfEKdxxpnQ3BUIFJpM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEUADfciX/URARypJecR9G8cvvnFoT9/1bXkZgWRFDWKW+cJo9KaM3MFEhgjaEHhOCHaMTCDOEVE6YCNbJhOmgGo2VsDqLr1Cp54mHBM+/dLvhbkKAo2we14CWmt/xeapDFWSg3kBRa5Cyimya2zStvV+PPKeZgWdFRAXXG71mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xC+ZdwHF; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xC+ZdwHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000668; x=1731259868;
	bh=vDwUmJ+V8Rw4gV6rJzkYvpJL3+x5/BhgO2ef5/F5Ci8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=xC+ZdwHFdtnThaiVEOXMZGW5CIV2YMyv4gwjukPpwEXJihn25gi/0XRaVIO2+vPUb
	 yZymRULuH9YYqbZoIWajgZVK9GBQsMPDwmhmsz8myP4xr9a6UsO4txZyHt2qZizFR0
	 rjdgMzB0Do2P4tPc7+3JhAKnvhcIws/S9qFr71uDgkellkzMdxIoXB+HXxmj77fZwO
	 1rdKdnkQqwboA6a8JsoGj3PDEHwHpMLgOeAxbG9TSlGF4UauEd/U72U5ftsv08Le/B
	 NyWsj/j22DLwiImw8VllxbzHNkoznfRiELWOa3/4t7lIL0wshKkW2cIZkMAnu296T9
	 0orqCHMvuIBjw==
Date: Thu, 07 Nov 2024 17:31:03 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 3/4] staging: rtl8723bs: Remove TODO contact information
Message-ID: <20241107172908.95530-4-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: eaa5207692cc5047455d3f2c6df96d7f2dccde6c
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove contact information from TODO file, as it is redundant and can
get stale easily.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8723bs/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TOD=
O
index 4c413f9d3df0..050dcd0bffab 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -6,6 +6,3 @@ TODO:
   of them will require refactoring
 - merge Realtek's bugfixes and new features into the driver
 - switch to use MAC80211
-
-Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>=
,
-Hans de Goede <hdegoede@redhat.com> and Larry Finger <Larry.Finger@lwfinge=
r.net>.
--=20
2.34.1


