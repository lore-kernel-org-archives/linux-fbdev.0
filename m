Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6CDC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 29 Jun 2022 13:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiF2NEd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiF2NEc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 29 Jun 2022 09:04:32 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559A1D0E2;
        Wed, 29 Jun 2022 06:04:31 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7510C1C0BCD; Wed, 29 Jun 2022 15:04:30 +0200 (CEST)
Date:   Wed, 29 Jun 2022 15:04:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Yihao Han <hanyihao@vivo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 4.9 08/13] video: fbdev: simplefb: Check before
 clk_put() not needed
Message-ID: <20220629130430.GD13395@duo.ucw.cz>
References: <20220628022657.597208-1-sashal@kernel.org>
 <20220628022657.597208-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <20220628022657.597208-8-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 5491424d17bdeb7b7852a59367858251783f8398 ]
>=20
> clk_put() already checks the clk ptr using !clk and IS_ERR()
> so there is no need to check it again before calling it.

Nice cleanup, but not a bugfix; we don't need it in -stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrxN3gAKCRAw5/Bqldv6
8l0vAJ4hi7VBDbsObGLei7MhiNZd1W/QkwCbBN5YwMYoM34CeEw8AVL19VF1JNk=
=oYg7
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
