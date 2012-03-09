From: Michal Januszewski <michalj@gmail.com>
Date: Fri, 09 Mar 2012 00:39:23 +0000
Subject: Re: [PATCH] video:uvesafb: Fix oops that uvesafb try to execute NX-protected page
Message-Id: <CAMU5vjjvgRRejipVz5+LZ+8YE1usgaTQrmJzQ6TTY2tBbUXTbw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120302004850.GA4139@udknight>
	<20120305005250.GA17071@udknight>
	<4F54669E.6080009@gmx.de>
In-Reply-To: <4F54669E.6080009@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Wang YanQing <Udknight@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 5, 2012 at 08:09, Florian Tobias Schandinat
<FlorianSchandinat@gmx.de> wrote:
> On 03/05/2012 12:52 AM, Wang YanQing wrote:
>> On Fri, Mar 02, 2012 at 08:48:50AM +0800, Wang YanQing wrote:
>>>
>>> Ok! I think I have learned to make thing simple and send to the right p=
eople:)
>
> That's right.
>
>>> This patch try to fix the oops below that catched in my machine
>
> This sounds like you didn't test it. I assume you did? So just write
> "This patch fixes the oops below"
>
>>>
>>> [ =C2=A0 81.560602] uvesafb: NVIDIA Corporation, GT216 Board - 0696a290=
, Chip Rev =C2=A0 , OEM: NVIDIA, VBE v3.0
>>> [ =C2=A0 81.609384] uvesafb: protected mode interface info at c000:d350
>>> [ =C2=A0 81.609388] uvesafb: pmi: set display start =3D c00cd3b3, set p=
alette =3D c00cd40e
>>> [ =C2=A0 81.609390] uvesafb: pmi: ports =3D 3b4 3b5 3ba 3c0 3c1 3c4 3c5=
 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
>>> [ =C2=A0 81.614558] uvesafb: VBIOS/hardware doesn't support DDC transfe=
rs
>>> [ =C2=A0 81.614562] uvesafb: no monitor limits have been set, default r=
efresh rate will be used
>>> [ =C2=A0 81.614994] uvesafb: scrolling: ypan using protected mode inter=
face, yres_virtualI15
>>> [ =C2=A0 81.744147] kernel tried to execute NX-protected page - exploit=
 attempt? (uid: 0)
>>> [ =C2=A0 81.744153] BUG: unable to handle kernel paging request at c00c=
d3b3
>>> [ =C2=A0 81.744159] IP: [<c00cd3b3>] 0xc00cd3b2
>>> [ =C2=A0 81.744167] *pdpt =3D 00000000016d6001 *pde =3D 0000000001c7b06=
7 *pte =3D 80000000000cd163
>>> [ =C2=A0 81.744171] Oops: 0011 [#1] SMP
>>> [ =C2=A0 81.744174] Modules linked in: uvesafb(+) cfbcopyarea cfbimgblt=
 cfbfillrect
>>> [ =C2=A0 81.744178]
>>> [ =C2=A0 81.744181] Pid: 3497, comm: modprobe Not tainted 3.3.0-rc4NX+ =
#71 Acer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Aspire 4741 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/Aspire 4741
>>> [ =C2=A0 81.744185] EIP: 0060:[<c00cd3b3>] EFLAGS: 00010246 CPU: 0
>>> [ =C2=A0 81.744187] EIP is at 0xc00cd3b3
>>> [ =C2=A0 81.744189] EAX: 00004f07 EBX: 00000000 ECX: 00000000 EDX: 0000=
0000
>>> [ =C2=A0 81.744191] ESI: f763f000 EDI: f763f6e8 EBP: f57f3a0c ESP: f57f=
3a00
>>> [ =C2=A0 81.744192] =C2=A0DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
>>> [ =C2=A0 81.744195] Process modprobe (pid: 3497, ti=F57f2000 task=F748c=
600 task.ti=F57f2000)
>>> [ =C2=A0 81.744196] Stack:
>>> [ =C2=A0 81.744197] =C2=A0f82512c5 f759341c 00000000 f57f3a30 c124a9bc =
00000001 00000001 000001e0
>>> [ =C2=A0 81.744202] =C2=A0f8251280 f763f000 f7593400 00000000 f57f3a40 =
c12598dd f5c0c000 00000000
>>> [ =C2=A0 81.744206] =C2=A0f57f3b10 c1255efe c125a21a 00000006 f763f09c =
00000000 c1c6cb60 f7593400
>>> [ =C2=A0 81.744210] Call Trace:
>>> [ =C2=A0 81.744215] =C2=A0[<f82512c5>] ? uvesafb_pan_display+0x45/0x60 =
[uvesafb]
>>> [ =C2=A0 81.744222] =C2=A0[<c124a9bc>] fb_pan_display+0x10c/0x160
>>> [ =C2=A0 81.744226] =C2=A0[<f8251280>] ? uvesafb_vbe_find_mode+0x180/0x=
180 [uvesafb]
>>> [ =C2=A0 81.744230] =C2=A0[<c12598dd>] bit_update_start+0x1d/0x50
>>> [ =C2=A0 81.744232] =C2=A0[<c1255efe>] fbcon_switch+0x39e/0x550
>>> [ =C2=A0 81.744235] =C2=A0[<c125a21a>] ? bit_cursor+0x4ea/0x560
>>> [ =C2=A0 81.744240] =C2=A0[<c129b6cb>] redraw_screen+0x12b/0x220
>>> [ =C2=A0 81.744245] =C2=A0[<c128843b>] ? tty_do_resize+0x3b/0xc0
>>> [ =C2=A0 81.744247] =C2=A0[<c129ef42>] vc_do_resize+0x3d2/0x3e0
>>> [ =C2=A0 81.744250] =C2=A0[<c129efb4>] vc_resize+0x14/0x20
>>> [ =C2=A0 81.744253] =C2=A0[<c12586bd>] fbcon_init+0x29d/0x500
>>> [ =C2=A0 81.744255] =C2=A0[<c12984c4>] ? set_inverse_trans_unicode+0xe4=
/0x110
>>> [ =C2=A0 81.744258] =C2=A0[<c129b378>] visual_init+0xb8/0x150
>>> [ =C2=A0 81.744261] =C2=A0[<c129c16c>] bind_con_driver+0x16c/0x360
>>> [ =C2=A0 81.744264] =C2=A0[<c129b47e>] ? register_con_driver+0x6e/0x190
>>> [ =C2=A0 81.744267] =C2=A0[<c129c3a1>] take_over_console+0x41/0x50
>>> [ =C2=A0 81.744269] =C2=A0[<c1257b7a>] fbcon_takeover+0x6a/0xd0
>>> [ =C2=A0 81.744272] =C2=A0[<c12594b8>] fbcon_event_notify+0x758/0x790
>>> [ =C2=A0 81.744277] =C2=A0[<c10929e2>] notifier_call_chain+0x42/0xb0
>>> [ =C2=A0 81.744280] =C2=A0[<c1092d30>] __blocking_notifier_call_chain+0=
x60/0x90
>>> [ =C2=A0 81.744283] =C2=A0[<c1092d7a>] blocking_notifier_call_chain+0x1=
a/0x20
>>> [ =C2=A0 81.744285] =C2=A0[<c124a5a1>] fb_notifier_call_chain+0x11/0x20
>>> [ =C2=A0 81.744288] =C2=A0[<c124b759>] register_framebuffer+0x1d9/0x2b0
>>> [ =C2=A0 81.744293] =C2=A0[<c1061c73>] ? ioremap_wc+0x33/0x40
>>> [ =C2=A0 81.744298] =C2=A0[<f82537c6>] uvesafb_probe+0xaba/0xc40 [uvesa=
fb]
>>> [ =C2=A0 81.744302] =C2=A0[<c12bb81f>] platform_drv_probe+0xf/0x20
>>> [ =C2=A0 81.744306] =C2=A0[<c12ba558>] driver_probe_device+0x68/0x170
>>> [ =C2=A0 81.744309] =C2=A0[<c12ba731>] __device_attach+0x41/0x50
>>> [ =C2=A0 81.744313] =C2=A0[<c12b9088>] bus_for_each_drv+0x48/0x70
>>> [ =C2=A0 81.744316] =C2=A0[<c12ba7f3>] device_attach+0x83/0xa0
>>> [ =C2=A0 81.744319] =C2=A0[<c12ba6f0>] ? __driver_attach+0x90/0x90
>>> [ =C2=A0 81.744321] =C2=A0[<c12b991f>] bus_probe_device+0x6f/0x90
>>> [ =C2=A0 81.744324] =C2=A0[<c12b8a45>] device_add+0x5e5/0x680
>>> [ =C2=A0 81.744329] =C2=A0[<c122a1a3>] ? kvasprintf+0x43/0x60
>>> [ =C2=A0 81.744332] =C2=A0[<c121e6e4>] ? kobject_set_name_vargs+0x64/0x=
70
>>> [ =C2=A0 81.744335] =C2=A0[<c121e6e4>] ? kobject_set_name_vargs+0x64/0x=
70
>>> [ =C2=A0 81.744339] =C2=A0[<c12bbe9f>] platform_device_add+0xff/0x1b0
>>> [ =C2=A0 81.744343] =C2=A0[<f8252906>] uvesafb_init+0x50/0x9b [uvesafb]
>>> [ =C2=A0 81.744346] =C2=A0[<c100111f>] do_one_initcall+0x2f/0x170
>>> [ =C2=A0 81.744350] =C2=A0[<f82528b6>] ? uvesafb_is_valid_mode+0x66/0x6=
6 [uvesafb]
>>> [ =C2=A0 81.744355] =C2=A0[<c10c6994>] sys_init_module+0xf4/0x1410
>>> [ =C2=A0 81.744359] =C2=A0[<c1157fc0>] ? vfsmount_lock_local_unlock_cpu=
+0x30/0x30
>>> [ =C2=A0 81.744363] =C2=A0[<c144cb10>] sysenter_do_call+0x12/0x36
>>> [ =C2=A0 81.744365] Code: f5 00 00 00 32 f6 66 8b da 66 d1 e3 66 ba d4 =
03 8a e3 b0 1c 66 ef b0 1e 66 ef 8a e7 b0 1d 66 ef b0 1f 66 ef e8 fa 00 00 =
00 61 c3 <60> e8 c8 00 00 00 66 8b f3 66 8b da 66 ba d4 03 b0 0c 8a e5 66
>>> [ =C2=A0 81.744388] EIP: [<c00cd3b3>] 0xc00cd3b3 SS:ESP 0068:f57f3a00
>>> [ =C2=A0 81.744391] CR2: 00000000c00cd3b3
>>> [ =C2=A0 81.744393] ---[ end trace 18b2c87c925b54d6 ]---
>>>
>>> Signed-off-by: Wang YanQing <udknight@gmail.com>
>>> ---
>>> =C2=A0drivers/video/uvesafb.c | =C2=A0 12 ++++++++++--
>>> =C2=A01 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
>>> index e7f69ef..f9a670d 100644
>>> --- a/drivers/video/uvesafb.c
>>> +++ b/drivers/video/uvesafb.c
>>> @@ -23,6 +23,7 @@
>>> =C2=A0#include <video/uvesafb.h>
>>> =C2=A0#ifdef CONFIG_X86
>>> =C2=A0#include <video/vga.h>
>>> +#include <linux/pci.h>
>>> =C2=A0#endif
>>> =C2=A0#ifdef CONFIG_MTRR
>>> =C2=A0#include <asm/mtrr.h>
>>> @@ -815,8 +816,15 @@ static int __devinit uvesafb_vbe_init(struct fb_in=
fo *info)
>>> =C2=A0 =C2=A0 =C2=A0par->pmi_setpal =3D pmi_setpal;
>>> =C2=A0 =C2=A0 =C2=A0par->ypan =3D ypan;
>>>
>>> - =C2=A0 =C2=A0if (par->pmi_setpal || par->ypan)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uvesafb_vbe_getpmi(task, par=
);
>>> + =C2=A0 =C2=A0if (par->pmi_setpal || par->ypan) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pcibios_enabled) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
uvesafb_vbe_getpmi(task, par);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
par->pmi_setpal =3D par->ypan =3D 0;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
printk(KERN_WARNING "uvesafb: PCI BIOS area is NX."
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Can't use protected mode interface\n");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> + =C2=A0 =C2=A0}
>>> =C2=A0#else
>>> =C2=A0 =C2=A0 =C2=A0/* The protected mode interface is not available on=
 non-x86. */
>>> =C2=A0 =C2=A0 =C2=A0par->pmi_setpal =3D par->ypan =3D 0;
>>> --
>>> 1.7.9.2.315.g25a78
>>
>> Ok! Can anybody tell me why this patch had been ignored by community?
>> I try to find out what's wrong with this patch, but I failed to find it =
out.
>> So any comment is welcome.Thanks
>
> Patch looks okay to me. I will wait a few days to give Michal a chance to
> comment on it.

LGTM here as well.

Thanks,
--=20
Michal Januszewski
http://people.gentoo.org/spock
