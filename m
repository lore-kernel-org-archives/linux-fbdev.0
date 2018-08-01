From: David Airlie <airlied@redhat.com>
Date: Wed, 01 Aug 2018 22:31:41 +0000
Subject: Re: Sleeping from invalid context in udlfb
Message-Id: <CAMwc25ryeLgZ+m87eeJR2Ti8330uR-dFkxP2kcETJ6ZfrLZZRQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0000000000003ee66f05726742e5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180603154636epcas2p4812a1f19c6ae236336ae580658edb167@epcas2p4.samsung.com>
 <6008699.T6Yd1fn3Dk@amdc3058>
 <alpine.LRH.2.02.1807092148080.30863@file01.intranet.prod.int.rdu2.redhat.com>
 <1975707.vO8kdHz3oS@amdc3058>
 <alpine.LRH.2.02.1807300552140.2919@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1807311111520.22145@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdVBurd2L1iK218QvNUorLyQs4nnTpikZGgJRZjHN8apAw@mail.gmail.com>
 <alpine.LRH.2.02.1808010657300.903@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdUGSv-_2nTcRoj1ScC2XhYr75yX4ttSvwcyW8esJas=eQ@mail.gmail.com>
 <alpine.LRH.2.02.1808010929580.30128@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808010929580.30128@file01.intranet.prod.int.rdu2.redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, Bernie Thompson <bernie@plugable.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.com>

--0000000000003ee66f05726742e5
Content-Type: text/plain; charset="UTF-8"

I'm pretty sure udlkms handles this already.

Dave.

On Wed, Aug 1, 2018 at 11:34 PM, Mikulas Patocka <mpatocka@redhat.com>
wrote:

>
>
> On Wed, 1 Aug 2018, Geert Uytterhoeven wrote:
>
> > Hi Mikulas,
> >
> > On Wed, Aug 1, 2018 at 12:59 PM Mikulas Patocka <mpatocka@redhat.com>
> wrote:
> > > On Wed, 1 Aug 2018, Geert Uytterhoeven wrote:
> > > > On Tue, Jul 31, 2018 at 5:23 PM Mikulas Patocka <mpatocka@redhat.com>
> wrote:
> > > > > BTW when using the udlfb driver as a console, I've got this
> warning.
> > > > > vt_console_print takes a spinlock and then calls the framebuffer
> driver
> > > > > that sleeps.
> > > > >
> > > > > The question is - whose fault is this? Could the console code
> somehow be
> > > > > told to print characters without holding a spinlock? Or does it
> mean that
> > > > > framebuffer drivers can't sleep?
> > > > >
> > > > > udlfb communicates through USB, so the sleeping is inevitable.
> > > > >
> > > > > Mikulas
> > > > >
> > > > >
> > > > > BUG: sleeping function called from invalid context at mm/slab.h:421
> > > > > in_atomic(): 1, irqs_disabled(): 0, pid: 430, name: kworker/2:3
> > > > > 6 locks held by kworker/2:3/430:
> > > > >  #0: 000000001301127e ( (wq_completion)"events"){....} , at:
> process_one_work+0x17c/0x3a8
> > > > >  #1: 00000000beacc951 ( (work_completion)(&(&dlfb->
> init_framebuffer_work)->work)){....} , at: process_one_work+0x17c/0x3a8
> > > > >  #2: 00000000a402f826 ( registration_lock){....} , at:
> register_framebuffer+0x28/0x2c0 [fb]
> > > > >  #3: 0000000021cbe902 ( console_lock){....} , at:
> register_framebuffer+0x258/0x2c0 [fb]
> > > > >  #4: 0000000096d51735 ( console_owner){....} , at:
> console_unlock+0x174/0x500
> > > > >  #5: 00000000faa7f206 ( printing_lock){....} , at:
> vt_console_print+0x60/0x3a0
> > > > > Preemption disabled at: [<ffffff8008403130>]
> vt_console_print+0x60/0x3a0
> > > > > CPU: 2 PID: 430 Comm: kworker/2:3 Not tainted 4.17.10-debug #3
> > > > > Hardware name: Marvell Armada 8040 MacchiatoBin/Armada 8040
> MacchiatoBin, BIOS EDK II Jul 30 2018
> > > > > Workqueue: events dlfb_init_framebuffer_work [udlfb]
> > > > > Call trace:
> > > > >  dump_backtrace+0x0/0x150
> > > > >  show_stack+0x14/0x20
> > > > >  dump_stack+0x8c/0xac
> > > > >  ___might_sleep+0x140/0x170
> > > > >  __might_sleep+0x50/0x88
> > > > >  __kmalloc+0x1b0/0x270
> > > > >  xhci_urb_enqueue+0xa8/0x460 [xhci_hcd]
> > > > >  usb_hcd_submit_urb+0xc0/0x998 [usbcore]
> > > > >  usb_submit_urb+0x1e0/0x518 [usbcore]
> > > > >  dlfb_submit_urb+0x38/0x98 [udlfb]
> > > > >  dlfb_handle_damage.isra.4+0x1e0/0x210 [udlfb]
> > > > >  dlfb_ops_imageblit+0x28/0x38 [udlfb]
> > > > >  soft_cursor+0x15c/0x1d8 [fb]
> > > > >  bit_cursor+0x324/0x510 [fb]
> > > > >  fbcon_cursor+0x144/0x1a0 [fb]
> > > > >  hide_cursor+0x38/0xa0
> > > > >  vt_console_print+0x334/0x3a0
> > > > >  console_unlock+0x274/0x500
> > > > >  register_framebuffer+0x22c/0x2c0 [fb]
> > > > >  dlfb_init_framebuffer_work+0x1ec/0x2fc [udlfb]
> > > > >  process_one_work+0x1e8/0x3a8
> > > > >  worker_thread+0x44/0x418
> > > > >  kthread+0x11c/0x120
> > > > >  ret_from_fork+0x10/0x18
> > > >
> > > > This is sort of expected: you cannot do USB transfers from printk().
> > > >
> > > > Gr{oetje,eeting}s,
> > > >
> > > >                         Geert
> > >
> > > So, should there be a framebuffer flag that prevents the console from
> > > binding to it?
> > >
> > > If I start the kernel with "console=ttyS0,115200", it doesn't try to
> bind
> > > to the udlfb driver, but if I start it without this flag, it does and
> > > crashes :-(
> >
> > Your frame buffer driver should offload tasks that may sleep to e.g. a
> > workqueue.
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
>
> I can try to do this - but - taking a spinlock and copying 8MB framebuffer
> would damage scheduling latency even for PCI framebuffer drivers.
>
> Mikulas
>

--0000000000003ee66f05726742e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>I&#39;m pretty sure udlkms handles thi=
s already.</div><div><br></div><div>Dave.<br></div></div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Wed, Aug 1, 2018 at 11:34 PM, Mi=
kulas Patocka <span dir=3D"ltr">&lt;<a href=3D"mailto:mpatocka@redhat.com" =
target=3D"_blank">mpatocka@redhat.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On Wed, 1 Aug 2018, Geert Uytterhoeven wrote:<br>
<br>
&gt; Hi Mikulas,<br>
&gt; <br>
&gt; On Wed, Aug 1, 2018 at 12:59 PM Mikulas Patocka &lt;<a href=3D"mailto:=
mpatocka@redhat.com">mpatocka@redhat.com</a>&gt; wrote:<br>
&gt; &gt; On Wed, 1 Aug 2018, Geert Uytterhoeven wrote:<br>
&gt; &gt; &gt; On Tue, Jul 31, 2018 at 5:23 PM Mikulas Patocka &lt;<a href=
=3D"mailto:mpatocka@redhat.com">mpatocka@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; BTW when using the udlfb driver as a console, I&#39;ve =
got this warning.<br>
&gt; &gt; &gt; &gt; vt_console_print takes a spinlock and then calls the fr=
amebuffer driver<br>
&gt; &gt; &gt; &gt; that sleeps.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The question is - whose fault is this? Could the consol=
e code somehow be<br>
&gt; &gt; &gt; &gt; told to print characters without holding a spinlock? Or=
 does it mean that<br>
&gt; &gt; &gt; &gt; framebuffer drivers can&#39;t sleep?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; udlfb communicates through USB, so the sleeping is inev=
itable.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Mikulas<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; BUG: sleeping function called from invalid context at m=
m/slab.h:421<br>
&gt; &gt; &gt; &gt; in_atomic(): 1, irqs_disabled(): 0, pid: 430, name: kwo=
rker/2:3<br>
&gt; &gt; &gt; &gt; 6 locks held by kworker/2:3/430:<br>
&gt; &gt; &gt; &gt;=C2=A0 #0: 000000001301127e ( (wq_completion)&quot;event=
s&quot;){....} , at: process_one_work+0x17c/0x3a8<br>
&gt; &gt; &gt; &gt;=C2=A0 #1: 00000000beacc951 ( (work_completion)(&amp;(&a=
mp;dlfb-&gt;<wbr>init_framebuffer_work)-&gt;work))<wbr>{....} , at: process=
_one_work+0x17c/0x3a8<br>
&gt; &gt; &gt; &gt;=C2=A0 #2: 00000000a402f826 ( registration_lock){....} ,=
 at: register_framebuffer+0x28/<wbr>0x2c0 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 #3: 0000000021cbe902 ( console_lock){....} , at: =
register_framebuffer+0x258/<wbr>0x2c0 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 #4: 0000000096d51735 ( console_owner){....} , at:=
 console_unlock+0x174/0x500<br>
&gt; &gt; &gt; &gt;=C2=A0 #5: 00000000faa7f206 ( printing_lock){....} , at:=
 vt_console_print+0x60/0x3a0<br>
&gt; &gt; &gt; &gt; Preemption disabled at: [&lt;ffffff8008403130&gt;] vt_c=
onsole_print+0x60/0x3a0<br>
&gt; &gt; &gt; &gt; CPU: 2 PID: 430 Comm: kworker/2:3 Not tainted 4.17.10-d=
ebug #3<br>
&gt; &gt; &gt; &gt; Hardware name: Marvell Armada 8040 MacchiatoBin/Armada =
8040 MacchiatoBin, BIOS EDK II Jul 30 2018<br>
&gt; &gt; &gt; &gt; Workqueue: events dlfb_init_framebuffer_work [udlfb]<br=
>
&gt; &gt; &gt; &gt; Call trace:<br>
&gt; &gt; &gt; &gt;=C2=A0 dump_backtrace+0x0/0x150<br>
&gt; &gt; &gt; &gt;=C2=A0 show_stack+0x14/0x20<br>
&gt; &gt; &gt; &gt;=C2=A0 dump_stack+0x8c/0xac<br>
&gt; &gt; &gt; &gt;=C2=A0 ___might_sleep+0x140/0x170<br>
&gt; &gt; &gt; &gt;=C2=A0 __might_sleep+0x50/0x88<br>
&gt; &gt; &gt; &gt;=C2=A0 __kmalloc+0x1b0/0x270<br>
&gt; &gt; &gt; &gt;=C2=A0 xhci_urb_enqueue+0xa8/0x460 [xhci_hcd]<br>
&gt; &gt; &gt; &gt;=C2=A0 usb_hcd_submit_urb+0xc0/0x998 [usbcore]<br>
&gt; &gt; &gt; &gt;=C2=A0 usb_submit_urb+0x1e0/0x518 [usbcore]<br>
&gt; &gt; &gt; &gt;=C2=A0 dlfb_submit_urb+0x38/0x98 [udlfb]<br>
&gt; &gt; &gt; &gt;=C2=A0 dlfb_handle_damage.isra.4+<wbr>0x1e0/0x210 [udlfb=
]<br>
&gt; &gt; &gt; &gt;=C2=A0 dlfb_ops_imageblit+0x28/0x38 [udlfb]<br>
&gt; &gt; &gt; &gt;=C2=A0 soft_cursor+0x15c/0x1d8 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 bit_cursor+0x324/0x510 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 fbcon_cursor+0x144/0x1a0 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 hide_cursor+0x38/0xa0<br>
&gt; &gt; &gt; &gt;=C2=A0 vt_console_print+0x334/0x3a0<br>
&gt; &gt; &gt; &gt;=C2=A0 console_unlock+0x274/0x500<br>
&gt; &gt; &gt; &gt;=C2=A0 register_framebuffer+0x22c/<wbr>0x2c0 [fb]<br>
&gt; &gt; &gt; &gt;=C2=A0 dlfb_init_framebuffer_work+<wbr>0x1ec/0x2fc [udlf=
b]<br>
&gt; &gt; &gt; &gt;=C2=A0 process_one_work+0x1e8/0x3a8<br>
&gt; &gt; &gt; &gt;=C2=A0 worker_thread+0x44/0x418<br>
&gt; &gt; &gt; &gt;=C2=A0 kthread+0x11c/0x120<br>
&gt; &gt; &gt; &gt;=C2=A0 ret_from_fork+0x10/0x18<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This is sort of expected: you cannot do USB transfers from p=
rintk().<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Gr{oetje,eeting}s,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Geert<br>
&gt; &gt;<br>
&gt; &gt; So, should there be a framebuffer flag that prevents the console =
from<br>
&gt; &gt; binding to it?<br>
&gt; &gt;<br>
&gt; &gt; If I start the kernel with &quot;console=3DttyS0,115200&quot;, it=
 doesn&#39;t try to bind<br>
&gt; &gt; to the udlfb driver, but if I start it without this flag, it does=
 and<br>
&gt; &gt; crashes :-(<br>
&gt; <br>
&gt; Your frame buffer driver should offload tasks that may sleep to e.g. a=
<br>
&gt; workqueue.<br>
&gt; <br>
&gt; Gr{oetje,eeting}s,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Geert<br>
<br>
</div></div>I can try to do this - but - taking a spinlock and copying 8MB =
framebuffer <br>
would damage scheduling latency even for PCI framebuffer drivers.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Mikulas<br>
</font></span></blockquote></div><br></div>

--0000000000003ee66f05726742e5--
