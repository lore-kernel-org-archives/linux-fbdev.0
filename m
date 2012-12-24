From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Dec 2012 14:12:28 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <3445117.L94DmxEvrl@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com> <CAD025yQoCiNaKvaCwvUWhk_jV70CPhV35UzV9MR6HtE+1baCxg@mail.gmail.com> <7255068.DBf2OgseHL@amdc1227>
In-Reply-To: <7255068.DBf2OgseHL@amdc1227>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomasz Figa <t.figa@samsung.com>
Cc: dri-devel@lists.freedesktop.org, Vikas Sajjan <vikas.sajjan@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Tom Gall <tom.gall@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Rob Clark <rob.clark@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, sunil joshi <joshi@samsung.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, linux-media@vger.kernel.org

Hi Tomasz,

On Friday 21 December 2012 11:00:52 Tomasz Figa wrote:
> On Tuesday 18 of December 2012 08:31:30 Vikas Sajjan wrote:
> > On 17 December 2012 20:55, Laurent Pinchart wrote:
> > > Hi Vikas,
> > >=20
> > > Sorry for the late reply. I now have more time to work on CDF, so
> > > delays should be much shorter.
> > >=20
> > > On Thursday 06 December 2012 10:51:15 Vikas Sajjan wrote:
> > > > Hi Laurent,
> > > >=20
> > > > I was thinking of porting CDF to samsung EXYNOS 5250 platform, what
> > > > I found is that, the exynos display controller is MIPI DSI based
> > > > controller.
> > > >=20
> > > > But if I look at CDF patches, it has only support for MIPI DBI based
> > > > Display controller.
> > > >=20
> > > > So my question is, do we have any generic framework for MIPI DSI
> > > > based display controller? basically I wanted to know, how to go abo=
ut
> > > > porting CDF for such kind of display controller.
> > >=20
> > > MIPI DSI support is not available yet. The only reason for that is
> > > that I don't have any MIPI DSI hardware to write and test the code
> > > with :-)
> > >=20
> > > The common display framework should definitely support MIPI DSI. I
> > > think the existing MIPI DBI code could be used as a base, so the
> > > implementation shouldn't be too high.
> > >=20
> > > Yeah, i was also thinking in similar lines, below is my though for
> > > MIPI DSI support in CDF.
> >=20
> > o   MIPI DSI support as part of CDF framework will expose
> > =A7  mipi_dsi_register_device(mpi_device) (will be called mach-xxx-dt.c
> > file )
> > =A7  mipi_dsi_register_driver(mipi_driver, bus ops) (will be called from
> > platform specific init driver call )
> > =B7    bus ops will be
> > o   read data
> > o   write data
> > o   write command
> > =A7  MIPI DSI will be registered as bus_register()
> >=20
> > When MIPI DSI probe is called, it (e.g., Exynos or OMAP MIPI DSI) will
> > initialize the MIPI DSI HW IP.
> >=20
> > This probe will also parse the DT file for MIPI DSI based panel, add
> > the panel device (device_add() ) to kernel and register the display
> > entity with its control and  video ops with CDF.
> >=20
> > I can give this a try.
>=20
> I am currently in progress of reworking Exynos MIPI DSIM code and s6e8ax0
> LCD driver to use the v2 RFC of Common Display Framework. I have most of
> the work done, I have just to solve several remaining problems.

Do you already have code that you can publish ? I'm particularly interested=
=20
(and I think Tomi Valkeinen would be as well) in looking at the DSI operati=
ons=20
you expose to DSI sinks (panels, transceivers, ...).

--=20
Regards,

Laurent Pinchart

