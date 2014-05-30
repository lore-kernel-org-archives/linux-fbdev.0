From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 30 May 2014 17:06:21 +0000
Subject: Re: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <5388BA8D.3010707@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?TWFudWVsIFNjaMO2bGxpbmc=?= <manuel.schoelling@gmx.de>, plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, geert@linux-m68k.org, broonie@linaro.org, dh.herrmann@gmail.com, airlied@redhat.com, mtosatti@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/30/2014 06:27 AM, Manuel Sch=C3=B6lling wrote:
> ---
>  drivers/video/console/Kconfig  |    6 +-
>  drivers/video/console/vgacon.c |  124 ++++++++++++++++++++++++----------=
------
>  2 files changed, 79 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index fe1cd01..d7ec96c 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -38,14 +38,14 @@ config VGACON_SOFT_SCROLLBACK
>  	 RAM to allocate for this buffer.  If unsure, say 'N'.
> =20
>  config VGACON_SOFT_SCROLLBACK_SIZE
> -       int "Scrollback Buffer Size (in KB)"
> +       int "Scrollback Buffer Size per console (in KB)"
>         depends on VGACON_SOFT_SCROLLBACK
>         range 1 1024
>         default "64"
>         help
>           Enter the amount of System RAM to allocate for the scrollback
> -	 buffer.  Each 64KB will give you approximately 16 80x25
> -	 screenfuls of scrollback buffer
> +	 buffer for each VGA console. Each 64KB will give you approximately
> +	 16 80x25 screenfuls of scrollback buffer.

Nitpick: CodingStyle says to indent help text 1 tab + 2 spaces.

> =20
>  config MDA_CONSOLE
>  	depends on !M68K && !PARISC && ISA

--=20
~Randy
