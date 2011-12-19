From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 19 Dec 2011 13:51:24 +0000
Subject: Re: [PATCH] MXSFB: Fix driver registration
Message-Id: <CAAQ0ZWSJ0Yzr2Gk9MBQ0nvVCWxr0yWF_RFTy3isqc0pgEDdRxw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324169888-6687-1-git-send-email-marek.vasut@gmail.com>
In-Reply-To: <1324169888-6687-1-git-send-email-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Marek Vasut <marek.vasut@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, Wolfgang Denk <wd@denx.de>, Stefano Babic <sbabic@denx.de>, Huang Shijie <b32955@freescale.com>, Axel Lin <axel.lin@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-fbdev@vger.kernel.org

Cc-ed Florian and linux-fbdev@vger.kernel.org, as I guess Florian is
the person who will take this patch.

--=A0Regards,Shawn
On 18 December 2011 08:58, Marek Vasut <marek.vasut@gmail.com> wrote:
> The driver should be registered with mxsfb_driver, not with mxsfb_devtype.
> This caused obvious null pointer dereference and crash.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Huang Shijie <b32955@freescale.com>
> Cc: Axel Lin <axel.lin@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =A0drivers/video/mxsfb.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 18742c2..d29c7c0 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -902,7 +902,7 @@ static struct platform_driver mxsfb_driver =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -module_platform_driver(mxsfb_devtype);
> +module_platform_driver(mxsfb_driver);
>
> =A0MODULE_DESCRIPTION("Freescale mxs framebuffer driver");
> =A0MODULE_AUTHOR("Sascha Hauer, Pengutronix");
> --
> 1.7.6.4
>
