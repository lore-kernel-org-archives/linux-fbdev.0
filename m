From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 05 Feb 2020 22:18:21 +0000
Subject: Re: [PATCH 1/3] fbdev/g364fb: Fix build failure
Message-Id: <alpine.LNX.2.22.394.2002060918030.8@nippy.intranet>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463811774-850924153-1580941101=:8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1580610812.git.fthain@telegraphics.com.au>
 <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
 <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
 <08447d52-0007-6f68-3848-209295a61d13@amsat.org>
In-Reply-To: <08447d52-0007-6f68-3848-209295a61d13@amsat.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, open list <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Bogendoerfer <tbogendoerfer@suse.de>, dri-devel@lists.freedesktop.org, Laurent Vivier <laurent@vivier.eu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-850924153-1580941101=:8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 5 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:

> Note, you need to rebase your series due to:
>=20
>   commit 8a48ac339398f21282985bff16552447d41dcfb2
>   Author: Jani Nikula <jani.nikula@intel.com>
>   Date:   Tue Dec 3 18:38:50 2019 +0200
>=20
>       video: constify fb ops across all drivers
>=20

OK.

Thanks for your review.
---1463811774-850924153-1580941101=:8--
