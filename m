From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Wed, 01 Oct 2014 13:01:48 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAKON4OzeZHkkmjxe_72ykSy6wvhkEmb256-tdMB67eMVcrk7Zw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo>
In-Reply-To: <20141001124852.GB21733@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 1, 2014 at 8:48 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Wed, Oct 01, 2014 at 01:20:08PM +0100, Mark Brown wrote:
>> On Wed, Oct 01, 2014 at 10:14:44AM +0200, Thierry Reding wrote:
>> > On Tue, Sep 30, 2014 at 07:00:36PM +0100, Mark Brown wrote:
>>
>> > > You may well need to extend the binding in future for an actual driver
>> > > but from the point of view of what's going into the block it really
>> > > should just be a case of reading the datasheet and mechanically typing
>> > > that in.  If we can work out how to say where the framebuffer is we
>> > > really ought to be able to work this stuff out.
>>
>> > I agree from a technical point of view. However given the dynamically
>> > generated nature of the node the problem is more of a logistical nature.
>> > As we've seen U-Boot is being enabled to add clocks to the simplefb node
>> > but I'm fairly certain that there's a regulator somewhere that needs to
>> > be enabled too, be it for powering the display controller, the panel or
>> > the backlight. I wouldn't even be surprised if there were one for each
>> > of those. If so simplefb on this board will break when the regulators
>> > are described in the kernel's DTS.
>>
>> > If we don't consider this a problem then the whole DT ABI stability
>> > business is a farce.
>>
>> I think you're setting constraints on the implementation you want to see
>> which make it unworkable but I don't think those constraints are needed.
>> You're starting from the position that the DT needs to be updated without
>> the bootloader
>
> No, what I'm saying is that what the simplefb driver expects and what
> the bootloader sets up may diverge as resource drivers are added to the
> kernel. The DT /could/ be updated without the bootloader. You may only
> be able to replace the DTB but not the bootloader on a given platform.

simplefb should be a boot console and not survive past the boot
process. Trying to get a 'generic' console driver to survive the boot
process is not a generic problem. There are about 1,000 messages in
these threads explaining why this is not a generic problem.

All of these clock and regulator issues would go away by building a
device specific framebuffer driver.  A device specific framebuffer
driver can be written in a day or two, it is far simpler than a KMS
driver. This driver would how to parse the device specific device tree
node and do the right thing with the regulators/clocks.

So simplefb is built-in and used for early boot.  During the boot
process a device specific framebuffer driver loads.  This device
specific driver takes over for simplefb and can become the user space
console.

If the device specific framebuffer does not get loaded, then simplefb
is going to stop working when the clocks and regulators get shut off.
But that is what should happen.



>
>>                and that the DT must not contain any hint of simplefb as
>> shipped separately.
>
> Well, I don't think it should because it describes the same resources
> that the device tree node for the real device already describes. But
> perhaps this is one of the cases where duplication isn't all that bad?
>
>>                     That's never going to work well as far as I can see
>> but doesn't seem like an ABI stability issue, or at least not a
>> reasonable one.
>
> It would work well under the assumption that the kernel wouldn't be
> touching any of the resources that simplefb depends on. If that's not a
> reasonable assumption then I think we can't make simplefb work the way
> it's currently written.
>
>> Either the bootloader needs to be updated along with the DT
>
> I thought we had decided that this was one of the big no-nos. But
> perhaps I'm misremembering.
>
>>                                                             or the DT
>> needs to offer the bootloader a stable interface of its own for adding
>> the description of what it has set up (like a default disabled node
>> with the FB description, I'm sure other ideas are possible).  Obviously
>> the goal with the stable ABI is that the DT will be distributed along
>> with the platform.
>
> So instead of pretending that this is in any way generic, maybe a better
> idea would be to provide code in DRM/KMS drivers that is called early,
> grabs all the resources as defined in the binding for the device and
> then instantiates simplefb using the parsed information. Which is kind
> of the stub driver that Grant had suggested.
>
> Of course that means duplicating most of the resource handling from the
> real driver into this stub driver. And it means that this part of the
> driver would have to be built into the kernel and bloat it some more.
>
> Thierry



-- 
Jon Smirl
jonsmirl@gmail.com
