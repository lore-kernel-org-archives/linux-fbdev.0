From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/5] fbdev: Various mach64 changes
Date: Fri, 22 Oct 2004 00:55:31 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041022005531.28218795.akpm@osdl.org>
References: <200410200815.41690.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKuIn-0007BW-MH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 00:57:33 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKuIn-00006l-1o
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Oct 2004 00:57:33 -0700
In-Reply-To: <200410200815.41690.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: adaplas@pol.net
Cc: adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net, alex.kern@gmx.de, arnaud.fontaine@free.fr, geert@linux-m68k.org, jsimmons@infradead.org, nsouch@free.fr, syrjala@sci.fi

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:
>
>   Alexander Kern <alex.kern@gmx.de>
>    [PATCH] port Daniel Mantione 2.4 driver to 2.6
>    [PATCH] add more pci_id number
>    [PATCH] add accelerated imgblit
>    [PATCH] revert SDRAM_MAGIC_PLL to old behaviour
>    [PATCH] do a "from BIOS" initialisation only by __i386__
>=20
>    Arnaud FONTAINE <arnaud.fontaine@free.fr>
>    [PATCH atyfb] correction for 3D Rage Mobility L
>=20
>    Geert Uytterhoeven <geert@linux-m68k.org>
>    [PATCH atyfb] Atari Atyfb fixes
>    [PATCH atyfb] Atyfb on Mach64 GX or Atari
>    [PATCH 468] m68k sparse floating point
>=20
>    James Simmons <jsimmons@infradead.org>
>    [PATCH add] port to framebuffer_alloc api
>=20
>    Nicolas Souchu <nsouch@free.fr>
>    [PATCH] I do not found a copy, but it was incorporated too
>=20
>    Ville Syrj=E4l=E4 <syrjala@sci.fi>
>    [PATCH] fix pan with doublescan
>    [PATCH] another double scan fix
>    [PATCH] disable linear aperture register access
>    [PATCH] Memory type correction
>    [PATCH] atyfb (2.6): Fix mmio_start
>    [PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
>    [PATCH] atyfb (2.6): Add RGB565 support
>    [PATCH] atyfb: Blank LCD by turning off backlight voltage
>    [PATCH] atyfb: Rage LT LCD register access
>    [PATCH] atyfb: vblank irq support
>    [PATCH] atyfb: MTRR support

This patch is fairly screwed on sparc64.  I fixed a few things, below, but
it's still treating ->ati_regbase as a scalar and not a pointer, so I'll
toss that one back to your guys.

An incremental patch against 2.6.9-mm1 would be appreciated.  Hopefully
I'll get that out the door tonight.


drivers/video/aty/atyfb_base.c: In function `atyfb_setup_sparc':
drivers/video/aty/atyfb_base.c:2769: warning: assignment makes pointer from=
 integer without a cast
drivers/video/aty/atyfb_base.c: In function `atyfb_pci_probe':
drivers/video/aty/atyfb_base.c:3399: error: invalid operands to binary &



Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-sparc64-akpm/drivers/video/aty/atyfb_base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~fbdev-various-mach64-changes-sparc=
64-fix drivers/video/aty/atyfb_base.c
--- 25-sparc64/drivers/video/aty/atyfb_base.c~fbdev-various-mach64-changes-=
sparc64-fix	2004-10-22 00:47:03.000000000 -0700
+++ 25-sparc64-akpm/drivers/video/aty/atyfb_base.c	2004-10-22 00:50:03.0000=
00000 -0700
@@ -2746,9 +2746,11 @@ static int atyfb_setcolreg(u_int regno,=20
=20
 #ifdef __sparc__
=20
-static int __devinit atyfb_setup_sparc(struct pci_dev *pdev, struct fb_ind=
o *info, unsigned long addr)
+extern void (*prom_palette) (int);
+
+static int __devinit atyfb_setup_sparc(struct pci_dev *pdev,
+			struct fb_info *info, unsigned long addr)
 {
-	extern void (*prom_palette) (int);
 	extern int con_is_present(void);
=20
 	struct atyfb_par *par =3D info->par;
@@ -2782,7 +2784,7 @@ static int __devinit atyfb_setup_sparc(s
 	j =3D i + 4;
=20
 	par->mmap_map =3D kmalloc(j * sizeof(*par->mmap_map), GFP_ATOMIC);
-	if (!_par->mmap_map) {
+	if (!par->mmap_map) {
 		PRINTKE("atyfb_setup_sparc() can't alloc mmap_map\n");
 		return -ENOMEM;
 	}
_



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
