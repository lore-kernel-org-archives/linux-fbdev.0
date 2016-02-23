From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Date: Tue, 23 Feb 2016 10:59:50 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <6A77838A-7F72-40C3-B279-710F305AEB40@konsulko.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAHCN7xLo7q=Ts3WLvx_GzSBWt5r1SiU7vr+W==kUAaAvmwXJYA@mail.gmail.com>
In-Reply-To: <CAHCN7xLo7q=Ts3WLvx_GzSBWt5r1SiU7vr+W==kUAaAvmwXJYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Adam,

> On Feb 23, 2016, at 12:32 , Adam Ford <aford173@gmail.com> wrote:
> 
> On Tue, Feb 23, 2016 at 3:58 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> (cc'ing a few more people as this is going into generic direction)
>> 
>> On 23/02/16 11:08, Linus Walleij wrote:
>>> On Thu, Feb 4, 2016 at 3:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> 
>>>> This moves the versatile CLCD configuration to the device tree by:
>>> 
>>> As this Schrödinger's cat approach seems controversial, as well
>>> as the alternative to manipulate the DT in memory at run-time,
>>> I will respin the series without the full Versatile support, adding
>>> plug-in for the other ARM boards and and half-baked support
>>> for the Versatile supporting just VGA (like the other reference
>>> designs from ARM).
>>> 
>>> The pluggable displays prove yet again to be a problem to the
>>> world, sigh.
>>> 
>>> I will think of a better solution, if any, for this for v4.6, but will
>>> put forward something that handles the Nomadik and all the
>>> other ARM reference designs for now.
>> 
>> I had a chat with Tom Rini and Pantelis Antoniou yesterday.
>> 
>> Panto is about to send a new series for DT overlay management soon. I
>> haven't had time to test that yet, but what it would give us is that you
>> could build DT overlay binaries as "firmware" into the kernel image, and
>> thus the panel DT data would be there even before rootfs is mounted. The
>> DT overlays can be loaded from the rootfs or initramfs too, if it's not
>> critical to get the display up early.
>> 
>> I'm not quite sure how it works if, as in versatile display case, there
>> are multiple DT overlays of which one has to be enabled. I hope there's
>> support to choose which one to use via kernel cmdline or similar.
>> 
>> I would personally like it much more if the bootloader would either
>> compose a final dtb from DT fragments and pass it to the kernel, or
>> alternatively the bootloader would pass the base dtb image and a bunch
>> of DT overlays to the kernel, and the kernel would deal with the DT
>> overlays.
>> 
> If there was a nice way to merge the device trees, I would love to
> create device tree 'modules' that could be loaded at will and merged
> just before the time of boot.  I could see this being useful beyond
> just plugable displays.
> 

Looks like you would be happy by having a way to boot using a device tree
blob + a number of device tree overlay blobs to be applied in sequence.

You could append the dtbo’s to the device tree blob (where-ever that may be)
and it should work.

The good thing about this scheme is that it’s independent of the bootloader.

An advanced bootloader (like u-boot) with DT smarts can create the appended
DT blob itself, while a dumb one can just be given the appended blob as
it was created outside of the device.

>> In any case, I think the firmware solution is a good step forward, and
>> will probably work fine for many users. Then again, I haven't tested it
>> yet so I don't know the details, and it's not in the mainline.
>> 
> I am willing to test it, but I'll need the patch and some instructions
> from Panto.
> 

The appended device tree blob thing does not exist yet, but it’s not such a big
problem to add. I’d give it a shot this week.

The standard device tree overlays are in my overlay branch at
https://github.com/pantoniou/linux-beagle-track-mainline/tree/bbb-overlays

The capemgr has options for parsing a kernel command line to apply an overlay:

https://github.com/pantoniou/linux-beagle-track-mainline/blob/bbb-overlays/drivers/misc/bone_capemgr.c

The command line options are enable_partno & disable_partno where you supply
the part numbers of the capes you want enabled/disabled at boot.

The capemgr is complicated due to the eeprom detection and the horrible kludges done with the
variants (beaglebone white/beaglebone black), but I think you can figure out what’s going
on with the command line options.


>> Tomi
>> 

Regards

— Pantelis

