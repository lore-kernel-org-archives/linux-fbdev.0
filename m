From: Jak <rfjak@eircom.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and 2.5.5[45]
Date: Sat, 18 Jan 2003 20:28:33 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200301182028.33155.rfjak@eircom.net>
References: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail00.svc.cra.dublin.eircom.net ([159.134.118.16])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ZzWm-0001R1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 18 Jan 2003 12:25:16 -0800
In-Reply-To: <Pine.LNX.4.44.0301150042470.23774-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


James,
=09=09I still see the same problem using 2.5.59. I think this
is the same problem as that referred to by Udo A. Steinberg
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104278873827538&w=3D2
( I get similar results as him if I compile rivafb built-in )

Is this possibly related to driver-model issues discussed in this thread =
?
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104283662023857&w=3D2

Good news is that 2.5.59 seems quite stable as regards framebuffer.
It no longer locks up after loading fbcon. But rmmod fbcon still
causes instant death accompanied by increased whirring noises from inside
box.

To summarise:
 insmod rivafb causes "Badness in kobject_register" every time=20
   ( after pci_register_driver() in rivafb_init(),see below )
 after insmod rivafb, I have a green screen, which can be cleared by fbse=
t
  ( fbset now changes resolution of all VTs, this is different from 2.4.x=
 )
 after clearing green screen using fbset, text colours are wrong
 now ( 2.5.59 ), I can insmod fbcon, and screen looks OK again ( apart fr=
om
  the left-hand-most column of screen appears at right-hand side of scree=
n )
 rmmod fbcon locks up machine, no ALT-SYSRQ effective

Jan 18 14:44:10 TBird kernel: About to pci_module_init() in rivafb_init()
Jan 18 14:44:10 TBird kernel: Entering rivafb_probe()
Jan 18 14:44:10 TBird kernel: rivafb: nVidia device/chipset 10DE002C
Jan 18 14:44:10 TBird kernel: rivafb: RIVA MTRR set to ON
Jan 18 14:44:10 TBird kernel: About to pci_set_drvdata() in rivafb_probe(=
)
Jan 18 14:44:10 TBird kernel: rivafb: PCI nVidia NV4 framebuffer ver 0.9.=
5b (nVidiaRIVA-VTNT2, 16MB @ 0xD0000000)
Jan 18 14:44:10 TBird kernel: Return OK from rivafb_probe()
Jan 18 14:44:10 TBird kernel: About to pci_register_driver() in rivafb_in=
it()
Jan 18 14:44:10 TBird kernel: Badness in kobject_register at lib/kobject.=
c:152
Jan 18 14:44:10 TBird kernel: Call Trace:
Jan 18 14:44:10 TBird kernel:  [<d08d17b4>] rivafb_driver+0x54/0xfffe0918=
 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<c01d1436>] kobject_register+0x56/0x60
Jan 18 14:44:10 TBird kernel:  [<d08d17a4>] rivafb_driver+0x44/0xfffe0918=
 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<c0202707>] bus_add_driver+0x57/0xf0
Jan 18 14:44:10 TBird kernel:  [<d08d17a4>] rivafb_driver+0x44/0xfffe0918=
 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<c0202b91>] driver_register+0x31/0x40
Jan 18 14:44:10 TBird kernel:  [<d08d1788>] rivafb_driver+0x28/0xfffe0918=
 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<c01d5ae9>] pci_register_driver+0x49/0x60
Jan 18 14:44:10 TBird kernel:  [<d08d1788>] rivafb_driver+0x28/0xfffe0918=
 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<d08b204a>] +0x4a/0x68 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<d08d1760>] rivafb_driver+0x0/0xfffe0918 =
[rivafb]
Jan 18 14:44:10 TBird kernel:  [<d08d3100>] +0x0/0xfffdef78 [rivafb]
Jan 18 14:44:10 TBird kernel:  [<c0133e07>] sys_init_module+0x117/0x1c0
Jan 18 14:44:10 TBird kernel:  [<c010a393>] syscall_call+0x7/0xb

=09=09=09=09Thanks,
=09=09=09=09=09=09Jak.

On Wednesday 15 January 2003 00:43, James Simmons wrote:
> Can you try the latest pacth at
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
