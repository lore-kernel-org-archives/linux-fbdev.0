From: Grazvydas Ignotas <notasas@gmail.com>
Date: Tue, 09 Feb 2010 10:15:39 +0000
Subject: Re: [PATCH 14/17] OMAP: DSS2: move enable/disable/suspend/resume
Message-Id: <6ed0b2681002090215g4e53851bgb11c5a507bdf6dff@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-12-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-13-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-14-git-send-email-tomi.valkeinen@nokia.com>
	 <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1265644661-3694-15-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Feb 8, 2010 at 5:57 PM, Tomi Valkeinen <tomi.valkeinen@nokia.com> w=
rote:
> Move enable/disable/suspend/resume from omap_dss_device to
> omap_dss_driver.
>
> This is part of a larger patch-set, which moves the control from omapdss
> driver to the display driver.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---

<snip>

> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/driver=
s/video/omap2/displays/panel-tpo-td043mtea1.c
> index f297a46..c6e4a7e 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -262,18 +262,20 @@ static const struct omap_video_timings tpo_td043_ti=
mings =3D {
> =A0 =A0 =A0 =A0.vbp =A0 =A0 =A0 =A0 =A0 =A0=3D 34,
> =A0};
>
> -static int tpo_td043_enable(struct omap_dss_device *dssdev)
> +static int generic_panel_power_on(struct omap_dss_device *dssdev)

I guess you meant tpo_td043_power_on/tpo_td043_power_off?

I'll try to test your both series later this week.
