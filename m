From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 16 Aug 2013 23:11:50 +0000
Subject: Re: conflict of hyperv_fb and the generic video driver?
Message-Id: <CANq1E4TwJe9w2gGMyLx-6nk4G3SVe-sh18ST-OSmnXGb2Pyo6g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <511c70f647a8481d90e8660773512efc@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
 <CANq1E4SsnQfRNpgcNW12t26MeQvVVS9p136dGTirPaJZKxXo_Q@mail.gmail.com>
 <c4a33a56e2844e5b8bda5bcfc2535aa4@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
 <CANq1E4S9kwDj_J0tu8pgXOVJhvokEzCFNvs2VTQfxA21GHgfGQ@mail.gmail.com>
 <34df20beb0de41f4b52ec4a2177e8f3e@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
In-Reply-To: <34df20beb0de41f4b52ec4a2177e8f3e@DFM-DB3MBX15-06.exchange.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "driverdev-devel@linuxdriverproject.org" <driverdev-devel@linuxdriverproject.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hi

On Sat, Aug 17, 2013 at 1:04 AM, Haiyang Zhang <haiyangz@microsoft.com> wrote:
>> > But I saw VESA VBE in the x log. Seems it's the default driver:
>> > "/var/log/Xorg.0.log":
>> > [    12.340] (II) VESA(0): Primary V_BIOS segment is: 0xc000
>> > [    12.341] (II) VESA(0): VESA BIOS detected
>> > [    12.341] (II) VESA(0): VESA VBE Version 2.0
>> > [    12.341] (II) VESA(0): VESA VBE Total Mem: 4096 kB
>> > [    12.341] (II) VESA(0): VESA VBE OEM: IBM SVGA BIOS, (C) 1993
>> International Business Machines
>> > [    12.341] (II) VESA(0): VESA VBE OEM Software Rev: 0.0
>> > [    12.365] (II) VESA(0): Creating default Display subsection in Screen
>> section
>> >         "Default Screen Section" for depth/fbbpp 24/32
>> > [    12.365] (=) VESA(0): Depth 24, (--) framebuffer bpp 32
>> > [    12.365] (=) VESA(0): RGB weight 888
>> > [    12.365] (=) VESA(0): Default visual is TrueColor
>> > [    12.365] (=) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
>> >
>> > There is no  /dev/fb*,  /dev/dri/, /sys/class/drm I see
>> > /sys/class/graphics/fbcon is here.  But console output is not working.
>> >
>> > Seems that the VESA VBE is causing conflict with my driver... Is there
>> > any way to disable VESA VBE driver?
>>
>> This is the Xorg vesa driver. There is no way to detect that from the kernel (at
>> least no sane way). Just uninstall the vesa driver, no one uses that these days.
>> At least I see no reason why you would use it.
>> Probably named xf86-video-vesa. Or make sure your hyperv fbdev driver is
>> loaded before xorg starts and then load xf86-video-fbdev over xf86-video-
>> vesa.
>
> Removing the xorg vesa driver has solved the conflict.
>
> Also, I found adding a xorg.conf which specifies fbdev can solve the problem too:
> [root@localhost ~]# cat /etc/X11/xorg.conf
> Section "Device"
>     Identifier  "HYPER-V Framebuffer"
>     Driver      "fbdev"
> EndSection
>
> Thank you SO MUCH for the help!!

You're welcome. Good to hear it's solved now.

Cheers
David
