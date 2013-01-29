From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 29 Jan 2013 15:50:40 +0000
Subject: Re: [Linaro-mm-sig] CDF discussions at FOSDEM
Message-Id: <20130129155040.GR14766@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2665133.qfM3EnSmyB@avalon> <2040571.zD1Nq6nRq3@avalon>
	<20130129114716.GA4239@skynet.be> <1465762.gbACDvF2Tt@avalon>
	<CAKMK7uEJ+gyX1F=FqSEjmKYgqrrCUM3LgYZLCVWyq6eimWfGsQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEJ+gyX1F=FqSEjmKYgqrrCUM3LgYZLCVWyq6eimWfGsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "Syrjala,
	Ville" <ville.syrjala@intel.com>, dri-devel@lists.freedesktop.org, Linaro MM SIG <linaro-mm-sig@lists.linaro.org>, "Clark, Rob" <rob@ti.com>

On Tue, Jan 29, 2013 at 3:19 PM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Tue, Jan 29, 2013 at 1:11 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>> DevRooms are also not supposed to open before 11:00 (which is already a
>>> massive improvement over 2011 and the years before, where i was happy
>>> to be able to put the cabling in at 12:00), and i tend to first get a
>>> nod of approval from the on-site devrooms supervisor before i go in and
>>> set up the room.
>>>
>>> So use the hackingroom this year. Things will hopefully be better next
>>> year.
>>
>> Saturday is pretty much out of question, given that most developers interested
>> in CDF will want to attend the X.org talks. I'll try to get a room for Sunday
>> then, but I'm not sure yet what time slots will be available. It would be
>> helpful if people interested in CDF discussions could tell me at what time
>> they plan to leave Brussels on Sunday.
>
> I'll stay till Monday early morning, so requirements from me. Adding a
> bunch of Intel guys who're interested, too.

Ok, in the interest of pre-heating the discussion a bit I've written down
my thoughts about display slave drivers. Adding a few more people and
lists to make sure I haven't missed anyone ...

Cheers, Daniel
--
Display Slaves
=======

A highly biased quick analysis from Daniel Vetter.

A quick discussion about the issues surrounding some common framework for
display slaves like panels, hdmi/DP/whatever encoders, ... Since these external
chips are very often reused accross different SoCs, it would be beneficial to
share slave driver code between different chipset drivers.

Caveat Emperor!
---------------

Current output types and slave encoders already have to deal with a pletoria of
special cases and strange features. To avoid ending up with something not
suitable for everyone, we should look at what's all supported already and how we
could possibly deal with those things:

- audio embedded into the display stream (hdmi/dp). x86 platforms with the HD
  Audio framework rely on ELD and forwarding certain events as interrupts
  through the hw between the display and audio side ...

- hdmi/dp helpers: HDMI/DP are both standardized output connectors with nice
  complexity. DP is mostly about handling dp aux transactions and DPCD
  registers, hdmi mostly about infoframes and how to correctly set them up from
  the mode + edid.

- dpms is 4 states in drm, even more in fbdev afaict, but real hw only supports
  on/off nowadays ... how should/do we care?

- Fancy modes and how to represent them. Random list of things we need to
  represent somehow: broadcast/reduced rbg range for hdmi, yuv modes, different
  bpc modes (and handling how this affects bandwidth/clocks, e.g. i915
  auto-dithers to 6bpc on DP if there's not enough), 3D hdmi modes (patches have
  floated on dri-devel for this), overscan compensation. Many of these things
  link in with e.g. the helper libraries for certain outputs, e.g. discovering
  DP sink capabilities or setting up the correct hdmi infoframe.

- How to expose random madness as properties, e.g. backlight controllers,
  broadcast mode, enable/disable embedded audio (some screens advertise it, but
  don't like it). For additional fun I expect different users of a display slave
  driver to expect different set of "standardized" properties.

- Debug support: Register dumping, exposing random debugfs files, tracing.
  Preferably somewhat unified to keep things sane, since most often slave
  drivers are rather simple, but we expect quite a few different ones.

- Random metadata surrounding a display sink, like output type. Or flags for
  support special modes (h/vsync polarity, interlaced/doublescan, pixel
  doubling, ...).

- mode_fixup: Used a lot in drm-land to allow encoders to change the input mode,
  e.g. for lvds encoders which can do upscaling, or if the encoder supports
  progressive input with interlaced output and similar fancy stuff. See e.g. the
  intel sdvo encoder chip support.

- Handling different control buses like i2c, direct access (not seen that yet),
  DSI, DP aux, some other protocols.

- Handling of different display data standards like dsi (intel invented a few of
  its own, I'm sure we're not the only ones).

- hpd support/polling. Depending upon desing hpd handling needs to be
  cooperative between slave and master, or is a slave only thing (which means
  the slave needs to be able to poke the master when something changes).
  Similarly, masters need to know which slaves require output polling.

- Initializing of slave drivers: of/devicetree based, compiled-in static tables
  in the driver, dynamic discovery by i2c probing, lookup through some
  platform-specific firmware table (ACPI). Related is how to forward random
  platform init values to the drivers from these sources (e.g. the panel fixed
  modes) to the slave driver.

- get_hw_state support. One of the major point in the i915 modeset rewrite which
  landed in 3.7 is that a lot of the hw state can be cross-checked with the sw
  tracking. Helps tremendously in tracking down driver (writer) fumbles ;-)

- PSR/dsi command mode and how the start/stop frame dance should be handled.

- Random funny expectations around the modeset sequence, i.e. when (and how
  often) the video stream should be enabled/disabled. In the worst case this
  needs some serious cooperation between master and slaves. Even more fun for
  trained output links like DP where a re-training and so restarting parts - or
  even the complete - modeset sequence could be required to happen any time.

- There's more I'm sure, gfx hw tends to be insane ...

Wishful Thinking
----------------

Ignoring reality, let's look at what the perfect display slave framework should
achieve to be useful:

- Should be simple to share code between different master drivers - display slave
  drivers tend to be boring assemblies of register definitions and banging the
  right magic values into them. Which also means that we should aim for a high
  level of unification so that using, understanding and debugging drivers is
  easy.

- Since we expect drivers to be simple, even little amounts of
  impedence-matching code can kill the benefits of the shared code. Furthermore
  it should be possible to extend drivers with whatever subset of the above
  feature list is required by the subsystem/driver using a slave driver. Again,
  without incurring unnecessary amounts of impendance matching. Ofc, not all
  users of slave drivers will be able to use all the crazy features.

Reality Check
-------------

We already have tons of different slave encoder frameworks sprinkled all over
the kernel, which support different sets of crazy features and are used by
different. Furthermore each subsystem seems to have come up with it's own way to
describe metadata like display modes, all sorts of type enums, properties,
helper functions for special output types.

Conclusions:

- Throwing away and rewriting all the existing code seems unwise, but we'll
  likely need tons of existing drivers with the new framework.

- Unifying the metadata handling will be _really_ painful since it's deeply
  ingrained into each driver. Not unifying it otoh will lead to colossal amounts
  of impendance matching code.

- The union of all the slave features used by all the existing frameworks is
  impressive, but also highly non-overlapping. Likely everyone has his own
  utterly "must-have" feature.

Proposal
--------

I have to admit that I'm not too much in favour of the current CDF. It has a bit
of midlayer smell to it imo, and looks like it will make many of the mentioned
corner-case messy to enable. Also looking at things the proposed generic video
mode structure it seems to lack some features e.g. drm_mode already has. Which
does not include new insanity like 3d modes or some advanced infoframes stuff.

So instead I'll throw around a few ideas and principles:

- s/framework/helper library/ Yes, I really hate midlayers and just coming up
  with a different name seems to go a long way towards saner apis.

- I think we should reduce the scope of the intial version massively and instead
  increase the depth to fully cover everything. So instead of something which
  covers everything of a limited use-case from discover, setup, modes handling
  and mode-setting, concentrate on only one operation. The actual mode-set seems
  to be the best case, since it usually involves a lot of the boring register
  bashing code. The first interface version would ignore everything else
  completely.

- Shot for the most powerful api for that little piece we're starting with, make
  it the canonical thing. I.e. for modeset we need a video mode thing, and imo
  it only makes sense if that's the native data structure for all invovled
  subsystems. At least it should be the aim. Yeah, that means tons of work. Even
  more important is that the new datastructure supports every feature already
  support in some insane way in one of the existing subsystems. Imo if we keep
  different datastructures everywhere, the impendance matching will eat up most
  of the code sharing benefits.

- Since converting all invovled subsystems we should imo just forget about
  fbdev. For obvious reasons I'm also leaning towards simply ditching the
  drm prefix from the drm defines and using those ;-)

- I haven't used it in a driver yet, but mandating regmap (might need some
  improvements) should get us decent unification between drivers. And hopefully
  also an easy way to have unified debug tools. regmap already has trace points
  and a few other cool things.

- We need some built-in way to drill direct paths from the master display driver
  to the slave driver for the different subsystems. Jumping through hoops (or
  even making it impossible) to extend drivers in funny ways would be a big step
  backwards.

- Locking will be fun, especially once we start to add slave->master callbacks
  (e.g. for stopping/starting the display signal, hpd interrupts, ...). As a
  general rule I think we should aim for no locks in the slave driver, with the
  master owning the slave and ensure exclusion with its own locks. Slaves which
  use shared resources and so need locks (everything doing i2c actually) may not
  call master callback functions with locks held.

Then, once we've gotten things of the ground and have some slave encoder drivers
which are actually shared between different subsystems/drivers/platforms or
whatever we can start to organically grow more common interfaces. Ime it's much
easier to simply extract decent interfaces after the fact than trying to come
up.

Now let's pour this into a more concrete form:

struct display_slave_ops {
	/* modeset ops, e.g. prepare/modset/commit from drm */
};

struct display_slave {
	struct display_slave_ops *ops;
	void *driver_private;
};

I think even just that will be worth a lot of flames to come up with a good and
agreeable interface for everyone. It'll probably satisfactory to no one though.

Then each subsystem adds it's own magic, e.g.

struct drm_encoder_slave {
	struct display_slave slave;

	/* everything else which is there already and not covered by the display
	 * slave interface. */
};

Other subsystems/drivers like DSS would embed the struct display_slave in their
own equivalent data-structure.

So now we have the little problem that we want to have one single _slave_ driver
codebase, but it should be able to support n different interfaces and
potentially even more ways to be initialized and set up. Here's my idea how this
could be tackled:

1. Smash everything into one driver file/directory.
2. Use a common driver structure which contains pointers/members for all
possible use-cases. For each interface the driver supports, it'll allocate the
same structure and put the pointer into foo->slave.driver_private. This way
different entry points from different interfaces could use the same internal
functions since all deal with the same structure.
3. Add whatever magic is required to set up the driver for different platforms.
E.g. and of match, drm_encoder_slave i2c match and some direct function to set
up hardcoded cases could all live in the same file.

Getting the kernel Kconfig stuff right will be fun, but we should get by with
adding tons more stub functions. That might mean that an of/devicetree platform
build carries around a bit of gunk for x86 vbt matching maybe, but imo that
shouldn't ever get out of hand size-wise.

Once we have a few such shared drivers in place, and even more important,
unified that part of the subsystem using them a bit, it should be painfully
obvious which is the next piece to extract into the common display slave library
interface. After all, they'll live right next to each another in the driver
sources ;-)

Eventually we should get into the real fun part like dsi bus support or command
mode/PSR ... Those advanced things probably need to be optional.

But imo the key part is that we aim for real unification in the users of
display_slave's, so internally convert over everything to the new structures.
That should also make code-sharing much easier, so that we could move existing
helper functions to the common display helper library.

Bikesheds
---------

I.e. the boring details:

- Where to put slave drivers? I'll vote for anything which does not include
  drivers/video ;-)

- Maybe we want to start with a different part than modeset, or add a bit more
  on top. Though I really think we should start minimally and modesetting seemed
  like the most useful piece of the puzzle.

- Naming the new interfaces. I'll have more asbestos suites on order ...

- Can we just copy the new "native" interface structs from drm, pls?
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
