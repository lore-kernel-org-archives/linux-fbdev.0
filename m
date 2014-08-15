From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date: Fri, 15 Aug 2014 12:34:45 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CAKON4OxBoJ-7PqE+yqv9E7uYPwPEaY2jUN8kFaGoVeQEGnqNLw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be>
 <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <CAKON4OzQbuaQsbTCDXuaqxLRxvat_5+wmf71S-rWXdfiT1gkvA@mail.gmail.com>
 <CACxGe6v1UPHMF5aPpe-boh+RuoPArJmKK_cQWr7aXsRjDUZrfQ@mail.gmail.com>
 <CAKON4OypgToTSXxjShCt6uTGZBU69LpJxRwVoz=PnotpL=zm4w@mail.gmail.com>
 <1408063512.890.22.camel@localhost>
 <CAKON4Oyp0qCucAhTNeXu7LELv_MRXPkYum+jOH2QADHb4Lw_HA@mail.gmail.com>
 <20140815064336.GX15297@lukather>
In-Reply-To: <20140815064336.GX15297@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Fri, Aug 15, 2014 at 2:43 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Aug 14, 2014 at 09:27:14PM -0400, jonsmirl@gmail.com wrote:
>> On Thu, Aug 14, 2014 at 8:45 PM, Henrik Nordstr=C3=B6m
>> <henrik@henriknordstrom.net> wrote:
>> > tor 2014-08-14 klockan 08:07 -0400 skrev jonsmirl@gmail.com:
>> >
>> >> So what are the rules going to be? Once the OS is up and starts
>> >> changing things the state in the DT and the OS are going to diverge.
>> >> How does this get handled for a kernel driver that can load/unload?
>> >> Should the kernel remove those state nodes as soon as it alters the
>> >> state?
>> >
>> > hardware that is no longer there should also not be represented/active
>> > in DT.
>> >
>> > A simple fb that have been torn down is no more, no different from nev=
er
>> > having been there. It can be argued that it never was in the first pla=
ce
>> > (i.e. that it is not actually hardware) but that it another can of wor=
ms
>> > and both have their benefits and drawbacks. One thing is certain
>> > however, as far as simplefb is concerned it is hardware, not really any
>> > different from a persistent framebuffer with hardwired settings in
>> > hardware.
>>
>> How does the kernel know what clocks to protect? A list in the
>> simplefb node?  This list of clocks is a reason for adding simplefb to
>> the compatible list for the real hardware.  That way it won't be
>> duplicated.
>>
>> The issues with parameter conflicts between simplefb and the real
>> hardware can be dealt with.  If the real hardware wants to add the
>> simplefb compatible field it will need to get its parameters sorted
>> out so that they don't conflict. Clock syntax is standardized in the
>> DTS so it shouldn't be a problem.
>
> It shouldn't be, but apparently, some disagree.
>
> Anyway, I'm not sure having the simplefb compatible would work in this
> use-case, mainly for two reasons:
>   - Most likely, the bindings are going to be very different. Not only
>     about which properties you'll have, but also what you will place
>     in these properties. reg for example have the memory address of
>     the buffer in the simplefb case, while in the KMS driver case, it
>     would have the memory address of the registers.
>   - There's will be a single driver probed. So if you want to go down
>     the hand over road (which is a bit premature at this point if you
>     ask me, but anyway), you will have no driver probed to hand over
>     to.

The graphic drivers have already been down this road before. Simplefb
should be a driver library not a driver. DRM is also a driver library.

So to implement simplefb whip up a real skeleton driver for the video
hardware that parses the DT and then pokes the appropriate info into
the simplefb library. Initially that driver will just include the
calls out to the simplefb library. Later on it can get KMS
implemented.  This real driver will get bound to the hardware and have
a dependency that loads the simplefb driver library.

Now there is no handover problem. Only a single driver is ever
attached to the hardware. When it wants to go into KMS mode it makes a
call into the simplefb library to shut down whatever it is doing.

But you still need a mechanism for uboot to signal that it has set up
simplefb. Adding a dynamic node like this might work...

video0: video@01c21800 {
   compatible =3D "allwinner,sun4i-a10-video";
   clocks =3D <&apb0_gates 6>, <&ir0_clk>;
   clock-names =3D "apb", "video";
   interrupts =3D <0 5 4>;
   reg =3D <0x01c21800 0x40>;
   status =3D "enabled";
   simplefb {
       new namespace for simplefb parameters
   }
};

I would have suggested a driver library earlier but it has been a
while since I worked on DRM and I forgot about it.



>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



--=20
Jon Smirl
jonsmirl@gmail.com
