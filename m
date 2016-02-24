From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Wed, 24 Feb 2016 12:13:49 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <B8A82546-46C7-4A21-92D8-62418E49FBB6@konsulko.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com> <20160224104638.GL19428@n2100.arm.linux.org.uk>
 <56CD924F.50108@ti.com>
In-Reply-To: <56CD924F.50108@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Tomi,

> On Feb 24, 2016, at 13:21 , Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 

[snip]

>> 
>> That argument does not stack up.  Just because you've plugged in a
>> network device does not mean that the kernel can drive it: the kernel
>> needs a device specific driver, which is determined by looking at the
>> IDs.  There is no standard network driver PCI interface.
> 
> Yes, but you can connect the network device to any board with a PCI bus
> and it works. Here, if I'm not mistaken, the displays are built for this
> single board, making them board specific.
> 
> So sure, someone could build boards with the same connector, allowing
> you to connect the same displays. If that's the case, then CLCD should
> be taken out of this picture, as the board could have something else
> than CLCD as the display controller.
> 
>>> I think one of the core questions here is: do we want to start adding
>>> board specific drivers to the kernel, instead of dealing with it in the
>>> bootloader when possible? My understanding is that we've been trying to
>>> reduce board specific code from the kernel.
>> 
>> That's not really the question, because that question assumes that it
>> isn't already present, which is not true.  The code is already present.
>> The question is how to deal with this from the DT perspective.
> 
> Yes. As I commented in this (or the other thread), I'm looking for a
> proper generic solution which can be recommended for all new boards.
> When we know what that is, we can see if and how that could fit into
> Versatile's case. Versatile is not the only board with the exact same
> problem.
> 
> I wouldn't be at all surprised if the final solution is to just go with
> Linus' current patches for Versatile, as everything else would break
> compatibility or be overly complex.
> 
> But I cannot accept that as a general solution for all similar cases
> going forward, especially when moving to DRM world, that's just bad SW
> design.
> 

IMHO DT+overlays handle all your cases just fine.

As far as I see these are the cases which we need to handle:

1) The expansion board in question has some means of identification, whether it’s an
EEPROM or a GPIO keying combination etc. In that case it is the kernel’s job to match this
id value with a dtbo firmware file and apply it. The blob is located via means of request_firmware().

2) The expansion board in question has no means of identification. In that case the bootloader’s
job is to provide user-configured means to the kernel to use the expansion board.

We talked about two basic schemes.

2.1) The kernel command line contains information about the extra overlays to apply upon booting.
Something like “applyoverlays=foo.dtbo,bar.dtbo” is sufficient. The problem with this approach is that
if the firmware files must be present in the initrd/rootfs/builtin-kernel-image. For some this is a
problem.

2.2) The base DTB provided to the kernel from the bootloader is augmented with extra DTBOs that describe
the extra hardware. The concatenation is as simple as performing a ‘$ cat base.dtb foo.dtbo bar.dtbo’, which
can be done either by the bootloader or offline.  At the moment this is not being done, but it’s easy enough
to add it and other people expressed interest for it.

Am I missing something here?

> Tomi
> 

Regards

— Pantelis

