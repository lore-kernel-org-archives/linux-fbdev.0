Received: from mail-qv2-f6.google.com (mail-qv2-f6.google.com [74.125.230.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB23370D47
	for <linux-fbdev@vger.kernel.org>; Sat, 12 Sep 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789185579; cv=pass; b=hPsthfIElGjK570kDwdLbIHC3e2FVrgc6eWkke2HKgxQyoIdG2A9sIun3iQjSJQUpYodloiaY51TvDzRwVYmvbztEI1IXRSf6mDY/JyOxslF08Y11FHhTKKB2+FsSNhKYg1+ZeuSNFYn9jqhcZBTOkoZzRRwWGHuHRIrkHlGx38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789185579; c=relaxed/simple;
	bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKQt89wZoKxL0BYySeybbAVh/CnFa7BytkA/xriUGcMEdv98QzFN+JXvhCp8o3TZ138qxEJh+6O3Eei1KSZXGXFgGSEHV3Yzu++1mwX37ZXppg9A9fet6qhnee7jnkMx8D0R/7OmUv/wlo3ZAsZRTXqpVXGLb6vg8wdt+CByaZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUi99WX2; arc=pass smtp.client-ip=74.125.230.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUi99WX2"
Received: by mail-qv2-f6.google.com with SMTP id 6a1803df08f44-90cd0a3019eso6292066d6.0
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 20:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789185577; cv=none;
        d=google.com; s=arc-20260327;
        b=PmGpmE/fuClXivxDnXxu17BoTkuhUT/yoYVesXpUmBXbLBVo6DDFCs493TSNK8WiTn
         6effTqlM6cbwGIEXLTgBKGna68MZEnpmHAOLgvwVBboVSNeAFQ+z42zjV32GFIkdzaqy
         TjgpGOBVrRj1my5KGZQrLQ8oelvjWgol+ZRooU6xoip33+3RxG3lGf2C4+VF9aRm2jmQ
         IdSehf6dq2KDdVkZZthd7K68iynkcCinP/JULCjHUmvKJXmiCk1DNM/zwG7jfi7WpHzs
         Q0N2G/p8FMSK7ZDVUdNrb7Mhfvvy3RYv15ANPT+xqwZiZb+Onz8oGKcRStT6rHsdcM+T
         9gdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        fh=GSoqliMrAh0itHRNHIlJONguNavM9JccHbZQeAHa5Ug=;
        b=FdTvMaAO3LWWFwAk5arO/yvK4iRTctAOcgoPhncezQZ26+SbO32y6++epkUHFz4LbE
         xw+ZkYOO+8812DGjSYkYw+aG1JSawb2WKy6jfyGT6RohyqD2iGBcuNvY/b5Mx7f/0eZS
         ED6LzES1jJTQfTSUbTGamhdSXx1uo8/yj71aTqcebn0T2rBG8gwzBDyzNeXvXZkn2vUV
         wxtMlHNkYG8nSyzwGVLZdK/DTBV1PbY+hSAhKUW4LmbJbbfqoPe7Ik8vf1CNZkeZa5qp
         KPAhSZMJLqXmh6QO6LKI2n8/3xSrSGdU0ZXn1RMzY89PT7A3wjX89Uyq+v1b9lF2K549
         uzBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789185577; x=1789790377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=AUi99WX2mjCEnh94Mgz8UyqQU/oNEA9cIEKZBdzKT+z8ihWUMzk831dQkI3koNvu9G
         FOXv9hL+LCMEPxf/E6B6X3tqNMNit0enH6a996hZjF9P1W9Ca9u/JogjBROhVSBVKuKe
         i1ZglNYBRcPU+heleoHDLB4sNQG/UeUlV3ciG1mn4mte93xJ1PyBBaGWQo9SW/MmOyUE
         E2GuwCGaztMXULuWO9e3gDAe+xNSNVCpMSpRBjuIJOXYQi9Lt395uXUGN7PpUrH06Wk6
         hST40P8ADAOoVPLsm4F0dumn5utDUM8S2/msBC6ownOQBTLYS6vL4zC5VkaFucosXqdX
         tFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789185577; x=1789790377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkL3lGBHwiEi97Q6sw1wqPYNFpmHLpnVSD+N4L8TFo0=;
        b=VKvZ5+0ZWKoxOD7vLUGW+NTh0lVKZZaBWiBNvOl4xOXYu87vUvzd+RDGFxecv+ldPD
         sUzew6jdMm0xnXV34/moK7FQJCo/TNjXp4k1z/Bi+GTpLHRmtWfg8ECo79S6+mE4xKQn
         m25IDnTR/u7V8gDGfQNHhDf5LDLjYs5cLA4eRE5XejtAydMP4z3YwVHo+N7lDoDUlC2c
         TvsjLX5wEoEi06zTVp9jhmBnPuhDYmEx5DwQ0fxzg+wBKzDtlocHuOJZjCBCooBFkWr8
         wb6EfqPq6an2acvV24PXk+IlZheb4hyboGkrr0Ox6WIUAnFu4oxi8Wg2w6gFVcLXVq6m
         soLw==
X-Forwarded-Encrypted: i=1; AKwUvBxUC71J23f+TqJTANjflw7gStqboPvBstC9MO994uEgPKzBXqXIRyt+c04aJw/e79kRG9GsWyp/OULIrw==@vger.kernel.org
X-Gm-Message-State: AFuF++mX5QgtHjn+ZmCdraFUrDaautgK5cGqG69faha3tB4MRCjZL9u3
	VuH1BVxCTCxN9Rfd/ybzC01kC0jiTDeTCGcFRe8kiLGCDB2LgromdCaGgeavJl2c9OnvoG6Pb+t
	8Pmf+QTaL81GgjR+iNRWAHewyMOrmSL4=
X-Gm-Gg: AYBFou3Tr11PSc/97oe2ca3jM8g8Y7ZG8AreVA1mZO42cdjkSsukG5xOOFbCD6BKBKN
	iNj4JA613haaoTXIJ2eiFM03M9jgV3gkA1wAigIEF4bjJw6a5MBE5vVVMZWg4c+wEwpHy78XFb3
	c4jX/UZMoAMhe/b1yHENYINXwRhltYa2CS471CdlL1bzwHnlibdY79ckP+LIrjT95Afa2wqYVMp
	xYIrYSiRGjYcLoGqD7sxrmElvZa6zV4wxNQE21Xezzx/2kBndUb7uc6jfo3IQfFPV/Yt+dnh45k
	/Ya2oCjsFVIVQmbWvK8B50mDeuf2x9UDWhhUsKQpOHC+nZAYEUj/uiuh/n8NHjbFzBL3pPk8MgI
	AAP06iyn2G7pfU1mx3L4DPEfnWphpK1gue13Jjqtu
X-Received: by 2002:a05:6214:8446:b0:912:15a8:bd9f with SMTP id
 6a1803df08f44-91215a8ec1dmr55956796d6.7.1789185576987; Fri, 11 Sep 2026
 20:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <aqRI3N5FPX1dpIlk@gmail.com> <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
In-Reply-To: <CADkSEUgkPyikkhqLBOVEeS-H8L7CvUN8VD88=dUuTeFB8pUM5w@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 11 Sep 2026 20:59:26 -0700
X-Gm-Features: AcwNN1VfZ_rXL-z6In5wMRJEgOMU7kPx8LknulegWooIebA5av8sYgSMw6by5S0
Message-ID: <CADkSEUhpe5sX=C5NfUrFMoP9fOGNiFaJ5QmEAVJ=80p8H8S9HQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Karl,

On Fri, Sep 11, 2026 at 7:08=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The Risc PC and NetWinder lost their audio drivers when OSS was
> removed in commit 727dede0ba8afbd8d19116d39f2ae8d19d00033d. RMK was
> working on an ALSA driver for the NetWinder but never finished it
> (IIRC it is in 2.6.0-rmk2 but probably doesn't work).

I just remembered someone wrote an ALSA driver that works on the ISA
card version of the WaveArtist, which would probably be easy to get to
work on the NetWinder:
https://lore.kernel.org/all/1440445816-28593-1-git-send-email-linux@rainbow=
-software.org/

Ethan
