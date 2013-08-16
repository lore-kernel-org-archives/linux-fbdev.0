From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 20:40:26 +0000
Subject: Re: conflict of hyperv_fb and the generic video driver?
Message-Id: <CANq1E4S9kwDj_J0tu8pgXOVJhvokEzCFNvs2VTQfxA21GHgfGQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <511c70f647a8481d90e8660773512efc@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
 <CANq1E4SsnQfRNpgcNW12t26MeQvVVS9p136dGTirPaJZKxXo_Q@mail.gmail.com>
 <c4a33a56e2844e5b8bda5bcfc2535aa4@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
In-Reply-To: <c4a33a56e2844e5b8bda5bcfc2535aa4@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi

On Fri, Aug 16, 2013 at 10:27 PM, Haiyang Zhang <haiyangz@microsoft.com> wrote:
>
>
>> -----Original Message-----
>> From: David Herrmann [mailto:dh.herrmann@gmail.com]
>> Sent: Friday, August 16, 2013 3:11 PM
>> To: Haiyang Zhang
>> Cc: linux-fbdev@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
>> Tomi Valkeinen; Jean-Christophe Plagniol-Villard; akpm@linux-
>> foundation.org; KY Srinivasan
>> Subject: Re: conflict of hyperv_fb and the generic video driver?
>>
>> Hi
>>
>> (hint: your mail header seems to drop Reference-to/Reply-to headers
>> and breaks thread-info)
>>
>> On Fri, Aug 16, 2013 at 8:45 PM, Haiyang Zhang <haiyangz@microsoft.com>
>> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: David Herrmann [mailto:dh.herrmann@gmail.com]
>> >> Sent: Friday, August 16, 2013 9:46 AM
>> >> To: Haiyang Zhang
>> >> Cc: linux-fbdev@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
>> >> Tomi Valkeinen; Jean-Christophe Plagniol-Villard; akpm@linux-
>> >> foundation.org; KY Srinivasan
>> >> Subject: Re: source code file for the generic vga driver?
>> >>
>> >> Hi
>> >>
>> >> On Mon, Aug 5, 2013 at 9:12 PM, Haiyang Zhang
>> <haiyangz@microsoft.com>
>> >> wrote:
>> >> > Hi folks,
>> >> >
>> >> > I'm working on an issue of HyperV synthetic frame buffer driver, which
>> >> > seems to have a conflict with the generic vga driver (not the vesa
>> >> > driver). I hope to read and trace into the source code for the generic vga
>> >> driver...
>> >> >
>> >> > Can anyone point me to the source code file for the generic vga driver in
>> >> the kernel tree?
>> >>
>> >> Everything lives in ./drivers/video/. The drivers you're probably interested
>> in
>> >> are "vesafb.c" or "vga16fb.c". There is also the "vgacon" driver
>> >> in ./drivers/video/console/vgacon.c. I am not sure which one you are
>> talking
>> >> about.
>> >>
>> >> You might also want to have a look at the x86 sysfb infrastructure which
>> isn't
>> >> merged, yet:
>> >> http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/fb
>> >> It provides proper platform-devices so drivers no longer conflict on the
>> >> vga/vesa/efi.. framebuffer resources. It's x86 only as all the relevant
>> drivers
>> >> only work on x86.
>> >>
>> >> If you give some more information on what you are trying to do, I can
>> point
>> >> you to the relevant resources. My guess is that you want to have a look at
>> >> remove_conflicting_framebuffers() in ./drivers/video/fbmem.c.
>> >
>> > Thank you for the detailed reply!
>> >
>> > I'm looking at a problem of Hyper-V synthetic fb driver (hyperv_fb) which
>> seems
>> > to have conflict with some kind of generic video driver. I'm not sure which
>> driver
>> > is this.
>> >
>> > On Suse, the vesafb is removed automatically by
>> remove_conflicting_framebuffers()
>> > when hyperv_fb is loaded. We don't have any problem here.
>> >
>> > On some other Distros, like RHEL, CentOS, Ubuntu, the generic driver
>> seems not
>> > to be vesafb -- I can't see any /dev/fb* there. And, the generic video driver
>> seems not be
>> > removed when hyperv_fb is loaded. This generic video driver is not vesafb
>> or vga16fb or
>> > vgacon, because it supports x-window GUI, and it's still here after I un-
>> configured vesafb
>> > and vga16fb.
>> >
>> > Could point out what is the generic video driver used by RHEL, Ubuntu by
>> default? And,
>> > how to let it exit automatically when our FB driver (hyperv_fb) is loaded?
>>
>> I have no idea what RHEL or Ubuntu use, sorry. But your description
>> sounds odd. The kernel has 3 different places that could use VGA
>> resources:
>>  - fbdev drivers (/dev/fbX or /sys/class/graphics)
>>  - DRM drivers (/dev/dri/cardX or /sys/class/drm)
>>  - vgacon
>> Could you check whether these directories are empty?
>> (/sys/class/graphics/ and /sys/class/drm/ on a running machine)
>>
>> If these are empty, this doesn't look like a kernel thing. Are you
>> sure it's a kernel driver that accesses your VGA resources? The
>> xserver used to have some pretty huge vga/vesa/.. user-space drivers.
>>
>> Could you tell me whether the linux-console actually works? That is,
>> do you get some console output if xserver is not running?
>
> To find out the default driver, I manually removed my hyperv_fb driver.
> The vesafb is unconfigured:
> # CONFIG_FB_BOOT_VESA_SUPPORT is not set
> # CONFIG_FB_UVESA is not set
> # CONFIG_FB_VESA is not set
>
> But I saw VESA VBE in the x log. Seems it's the default driver:
> "/var/log/Xorg.0.log":
> [    12.340] (II) VESA(0): Primary V_BIOS segment is: 0xc000
> [    12.341] (II) VESA(0): VESA BIOS detected
> [    12.341] (II) VESA(0): VESA VBE Version 2.0
> [    12.341] (II) VESA(0): VESA VBE Total Mem: 4096 kB
> [    12.341] (II) VESA(0): VESA VBE OEM: IBM SVGA BIOS, (C) 1993 International Business Machines
> [    12.341] (II) VESA(0): VESA VBE OEM Software Rev: 0.0
> [    12.365] (II) VESA(0): Creating default Display subsection in Screen section
>         "Default Screen Section" for depth/fbbpp 24/32
> [    12.365] (=) VESA(0): Depth 24, (--) framebuffer bpp 32
> [    12.365] (=) VESA(0): RGB weight 888
> [    12.365] (=) VESA(0): Default visual is TrueColor
> [    12.365] (=) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
>
> There is no  /dev/fb*,  /dev/dri/, /sys/class/drm
> I see /sys/class/graphics/fbcon is here.  But console output is not working.
>
> Seems that the VESA VBE is causing conflict with my driver... Is there
> any way to disable VESA VBE driver?

This is the Xorg vesa driver. There is no way to detect that from the
kernel (at least no sane way). Just uninstall the vesa driver, no one
uses that these days. At least I see no reason why you would use it.
Probably named xf86-video-vesa. Or make sure your hyperv fbdev driver
is loaded before xorg starts and then load xf86-video-fbdev over
xf86-video-vesa.

Regards
David
