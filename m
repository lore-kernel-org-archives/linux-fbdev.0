From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Dec 2012 14:53:10 +0000
Subject: Re: [RFC 0/6] Common Display Framework-T
Message-Id: <50D1D4D6.1090308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig8191A9BC15E28C09DF23EDC3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355495252-26364-1-git-send-email-tomi.valkeinen@ti.com>
	<5024715.KeGkjOKZ3Q@avalon>
In-Reply-To: <5024715.KeGkjOKZ3Q@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig8191A9BC15E28C09DF23EDC3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-19 15:21, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Friday 14 December 2012 16:27:26 Tomi Valkeinen wrote:
>> Hi,
>>
>> I have been testing Common Display Framework on OMAP, and making chang=
es
>> that I've discussed in the posts I've sent in reply to the CDF series =
from
>> Laurent. While my CDF code is rather hacky and not at all ready, I wan=
ted
>> to post the code for comments and also as a reference code to my posts=
=2E
>>
>> So here is CDF-T (Tomi-edition =3D).
>=20
> We've discussed your approach extensively face-to-face today so I won't=
 review=20
> the patches in detail, but I will instead summarize our discussion to m=
ake=20
> sure we understood each other (and let other developers jump in).

I have some comments =3D). But mostly it looks good.

> For the purpose of this discussion the term "display controller driver"=
 (or=20
> just "display controller") refer to both the low-level driver layer tha=
t=20
> communicates directly with the display controller hardware, and to the =
higher-
> level driver layer that implements and exposes the userspace API (FBDEV=
, KMS=20
> and/or V4L). Those layers can be implemented in multiple kernel modules=
 (such=20
> as in the OMAP DSS case, with omapdss for the low-level layer and omapd=
rm,=20
> omapfb and omapvout for the API-level layer) or a single kernel module.=

>=20
> Control model
> -------------
>=20
> The figure at http://www.ideasonboard.org/media/cdf/cdf-panel-control-
> model.png shows the CDF control model.
>=20
> The panel object depicted on the figure doesn't need to be a panel in t=
he=20
> stricter sense but could be any chain of off-SoC (both on-board or off-=
board)=20
> display entities. It however helps thinking about it as a panel and doe=
sn't=20
> hurt the model.

I don't think it needs to be off-soc. The dispc and the panel in the
image could be any two components, in- or off-soc.

> The panel is controlled through abstract control requests. Those reques=
ts are=20
> used to retrieve panel information (such as the physical size, the supp=
orted=20
> video modes, EDID information, ...), set the panel configuration (such =
as the=20
> active video timings) or control the panel operation state (enabling/di=
sabling=20
> the panel, controlling panel blanking and power management, ...). They =
are=20
> exposed by the panel using function pointers, and called by other kerne=
l=20
> components in response to userspace requests (through the FBDEV, KMS or=
 V4L2=20
> APIs) or in-kernel events (for instance hotplug notifications).
>=20
> In response to the control requests the panel driver will communicate w=
ith the=20
> panel through the panel control bus (I2C, SPI, DBI, DSI, GPIO, ..., not=
 shown=20
> on the figure) and will control the video stream it receives on its inp=
ut.
>=20
> The panel is connected at the hardware level to a video source (shown a=
s a=20
> green hashed rectangle) that provides it with a video stream. The video=
 stream=20
> flows from the video source to the panel and is directly controlled by =
its=20
> source, as shown by the green arrow from the display controller to the =
video=20
> stream. The video source exposes stream control operations as function =

> pointers that are used by the panel to control the video stream, as sho=
wn by=20
> the green arrow from the panel to the video source.
>=20
> The figure at http://www.ideasonboard.org/media/cdf/cdf-panel-control-
> model-2.png shows the call flow across entities when the panel is a pip=
eline=20
> made of more than a single entity. In this case the SoC (on the left of=
 the=20
> dashed line) outputs a video stream on a DSI bus connected to a DSI to =
LVDS=20
> transmitter. The output of the DSI to LVDS transmitter is connected to =
an LVDS=20
> panel (or, more accurately, an LVDS panel module made of an LVDS panel =

> controller and a panel).

Here also I don't see any reason to separate in- or off-soc components.
I think the call from DISPC, which now goes to the transmitter, should
first go to the DPI/DSI block. Whether the DPI/DSI block is in- or
off-soc should be irrelevant regarding CDF.

> The transmitter and panel module are seen by the display controller and=
=20
> userspace API implementations as a single entity that exposes control r=
equest=20
> operations and controls its input video stream. When a control request =
is=20

I don't like the sound of this. I think the CDF shouldn't care how the
userspace API is implemented. There's no reason in CDF level to separate
in- or out-soc entities, nor expose only one entity. If DRM requires
mapping DRM's crtc, encoder and connector to, respectively, dispc,
DPI/DSI, the-rest, it should be able to do that, but CDF shouldn't force
that model.

Of course, the implementor of the particular SoC display driver could
decide to use one display entity that covers both dispc and DPI/DSI
blocks. But at least I would like to have OMAP's DISPC as a display
entity (or actually multiple entities, one for each DISPC output), and
the various in-SoC DPI-to-something encoders as display entities.

> performed (outermost green arrow) the DSI to LVDS transmitter will prop=
agate=20
> it to the panel, possibly mangling the input parameters or the response=
=2E For=20
> panel operation state control requests the last entity in the pipeline =
will=20
> likely want to control the video stream it receives on its input. The v=
ideo=20
> stream control calls will be propagated from right to left as shown by =
the red=20
> arrows.
>=20
> Every entity in the call stack can communicate with its hardware device=
=20
> through the corresponding control bus, and/or control the video stream =
it=20
> receives on its input.
>=20
> This model allows filtering out modes and timings supported by the pane=
l but=20
> unsupported by the transmitter and mangling the modes and timings accor=
ding to=20
> the transmitter limitations. It has no complexity drawback for simple d=
evices,=20
> as the corresponding drivers can just forward the calls directly. Simil=
ar use=20
> cases could exist for other control operations than mode and informatio=
n=20
> retrieval.
>=20
> Discovery
> ---------
>=20
> Before being able to issue control requests, panel devices need to be=20
> discovered and associated with the connected display controller(s).
>=20
> Panels and display controllers are cross-dependent. There is no way aro=
und=20

Perhaps semantics, but I don't think they are cross-dependent. True,
they will call ops in each other, but the dispc will get the pointer to
the panel when the panel connects the dispc and the panel. And when the
panel disconnects, dispc will lose the reference to the panel.

For me, cross-dependent would mean that dispc could have a reference to
the panel regardless of what the panel does. In our case it is not so,
and there's no harm with the dispc's reference to the panel, as the
panel can remove it (almost) at any time.

> that, as the display controller needs a reference to the panel to call =
control=20
> requests in response to userspace API, and the panel needs a reference =
to the=20
> display controller to call video stream control functions (in addition =
to=20
> requiring generic resources such as clocks, GPIOs or even regulators th=
at=20
> could be provided by the display controller).
>=20
> As we can't probe the display controller and the panel together, a prob=
e order=20
> needs to be defined. The decision was to consider video sources as reso=
urces=20
> and defer panel probing until all required resources (video stream sour=
ce,=20
> clocks, GPIOs, regulators and more) are available. Display controller p=
robing=20
> must succeed without the panel being available. This mimicks the hotplu=
ggable=20
> monitor model (VGA, HDMI, DP) that doesn't prevent display controllers =
from=20
> being successfully probed without a connected monitor.
>=20
> Our design goal is to handle panel discovery in a similar (if not ident=
ical)=20
> way as HDMI/DP hotplug in order to implement a single display discovery=
 method=20
> in display controller drivers. This might not be achievable, in which c=
ase=20
> we'll reconsider the design requirement.
>=20
> When the display controller driver probes the device it will register t=
he=20
> video source(s) at the output of the display controller with the CDF co=
re.=20
> Those sources will be identified by the display controller dev_name() a=
nd a=20
> source integer index. A new structure, likely called display_entity_por=
t, will=20
> be used to represent a source or sink video port on a display entity.
>=20
> Panel drivers will handle video sources as resources. They will retriev=
e at=20
> probe time the video source the panel is connected to using a phandle o=
r a=20
> source name (depending on whether the platform uses DT). If the source =
isn't=20
> available the probe function will return -EPROBE_DEFER.
>=20
> In addition to the video stream control operations mentioned above, por=
ts will=20
> also expose a connect/disconnect operation use to notify them of=20
> connection/disconnection events. After retrieving the connected video s=
ource=20
> panel drivers call the connect/disconnect operation on the video source=
 to=20
> notify it that the panel is available.
>=20
> When the panel is a pipeline made of more than a single entity, entitie=
s are=20
> probed in video source to video sink order. Out-of-order probe will res=
ult in=20
> probe deferral as explained above due to the video source not being ava=
ilable,=20
> resulting in the source to sink probe order. Entities should not call t=
he=20
> connect operation of their video source at probe time in that case, but=
 only=20
> when their own connect operation for the video source(s) they provide t=
o the=20
> next entity is called by the next entity. Connect operations will thus =
be=20
> called in sink to source order starting at the entity at the end of the=
=20
> pipeline and going all the way back to the display controller.
>=20
> This notification system is a hotplug mechanism that replaces the displ=
ay=20
> entity notifier system from my previous RFC. Alan Cox rightly objected =
to the=20
> notification system, arguing that such system-wide notifications were u=
sed by=20
> FBDEV and very subject to abuse. I agree with his argument, this new me=
chanism=20
> should result in a cleaner implementation as video sources will only be=
=20
> notified of connect/disconnect events for the entity they're connected =
to.
>=20
> DBI/DSI busses
> --------------
>=20
> My RFC introduced a DBI bus using the Linux device and bus model. Its p=
urpose=20
> was multifold:
>=20
> - Support (un)registration, matching and binding of devices and drivers=
=2E
>=20
> - Provide power management (suspend/resume) services through the standa=
rd=20
> Linux PM bus/device model, to make sure that DBI devices will be=20
> suspended/resumed after/before their DBI bus controller.
>=20
> - Provide bus services to access the connected devices. For DBI that to=
ok the=20
> form of command read and data read/write functions.
>=20
> A DSI bus implementation using the same model was also planned.
>=20
> Tomi's patches removed the DBI bus and replaced DBI devices with platfo=
rm=20
> devices, moving the bus services implementation to the video source. DB=
I and=20
> DSI busses are always either pure video or video + control busses (alth=
ough=20
> controlling a DPI panel through DSI is conceivable, nobody in his right=
 mind,=20
> not even a hardware engineer, would likely implement that), so there wi=
ll=20
> always be a video source to provide the DBI/DSI control operations.
>=20
> (Un)registration, matching and binding of devices and drivers is provid=
ed by=20
> the platform device bus. Bus services to access connected devices are p=
rovided=20
> by the video source, wrapper functions will be used to handle serializa=
tion=20
> and locking, and possibly to offer higher level services (such as DCS f=
or=20
> instance).
>=20
> One drawback of using the platform bus is that PM relationships between=
 the=20
> bus master and slaves will not be taken into account during suspend/res=
ume.=20
> However, a similar issue exists for DPI panels, and PM relationships at=
 the=20
> video bus level for DBI and DSI are not handled by the DBI/DSI busses e=
ither.=20
> As we need a generic solution to handle those (likely through early sus=
pend=20
> and late resume), the same solution can be used to handle DBI and DSI c=
ontrol=20
> bus PM relationships without requiring a Linux DBI or DSI bus.
>=20
> Even though I still like the idea of DBI and DSI busses, I agree with T=
omi=20
> that they're not strictly needed and I will drop them.

I'd like to highlight two points I made about the bus model:

- If DBI is used only for video, there's no DBI bus. How to configure
DBI in this case?

- If DBI is used for control and video, we have two separate APIs for
the bus. In theory it's possible to handle this, but in practice it may
be impossible, especially for more complex busses like DSI.

I think both of those issues would make the bus model very difficult to
implement. I have no idea how it could be done neatly. So as I see it,
it's not only about "not strictly needed", but that the bus model
wouldn't work without complex code.

> Entity model
> ------------
>=20
> Tomi's proposal split the display entities into video sources (struct  =

> video_source) and display entities (struct display_entity). To make gen=
eric=20
> pipeline operations easier, we agreed to merge the video source and the=
=20
> display entity back. struct display_entity thus models a display entity=
 that=20
> has any number of sink and/or source ports, modeled as struct=20
> display_entity_port instances.
>=20
> Video stream operations will be exposed by the display entity as functi=
on=20
> pointers and will take a port reference as argument (this could take th=
e form=20
> of struct display_entity * and port index, or struct display_entity_por=
t *).=20

I'd very much like to have only one parameter to pass, as there may be
lots of ops for some busses. Having two parameters to refer to the
source is just extra code that has no extra benefit when using video
source ops. Then again, having separate port index parameter could be
perhaps simpler to implement for the one handling the video source ops,
so...

> The DVI and DSI operations model proposed by Tomi in this patch series =
will be=20
> kept.
>=20
> Points that we forgot to discuss
> --------------------------------
>=20
> - DISPLAY_ENTITY_STREAM_SINGLE_SHOT vs. update() operation

Ah, yes, we missed that. I think it's possible to use SINGLE_SHOT, but
then it requires some kind of system to inform about finished update. Or
we could, of course, decide that informing about the update is done in
dispc-specific code, like handling VSYNC.

Hmm, except that won't probably work, as the panel (or any DSI device)
may need to know if the DSI bus is currently used or not.

 Tomi



--------------enig8191A9BC15E28C09DF23EDC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQ0dTXAAoJEPo9qoy8lh7150oP/1MmeFGZXD9zygWByQIiE8Kp
n9T3C5hM8NDQxT1K912zYPY7ebiCB86221dej+ZJ+ZuO12SacN76TM1gq+YRJHy0
LThreQwNTQYGg8Kw/vBlWSWm4Sml59mc8j7sAM5wO2a9jeRv+SeqYEYlckl2FfHE
dqvSxda1eV7WUa52RYvPX/YRMImjnKodt7P/SHEBq5sMf7vH45E+6rvZvt+ztGAt
/zfuJNzAyYr41VeL7cntaX/3FtgfM6Eh5mg4NMCczlKn/RTMnz+V5H4w+AqHwLTz
t33Dw3XRC9c0yInI+VPi68EaYkPlElhDZ5HI9u6J9YS7oI/7MLeSpCiqPrDhfB9a
OxBVfRnLkN5s52Lon4lfhUfNt8P6vrD/YixPgp06X3g/S3j3YT/ZhDkUyv9bUXFg
yWEQuWm2qCu/qMRd6yGAQlE/sW6bDvqHGWQ3BDJ/PBQ57DcG6m6aR5eC598/VkGC
82t8CQW/M26FpmLI9mXATLsGzLTSOi0/x8HOUX/yLIWcH7ZaoqMx6C83ceadEJIM
SlDPz3ir+lQRZ14E5O67qfs43dpmTWxnO6FSCeHtG1X/pj2qI9TLAXcWyVkCC7kn
UBrVl+iWF/bZbyFjwrHShFHVC49CcdczwO9UuayqJ5dZe13s870f5tPFzukdP9iU
eaGEgwKcoDQKYtGyj6+C
=EDIg
-----END PGP SIGNATURE-----

--------------enig8191A9BC15E28C09DF23EDC3--
