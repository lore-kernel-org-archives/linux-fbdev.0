From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 03 Aug 2020 19:56:41 +0000
Subject: Re: [PATCH][next] fbdev: Use fallthrough pseudo-keyword
Message-Id: <6dd23644-bace-549f-8053-f0f1f99d9352@embeddedor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200707210539.GA12530@embeddedor>
 <20200803194024.GA525506@ravnborg.org>
In-Reply-To: <20200803194024.GA525506@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sam Ravnborg <sam@ravnborg.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Timur Tabi <timur@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 8/3/20 14:41, Sam Ravnborg wrote:
> On Tue, Jul 07, 2020 at 04:05:39PM -0500, Gustavo A. R. Silva wrote:
>> Replace the existing /* fall through */ comments and its variants with
>> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>> fall-through markings when it is the case.
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highl=
ight=FAllthrough#implicit-switch-case-fall-through
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>=20
> Thanks.
>=20
> Fixed indent in arcfb.c while applying.
> Applied to drm-misc-next and it will appear in 5.10
>=20

Thank you, Sam. :)

--
Gustavo
