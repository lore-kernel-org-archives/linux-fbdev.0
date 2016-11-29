From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Tue, 29 Nov 2016 19:57:21 +0000
Subject: Re: [PATCH v2] video: imxfb: remove the macros for initializing the DMACR
Message-Id: <20161129195721.rwlals7tzusprzpz@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161129074949.taj5bwnhge37pi5e@pengutronix.de>
 <1480449039-14774-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1480449039-14774-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Martin Kaiser <martin@kaiser.cx>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 29, 2016 at 08:50:39PM +0100, Martin Kaiser wrote:
> The current definitions of DMACR_HM() and DMACR_TM() are correct only
> for imx1, they're wrong for imx21.
>=20
> The macros are meant for legacy board files only, they're not applicable
> for boards using device tree.
>=20
> At the moment, there are no boards using these macros. So it should be
> safe to drop them rather than making them work for both imx1 and imx21,
> which would require a change in the platform data struct.
>=20
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
