From: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
Date: Tue, 29 Jan 2013 19:35:28 +0000
Subject: Re: [Linaro-mm-sig] CDF discussions at FOSDEM
Message-Id: <51082480.9070500@stericsson.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2665133.qfM3EnSmyB@avalon> <2040571.zD1Nq6nRq3@avalon>
	<20130129114716.GA4239@skynet.be> <1465762.gbACDvF2Tt@avalon>
	<CAKMK7uEJ+gyX1F=FqSEjmKYgqrrCUM3LgYZLCVWyq6eimWfGsQ@mail.gmail.com>
	<20130129155040.GR14766@phenom.ffwll.local>
In-Reply-To: <20130129155040.GR14766@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "Syrjala,
	Ville" <ville.syrjala@intel.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linaro MM SIG <linaro-mm-sig@lists.linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "Clark,
	Rob" <rob@ti.com>

On 01/29/2013 04:50 PM, Daniel Vetter wrote:
> On Tue, Jan 29, 2013 at 3:19 PM, Daniel Vetter<daniel.vetter@ffwll.ch>  wrote:
> Ok, in the interest of pre-heating the discussion a bit I've written down
> my thoughts about display slave drivers. Adding a few more people and
> lists to make sure I haven't missed anyone ...
>
> Cheers, Daniel
> --
> Display Slaves
> =======
>
> A highly biased quick analysis from Daniel Vetter.
And here is my biased version as one of the initiators of the idea of CDF.

I work with ARM SoCs (ST-Ericsson) and mobile devices (DSI/DPI panels). 
Of course some of these have the "PC" type of encoder devices like HDMI 
and eDP or even VGA. But from what I have seen most of these encoders 
are used by few different SoCs(GPUs?). And using these type of encoders 
was quite straight forward from DRM encoders. My goal was to get some 
common code of all the "mobile" panel encoders or "display module driver 
IC"s as some call them. Instead of tens of drivers (my assumption) you 
now have hundreds of drivers often using MIPI DSI/DPI/DBI or some 
similar interface. And lots of new come each year. There are probably 
more panel types than there are products on the market, since most 
products use more than one type of panel on the same product to secure 
sourcing for mass production (note multiple panels use same driver IC).
So that was the initial goal, to cover all of these, which most are 
maintained per SoC/CPU out of kernel.org. If HDMI/DP etc fits in this 
framework, then that is just a nice bonus.
I just wanted to give my history so we are not trying to include to many 
different types of encoders without an actual need. Maybe the I2C drm 
stuff is good enough for that type of encoders. But again, it would be 
nice with one suit that fits all ...
I also like the idea to start out small. But if no support is added 
initially for the mobile panel types. Then I think it will be hard to 
get all vendors to start pushing those drivers, because the benefit of 
doing so would be small. But maybe the CDF work with Linaro and Laurent 
could just be a second step of adding the necessary details to your 
really simple baseline. And I also favor the helpers over framework 
approach but I miss a big piece which is the ops for panel drivers to 
call back to display controller (the video source stuff).
Some inline comments below.

>
> A quick discussion about the issues surrounding some common framework for
> display slaves like panels, hdmi/DP/whatever encoders, ... Since these external
> chips are very often reused accross different SoCs, it would be beneficial to
> share slave driver code between different chipset drivers.
>
> Caveat Emperor!
> ---------------
>
> Current output types and slave encoders already have to deal with a pletoria of
> special cases and strange features. To avoid ending up with something not
> suitable for everyone, we should look at what's all supported already and how we
> could possibly deal with those things:
>
> - audio embedded into the display stream (hdmi/dp). x86 platforms with the HD
>    Audio framework rely on ELD and forwarding certain events as interrupts
>    through the hw between the display and audio side ...
I would assume any driver handling audio/video/cec like HDMI would hook 
itself up as an mfd device. And one of those exposed functions would be 
the CDF part. Instead of pushing everything into the "display parts". At 
least that is sort of what we do today and it keeps the audio, cec and 
display parts nicely separated.
> - hdmi/dp helpers: HDMI/DP are both standardized output connectors with nice
>    complexity. DP is mostly about handling dp aux transactions and DPCD
>    registers, hdmi mostly about infoframes and how to correctly set them up from
>    the mode + edid.
Yes, it is a mess. But we have managed to hide that below a simple panel 
API similar to CDF/omap so far.
> - dpms is 4 states in drm, even more in fbdev afaict, but real hw only supports
>    on/off nowadays ... how should/do we care?
Agreed, they should all really go away unless someone find a valid use case.
> - Fancy modes and how to represent them. Random list of things we need to
>    represent somehow: broadcast/reduced rbg range for hdmi, yuv modes, different
>    bpc modes (and handling how this affects bandwidth/clocks, e.g. i915
>    auto-dithers to 6bpc on DP if there's not enough), 3D hdmi modes (patches have
>    floated on dri-devel for this), overscan compensation. Many of these things
>    link in with e.g. the helper libraries for certain outputs, e.g. discovering
>    DP sink capabilities or setting up the correct hdmi infoframe.
Are you saying drm modes doesn't support this as of today? I have not 
used these types of modes in DRM yet. Maybe the common video mode 
patches is a good start.
> - How to expose random madness as properties, e.g. backlight controllers,
>    broadcast mode, enable/disable embedded audio (some screens advertise it, but
>    don't like it). For additional fun I expect different users of a display slave
>    driver to expect different set of "standardized" properties.
Some standardized properties would be nice :). Whatever is not standard 
doesn't really matter.
> - Debug support: Register dumping, exposing random debugfs files, tracing.
>    Preferably somewhat unified to keep things sane, since most often slave
>    drivers are rather simple, but we expect quite a few different ones.
>
> - Random metadata surrounding a display sink, like output type. Or flags for
>    support special modes (h/vsync polarity, interlaced/doublescan, pixel
>    doubling, ...).
One thing that is needed is all the meta data related to the 
control/data interface between display controller and encoder. Because 
this has to be unified per interface type like DSI/DBI so the same CDF 
driver can setup different display controllers. But I hope we could 
split the "CDF API" (panel ops) from the control/data bus API 
(host/source ops or CDF video source).
> - mode_fixup: Used a lot in drm-land to allow encoders to change the input mode,
>    e.g. for lvds encoders which can do upscaling, or if the encoder supports
>    progressive input with interlaced output and similar fancy stuff. See e.g. the
>    intel sdvo encoder chip support.
>
> - Handling different control buses like i2c, direct access (not seen that yet),
>    DSI, DP aux, some other protocols.
This is actually the place I wanted to start. With vendor specific panel 
drivers using common ops to access the bus (DSI/I2C/DBI etc). Then once 
we have a couple of panel drivers we could unify the API making them do 
their stuff (like the current CDF ops). Or even better, maybe these two 
could be made completely separate and worked on in parallel.
> - Handling of different display data standards like dsi (intel invented a few of
>    its own, I'm sure we're not the only ones).
>
> - hpd support/polling. Depending upon desing hpd handling needs to be
>    cooperative between slave and master, or is a slave only thing (which means
>    the slave needs to be able to poke the master when something changes).
>    Similarly, masters need to know which slaves require output polling.
I prefer a slave only thing forwarded to the drm encoder which I assume 
would be the drm equivalent of the display slave. At least I have not 
seen any need to involve the display controller in hpd (which I assume 
you mean by master).
> - Initializing of slave drivers: of/devicetree based, compiled-in static tables
>    in the driver, dynamic discovery by i2c probing, lookup through some
>    platform-specific firmware table (ACPI). Related is how to forward random
>    platform init values to the drivers from these sources (e.g. the panel fixed
>    modes) to the slave driver.
I'm not that familiar with the bios/uefi world. But on our SoCs we 
always have to show a splash screen from the boot loader (like bios, 
usually little kernel, uboot etc). And so all probing is done by 
bootloader and HW is running when kernel boot. And you are not allowed 
to disrupt it either because that would yield visual glitches during 
boot. So some way or the other the boot loader would need to transfer 
the state to the kernel or you would have to reverse engineer the state 
from hw at kernel probe.
> - get_hw_state support. One of the major point in the i915 modeset rewrite which
>    landed in 3.7 is that a lot of the hw state can be cross-checked with the sw
>    tracking. Helps tremendously in tracking down driver (writer) fumbles ;-)
This sounds more like a display controller feature than a display slave 
feature.
> - PSR/dsi command mode and how the start/stop frame dance should be handled.
Again, a vital piece for the many mobile driver ICs. And I think we have 
several sources (STE, Renesas, TI, Samsung, ...) on how to do this and 
tested in many products. So I hope this could be an early step in the 
evolution.
> - Random funny expectations around the modeset sequence, i.e. when (and how
>    often) the video stream should be enabled/disabled. In the worst case this
>    needs some serious cooperation between master and slaves. Even more fun for
>    trained output links like DP where a re-training and so restarting parts - or
>    even the complete - modeset sequence could be required to happen any time.
Again, we have several samples of platforms already doing this stuff. So 
we should be able to get a draft pretty early. From my experience when 
to enable/disable video stream could vary between versions of the same 
display controller. So I think it could be pretty hairy to get a single 
solution for all. Instead I think we need to leave some room for the 
master/slave to decide when to enable/disable. And to be able to do this 
we should try to have pretty specific ops on the slave and master. I'm 
not sure prepare/modeset/commit is specific enough unless we document 
what is expected to be done by the slave in each of these.
>
> - There's more I'm sure, gfx hw tends to be insane ...
Yes, and one is the chain of slaves issue that is "common" on mobile 
systems. One example I have is 
dispc->dsi->dsi2dsi-bridge->dsi2lvds-bridge->lvds-panel.
My proposal to hide this complexity in CDF was aggregate drivers. So 
from drm there will only be one master (dispc) and one slave (dsi2dsi). 
Then dsi2dsi will itself use another CDF/slave driver to talk to its 
slave. This way the top master (dispc) driver never have to care about 
this complexity. Whether this is possible to hide in practice we will 
see ...
>
> Wishful Thinking
> ----------------
>
> Ignoring reality, let's look at what the perfect display slave framework should
> achieve to be useful:
>
> - Should be simple to share code between different master drivers - display slave
>    drivers tend to be boring assemblies of register definitions and banging the
>    right magic values into them. Which also means that we should aim for a high
>    level of unification so that using, understanding and debugging drivers is
>    easy.
>
> - Since we expect drivers to be simple, even little amounts of
>    impedence-matching code can kill the benefits of the shared code. Furthermore
>    it should be possible to extend drivers with whatever subset of the above
>    feature list is required by the subsystem/driver using a slave driver. Again,
>    without incurring unnecessary amounts of impendance matching. Ofc, not all
>    users of slave drivers will be able to use all the crazy features.
This is also my fear. Which is why I wanted to start with one slave 
interface at a time. And maybe even have different "API"s for differnt 
type of panels. Like classic I2C encoders, DSI command mode "smart" 
panels, DSI video mode, DPI ... and then do another layer of helpers in 
drm encoders. That way a DSI command mode panel wouldn't have to be 
forced into the same shell as a I2C HDMI encoder as they are very 
different with very little overlap.
> Reality Check
> -------------
>
> We already have tons of different slave encoder frameworks sprinkled all over
> the kernel, which support different sets of crazy features and are used by
> different. Furthermore each subsystem seems to have come up with it's own way to
> describe metadata like display modes, all sorts of type enums, properties,
> helper functions for special output types.
>
> Conclusions:
>
> - Throwing away and rewriting all the existing code seems unwise, but we'll
>    likely need tons of existing drivers with the new framework.
>
> - Unifying the metadata handling will be _really_ painful since it's deeply
>    ingrained into each driver. Not unifying it otoh will lead to colossal amounts
>    of impendance matching code.
>
> - The union of all the slave features used by all the existing frameworks is
>    impressive, but also highly non-overlapping. Likely everyone has his own
>    utterly "must-have" feature.
>
> Proposal
> --------
>
> I have to admit that I'm not too much in favour of the current CDF. It has a bit
> of midlayer smell to it imo, and looks like it will make many of the mentioned
> corner-case messy to enable. Also looking at things the proposed generic video
> mode structure it seems to lack some features e.g. drm_mode already has. Which
> does not include new insanity like 3d modes or some advanced infoframes stuff.
>
> So instead I'll throw around a few ideas and principles:
>
> - s/framework/helper library/ Yes, I really hate midlayers and just coming up
>    with a different name seems to go a long way towards saner apis.
Me like, but I hope you agree to keep calling it CDF until it is merged. 
We could call it Common Display Frelpers if you like ;)
> - I think we should reduce the scope of the intial version massively and instead
>    increase the depth to fully cover everything. So instead of something which
>    covers everything of a limited use-case from discover, setup, modes handling
>    and mode-setting, concentrate on only one operation. The actual mode-set seems
>    to be the best case, since it usually involves a lot of the boring register
>    bashing code. The first interface version would ignore everything else
>    completely.
To also cover and be useful to mobile panels I suggest starting with 
on/off using a fixed mode initially. Because modeset is not used for 
most mobile panels (they only have one mode).
> - Shot for the most powerful api for that little piece we're starting with, make
>    it the canonical thing. I.e. for modeset we need a video mode thing, and imo
>    it only makes sense if that's the native data structure for all invovled
>    subsystems. At least it should be the aim. Yeah, that means tons of work. Even
>    more important is that the new datastructure supports every feature already
>    support in some insane way in one of the existing subsystems. Imo if we keep
>    different datastructures everywhere, the impendance matching will eat up most
>    of the code sharing benefits.
>
> - Since converting all invovled subsystems we should imo just forget about
>    fbdev. For obvious reasons I'm also leaning towards simply ditching the
>    drm prefix from the drm defines and using those ;-)
>
> - I haven't used it in a driver yet, but mandating regmap (might need some
>    improvements) should get us decent unification between drivers. And hopefully
>    also an easy way to have unified debug tools. regmap already has trace points
>    and a few other cool things.
Guideline for I2C slave drivers maybe? Do we really want to enforce how 
drivers are implemented when it doesn't affect the API?
Also, I don't think it fits in general for slaves. Since DSI/DBI have 
not only registers but also operations you can execute using control 
interface.
> - We need some built-in way to drill direct paths from the master display driver
>    to the slave driver for the different subsystems. Jumping through hoops (or
>    even making it impossible) to extend drivers in funny ways would be a big step
>    backwards.
>
> - Locking will be fun, especially once we start to add slave->master callbacks
>    (e.g. for stopping/starting the display signal, hpd interrupts, ...). As a
>    general rule I think we should aim for no locks in the slave driver, with the
>    master owning the slave and ensure exclusion with its own locks. Slaves which
>    use shared resources and so need locks (everything doing i2c actually) may not
>    call master callback functions with locks held.
Agreed, and I think we should rely on upper layers like drm as much as 
possible for locking.
> Then, once we've gotten things of the ground and have some slave encoder drivers
> which are actually shared between different subsystems/drivers/platforms or
> whatever we can start to organically grow more common interfaces. Ime it's much
> easier to simply extract decent interfaces after the fact than trying to come
> up.
>
> Now let's pour this into a more concrete form:
>
> struct display_slave_ops {
>          /* modeset ops, e.g. prepare/modset/commit from drm */
> };
>
> struct display_slave {
>          struct display_slave_ops *ops;
>          void *driver_private;
> };
>
> I think even just that will be worth a lot of flames to come up with a good and
> agreeable interface for everyone. It'll probably satisfactory to no one though.
>
> Then each subsystem adds it's own magic, e.g.
>
> struct drm_encoder_slave {
>          struct display_slave slave;
>
>          /* everything else which is there already and not covered by the display
>           * slave interface. */
> };
I like the starting point. Hard to make it any more simple ;). But next 
step would probably follow quickly. I also like the idea to have current 
drivers aggregate the slave to make transition easier. CDF as it is now 
is an all or nothing API. And since you don't care how slaves interact 
with master (bus ops) I see the possibility still to separate "CDI 
device API" and "CDF bus API". Which would allow using DSI bus API for 
DSI panels and I2C bus API (or regmap) for I2C encoders instead of force 
use of the video source API in all slave drivers.
> Other subsystems/drivers like DSS would embed the struct display_slave in their
> own equivalent data-structure.
>
> So now we have the little problem that we want to have one single _slave_ driver
> codebase, but it should be able to support n different interfaces and
> potentially even more ways to be initialized and set up. Here's my idea how this
> could be tackled:
>
> 1. Smash everything into one driver file/directory.
> 2. Use a common driver structure which contains pointers/members for all
> possible use-cases. For each interface the driver supports, it'll allocate the
> same structure and put the pointer into foo->slave.driver_private. This way
> different entry points from different interfaces could use the same internal
> functions since all deal with the same structure.
> 3. Add whatever magic is required to set up the driver for different platforms.
> E.g. and of match, drm_encoder_slave i2c match and some direct function to set
> up hardcoded cases could all live in the same file.
>
> Getting the kernel Kconfig stuff right will be fun, but we should get by with
> adding tons more stub functions. That might mean that an of/devicetree platform
> build carries around a bit of gunk for x86 vbt matching maybe, but imo that
> shouldn't ever get out of hand size-wise.
>
> Once we have a few such shared drivers in place, and even more important,
> unified that part of the subsystem using them a bit, it should be painfully
> obvious which is the next piece to extract into the common display slave library
> interface. After all, they'll live right next to each another in the driver
> sources ;-)
>
> Eventually we should get into the real fun part like dsi bus support or command
> mode/PSR ... Those advanced things probably need to be optional.
>
> But imo the key part is that we aim for real unification in the users of
> display_slave's, so internally convert over everything to the new structures.
> That should also make code-sharing much easier, so that we could move existing
> helper functions to the common display helper library.
What about drivers that are waiting for CDF to be pushed upstream 
instead of having to push another custom panel framework? I'm talking of 
my own KMS driver ... but maybe I could put most of it in staging and 
move relevant parts of DSI/DPI/HDMI panel drivers to "common" slave 
drivers ...
> Bikesheds
> ---------
>
> I.e. the boring details:
>
> - Where to put slave drivers? I'll vote for anything which does not include
>    drivers/video ;-)
drivers/video +1, drivers/gpu -1, who came up with putting KMS under 
drivers/gpu ;)
> - Maybe we want to start with a different part than modeset, or add a bit more
>    on top. Though I really think we should start minimally and modesetting seemed
>    like the most useful piece of the puzzle.
As suggested, start with on/off and static/fixed mode would help single 
resolution LCDs. Actually that is almost all that is needed for mobile 
panels and what I intended to get from CDF :)
>
> - Naming the new interfaces. I'll have more asbestos suites on order ...
Until you get them. Would it make sense to reuse the encoder name from 
drm or is that to restrictive?
>
> - Can we just copy the new "native" interface structs from drm, pls?
I hope you are not talking about the helper interfaces at least ;). But 
if CDF is going to be the new drm helpers of choice for 
encoder/connector parts. Then it sounds like CDF would replace most of 
the old helpers. It would be far to many layers with the old helpers 
too. And I think I recall Jesse wanting to deprecate/remove them too.
Hopefully we could have some generic encoder/connector helper 
implementations that only depend on CDF.

/BR
/Marcus

