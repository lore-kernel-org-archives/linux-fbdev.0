From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 14 Aug 2014 09:37:19 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53EC834F.6020307@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-5-git-send-email-libv@skynet.be>
 <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
In-Reply-To: <20140813170106.GT15297@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/13/2014 07:01 PM, Maxime Ripard wrote:
> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>> On 08/13/2014 01:17 AM, Luc Verhaegen wrote:
>>> This claims and enables clocks listed in the simple framebuffer dt node.
>>> This is needed so that the display engine, in case the required clocks
>>> are known by the kernel code and are described in the dt, will remain
>>> properly enabled.
>>
>> I think this make simplefb not simple any more, which rather goes
>> against the whole point of it.
>>
>> I specifically conceived simplefb to know about nothing more than
>> the memory address and pixel layout of the memory buffer. I
>> certainly don't like the idea of expanding simplefb to anything
>> beyond that, and IIRC *not* extending is was a condition agreed when
>> it was first merged. If more knowledge than that is required, then
>> there needs to be a HW-specific driver to manage any
>> clocks/resets/video registers, etc.
> 
> I'm sorry, but how is that not simple? clocks enabling is step 1 in a
> driver in order to communicate somehow with the controller. Reset is a
> different story, because arguably, if simplefb is there, the
> controller is already out of reset.
> 
> And I don't see why video registers are coming into the discussion
> here. The code Luc posted doesn't access any register, at all. It just
> makes sure the needed controller keep going.
> 
>> The correct way to handle this without a complete DRM/KMS/... driver
>> is to avoid the clocks in question being turned off at boot.
> 
> Which is exactly what this code does, using the generic DT bindings to
> express dependency for a given clock. How is this wrong?
> 
>> I thought there was a per-clock flag to prevent disabling an unused
>> clock?
> 
> No, last time I heard, Mike Turquette was against it.
> 
>> If not, perhaps the clock driver should force the clock to be
>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
> 
> I'm sorry, but I'm not going to take any code that will do that in our
> clock driver.
> 
> I'm not going to have a huge list of ifdef depending on configuration
> options to know which clock to enable, especially when clk_get should
> have the consumer device as an argument.
> 
>> For example, the Tegra clock driver has a clock initialization table
>> which IIRC was used for this purpose before we got a DRM/KMS driver.
>> That way, all the details are kept inside the kernel code, and don't
>> end up influencing the DT representation of simplefb.
> 
> I don't really see how the optional usage of a generic property
> influences badly the DT representation of simplefb.

+1 to all that Maxime said.

Also as can be seen in other discussion on this patch set, simplefb
should not be seen as something orthogonal to having a full kms driver.

So just write a full kms driver is not the answer IMHO. What we want
is for a bootloader setup console to be available through simplefb
bindings so that the kernel can show output without depending on
module loading, and thus can show errors if things go bad before
a kms driver gets loaded.

And no build kms into the kernel is not the answer. We've all been
working hard to be able to build more generic kernels, so as to get
generic distro support. And generic distros will build kms as modules,
as there are simply to many different kms drivers to build them all
in.

Regards,

Hans
