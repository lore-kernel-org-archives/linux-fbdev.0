From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Thu, 09 Dec 2010 14:34:45 +0000
Subject: Re: [PATCH 2/9] ARM i.MX51: rename IPU irqs
Message-Id: <20101209143445.GX17441@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-3-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-3-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 09, 2010 at 02:47:14PM +0100, Sascha Hauer wrote:
> -#define MX51_MXC_INT_IPU_ERR		10
> -#define MX51_MXC_INT_IPU_SYN		11
> +#define MX51_INT_IPU_ERR		10
> +#define MX51_INT_IPU_SYN		11
This one is easy.  Acked-by: me.  Maybe it's worth to do

	git ls-files | xargs perl -p -i -e 's/\bMX51_MXC_INT_/MX51_INT_/

and then fix up the layout damage.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
