Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB32E0B71;
	Tue,  4 Aug 2026 05:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821147; cv=none; b=JAntQ1q5jWFtaN4w7zgbHR1LuYuGDIJKmWEO6e5R6iLPOR0EricCEslvLEjegQMIu+OK9ncP1WY7kCYi66SL2xWLC7gQBaF5/k/CNWgk2exUwnLZY18EzHPKH7Ah3X4ZaLfiqYMi3M0Tth09BtQm/0LjtDfXzQAf9z++AD9QwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821147; c=relaxed/simple;
	bh=1RbFGfEdVv4WvCJGNOadcakqQOaVHRhyx12pAzG0c2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc+5KY9kHBNAm/Mfl7RE+RFuy8TNC10mHcBAR+iowHM/h8RCZpkw+Pzwe6+AJkAR5n6fOR1UgxVAtyfZisTSjTCU251r0+TgBExVp8N6vQ28m8CcA58wlk6jiUZ9gCk5ZM7ppmb++SeBidxodaHvZ7rKaFCTnQwezOxaXEBLyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C99062006F0;
	Tue, 04 Aug 2026 07:25:40 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1wr7em-002oRb-2O;
	Tue, 04 Aug 2026 07:25:40 +0200
Received: from uol by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1wr7em-0000000ALgp-2dXe;
	Tue, 04 Aug 2026 07:25:40 +0200
From: =?utf-8?Q?Ulrich_=C3=96lmann?= <u.oelmann@pengutronix.de>
To: =?utf-8?Q?M=C3=A0xim?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Rob Herring <robh@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  devicetree@vger.kernel.org,
  Helge Deller <deller@gmx.de>,  linux-fbdev@vger.kernel.org,  Maxime
 Ripard <mripard@kernel.org>,  linux-kernel@vger.kernel.org,  Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
  dri-devel@lists.freedesktop.org,  kernel@pengutronix.de,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
In-Reply-To: <CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com>
	(=?utf-8?Q?=22M=C3=A0xim?= Pedraza Padilla"'s message of "Tue, 4 Aug 2026
 00:04:23
	+0200")
References: <20260731215043.30392-1-maximpedraza@gmail.com>
	<am2mvECnCcO9IxuI@monoceros> <6rbjbj74zh.fsf@pengutronix.de>
	<CAEUXW=EHD1Y1zHQWE=jFhONM5Hg6TTc_uPYHgp-GS-4YWYJN3A@mail.gmail.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Tue, 04 Aug 2026 07:25:40 +0200
Message-ID: <6r5x1q78yz.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Max,

On Tue, Aug 04 2026 at 00:04 +0200, M=C3=A0xim Pedraza Padilla <maximpedraz=
a@gmail.com> wrote:
> El lun, 3 ago 2026 a las 14:39, Ulrich =C3=96lmann
> (<u.oelmann@pengutronix.de>) escribi=C3=B3:
>> independently of the specific implementation, please keep in mind that
>> the kernel is distributed under the GPLv2, which may have implications
>> for a proprietary image embedded in the device tree. That doesn't
>> necessarily have to be a deal-breaker, but it's probably something that
>> should be considered carefully.
>
> Good point, I had not considered it.
>
> A warning could be added to the binding documentation about the licensing
> implications of a proprietary logo, aimed at anyone thinking of
> submitting a device tree carrying one to the kernel tree. I am happy to
> add that in v2 if it is considered useful.

I think the issue is broader than upstream submissions. Once such a
device tree is shipped as part of a GPL kernel in a product, the GPL
obligations already apply to that distribution. Therefore, the licensing
implications of embedding a proprietary logo are not limited to upstream
acceptance, they also affect downstream product distributions.

> Patches 4 and 5 also avoid the question by construction: there the image
> is a separate binary the bootloader loads, and the device tree carries
> only a phandle to the reserved region.

Right, here everything is clearly uncoupled.

> In any case, whether such device trees are accepted is ultimately for the
> device tree maintainers to decide.

As mentioned above, the issue also extends to deployed products.

Those were just my thoughts on the licensing aspect.

Best regards,
Ulrich


> Best regards,
> Max
--=20
Pengutronix e.K.                           | Ulrich =C3=96lmann            =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
