Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774808;
	b=YYQOYBMLHEsvz/8IU80W4JimkIfyvTs9QpknHwHcjZjPOMACljmJw4pD/CuEFsqQrBLv
	 i8N9FgM2kTMNSvBr2Dcrcr4lvtjpCGVALi5EAnODkeVCsK8bk24Syu572txRBh/DedPYg
	 AD6TG7O0nzc6kyhmx1Vbw8pffyi06Sy+YR0Bqyy+z5ZCR/2jQ4CK3FRKkExJipspqbZHK
	 gsmk6XU3bRIRJtP7/cqAYwD27zHh3Z4wIVUUuwWAKPN5SKI73v3gQHeGFtKciOCc/IfXz
	 t+oIHsDB/k2jy8+XEvODACejbEHuNXVS5GUe3QrNQuGlDFBEAdcZov9BZ6a0VNxT04g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774808;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=S4bRI/HlfaIFeVBcrXtuaps8yKtfTuJ9r+oTx9rX7+c=;
	b=euRLxejec5fpYQgHCXI2Utyq7od7Dk5ZvpLNu4gIpQ3WAnYX3DtD9KZUi2JVYhZattly
	 s7IBazuElrRHlCQHz/wj1a1D6/vl1SlqkAiBkVDGA8TGmSoxRryGj0mRWV9vKhmyGbEJE
	 vrtkqix7+Bh61EJpgEsAN0tISRh9bVLg2wMr3Ciz1m+kCAzPMqZ9p58iGbVbPk0BdtHAf
	 aS1NTl65k4sEaSiXCwSQQXmdatuWFreiJClGC304mfUk0CsVSrowmQgjk4eRusLZzMhkE
	 moMmWgR324PuiJGMtBuV5Fb0OsiZe+b6Au66v4zYe/+xMlSTI4NK4v6GEMh+vm7Wnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=frqg7u12;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CD606A31E;
	Fri, 27 Nov 2026 10:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576CD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=frqg7u12
Received: from hawking.lan (ntp.lan [10.0.1.1])
	by www.nmnhosting.com (Postfix) with ESMTPSA id 81CA04C98B;
	Fri, 27 Nov 2026 21:20:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795774802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S4bRI/HlfaIFeVBcrXtuaps8yKtfTuJ9r+oTx9rX7+c=;
	b=frqg7u12UiCu3yQn8J4hgJpeBpHnc53t8X+L4mwl6fHURENZfSMgHu1IW7o5JroQ0hmdZd
	Q6k0MAQrAbufNql1iTN0jToGJcLfoa0375w4GoG0ATC/pnEYwNnL4PYJPKw69gBxo3SwHo
	cvH/QrMBgevZzgTov/Eg479W57ewjt+aPmqli15Au7+lMtvXkv9Q/SV/nkjUrM2fhaV0Qy
	IHge2OjJLy8/yRga0ljp/enQjvIWhUP1V5JYCi8joXVfENvF0EYCPQIvMVWxpa35CM61yD
	0JK74iDTsfYyUVUa99rlVa0XIIj+TRHWXlaAY2tbmNENi0Qi5T1ANJeK5yc6jw==
Message-ID: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb
 HDMI support
From: Alastair D'Silva <alastair@d-silva.org>
To: Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hansg@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland	 <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Date: Fri, 27 Nov 2026 21:20:02 +1100
In-Reply-To: <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
References: <20261127080649.1982883-1-alastair@d-silva.org>
	 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
Autocrypt: addr=alastair@d-silva.org; prefer-encrypt=mutual;
 keydata=mQINBGactvoBEADBFM2HqfQUUM4j40ZQPyYzmnM8S6zrycO0ipDDPMs7nZMzyzGzOdqfS
 VB/tuYvZOOKVWzJuWJ5aT/YyHx54r3L+D5hTkEG0sXPVJky3yTS9sbHEMSLBHb8TVVuhPVPuieV4g
 Nkqg5POMTidk8xAw50WpV++tUlewXVSciehnuCQPXhXMP7FcCh4uO8LdN7E8m7ir1LafKTFfoWPah
 KVT8NGG9r+ucrFcN5F+VnHxTDaI68yRPkNdtUWmp22wIX1KwDCtKFrndYO4p5Hv2hlDKomsuIIHHn
 muQGRwuh0xpf0nVJNF8ETZHMzxQLfo3e/HvxBFOTkwY9w7CuuQFZchbhS0I3PfmGT0+jiNcdfqjDC
 fPPB5uhy+DkR6wO72vuwFYUrpU2mdliDSdKEtWBHulnXMJjpBOXetfIwhI8G2dTVg59lN5i9DvJZc
 7y1Sp+qfZQ4P9qpYZyQEKR4GNDOdnm6F2LW2cZkcyAU/Ii765zdDMTQMIzZNSxT/FcDd0K1voTNRl
 QHbQw+kmIMhzSv2JefcC9oNbE0XYzcBDNP5T3O/4itOQ90GCKQEPAbIPeBjlQif7kkyvo/H6yv4s9
 duuK7zbJD9AID/+KGLkpU3p68VDB/C2ZSb9rQz3p1CJNSfsX/CPk7sPqA7RKZ4a2B0hSJ2pJCncNZ
 KXtMlkkm/FmewARAQABtCdBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz6JAl
 EEEwEKADsWIQTQGemDFwqYyU/dBWv75AdnjVo60gUCZpy2+gIbAwULCQgHAgIiAgYVCgkICwIEFgI
 DAQIeBwIXgAAKCRD75AdnjVo60qHZEACJnLfpS71Hk8bX0CLCNJ5wgqdZD3pBHEdbv9Ux9kRlZp4a
 ZFwlg9ltwBjl2dZP3PLtD9xQdsdYKVippKd5a7ZZC2y81oDaHjeC9LnPYn8+ce3mGE/+gRyoNfToY
 N06DeUNJKSlZ9t11UIqZCgfp12u16/Yrigy8C4ihEeHXlLhNX6JkeJR5gsHXJnC7vSuMZY+Qz2R72
 ZidWg+cd2WDMGop5sbTvc+55q94A7vTMlWzaix5HdbEUA3sd2U0dMBju5QodRGGhDQMcCu64TydRD
 MtMzzOk9ThJ036ze3HASWGOppyQmaw58k+XNzbHlr9Sc1LsFUNF7zpWXac2rzlywbyRAdFIT/TC76
 hy9zOkwIo2nwA/tdIwLx1j0UZPpAMQmcDUvJqZh6sE+fv6HN0yMPr+sSYJmriMt8Z6leCEHQXOHVI
 SI5z5FvV3coMmHYRq6aXpfs/8SLiYgkV3B0HE/E18Y3j1OkeLYoqIH1VfzQZeCSL/S77NYvk60/MV
 1HFSyqLdUR3uWZI4uZzoEcMoB0GX33uCTp2Ntc00+wSntwekCUQLCMLUb7dZrbpVuobHoWWtkiD2I
 uE5kAiaVwwwzM0BUwiM6VzVoKbeECz93rdsNtwoDqM0NtzoISC46H/BKVQ9mRNXDO4ThEBpJ4H2Tn
 mPNRYYcR0u2mNy1EJII04w==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> Hi,
>=20
> On 11/27/26 09:06, Alastair D'Silva wrote:
> > This series adds boot-time simplefb HDMI support for Allwinner A733
> > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
>=20
> Where does it do that and which U-Boot version does?
> I don't think we really want simplefb in the mainline DTs any more,=20
> unless there is a big blocker or delay for proper Linux DE support (like=
=20
> there was back in the A64 days).
> In Jernej's HDMI series he hints about A733 support being pretty=20
> straight-forward with the reworked H616 DE code, so chances are we see=
=20
> proper DE3.5 support in DRM rather sooner than later.
>=20
> Cheers,
> Andre
>=20

I think the blocker was firmware for DE for this SoC - it can be ripped out
of the Orange Pi OS blobs, but that won't be acceptable for linux-firmware.

I'm currently reverse engineering the GPU firmware blob, it's not very larg=
e,
and is a well understood instruction set (MIPs) so that may be a path forwa=
rd
without the vendor contributing the blob to linux-firmware themselves.

--=20
Alastair D'Silva
