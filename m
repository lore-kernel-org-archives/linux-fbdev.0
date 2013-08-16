From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 19:11:05 +0000
Subject: Re: conflict of hyperv_fb and the generic video driver?
Message-Id: <CANq1E4SsnQfRNpgcNW12t26MeQvVVS9p136dGTirPaJZKxXo_Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <511c70f647a8481d90e8660773512efc@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
In-Reply-To: <511c70f647a8481d90e8660773512efc@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi

(hint: your mail header seems to drop Reference-to/Reply-to headers
and breaks thread-info)

On Fri, Aug 16, 2013 at 8:45 PM, Haiyang Zhang <haiyangz@microsoft.com> wrote:
>
>
>> -----Original Message-----
>> From: David Herrmann [mailto:dh.herrmann@gmail.com]
>> Sent: Friday, August 16, 2013 9:46 AM
>> To: Haiyang Zhang
>> Cc: linux-fbdev@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
>> Tomi Valkeinen; Jean-Christophe Plagniol-Villard; akpm@linux-
>> foundation.org; KY Srinivasan
>> Subject: Re: source code file for the generic vga driver?
>>
>> Hi
>>
>> On Mon, Aug 5, 2013 at 9:12 PM, Haiyang Zhang <haiyangz@microsoft.com>
>> wrote:
>> > Hi folks,
>> >
>> > I'm working on an issue of HyperV synthetic frame buffer driver, which
>> > seems to have a conflict with the generic vga driver (not the vesa
>> > driver). I hope to read and trace into the source code for the generic vga
>> driver...
>> >
>> > Can anyone point me to the source code file for the generic vga driver in
>> the kernel tree?
>>
>> Everything lives in ./drivers/video/. The drivers you're probably interested in
>> are "vesafb.c" or "vga16fb.c". There is also the "vgacon" driver
>> in ./drivers/video/console/vgacon.c. I am not sure which one you are talking
>> about.
>>
>> You might also want to have a look at the x86 sysfb infrastructure which isn't
>> merged, yet:
>> http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/log/?h=x86/fb
>> It provides proper platform-devices so drivers no longer conflict on the
>> vga/vesa/efi.. framebuffer resources. It's x86 only as all the relevant drivers
>> only work on x86.
>>
>> If you give some more information on what you are trying to do, I can point
>> you to the relevant resources. My guess is that you want to have a look at
>> remove_conflicting_framebuffers() in ./drivers/video/fbmem.c.
>
> Thank you for the detailed reply!
>
> I'm looking at a problem of Hyper-V synthetic fb driver (hyperv_fb) which seems
> to have conflict with some kind of generic video driver. I'm not sure which driver
> is this.
>
> On Suse, the vesafb is removed automatically by remove_conflicting_framebuffers()
> when hyperv_fb is loaded. We don't have any problem here.
>
> On some other Distros, like RHEL, CentOS, Ubuntu, the generic driver seems not
> to be vesafb -- I can't see any /dev/fb* there. And, the generic video driver seems not be
> removed when hyperv_fb is loaded. This generic video driver is not vesafb or vga16fb or
> vgacon, because it supports x-window GUI, and it's still here after I un-configured vesafb
> and vga16fb.
>
> Could point out what is the generic video driver used by RHEL, Ubuntu by default? And,
> how to let it exit automatically when our FB driver (hyperv_fb) is loaded?

I have no idea what RHEL or Ubuntu use, sorry. But your description
sounds odd. The kernel has 3 different places that could use VGA
resources:
 - fbdev drivers (/dev/fbX or /sys/class/graphics)
 - DRM drivers (/dev/dri/cardX or /sys/class/drm)
 - vgacon
Could you check whether these directories are empty?
(/sys/class/graphics/ and /sys/class/drm/ on a running machine)

If these are empty, this doesn't look like a kernel thing. Are you
sure it's a kernel driver that accesses your VGA resources? The
xserver used to have some pretty huge vga/vesa/.. user-space drivers.

Could you tell me whether the linux-console actually works? That is,
do you get some console output if xserver is not running?

Cheers
David
