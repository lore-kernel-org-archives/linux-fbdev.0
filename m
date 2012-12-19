From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Dec 2012 22:59:51 +0000
Subject: Re: [RFC 0/6] Common Display Framework-T
Message-Id: <20864716.IsLOYExjmS@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1549956.kAcRGxSZyL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
	<5024715.KeGkjOKZ3Q@avalon> <50D1D4D6.1090308@ti.com>
In-Reply-To: <50D1D4D6.1090308@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


--nextPart1549956.kAcRGxSZyL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Tomi,

On Wednesday 19 December 2012 16:53:10 Tomi Valkeinen wrote:
> On 2012-12-19 15:21, Laurent Pinchart wrote:
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
> 
> I have some comments =). But mostly it looks good.

Thanks :-)

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
> 
> I don't think it needs to be off-soc. The dispc and the panel in the
> image could be any two components, in- or off-soc.

That's correct, whether the components are on-SoC or off-SoC doesn't matter 
here.

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
> 
> Here also I don't see any reason to separate in- or off-soc components.
> I think the call from DISPC, which now goes to the transmitter, should
> first go to the DPI/DSI block. Whether the DPI/DSI block is in- or
> off-soc should be irrelevant regarding CDF.

Agreed.

> > The transmitter and panel module are seen by the display controller and
> > userspace API implementations as a single entity that exposes control
> > request operations and controls its input video stream. When a control
> > request is
>
> I don't like the sound of this. I think the CDF shouldn't care how the
> userspace API is implemented. There's no reason in CDF level to separate
> in- or out-soc entities, nor expose only one entity. If DRM requires
> mapping DRM's crtc, encoder and connector to, respectively, dispc,
> DPI/DSI, the-rest, it should be able to do that, but CDF shouldn't force
> that model.
> 
> Of course, the implementor of the particular SoC display driver could decide
> to use one display entity that covers both dispc and DPI/DSI blocks. But at
> least I would like to have OMAP's DISPC as a display entity (or actually
> multiple entities, one for each DISPC output), and the various in-SoC DPI-
> to-something encoders as display entities.

OK, I haven't expressed myself correctly. I tried to describe here how the 
"russian doll model" of cascaded calls across entities works. I didn't want to 
force any in-/off-SoC model.

> > performed (outermost green arrow) the DSI to LVDS transmitter will
> > propagate it to the panel, possibly mangling the input parameters or the
> > response. For panel operation state control requests the last entity in
> > the pipeline will likely want to control the video stream it receives on
> > its input. The video stream control calls will be propagated from right
> > to left as shown by the red arrows.
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
> 
> Perhaps semantics, but I don't think they are cross-dependent. True,
> they will call ops in each other, but the dispc will get the pointer to
> the panel when the panel connects the dispc and the panel. And when the
> panel disconnects, dispc will lose the reference to the panel.
> 
> For me, cross-dependent would mean that dispc could have a reference to
> the panel regardless of what the panel does. In our case it is not so,
> and there's no harm with the dispc's reference to the panel, as the
> panel can remove it (almost) at any time.

The panel can ask the dispc to release its reference to the panel by calling 
the disconnect function, but it can't disappear all of a sudden. I will test 
the model for RFCv3.

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
> 
> I'd like to highlight two points I made about the bus model:
> 
> - If DBI is used only for video, there's no DBI bus. How to configure
> DBI in this case?

I was planning to handle DBI video configuration through video stream 
operations, so we agree here.

> - If DBI is used for control and video, we have two separate APIs for
> the bus. In theory it's possible to handle this, but in practice it may
> be impossible, especially for more complex busses like DSI.
> 
> I think both of those issues would make the bus model very difficult to
> implement. I have no idea how it could be done neatly. So as I see it,
> it's not only about "not strictly needed", but that the bus model
> wouldn't work without complex code.
> 
> > Entity model
> > ------------
> > 
> > Tomi's proposal split the display entities into video sources (struct
> > video_source) and display entities (struct display_entity). To make
> > generic pipeline operations easier, we agreed to merge the video source
> > and the display entity back. struct display_entity thus models a display
> > entity that has any number of sink and/or source ports, modeled as struct
> > display_entity_port instances.
> > 
> > Video stream operations will be exposed by the display entity as function
> > pointers and will take a port reference as argument (this could take the
> > form of struct display_entity * and port index, or struct
> > display_entity_port *).
>
> I'd very much like to have only one parameter to pass, as there may be lots
> of ops for some busses. Having two parameters to refer to the source is just
> extra code that has no extra benefit when using video source ops. Then
> again, having separate port index parameter could be perhaps simpler to
> implement for the one handling the video source ops, so...
> 
> > The DVI and DSI operations model proposed by Tomi in this patch series
> > will be kept.
> > 
> > Points that we forgot to discuss
> > --------------------------------
> > 
> > - DISPLAY_ENTITY_STREAM_SINGLE_SHOT vs. update() operation
> 
> Ah, yes, we missed that. I think it's possible to use SINGLE_SHOT, but
> then it requires some kind of system to inform about finished update. Or
> we could, of course, decide that informing about the update is done in
> dispc-specific code, like handling VSYNC.
> 
> Hmm, except that won't probably work, as the panel (or any DSI device) may
> need to know if the DSI bus is currently used or not.

-- 
Regards,

Laurent Pinchart

--nextPart1549956.kAcRGxSZyL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJQ0kcrAAoJEIkPb2GL7hl1F6UIAKYnbKjfruzBspcn+U4ldz8i
SswyR2Py+ieVdQ+riPAM3D8t+m9Ya81/whNTB4Dom/N1/WrAUtJml4lQDmok5cvs
vo+w0LjvKZWVdL/Uwipv4cfLKxyV+kdtk8MgJrcZAsvUVsRqbjCnlwzDiGcMeSM9
m2jbl/7a4c1KHTtwQtQjQkh9x0zdLQZVDN+FacnfvxFy/KLE/zJEEtg+YW2Jl9Gc
bqmG8EsetyEwfza/yEuAHlVMio2K8X2Y26aJEAzQJBScOoby9Wh57BdaUGgcwVtA
AxNNZMM4Y41q7QgNZcI+fTuHjQlt8d69zj1qR7KpYXHDQEywOtdZdHS9TO15yBo=
=OBzZ
-----END PGP SIGNATURE-----

--nextPart1549956.kAcRGxSZyL--

