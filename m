From: Jak <rfjak@eircom.net>
Subject: rivafb "Badness" using fbdev.diff.gz and 2.5.5[45]
Date: Sat, 11 Jan 2003 13:30:11 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301111330.11827.rfjak@eircom.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail00.svc.cra.dublin.eircom.net ([159.134.118.16])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XLfU-00021K-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 05:27:20 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

With so much good development being done on framebuffer drivers at the mo=
ment, perhaps
the following is only a temporary problem, but I hope the following repor=
t is of some use.

I seem to be triggering a reproducible bug when loading rivafb, whether i=
t is built-in or modular
with both 2.5.54 & 2.5.55 ( and, I suspect, 2.5.53 also ).
I have tried rivafb on 2 different nVidia cards, both yield the similar r=
esults when using recent
( Jan 8 ) fbdev.diff.gz patch.

After rivafb is loaded, the display goes bright green. After entering a c=
ommand, I get
text back, but colours are wrong - there is no visible blue on screen i.e=
 with colorized
ls listing, normally blue text is bright green, normally red is ( brighte=
r ) red, normally white
is grey.

This is from 2.5.55 with fbdev.diff.gz applied, rivafb and fbcon both mod=
ular:
I have manually insmodded cfbimgblt & vgastate, then insmod rivafb

Jan 11 12:30:41 TBird kernel: rivafb: nVidia device/chipset 10DE002C
Jan 11 12:30:41 TBird kernel: rivafb: RIVA MTRR set to ON
Jan 11 12:30:41 TBird kernel: rivafb: PCI nVidia NV4 framebuffer ver 0.9.=
5b (nVidiaRIVA-VTNT2, 16
MB @ 0xD0000000)
Jan 11 12:30:41 TBird kernel: Badness in kobject_register at lib/kobject.=
c:129
Jan 11 12:30:41 TBird kernel: Call Trace:
Jan 11 12:30:41 TBird kernel:  [<d08d43b4>] rivafb_driver+0x54/0xfffddd00=
 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<c01c6aa6>] kobject_add+0x56/0x60
Jan 11 12:30:41 TBird kernel:  [<d08d43a4>] rivafb_driver+0x44/0xfffddd00=
 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<c01f67f9>] bus_remove_device+0x59/0xc0
Jan 11 12:30:41 TBird kernel:  [<d08d43a4>] rivafb_driver+0x44/0xfffddd00=
 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<d08d3078>] +0x0/0xfffdefe8 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<c01f6c51>] put_driver+0x31/0x40
Jan 11 12:30:41 TBird kernel:  [<d08d4388>] rivafb_driver+0x28/0xfffddd00=
 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<c01cb369>] pci_device_resume+0x49/0x60
Jan 11 12:30:41 TBird kernel:  [<d08d4388>] rivafb_driver+0x28/0xfffddd00=
 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<d08b2032>] 0xd08b2032
Jan 11 12:30:41 TBird kernel:  [<d08d4360>] rivafb_driver+0x0/0xfffddd00 =
[rivafb]
Jan 11 12:30:41 TBird kernel:  [<d08d5d00>] +0x0/0xfffdc360 [rivafb]
Jan 11 12:30:41 TBird kernel:  [<c012ca97>] load_module+0x117/0x1c0
Jan 11 12:30:41 TBird kernel:  [<c0109327>] system_call+0x7/0xb
Jan 11 12:30:41 TBird kernel:
Module                  Size  Used by
rivafb                 45444  0
cfbimgblt               2880  1 rivafb
vgastate                9472  1 rivafb
mousedev                7256  1

Now I rmmod rivafb and insmod it again :

Module                  Size  Used by
cfbimgblt               2880  0
vgastate                9472  0
mousedev                7256  1
Jan 11 12:35:29 TBird kernel: Badness in kobject_register at lib/kobject.=
c:129
Jan 11 12:35:29 TBird kernel: Call Trace:
Jan 11 12:35:29 TBird kernel:  [<d08d43b4>] rivafb_driver+0x54/0xfffddd00=
 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<c01c6aa6>] kobject_add+0x56/0x60
Jan 11 12:35:29 TBird kernel:  [<d08d43a4>] rivafb_driver+0x44/0xfffddd00=
 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<c01f67f9>] bus_remove_device+0x59/0xc0
Jan 11 12:35:29 TBird kernel:  [<d08d43a4>] rivafb_driver+0x44/0xfffddd00=
 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<d08d3078>] +0x0/0xfffdefe8 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<c01f6c51>] put_driver+0x31/0x40
Jan 11 12:35:29 TBird kernel:  [<d08d4388>] rivafb_driver+0x28/0xfffddd00=
 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<c01cb369>] pci_device_resume+0x49/0x60
Jan 11 12:35:29 TBird kernel:  [<d08d4388>] rivafb_driver+0x28/0xfffddd00=
 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<d08b2032>] 0xd08b2032
Jan 11 12:35:29 TBird kernel:  [<d08d4360>] rivafb_driver+0x0/0xfffddd00 =
[rivafb]
Jan 11 12:35:29 TBird kernel:  [<d08d5d00>] +0x0/0xfffdc360 [rivafb]
Jan 11 12:35:29 TBird kernel:  [<c012ca97>] load_module+0x117/0x1c0
Jan 11 12:35:29 TBird kernel:  [<c0109327>] system_call+0x7/0xb
Jan 11 12:35:29 TBird kernel:
Module                  Size  Used by
rivafb                 45444  0
cfbimgblt               2880  1 rivafb
vgastate                9472  1 rivafb
mousedev                7256  1

BTW1: With stock 2.5.5 and modular rivafb, module will not load, this is =
what  I get :
Jan 10 12:49:53 TBird kernel: rivafb: falsely claims to have parameter fo=
nt

BTW2: the FBCON_ADVANCED  "Advanced low level driver options" still shows=
 up in=20
make *config, but does not seem to do much - should it still be there ?

BTW3: the second nVidia card I referred to is on my new laptop, using Gef=
orce4 420 Go
card, which is not yet supported in 2.4.x, but seems to be detected prope=
rly in 2.5.x.

Loading fbcon causes bigger problems : serial OOPSes shortly followed by =
complete lockup
accel_putcs always seems to be implicated.

Jan 11 12:36:51 TBird kernel: Call Trace:
Jan 11 12:36:51 TBird kernel:  [<d08cd437>] accel_putcs+0x157/0xfffe4f95 =
[fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d2d30>] +0x30/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d2d00>] +0x0/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<c017a731>] ext3_get_block_handle+0x51/0x=
90
Jan 11 12:36:51 TBird kernel:  [<c0211b2c>] blk_recount_segments+0xdc/0x1=
50
Jan 11 12:36:51 TBird kernel:  [<d08d4da0>] fb_display+0x0/0xfffdd4d5 [fb=
con]
Jan 11 12:36:51 TBird kernel:  [<d08ce976>] fbcon_putcs+0x86/0xfffe3985 [=
fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d4da0>] fb_display+0x0/0xfffdd4d5 [fb=
con]
Jan 11 12:36:51 TBird kernel:  [<c020b14b>] set_console+0x24b/0x300
Jan 11 12:36:51 TBird kernel:  [<c011c350>] sys_syslog+0x60/0x70
Jan 11 12:36:51 TBird kernel:  [<c011c42c>] _call_console_drivers+0x5c/0x=
120
Jan 11 12:36:51 TBird kernel:  [<c011c73f>] acquire_console_sem+0x3f/0xa0
Jan 11 12:36:51 TBird kernel:  [<c011c669>] emit_log_char+0x109/0x140
Jan 11 12:36:51 TBird kernel:  [<c0129eb5>] __constant_c_and_count_memset=
+0x35/0x40
Jan 11 12:36:51 TBird kernel:  [<c0117b3f>] bust_spinlocks+0x21f/0x4b8
Jan 11 12:36:51 TBird kernel:  [<c021fbd6>] execute_drive_cmd+0xf6/0x1a0
Jan 11 12:36:51 TBird kernel:  [<c021fda7>] ide_stall_queue+0xd7/0x1d0
Jan 11 12:36:51 TBird kernel:  [<c021febf>] ide_do_request+0x1f/0x30
Jan 11 12:36:51 TBird kernel:  [<c0212152>] blk_remove_plug+0x42/0x50
Jan 11 12:36:51 TBird kernel:  [<c0118f9a>] scheduling_functions_start_he=
re+0x16a/0x2a0
Jan 11 12:36:51 TBird kernel:  [<d08d324f>] +0x54f/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<c0117920>] bust_spinlocks+0x0/0x4b8
Jan 11 12:36:51 TBird kernel:  [<c0109d31>] divide_error+0x2d/0x38
Jan 11 12:36:51 TBird kernel:  [<d08d324f>] +0x54f/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08c1ef0>] fontdata_8x16+0x210/0x2f73e32=
0 [font]
Jan 11 12:36:51 TBird kernel:  [<d08d4300>] +0x1600/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08cd437>] accel_putcs+0x157/0xfffe4f95 =
[fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d2d50>] +0x50/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d2d00>] +0x0/0xfffdf575 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d4da0>] fb_display+0x0/0xfffdd4d5 [fb=
con]
Jan 11 12:36:51 TBird kernel:  [<d08ce976>] fbcon_putcs+0x86/0xfffe3985 [=
fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d4da0>] fb_display+0x0/0xfffdd4d5 [fb=
con]
Jan 11 12:36:51 TBird kernel:  [<c0207224>] scrdown+0x124/0x190
Jan 11 12:36:51 TBird kernel:  [<c0207e20>] set_origin+0x150/0x180
Jan 11 12:36:51 TBird kernel:  [<c02083f3>] vc_allocate+0x303/0x420
Jan 11 12:36:51 TBird kernel:  [<d08ce27d>] fbcon_set_display+0x31d/0xfff=
e4315 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<c0135cb8>] cache_free_debugcheck+0xb8/0x=
d0
Jan 11 12:36:51 TBird kernel:  [<c0134e36>] kmem_cache_alloc+0x96/0xd0
Jan 11 12:36:51 TBird kernel:  [<d08d4da0>] fb_display+0x0/0xfffdd4d5 [fb=
con]
Jan 11 12:36:51 TBird kernel:  [<d08cdac9>] fbcon_init+0x59/0xfffe4805 [f=
bcon]
Jan 11 12:36:51 TBird kernel:  [<d08d1820>] fb_con+0x0/0xfffe0a55 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<c0207f1c>] vc_cons_allocated+0xac/0x110
Jan 11 12:36:51 TBird kernel:  [<c020b8ba>] clear_buffer_attributes+0xaa/=
0x1c0
Jan 11 12:36:51 TBird kernel:  [<d08d2bc0>] +0x0/0xfffdf6b5 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d1939>] +0x1d/0xfffe0959 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08d2bc0>] +0x0/0xfffdf6b5 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<d08b226d>] 0xd08b226d
Jan 11 12:36:51 TBird kernel:  [<d08d1820>] fb_con+0x0/0xfffe0a55 [fbcon]
Jan 11 12:36:51 TBird kernel:  [<c012ca97>] load_module+0x117/0x1c0
Jan 11 12:36:51 TBird kernel:  [<c0109327>] system_call+0x7/0xb




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
