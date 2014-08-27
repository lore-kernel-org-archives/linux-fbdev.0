From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Wed, 27 Aug 2014 12:44:05 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com>
In-Reply-To: <53FDB46C.5010609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 27, 2014 at 6:35 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> On 08/27/2014 11:31 AM, Thierry Reding wrote:

snip

> In another mail in this thread you've mentioned 2 uses for simplefb:
>
> 1) Serving as *the* fb until a kms driver is present
> 2) Allowing for output of early kernel boot messages.
>
> I agree that those are the 2 use-cases we're dealing with here.
>
> Note that the whole discussion we're having hear about disabling the clocks
> once hardware probing is "done", is moot for 1. One possible way mentioned
> of dealing with 1. is to mark these clocks as always on for now, and then we
> need to drop this hack (I cannot call this anything else then a hack), once
> we get kms, meaning interdependencies between the dropping patch and the kms
> adding patches, etc. All not very pretty.
>
> For 2. We have what you call "mostly integration issues". Allow me to copy
> and paste in another bit of this thread here:

These are two independent problems.

> 1) Serving as *the* fb until a kms driver is present

Why can't we whip together a real device specific fbdev driver and
quit trying to run without a device specific driver in place? History
has shown that to be bad idea except during early boot when there
isn't a choice.

fbdev drivers are pretty simple things and you don't have to make one
that implements every feature. fbdev driver don't even have to
implement mode setting. They can just live with the mode initially
provided and refuse to change it. Communicating this initial mode info
on the kernel command line is already supported so we don't even need
a device tree change. This is the transition tool until KMS gets
written.

But it needs to be a device specific fbdev implementation, not
simplefb. That's because the device specific driver is going to claim
those clocks and regulators.

> 2) Allowing for output of early kernel boot messages.

For this to work the kernel needs to know two things - address of the
framebuffer and the x/y layout. Then just nuke this display when the
kernel finishes the boot process.

One of two things will happen.
1) the fbdev driver has been loaded. It has claimed the clocks, taken
care of memory, etc. If KMS is around, load it instead. When kernel
tries to nuke the display nothing will happen.
2) Your display goes blank because the kernel has disabled clocks and
reclaimed the memory. Take that as a hint to write a fbdev driver.

pages more snipped....

-- 
Jon Smirl
jonsmirl@gmail.com
