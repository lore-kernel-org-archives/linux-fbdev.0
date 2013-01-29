From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 29 Jan 2013 21:46:56 +0000
Subject: Re: [Linaro-mm-sig] CDF discussions at FOSDEM
Message-Id: <20130129214655.GU14766@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2665133.qfM3EnSmyB@avalon> <2040571.zD1Nq6nRq3@avalon>
	<20130129114716.GA4239@skynet.be> <1465762.gbACDvF2Tt@avalon>
	<CAKMK7uEJ+gyX1F=FqSEjmKYgqrrCUM3LgYZLCVWyq6eimWfGsQ@mail.gmail.com>
	<20130129155040.GR14766@phenom.ffwll.local>
	<51082480.9070500@stericsson.com>
In-Reply-To: <51082480.9070500@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "Syrjala,
	Ville" <ville.syrjala@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linaro MM SIG <linaro-mm-sig@lists.linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Clark,
	Rob" <rob@ti.com>

On Tue, Jan 29, 2013 at 08:35:28PM +0100, Marcus Lorentzon wrote:
> On 01/29/2013 04:50 PM, Daniel Vetter wrote:
> >On Tue, Jan 29, 2013 at 3:19 PM, Daniel Vetter<daniel.vetter@ffwll.ch>  wrote:
> >Ok, in the interest of pre-heating the discussion a bit I've written down
> >my thoughts about display slave drivers. Adding a few more people and
> >lists to make sure I haven't missed anyone ...
> >
> >Cheers, Daniel
> >--
> >Display Slaves
> >=======
> >
> >A highly biased quick analysis from Daniel Vetter.
> And here is my biased version as one of the initiators of the idea of CDF.

Thanks a lot for your detailed answer. Some quick replies, I need to go
through this more carefully and maybe send another mail.

> I work with ARM SoCs (ST-Ericsson) and mobile devices (DSI/DPI
> panels). Of course some of these have the "PC" type of encoder
> devices like HDMI and eDP or even VGA. But from what I have seen
> most of these encoders are used by few different SoCs(GPUs?). And
> using these type of encoders was quite straight forward from DRM
> encoders. My goal was to get some common code of all the "mobile"
> panel encoders or "display module driver IC"s as some call them.
> Instead of tens of drivers (my assumption) you now have hundreds of
> drivers often using MIPI DSI/DPI/DBI or some similar interface. And
> lots of new come each year. There are probably more panel types than
> there are products on the market, since most products use more than
> one type of panel on the same product to secure sourcing for mass
> production (note multiple panels use same driver IC).
> So that was the initial goal, to cover all of these, which most are
> maintained per SoC/CPU out of kernel.org. If HDMI/DP etc fits in
> this framework, then that is just a nice bonus.
> I just wanted to give my history so we are not trying to include to
> many different types of encoders without an actual need. Maybe the
> I2C drm stuff is good enough for that type of encoders. But again,
> it would be nice with one suit that fits all ...
> I also like the idea to start out small. But if no support is added
> initially for the mobile panel types. Then I think it will be hard
> to get all vendors to start pushing those drivers, because the
> benefit of doing so would be small. But maybe the CDF work with
> Linaro and Laurent could just be a second step of adding the
> necessary details to your really simple baseline. And I also favor
> the helpers over framework approach but I miss a big piece which is
> the ops for panel drivers to call back to display controller (the
> video source stuff).

Yeah, I think we have two main goals here for enabling code sharing for
these output devices:
1. Basic panel support, with the panel usually glued onto the board, so
squat runtime configuration required. Aim is to get the gazillion of
out-of-tree drivers merged.
2. Allowing generic output encoder slaves to be used in a bunch of SoCs in.

Summarizing my previous mail I fear that if we start with with the first
point and don't take some of the mad features required to do the 2nd one
right into account, we'll end up at a rather ugly spot.

[cut]

> >- hdmi/dp helpers: HDMI/DP are both standardized output connectors with nice
> >   complexity. DP is mostly about handling dp aux transactions and DPCD
> >   registers, hdmi mostly about infoframes and how to correctly set them up from
> >   the mode + edid.
> Yes, it is a mess. But we have managed to hide that below a simple
> panel API similar to CDF/omap so far.

Well, my concern is that we need to expose a bunch of special properties
(both to the master driver and ultimately to userspace) which are rather
hard to shovel through a simple panel abstraction. Ime from desktop
graphics there's no limits to the insane usecases and devices people come
up with and want to plug into your machine ;-)

> >- dpms is 4 states in drm, even more in fbdev afaict, but real hw only supports
> >   on/off nowadays ... how should/do we care?
> Agreed, they should all really go away unless someone find a valid use case.
> >- Fancy modes and how to represent them. Random list of things we need to
> >   represent somehow: broadcast/reduced rbg range for hdmi, yuv modes, different
> >   bpc modes (and handling how this affects bandwidth/clocks, e.g. i915
> >   auto-dithers to 6bpc on DP if there's not enough), 3D hdmi modes (patches have
> >   floated on dri-devel for this), overscan compensation. Many of these things
> >   link in with e.g. the helper libraries for certain outputs, e.g. discovering
> >   DP sink capabilities or setting up the correct hdmi infoframe.
> Are you saying drm modes doesn't support this as of today? I have
> not used these types of modes in DRM yet. Maybe the common video
> mode patches is a good start.

All the stuff I've mentioned is support in drm/i915 (or at least we have
patches floating around), and on a quick look at the proposed video_mode I
couldn't fit this all in. Some of the features are fully fledged out, but
I expect that we fill all the little tiny holes in the next few releases.

> >- How to expose random madness as properties, e.g. backlight controllers,
> >   broadcast mode, enable/disable embedded audio (some screens advertise it, but
> >   don't like it). For additional fun I expect different users of a display slave
> >   driver to expect different set of "standardized" properties.
> Some standardized properties would be nice :). Whatever is not
> standard doesn't really matter.

The problem is that we have a few 100klocs of driver code lying around in
upstream, so if we switch standards there's some decent fun involved
converting things. Or we need to add conversion functions all over the
place, which seems rather ugly, too.

> >- Debug support: Register dumping, exposing random debugfs files, tracing.
> >   Preferably somewhat unified to keep things sane, since most often slave
> >   drivers are rather simple, but we expect quite a few different ones.
> >
> >- Random metadata surrounding a display sink, like output type. Or flags for
> >   support special modes (h/vsync polarity, interlaced/doublescan, pixel
> >   doubling, ...).
> One thing that is needed is all the meta data related to the
> control/data interface between display controller and encoder.
> Because this has to be unified per interface type like DSI/DBI so
> the same CDF driver can setup different display controllers. But I
> hope we could split the "CDF API" (panel ops) from the control/data
> bus API (host/source ops or CDF video source).

I guess we have two options of panels on such buses with special needs:
- either add a bunch of optional functions to the common interfaces
- or subclass the common interface/struct and add additional magic in
  there, i.e.

struct dsi_slave {
  	struct display_slave;
	struct dsi_panel_ops;

	/* whatever other magic we need for dsi, e.g. callbacks to the
	 * source for start/stopping pixel data ... */
}

The later requires a bit more casting of struct pointers, but should be
more flexible. Ime from i915 code it's not too onereous, e.g. for encoders
we nest such C struct classes about 4 levels deep in the code: drm_encoder
-> intel_encoder -> intel_dig_encoder -> intel_dp/hdmi/ddi

So I think both approaches are doable.

> >- mode_fixup: Used a lot in drm-land to allow encoders to change the input mode,
> >   e.g. for lvds encoders which can do upscaling, or if the encoder supports
> >   progressive input with interlaced output and similar fancy stuff. See e.g. the
> >   intel sdvo encoder chip support.
> >
> >- Handling different control buses like i2c, direct access (not seen that yet),
> >   DSI, DP aux, some other protocols.
> This is actually the place I wanted to start. With vendor specific
> panel drivers using common ops to access the bus (DSI/I2C/DBI etc).
> Then once we have a couple of panel drivers we could unify the API
> making them do their stuff (like the current CDF ops). Or even
> better, maybe these two could be made completely separate and worked
> on in parallel.

Hm, so starting with some DSI interface code, similarly to how we have
i2c? tbh I have pretty much zero clue about how dsi exactly works, but
growing different parts of a common panel infrastructure sounds
intriguing.

> >- Handling of different display data standards like dsi (intel invented a few of
> >   its own, I'm sure we're not the only ones).
> >
> >- hpd support/polling. Depending upon desing hpd handling needs to be
> >   cooperative between slave and master, or is a slave only thing (which means
> >   the slave needs to be able to poke the master when something changes).
> >   Similarly, masters need to know which slaves require output polling.
> I prefer a slave only thing forwarded to the drm encoder which I
> assume would be the drm equivalent of the display slave. At least I
> have not seen any need to involve the display controller in hpd
> (which I assume you mean by master).

I've used pretty unclear definitions. Generally master is everything no
behind the slave/panel interface. Call it display driver maybe ... For
this case I don't expect that hpd involves any piece of hw on the
master/driver side, but we need to somehow forward this to the usespace
interfaces. At least in drm, dunno what other display drivers do here.

> >- Initializing of slave drivers: of/devicetree based, compiled-in static tables
> >   in the driver, dynamic discovery by i2c probing, lookup through some
> >   platform-specific firmware table (ACPI). Related is how to forward random
> >   platform init values to the drivers from these sources (e.g. the panel fixed
> >   modes) to the slave driver.
> I'm not that familiar with the bios/uefi world. But on our SoCs we
> always have to show a splash screen from the boot loader (like bios,
> usually little kernel, uboot etc). And so all probing is done by
> bootloader and HW is running when kernel boot. And you are not
> allowed to disrupt it either because that would yield visual
> glitches during boot. So some way or the other the boot loader would
> need to transfer the state to the kernel or you would have to
> reverse engineer the state from hw at kernel probe.

Actually reverse engineer the bios state from the actual hw state is what
we now do for i915 ;-) Which is why we need the ->get_hw_state callback in
some form. But that's just a result of some of the horrible things old
firmware does, it /should/ be better on newer platforms. And hopefully the
embedded ones aren't that massively screwed up ... Iirc the only current
interface exposed by ACPI lets you get at the vendor boot splash and
display it after you've taken over the hw.

> >- get_hw_state support. One of the major point in the i915 modeset rewrite which
> >   landed in 3.7 is that a lot of the hw state can be cross-checked with the sw
> >   tracking. Helps tremendously in tracking down driver (writer) fumbles ;-)
> This sounds more like a display controller feature than a display
> slave feature.

See above for why we have that in i915. And we do call down into slave
encoders (Intel (s)dvo standards) on older hw. Might be we won't need that
any more on SoC platforms (I do hope that's the case at least).

> >- PSR/dsi command mode and how the start/stop frame dance should be handled.
> Again, a vital piece for the many mobile driver ICs. And I think we
> have several sources (STE, Renesas, TI, Samsung, ...) on how to do
> this and tested in many products. So I hope this could be an early
> step in the evolution.

One issue with start/stop callbacks I've discussed a bit with Jani Nikula
and Rob Clark is locking rules around start/stop callbacks from the slave
to the display source. Especially how to handle fun like blocking the dsi
bus while we need to wait for the transfer window.

> >- Random funny expectations around the modeset sequence, i.e. when (and how
> >   often) the video stream should be enabled/disabled. In the worst case this
> >   needs some serious cooperation between master and slaves. Even more fun for
> >   trained output links like DP where a re-training and so restarting parts - or
> >   even the complete - modeset sequence could be required to happen any time.
> Again, we have several samples of platforms already doing this
> stuff. So we should be able to get a draft pretty early. From my
> experience when to enable/disable video stream could vary between
> versions of the same display controller. So I think it could be
> pretty hairy to get a single solution for all. Instead I think we
> need to leave some room for the master/slave to decide when to
> enable/disable. And to be able to do this we should try to have
> pretty specific ops on the slave and master. I'm not sure
> prepare/modeset/commit is specific enough unless we document what is
> expected to be done by the slave in each of these.

Well, drm/i915 killed prepare/modeset/commit ops, we now have our own
which semantics matching our hw. My concern here is mostly about fancier
display buses with link training - e.g. on DP you can't just start/stop
the pixel stream, but there's a nice dance involved to do it.

> >- There's more I'm sure, gfx hw tends to be insane ...
> Yes, and one is the chain of slaves issue that is "common" on mobile
> systems. One example I have is
> dispc->dsi->dsi2dsi-bridge->dsi2lvds-bridge->lvds-panel.
> My proposal to hide this complexity in CDF was aggregate drivers. So
> from drm there will only be one master (dispc) and one slave
> (dsi2dsi). Then dsi2dsi will itself use another CDF/slave driver to
> talk to its slave. This way the top master (dispc) driver never have
> to care about this complexity. Whether this is possible to hide in
> practice we will see ...

I think even more fun would be to replace the lvds endpoint with hdmi, and
the try to coax the infoframe control attributes down that pipeline (plus
who's responsibilty it is to do the various adjustments to the pixels).

[cut]

> >- I think we should reduce the scope of the intial version massively and instead
> >   increase the depth to fully cover everything. So instead of something which
> >   covers everything of a limited use-case from discover, setup, modes handling
> >   and mode-setting, concentrate on only one operation. The actual mode-set seems
> >   to be the best case, since it usually involves a lot of the boring register
> >   bashing code. The first interface version would ignore everything else
> >   completely.
> To also cover and be useful to mobile panels I suggest starting with
> on/off using a fixed mode initially. Because modeset is not used for
> most mobile panels (they only have one mode).

Would that be start/stop a frame for manual refresh or enable/disable the
display itself? Just curious what you're aiming for as the minimal useful
thing here ...

> >- Shot for the most powerful api for that little piece we're starting with, make
> >   it the canonical thing. I.e. for modeset we need a video mode thing, and imo
> >   it only makes sense if that's the native data structure for all invovled
> >   subsystems. At least it should be the aim. Yeah, that means tons of work. Even
> >   more important is that the new datastructure supports every feature already
> >   support in some insane way in one of the existing subsystems. Imo if we keep
> >   different datastructures everywhere, the impendance matching will eat up most
> >   of the code sharing benefits.
> >
> >- Since converting all invovled subsystems we should imo just forget about
> >   fbdev. For obvious reasons I'm also leaning towards simply ditching the
> >   drm prefix from the drm defines and using those ;-)
> >
> >- I haven't used it in a driver yet, but mandating regmap (might need some
> >   improvements) should get us decent unification between drivers. And hopefully
> >   also an easy way to have unified debug tools. regmap already has trace points
> >   and a few other cool things.
> Guideline for I2C slave drivers maybe? Do we really want to enforce
> how drivers are implemented when it doesn't affect the API?
> Also, I don't think it fits in general for slaves. Since DSI/DBI
> have not only registers but also operations you can execute using
> control interface.

Yeah, that was an idea for i2c guidelines. I guess if we have a different
(sub)type for DSI we could gather helpers somewhere which are useful only
for DSI. E.g. drm is in the process of growing some DP helpers shared
among a few drivers.

My idea behind being a bit more anal about standardization is that we
exect tons of these drivers, and also that lots of different SoC platforms
might share them. So trying to make them look similar and work in similar
ways (where reasonable) to help enable existing drivers on new SoCs and
debug isssue seemed like something we should discuss a bit.

> >- We need some built-in way to drill direct paths from the master display driver
> >   to the slave driver for the different subsystems. Jumping through hoops (or
> >   even making it impossible) to extend drivers in funny ways would be a big step
> >   backwards.
> >
> >- Locking will be fun, especially once we start to add slave->master callbacks
> >   (e.g. for stopping/starting the display signal, hpd interrupts, ...). As a
> >   general rule I think we should aim for no locks in the slave driver, with the
> >   master owning the slave and ensure exclusion with its own locks. Slaves which
> >   use shared resources and so need locks (everything doing i2c actually) may not
> >   call master callback functions with locks held.
> Agreed, and I think we should rely on upper layers like drm as much
> as possible for locking.
> >Then, once we've gotten things of the ground and have some slave encoder drivers
> >which are actually shared between different subsystems/drivers/platforms or
> >whatever we can start to organically grow more common interfaces. Ime it's much
> >easier to simply extract decent interfaces after the fact than trying to come
> >up.
> >
> >Now let's pour this into a more concrete form:
> >
> >struct display_slave_ops {
> >         /* modeset ops, e.g. prepare/modset/commit from drm */
> >};
> >
> >struct display_slave {
> >         struct display_slave_ops *ops;
> >         void *driver_private;
> >};
> >
> >I think even just that will be worth a lot of flames to come up with a good and
> >agreeable interface for everyone. It'll probably satisfactory to no one though.
> >
> >Then each subsystem adds it's own magic, e.g.
> >
> >struct drm_encoder_slave {
> >         struct display_slave slave;
> >
> >         /* everything else which is there already and not covered by the display
> >          * slave interface. */
> >};
> I like the starting point. Hard to make it any more simple ;). But
> next step would probably follow quickly. I also like the idea to
> have current drivers aggregate the slave to make transition easier.
> CDF as it is now is an all or nothing API. And since you don't care
> how slaves interact with master (bus ops) I see the possibility
> still to separate "CDI device API" and "CDF bus API". Which would
> allow using DSI bus API for DSI panels and I2C bus API (or regmap)
> for I2C encoders instead of force use of the video source API in all
> slave drivers.

I didn't follow here which pieces you'd like to cut apart along which
lines exactly ... Maybe some example structs or asci-art to help the
clueless?

Aside about the simplicity of the above: It's slightly tongue-in-check, I
expect it to be a bit feature-full ;-) Just wanted to direct the
discussion a bit into a minimal, but still useful interface, highly
extensible.

[cut]

> >But imo the key part is that we aim for real unification in the users of
> >display_slave's, so internally convert over everything to the new structures.
> >That should also make code-sharing much easier, so that we could move existing
> >helper functions to the common display helper library.
> What about drivers that are waiting for CDF to be pushed upstream
> instead of having to push another custom panel framework? I'm
> talking of my own KMS driver ... but maybe I could put most of it in
> staging and move relevant parts of DSI/DPI/HDMI panel drivers to
> "common" slave drivers ...

Hm, I think I've missed your driver drm/kms driver. Links to source? I
think reading through a drm driver using the current cdf would be nice,
that way I'm at least familiar with one part of the code ;-)

> >Bikesheds
> >---------
> >
> >I.e. the boring details:
> >
> >- Where to put slave drivers? I'll vote for anything which does not include
> >   drivers/video ;-)
> drivers/video +1, drivers/gpu -1, who came up with putting KMS under
> drivers/gpu ;)

I think the main reason was to be as far away from fbdev/fbcon code as
possible ;-) Also, we have gem/ttm in drm, which is all about PU part and
not really about G ..

> >- Maybe we want to start with a different part than modeset, or add a bit more
> >   on top. Though I really think we should start minimally and modesetting seemed
> >   like the most useful piece of the puzzle.
> As suggested, start with on/off and static/fixed mode would help
> single resolution LCDs. Actually that is almost all that is needed
> for mobile panels and what I intended to get from CDF :)
> >
> >- Naming the new interfaces. I'll have more asbestos suites on order ...
> Until you get them. Would it make sense to reuse the encoder name
> from drm or is that to restrictive?

On a quick check drm lacks names for DSI encoders/panels, so we might want
to add those. And maybe a generic panel output type. I guess it would be
good to take my caveats list above and strike off everything we don't need
for basic dsi panel support, then figure out where to steal the
definitions from. Common definitions will be hard to come by, e.g. after
much bikesheds and deciding to use common fourcc codes for pixel layouts
drm ended up with simply adding a bunch of its own fourcc codes since the
ones negotiated with v4l didn't cut it.

> >- Can we just copy the new "native" interface structs from drm, pls?
> I hope you are not talking about the helper interfaces at least ;).

Nope, the drm helpers are not the interfaces. Ofc, if we end up with a
massively generic panel interface, we might add a few helpers to give
slave/panel drivers an easy way to opt for sane default behaviour. E.g.
handling a fixed panel mode and always returning that mode is something
which is reinvented in drm a few times ...

I probably should have written metadata structs/definitions, since that'll
be the part which could get ugly if we end up with diverging standards.
Interface functions obviously need to fit into what the hw bus at hand
requires us to do (e.g. for DSI special cases).

[Aside wrt drm helpers: With i915 we now have an imo rather nice example
that the drm crtc are really just helpers, and that it's not too hard to
come up with your own modeset infrastructure. On an established driver
codebase even.]

> But if CDF is going to be the new drm helpers of choice for
> encoder/connector parts. Then it sounds like CDF would replace most
> of the old helpers. It would be far to many layers with the old
> helpers too. And I think I recall Jesse wanting to deprecate/remove
> them too.

Rob's tilcdc driver uses the drm crtc helpers and for the i2c encoder
slaves he added a new set of helpers to easier integrate the crtc helpers
with the existing drm_encoder_slave infrastructure. The end-result looks
fairly reasonable imo.

In general I think as long as we aim for the different libraries to be
as orthogonal as possible so that drivers can pick and choose, more kinds
of helpers doesn't really sound bad. On the drm side I've recently brushed
up the crtc/output polling and fb helpers quite a bit, so drivers can now
pick&choose (and i915 does only use some of them). Similarly for other
helper ideas floating around like DSI, hdmi infoframe handling, dp aux
stuff ...

Of course I expect that we'll wrap things up into dwim() functions for all
the common cases.

> Hopefully we could have some generic encoder/connector helper
> implementations that only depend on CDF.

I'm not sure whether we should aim for that really - having a slave/panel
driver with mostly common code and a wee bit of shim code once for drm and
once for dss (or whatever else is out there) doesn't sound too horrible to
me. But I agree that at least for new code we should aim to get this right
from the start.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
