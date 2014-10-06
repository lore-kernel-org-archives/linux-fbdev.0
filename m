From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 06 Oct 2014 12:06:45 +0000
Subject: Re: Fixing boot-time hiccups in your display
Message-Id: <543285D5.30607@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>	<20141005200150.4379.28017@quantum>	<CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>	<54324445.9070400@redhat.com>
 <CAKON4Ozum1SeAhecR14uuAmk1NqfMuLZAEyGZnv3Yr0CwAavzA@mail.gmail.com>
In-Reply-To: <CAKON4Ozum1SeAhecR14uuAmk1NqfMuLZAEyGZnv3Yr0CwAavzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/06/2014 01:26 PM, jonsmirl@gmail.com wrote:
> On Mon, Oct 6, 2014 at 3:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/05/2014 10:34 PM, jonsmirl@gmail.com wrote:

<snip>

> The 'clean up' command only releases resources that no one was
> claimed. The device specific framebuffer loaded and claimed all of the
> video resources, so this command has no impact on those resources.

Except that those resources may be turned off if they are shared by
another device with a clk_disable call. Yes I know you're suggesting
to increment the usage count of all clks, regulators, foobars and whatnots
by one, only to release them at the magic release moment, but that
means adding code for this to all affected subsystems, and as such is
not a good solution.

Besides that it has already been nacked by involved subsystem maintainers,
because it is just too ugly.

What we're talking about here from a technical pov is quite simple, we need
to keep various resources alive during the lifetime of the (fake) device using
them, e.g. simplefb. The most KISS solution for that is to simply tie them to
the lifetime of the device.

Not only is this KISS it is also obviously the right solution from a technical
viewpoint. But instead of coming with technical arguments why this is not a
good idea, you come with ...

> Because this needs to be fixed in the OS without relying on detailed
> communication with the BIOS.  Of course you can get this going on one
> box with one BIOS and one kernel. The problems occur when you try to
> get this going on all boxes, all BIOS and all kernels.

FUD about how we cannot trust firmware. What we are doing here is
defining a firmware <-> OS interface, if we cannot trust the firmware, then
we should not be adding such interfaces at all, yet simplefb already exists,
all I'm doing is trying to extend it.

>> Also this non-solution completely discards the use case where e.g. simplefb
>> is used as an early bringup mechanism and there may complete be no real
>> driver for a long time (months if not years). So then again there is no
> 
> I in no way support long term use of simplefb after the boot process.

You do realize that this is what it was actually *designed* for ? And that
only later the idea of using it as an early console came to bear ?

> The problems with this model are legendary on the x86. Try running
> your X server right now on the VBIOS driver, see if it functions.

And yet more fear for bad firmware.

I'm afraid that this is going to be my last reply to any objections from you,
as I simply cannot rationally argue against arguments which are mostly
based on fear.

Regards,

Hans
