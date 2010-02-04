From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Thu, 04 Feb 2010 23:05:12 +0000
Subject: Re: [PATCH 2/2] OMAP: DSS2: OMAPFB: implement
Message-Id: <20100204230512.GA10145@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265297486-22438-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1265297486-22438-2-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thu, Feb 04, 2010 at 05:31:26PM +0200, Tomi Valkeinen wrote:
> Previously the only place to get the size of the display was from the
> DSS's sysfs interface, making, for example, configuring overlays and doing
> updates on manual displays more difficult.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/omapfb/omapfb-ioctl.c |   18 ++++++++++++++++++
>  include/linux/omapfb.h                    |    7 +++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)
>=20
<snip>
> @@ -216,6 +217,12 @@ struct omapfb_tearsync_info {
>  	__u16 reserved2;
>  };
> =20
> +struct omapfb_display_info {
> +	__u16 width;
> +	__u16 height;

How about adding the physical display size here as well? I suppose
mm is the standard unit for such things but for small displays more
accuracy might be nice.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
