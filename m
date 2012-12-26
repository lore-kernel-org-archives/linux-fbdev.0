From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Dec 2012 12:14:46 +0000
Subject: Re: [RFC 0/6] Common Display Framework-T
Message-Id: <13987428.Pqxt44thym@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
	<5024715.KeGkjOKZ3Q@avalon>
	<CAGm_ybjbVbKDFCdMtqZhBOxkBCb-8kO4kwEXRLFsrNQqCvezwg@mail.gmail.com>
In-Reply-To: <CAGm_ybjbVbKDFCdMtqZhBOxkBCb-8kO4kwEXRLFsrNQqCvezwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vikas Sajjan <sajjan.linux@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org

Hi Vikas,

On Monday 24 December 2012 12:33:50 Vikas Sajjan wrote:
> On Wed, Dec 19, 2012 at 6:51 PM, Laurent Pinchart wrote:
> > On Friday 14 December 2012 16:27:26 Tomi Valkeinen wrote:
> >> Hi,
> >> 
> >> I have been testing Common Display Framework on OMAP, and making changes
> >> that I've discussed in the posts I've sent in reply to the CDF series
> >> from Laurent. While my CDF code is rather hacky and not at all ready, I
> >> wanted to post the code for comments and also as a reference code to my
> >> posts.
> >> 
> >> So here is CDF-T (Tomi-edition =).
> > 
> > We've discussed your approach extensively face-to-face today so I won't
> > review the patches in detail, but I will instead summarize our discussion
> > to make sure we understood each other (and let other developers jump in).
> > 
> > For the purpose of this discussion the term "display controller driver"
> > (or just "display controller") refer to both the low-level driver layer
> > that communicates directly with the display controller hardware, and to
> > the higher- level driver layer that implements and exposes the userspace
> > API (FBDEV, KMS and/or V4L). Those layers can be implemented in multiple
> > kernel modules (such as in the OMAP DSS case, with omapdss for the
> > low-level layer and omapdrm, omapfb and omapvout for the API-level layer)
> > or a single kernel module.
> > 
> > Control model
> > -------------
> > 
> > The figure at http://www.ideasonboard.org/media/cdf/cdf-panel-control-
> > model.png shows the CDF control model.
> > 
> > The panel object depicted on the figure doesn't need to be a panel in the
> > stricter sense but could be any chain of off-SoC (both on-board or
> > off-board) display entities. It however helps thinking about it as a
> > panel and doesn't hurt the model.
> > 
> > The panel is controlled through abstract control requests. Those requests
> > are used to retrieve panel information (such as the physical size, the
> > supported video modes, EDID information, ...), set the panel
> > configuration (such as the active video timings) or control the panel
> > operation state (enabling/disabling the panel, controlling panel blanking
> > and power management, ...). They are exposed by the panel using function
> > pointers, and called by other kernel components in response to userspace
> > requests (through the FBDEV, KMS or V4L2 APIs) or in-kernel events (for
> > instance hotplug notifications).
> > 
> > In response to the control requests the panel driver will communicate with
> > the panel through the panel control bus (I2C, SPI, DBI, DSI, GPIO, ...,
> > not shown on the figure) and will control the video stream it receives on
> > its input.
> > 
> > The panel is connected at the hardware level to a video source (shown as a
> > green hashed rectangle) that provides it with a video stream. The video
> > stream flows from the video source to the panel and is directly
> > controlled by its source, as shown by the green arrow from the display
> > controller to the video stream. The video source exposes stream control
> > operations as function pointers that are used by the panel to control the
> > video stream, as shown by the green arrow from the panel to the video
> > source.
> > 
> > The figure at http://www.ideasonboard.org/media/cdf/cdf-panel-control-
> > model-2.png shows the call flow across entities when the panel is a
> > pipeline made of more than a single entity. In this case the SoC (on the
> > left of the dashed line) outputs a video stream on a DSI bus connected to
> > a DSI to LVDS transmitter. The output of the DSI to LVDS transmitter is
> > connected to an LVDS panel (or, more accurately, an LVDS panel module
> > made of an LVDS panel controller and a panel).
> > 
> > The transmitter and panel module are seen by the display controller and
> > userspace API implementations as a single entity that exposes control
> > request operations and controls its input video stream. When a control
> > request is performed (outermost green arrow) the DSI to LVDS transmitter
> > will propagate it to the panel, possibly mangling the input parameters or
> > the response. For panel operation state control requests the last entity
> > in the pipeline will likely want to control the video stream it receives
> > on its input. The video stream control calls will be propagated from
> > right to left as shown by the red arrows.
> > 
> > Every entity in the call stack can communicate with its hardware device
> > through the corresponding control bus, and/or control the video stream it
> > receives on its input.
> > 
> > This model allows filtering out modes and timings supported by the panel
> > but unsupported by the transmitter and mangling the modes and timings
> > according to the transmitter limitations. It has no complexity drawback
> > for simple devices, as the corresponding drivers can just forward the
> > calls directly. Similar use cases could exist for other control
> > operations than mode and information retrieval.
> > 
> > Discovery
> > ---------
> > 
> > Before being able to issue control requests, panel devices need to be
> > discovered and associated with the connected display controller(s).
> > 
> > Panels and display controllers are cross-dependent. There is no way around
> > that, as the display controller needs a reference to the panel to call
> > control requests in response to userspace API, and the panel needs a
> > reference to the display controller to call video stream control
> > functions (in addition to requiring generic resources such as clocks,
> > GPIOs or even regulators that could be provided by the display
> > controller).
> > 
> > As we can't probe the display controller and the panel together, a probe
> > order needs to be defined. The decision was to consider video sources as
> > resources and defer panel probing until all required resources (video
> > stream source, clocks, GPIOs, regulators and more) are available. Display
> > controller probing must succeed without the panel being available. This
> > mimicks the hotpluggable monitor model (VGA, HDMI, DP) that doesn't
> > prevent display controllers from being successfully probed without a
> > connected monitor.
> > 
> > Our design goal is to handle panel discovery in a similar (if not
> > identical) way as HDMI/DP hotplug in order to implement a single display
> > discovery method in display controller drivers. This might not be
> > achievable, in which case we'll reconsider the design requirement.
> > 
> > When the display controller driver probes the device it will register the
> > video source(s) at the output of the display controller with the CDF core.
> > Those sources will be identified by the display controller dev_name() and
> > a source integer index. A new structure, likely called
> > display_entity_port, will be used to represent a source or sink video port
> > on a display entity.
> > 
> > Panel drivers will handle video sources as resources. They will retrieve
> > at probe time the video source the panel is connected to using a phandle
> > or a source name (depending on whether the platform uses DT). If the
> > source isn't available the probe function will return -EPROBE_DEFER.
> > 
> > In addition to the video stream control operations mentioned above, ports
> > will also expose a connect/disconnect operation use to notify them of
> > connection/disconnection events. After retrieving the connected video
> > source panel drivers call the connect/disconnect operation on the video
> > source to notify it that the panel is available.
> > 
> > When the panel is a pipeline made of more than a single entity, entities
> > are probed in video source to video sink order. Out-of-order probe will
> > result in probe deferral as explained above due to the video source not
> > being available, resulting in the source to sink probe order. Entities
> > should not call the connect operation of their video source at probe time
> > in that case, but only when their own connect operation for the video
> > source(s) they provide to the next entity is called by the next entity.
> > Connect operations will thus be called in sink to source order starting
> > at the entity at the end of the pipeline and going all the way back to
> > the display controller.
> > 
> > This notification system is a hotplug mechanism that replaces the display
> > entity notifier system from my previous RFC. Alan Cox rightly objected to
> > the notification system, arguing that such system-wide notifications were
> > used by FBDEV and very subject to abuse. I agree with his argument, this
> > new mechanism should result in a cleaner implementation as video sources
> > will only be notified of connect/disconnect events for the entity they're
> > connected to.
> > 
> > DBI/DSI busses
> > --------------
> > 
> > My RFC introduced a DBI bus using the Linux device and bus model. Its
> > purpose was multifold:
> > 
> > - Support (un)registration, matching and binding of devices and drivers.
> > 
> > - Provide power management (suspend/resume) services through the standard
> > Linux PM bus/device model, to make sure that DBI devices will be
> > suspended/resumed after/before their DBI bus controller.
> > 
> > - Provide bus services to access the connected devices. For DBI that took
> > the form of command read and data read/write functions.
> > 
> > A DSI bus implementation using the same model was also planned.
> > 
> > Tomi's patches removed the DBI bus and replaced DBI devices with platform
> > devices, moving the bus services implementation to the video source. DBI
> > and DSI busses are always either pure video or video + control busses
> > (although controlling a DPI panel through DSI is conceivable, nobody in
> > his right mind, not even a hardware engineer, would likely implement
> > that), so there will always be a video source to provide the DBI/DSI
> > control operations.
> > 
> > (Un)registration, matching and binding of devices and drivers is provided
> > by the platform device bus. Bus services to access connected devices are
> > provided by the video source, wrapper functions will be used to handle
> > serialization and locking, and possibly to offer higher level services
> > (such as DCS for instance).
> > 
> > One drawback of using the platform bus is that PM relationships between
> > the bus master and slaves will not be taken into account during
> > suspend/resume. However, a similar issue exists for DPI panels, and PM
> > relationships at the video bus level for DBI and DSI are not handled by
> > the DBI/DSI busses either. As we need a generic solution to handle those
> > (likely through early suspend and late resume), the same solution can be
> > used to handle DBI and DSI control bus PM relationships without requiring
> > a Linux DBI or DSI bus.
> > 
> > Even though I still like the idea of DBI and DSI busses, I agree with Tomi
> > that they're not strictly needed and I will drop them.
> > 
> > Entity model
> > ------------
> > 
> > Tomi's proposal split the display entities into video sources (struct
> > video_source) and display entities (struct display_entity). To make
> > generic pipeline operations easier, we agreed to merge the video source
> > and the display entity back. struct display_entity thus models a display
> > entity that has any number of sink and/or source ports, modeled as struct
> > display_entity_port instances.
> 
> Looking at Tomi's patchset, he has considered panel as "display entity"
> and  MIPI DSI as "video source entity". So if we are planning to merge it
> back how should we treat panel and MIPI DSI. i mean should we consider both
> panel  and MIPI DSI has 2 different display entities.
> i.e, during the probe of each of these drivers, should we register a
> display entity with CDF.

Both the DSI encoder and the DSI panel would be modeled as display entities. 
The DSI encoder would have a source port that models its DSI video source, and 
the DSI panel would have a sink port.

> > Video stream operations will be exposed by the display entity as function
> > pointers and will take a port reference as argument (this could take the
> > form of struct display_entity * and port index, or struct
> > display_entity_port *). The DVI and DSI operations model proposed by Tomi
> > in this patch series will be kept.
> 
> so you mean you will be adding these "ops" as part of "struct display
> entity" rather than  video source ops,

That's correct.

> static const struct dsi_video_source_ops dsi_dsi_ops = {
> 
> 	.update = dsi_bus_update,
> 	.dcs_write = dsi_bus_dcs_write,
> 	.dcs_read = dsi_bus_dcs_read,
> 	.configure_pins = dsi_bus_configure_pins,
> 	.set_clocks = dsi_bus_set_clocks,
> 	.enable = dsi_bus_enable,
> 	.disable = dsi_bus_disable,
> 	.set_size = dsi_bus_set_size,
> 	.set_operation_mode = dsi_bus_set_operation_mode,
> 	.set_pixel_format = dsi_bus_set_pixel_format,
> 	.enable_hs = dsi_bus_enable_hs,
> };
> 
> if you can post CDF v3 patches early, it will give us more clarity
> w.r.t to discussions you and Tomi had.

I'm working on that.

> > Points that we forgot to discuss
> > --------------------------------
> > 
> > - DISPLAY_ENTITY_STREAM_SINGLE_SHOT vs. update() operation
> > 
> > I'll look into that.
> > 
> > Please let me know if I've forgotten anything.

-- 
Regards,

Laurent Pinchart

