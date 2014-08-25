From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Mon, 25 Aug 2014 15:08:48 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OwGd8Fuv=nRdchoBrMLQSKafhKqu6eJ6RPEDUeLhrEfPQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
In-Reply-To: <20140825145303.GC14763@ulmo.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Aug 25, 2014 at 10:53 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Mon, Aug 25, 2014 at 04:23:59PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 08/25/2014 04:16 PM, Thierry Reding wrote:
>> > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
>> >> On 08/25/2014 03:39 PM, Thierry Reding wrote:
>> >>> On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
>> >>>> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
>> >>>>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
>> >>>>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>> >>>>> [...]
>> >>>>>>> If not, perhaps the clock driver should force the clock to be
>> >>>>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
>> >>>>>>
>> >>>>>> I'm sorry, but I'm not going to take any code that will do that in our
>> >>>>>> clock driver.
>> >>>>>>
>> >>>>>> I'm not going to have a huge list of ifdef depending on configuration
>> >>>>>> options to know which clock to enable, especially when clk_get should
>> >>>>>> have the consumer device as an argument.
>> >>>>>
>> >>>>> Are you saying is that you want to solve a platform-specific problem by
>> >>>>> pushing code into simple, generic drivers so that your platform code can
>> >>>>> stay "clean"?
>> >>>>
>> >>>> Are you saying that this driver would become "dirty" with such a patch?
>> >>>
>> >>> Yes. Others have said the same and even provided alternative solutions
>> >>> on how to solve what's seemingly a platform-specific problem in a
>> >>> platform-specific way.
>> >>
>> >> This is not platform specific, any platform with a complete clock driver
>> >> will suffer from the same problem (the clock driver disabling unclaimed
>> >> ahb gates, and thus killing the video output) if it wants to use simplefb
>> >> for early console support.
>> >
>> > It is platform specific in that your platform may require certain clocks
>> > to remain on. The next platform may require power domains to remain on
>> > during boot and yet another one may rely on regulators to stay on during
>> > boot. By your argument simplefb will need to be taught to handle pretty
>> > much every type of resource that the kernel has.
>> >
>> >> As for the suggestion to simply never disable the plls / ahb gates by blocking
>> >> them from ever being disabled in the sunxi clock driver, that is not really
>> >> a solution either, as we want to be able to turn these things off to safe
>> >> power on screen blank once control has been turned over to the kms driver.
>> >
>> > Then perhaps part of the hand-off procedure between simplefb and DRM/KMS
>> > should involve marking PLLs or "gates" as properly managed.
>>
>> And by your earlier argument also power domains, regulators, etc. So now we need
>> to add code to each of the clock core, power-domain core, regulator core, etc. to
>> have them now about this initially unmanaged state thing you're introducing, as
>> well as modify all involved clock / regulator / etc. drivers to mark certain
>> resources as unmanaged.
>
> Hmm... that's true. But we already have a way to deal with exactly this
> situation for regulators. There's a property called regulator-boot-on
> which a bootloader should set whet it has enabled a given regulator. It
> can of course also be set statically in a DTS if it's know upfront that
> a bootloader will always enable it. Perhaps what we need is a similar
> property for clocks so that the clock framework will not inadvertently
> turn off a clock that's still being used.

There should probably be a generic 'boot-initialized;' property that
can be added to any DT device node.   Then uboot can add that property
to the device node for anything it has turned on.

You could even use it to add more info 'boot-initialized = <"9600 8 N 1">;'

That passes the info in an OS agnostic manner.


>
> Thierry



-- 
Jon Smirl
jonsmirl@gmail.com
