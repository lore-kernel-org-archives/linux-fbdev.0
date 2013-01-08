From: Tomasz Figa <t.figa@samsung.com>
Date: Tue, 08 Jan 2013 16:36:39 +0000
Subject: Re: [RFC v2 0/5] Common Display Framework
Message-Id: <1987992.4TmVjQaiLj@amdc1227>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353620736-6517-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <3584709.mPLC5exzRY@avalon> <50EBF10A.7080906@stericsson.com>
In-Reply-To: <50EBF10A.7080906@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Tom Gall <tom.gall@linaro.org>, Ragesh Radhakrishnan <Ragesh.R@linaro.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Rob Clark <rob.clark@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, sunil joshi <joshi@samsung.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Bryan Wu <bryan.wu@canonical.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Vikas Sajjan <vikas.sajjan@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sebastien Guiriec <s-guiriec@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Tuesday 08 of January 2013 11:12:26 Marcus Lorentzon wrote:
> On 01/08/2013 09:18 AM, Laurent Pinchart wrote:
> > On Thursday 27 December 2012 15:43:34 Tomasz Figa wrote:
> >> >  On Monday 24 of December 2012 15:12:28 Laurent Pinchart wrote:
> >>> >  >  On Friday 21 December 2012 11:00:52 Tomasz Figa wrote:
> >>>> >  >  >  On Tuesday 18 of December 2012 08:31:30 Vikas Sajjan=20
wrote:
> >>>>> >  >  >  >  On 17 December 2012 20:55, Laurent Pinchart wrote:
> >>>>>> >  >  >  >  >  Hi Vikas,
> >>>>>> >  >  >  >  > =20
> >>>>>> >  >  >  >  >  Sorry for the late reply. I now have more time to
> >>>>>> >  >  >  >  >  work on CDF, so
> >>>>>> >  >  >  >  >  delays should be much shorter.
> >>>>>> >  >  >  >  > =20
> >>>>>> >  >  >  >  >  On Thursday 06 December 2012 10:51:15 Vikas Sajjan =

wrote:
> >>>>>>> >  >  >  >  >  >  Hi Laurent,
> >>>>>>> >  >  >  >  >  > =20
> >>>>>>> >  >  >  >  >  >  I was thinking of porting CDF to samsung
> >>>>>>> >  >  >  >  >  >  EXYNOS 5250 platform,
> >>>>>>> >  >  >  >  >  >  what I found is that, the exynos display
> >>>>>>> >  >  >  >  >  >  controller is MIPI DSI
> >>>>>>> >  >  >  >  >  >  based controller.
> >>>>>>> >  >  >  >  >  > =20
> >>>>>>> >  >  >  >  >  >  But if I look at CDF patches, it has only
> >>>>>>> >  >  >  >  >  >  support for MIPI DBI
> >>>>>>> >  >  >  >  >  >  based Display controller.
> >>>>>>> >  >  >  >  >  > =20
> >>>>>>> >  >  >  >  >  >  So my question is, do we have any generic
> >>>>>>> >  >  >  >  >  >  framework for MIPI DSI
> >>>>>>> >  >  >  >  >  >  based display controller? basically I wanted
> >>>>>>> >  >  >  >  >  >  to know, how to go
> >>>>>>> >  >  >  >  >  >  about porting CDF for such kind of display
> >>>>>>> >  >  >  >  >  >  controller.
> >>>>>> >  >  >  >  > =20
> >>>>>> >  >  >  >  >  MIPI DSI support is not available yet. The only
> >>>>>> >  >  >  >  >  reason for that is
> >>>>>> >  >  >  >  >  that I don't have any MIPI DSI hardware to write
> >>>>>> >  >  >  >  >  and test the code
> >>>>>> >  >  >  >  >  with:-)
> >>>>>> >  >  >  >  > =20
> >>>>>> >  >  >  >  >  The common display framework should definitely
> >>>>>> >  >  >  >  >  support MIPI DSI. I
> >>>>>> >  >  >  >  >  think the existing MIPI DBI code could be used as
> >>>>>> >  >  >  >  >  a base, so the
> >>>>>> >  >  >  >  >  implementation shouldn't be too high.
> >>>>>> >  >  >  >  > =20
> >>>>>> >  >  >  >  >  Yeah, i was also thinking in similar lines, below
> >>>>>> >  >  >  >  >  is my though for
> >>>>>> >  >  >  >  >  MIPI DSI support in CDF.
> >>>>> >  >  >  > =20
> >>>>> >  >  >  >  o   MIPI DSI support as part of CDF framework will
> >>>>> >  >  >  >  expose
> >>>>> >  >  >  >  =A7  mipi_dsi_register_device(mpi_device) (will be
> >>>>> >  >  >  >  called mach-xxx-dt.c
> >>>>> >  >  >  >  file )
> >>>>> >  >  >  >  =A7  mipi_dsi_register_driver(mipi_driver, bus ops)
> >>>>> >  >  >  >  (will be called
> >>>>> >  >  >  >  from platform specific init driver call )
> >>>>> >  >  >  >  =B7    bus ops will be
> >>>>> >  >  >  >  o   read data
> >>>>> >  >  >  >  o   write data
> >>>>> >  >  >  >  o   write command
> >>>>> >  >  >  >  =A7  MIPI DSI will be registered as bus_register()
> >>>>> >  >  >  > =20
> >>>>> >  >  >  >  When MIPI DSI probe is called, it (e.g., Exynos or
> >>>>> >  >  >  >  OMAP MIPI DSI)
> >>>>> >  >  >  >  will initialize the MIPI DSI HW IP.
> >>>>> >  >  >  > =20
> >>>>> >  >  >  >  This probe will also parse the DT file for MIPI DSI
> >>>>> >  >  >  >  based panel, add
> >>>>> >  >  >  >  the panel device (device_add() ) to kernel and
> >>>>> >  >  >  >  register the display
> >>>>> >  >  >  >  entity with its control and  video ops with CDF.
> >>>>> >  >  >  > =20
> >>>>> >  >  >  >  I can give this a try.
> >>>> >  >  > =20
> >>>> >  >  >  I am currently in progress of reworking Exynos MIPI DSIM
> >>>> >  >  >  code and
> >>>> >  >  >  s6e8ax0 LCD driver to use the v2 RFC of Common Display
> >>>> >  >  >  Framework. I
> >>>> >  >  >  have most of the work done, I have just to solve several
> >>>> >  >  >  remaining
> >>>> >  >  >  problems.
> >>> >  > =20
> >>> >  >  Do you already have code that you can publish ? I'm
> >>> >  >  particularly
> >>> >  >  interested (and I think Tomi Valkeinen would be as well) in
> >>> >  >  looking at
> >>> >  >  the DSI operations you expose to DSI sinks (panels,
> >>> >  >  transceivers, ...).
> >> > =20
> >> >  Well, I'm afraid this might be little below your expectations, but
> >> >  here's an initial RFC of the part defining just the DSI bus. I
> >> >  need a bit more time for patches for Exynos MIPI DSI master and
> >> >  s6e8ax0 LCD.
> >=20
> > No worries. I was particularly interested in the DSI operations you
> > needed to export, they seem pretty simple. Thank you for sharing the
> > code.
> FYI,
> here is STE "DSI API":
> http://www.igloocommunity.org/gitweb/?p=3Dkernel/igloo-kernel.git;a=3Dblo=
b;f
> =3Dinclude/video/mcde.h;hI9ce5cfecc9ad77593e761cdcc1624502f28432;hb=3DHEAD
> #l361
>=20
> But it is not perfect. After a couple of products we realized that most
> panel drivers want an easy way to send a bunch of init commands in one
> go. So I think it should be an op for sending an array of commands at
> once. Something like
>=20
> struct dsi_cmd {
>      enum mipi_pkt_type type; /* MIPI DSI, DCS, SetPacketLen, ... */
>      u8 cmd;
>      int dataLen;
>      u8 *data;
> }
> struct dsi_ops {
>      int dsi_write(source, int num_cmds, struct dsi_cmd *cmds);
>      ...
> }

Yes, this should be flexible enough to cover most of (or even whole) DSI=20
specification.

However I'm not sure whether the dsi_write name would be appropriate,=20
since DSI packet types include also read and special transactions. So,=20
according to DSI terminology, maybe dsi_transaction would be better?

>=20
> The rest of "DSI write API" could be made helpers on top of this one op.
> This grouping also allows driver to describe intent to send a bunch of
> commands together which might be of interest with mode set (if you need
> to synchronize a bunch of commands with a mode set, like setting smart
> panel rotation in synch with new framebuffer in dsi video mode).
>=20
> I also looked at the video source in Tomi's git tree
> (http://gitorious.org/linux-omap-dss2/linux/blobs/work/dss-dev-model-cdf
> /include/video/display.h). I think I would prefer a single "setup" op
> taking a "struct dsi_config" as argument. Then each DSI
> formatter/encoder driver could decide best way to set that up. We have
> something similar at
> http://www.igloocommunity.org/gitweb/?p=3Dkernel/igloo-kernel.git;a=3Dblo=
b;f
> =3Dinclude/video/mcde.h;hI9ce5cfecc9ad77593e761cdcc1624502f28432;hb=3DHEAD
> #l118

Yes, this would be definitely better, because such configuration changes=20
usually come together (i.e. display connected, which needs complete=20
reconfiguration of all parameters).

> And I think I still prefer the dsi_bus in favor of the abstract video
> source. It just looks like a home made bus with bus-ops ... can't you do
> something similar using the normal driver framework? enable/disable
> looks like suspend/resume, register/unregister_vid_src is like
> bus_(un)register_device, ... the video source anyway seems unattached
> to the panel stuff with the find_video_source call.

DSI needs specific power management. It's necessary to power up the panel=20
first to make it wait for Tinit event and then enable DSI master to=20
trigger such event. Only then rest of panel initialization can be=20
completed.

Also, as discussed in previous posts, some panels might use DSI only for=20
video data and another interface (I2C, SPI) for control data. In such case =

it would be impossible to represent such device in a reasonable way using=20
current driver model.

Best regards,
--=20
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform

