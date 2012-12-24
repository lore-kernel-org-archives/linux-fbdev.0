From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Dec 2012 12:59:31 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <21195616.A64r85Hc5F@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com> <3133576.BkqAl7V01U@avalon> <CAD025yQoCiNaKvaCwvUWhk_jV70CPhV35UzV9MR6HtE+1baCxg@mail.gmail.com>
In-Reply-To: <CAD025yQoCiNaKvaCwvUWhk_jV70CPhV35UzV9MR6HtE+1baCxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: Jesse Barker <jesse.barker@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org, sunil joshi <joshi@samsung.com>

Hi Vikas,

On Tuesday 18 December 2012 08:31:30 Vikas Sajjan wrote:
> On 17 December 2012 20:55, Laurent Pinchart wrote:
> > Hi Vikas,
> >=20
> > Sorry for the late reply. I now have more time to work on CDF, so delays
> > should be much shorter.
> >=20
> > On Thursday 06 December 2012 10:51:15 Vikas Sajjan wrote:
> > > Hi Laurent,
> > >=20
> > > I was thinking of porting CDF to samsung EXYNOS 5250 platform, what I
> > > found is that, the exynos display controller is MIPI DSI based
> > > controller.
> > >=20
> > > But if I look at CDF patches, it has only support for MIPI DBI based
> > > Display controller.
> > >=20
> > > So my question is, do we have any generic framework for MIPI DSI based
> > > display controller? basically I wanted to know, how to go about porti=
ng
> > > CDF for such kind of display controller.
> >=20
> > MIPI DSI support is not available yet. The only reason for that is that=
 I
> > don't have any MIPI DSI hardware to write and test the code with :-)
> >=20
> > The common display framework should definitely support MIPI DSI. I think
> > the existing MIPI DBI code could be used as a base, so the implementati=
on
> > shouldn't be too high.
> >=20
> > Yeah, i was also thinking in similar lines, below is my though for MIPI
> > DSI support in CDF.
>=20
> o MIPI DSI support as part of CDF framework will expose
>   =A7 mipi_dsi_register_device(mpi_device) (will be called mach-xxx-dt.c
>     file)
>   =A7 mipi_dsi_register_driver(mipi_driver, bus ops) (will be called from
>     platform specific init driver call )
>     =B7 bus ops will be
>       o read data
>       o write data
>       o write command
>  =A7 MIPI DSI will be registered as bus_register()
>=20
> When MIPI DSI probe is called, it (e.g., Exynos or OMAP MIPI DSI) will
> initialize the MIPI DSI HW IP.
>=20
> This probe will also parse the DT file for MIPI DSI based panel, add
> the panel device (device_add() ) to kernel and register the display
> entity with its control and  video ops with CDF.

After discussing the DBI/DSI busses with Tomi Valkeinen we concluded that=20
creating a real bus for DBI and DSI, although possible, wasn't required. DS=
I=20
operations should thus be provided through display entity video source=20
operations. You can find a proposed implementation in Tomi's patch set.

> > I can give this a try. Does the existing Exynos 5250 driver support MIPI
> > DSI ? Is the device documentation publicly available ? Can you point me=
 to
> > a MIPI DSI panel with public documentation (preferably with an existing
> > mainline driver if possible) ?
>
> yeah, existing Exynos 5250 driver support MIPI DSI ass well as eDP.
>=20
>  i think device documentation is NOT available publicly.

--=20
Regards,

Laurent Pinchart

