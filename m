Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696A3C5DC5;
	Tue, 23 Jun 2026 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201322; cv=none; b=BSN/rXK8/ZuRgxCXv+4biOF/jqfzgeJ46/w1yW9ObxDTPDDDev2NLfo8QsJCKu9xupiodZ2fgFjR8ky8A98hY7G22hg7EVL41Eebxql56FKlhwtdbQ5wwxOVCUiBKHX2G4kQz2PAcjG3FXoMy/UYVNfJb8twjnOkVUGc0Iz4/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201322; c=relaxed/simple;
	bh=uuDiLL3rWdYC9eTaYQ267+USP5fq+tG1tEtS4TluUqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slx+C3fXYzBUbQSIX1IQUbg2e1llclgBEjFUGsgtXQ9DaudLnUDpnyG70KXGkc1Pr3eVLMAWtpJ/OsnNMwi6di2O0tJ2v+4+9yj4iTWL/lqih75WzCUHs6eFrt4fKMxoriYDjdrmK/fGLGDbCoQWaOSQrvyS7ERKfKvGmh4PVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRgdPpnd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRgdPpnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E6B1F000E9;
	Tue, 23 Jun 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782201321;
	bh=uuDiLL3rWdYC9eTaYQ267+USP5fq+tG1tEtS4TluUqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRgdPpndYJzf46s8QpLYBy5AOGXx9hwsclV7j3ShiFtDg8SPMVkLcSXHceu7gVA12
	 7dcY5tzY4mM797HofjCHmJrl0b8gFTq7+NoleBUPrQeuX72s54fnsA/tcYMu9HUe4N
	 NXJ7VRy+7sJ1LrRqZVprFJ/ix6Vv4xs0lvwiAjsvQfFB9oregY8H+nG/i5/Yr8AHX1
	 aNjM6zMbCLBT5j3Zp7PU/fxlDqCc5vD//EybmnOnxdnVsMk6A1F40PHGYbS2t1L8iF
	 zVC9tEfK0BcB49o/8Y+/yd7nFzE3DNDbt9c6Z71Yuo1uRE0VKinOMKaPbAja4Le9fl
	 mIH3pLZdGjg4g==
Date: Tue, 23 Jun 2026 09:55:18 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org, gregkh@linuxfoundation.org, 
	deller@gmx.de, azuddinadam@gmail.com, chintanlike@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
Message-ID: <20260623-silent-dramatic-crayfish-970cdd@houat>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-5-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gw7ljox4iins6cyc"
Content-Disposition: inline
In-Reply-To: <20260622152506.78627-5-amit.barzilai22@gmail.com>


--gw7ljox4iins6cyc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
MIME-Version: 1.0

Hi,

On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
> The SSD1351 support was added to the ssd130x DRM driver. To avoid
> confusion and irrelevant updates, the staging fb_ssd1351 driver is
> removed.
>=20
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>

fbtft uses a different dt binding iirc, and has a different uABI, so we
should probably keep it around.

Maxime

--gw7ljox4iins6cyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajo74QAKCRAnX84Zoj2+
dnmXAX9P+PJBYkVuU9e3AolV5ij1GbfkoFUpN0wN60OCuslj4w/fGr3BYEMXqoYD
b41D4yEBgLBDEfa8uCc5AlDq4yYn4UgEjNwttY0JaZRx4btU/jCkbEOf54AUNVMb
ZqzRxMu2+A==
=K+pu
-----END PGP SIGNATURE-----

--gw7ljox4iins6cyc--
