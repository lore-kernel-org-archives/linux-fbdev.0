From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 21 Aug 2017 14:17:58 +0000
Subject: Re: [PATCH] video: fbdev: pxa3xx_gcu: fix error return code in pxa3xx_gcu_probe()
Message-Id: <1746251.LKqyi5Vgub@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170808221735epcas1p41578ae889d438fd96e3162ef45cf701a@epcas1p4.samsung.com>
        <20170808221729.GA2208@embeddedgus>
In-Reply-To: <20170808221729.GA2208@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 08, 2017 05:17:30 PM Gustavo A. R. Silva wrote:
> platform_get_irq() returns an error code, but the pxa3xx_gcu driver
> ignores it and always returns -ENODEV. This is not correct and,
> prevents -EPROBE_DEFER from being propagated properly.
>=20
> Also, notice that platform_get_irq() no longer returns 0 on error:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=E330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
>=20
> Print and propagate the return value of platform_get_irq on failure.
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

