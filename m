From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: split vesafb option vram into vtotal and vremap
Date: Tue, 5 Oct 2004 05:40:50 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410050540.50453.adaplas@hotpop.com>
References: <200410040923.49817.adaplas@hotpop.com> <20041004115604.GA8827@bytesex>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEaZx-0005vy-3i
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 14:41:09 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEaZp-0004Wi-Ac
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 04 Oct 2004 14:41:09 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 664408ACBEC
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  4 Oct 2004 21:40:45 +0000 (UTC)
In-Reply-To: <20041004115604.GA8827@bytesex>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Gerd Knorr <kraxel@bytesex.org>, adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Aurelien Jacobs <aurel@gnuage.org>

=46rom Gerd Knorr <kraxel@bytesex.org>:

"IMHO the the only sane thing is to have two options for total + remapped
memory as well.  Otherwise we'll end up changing that back and forth like
it happened for the size calculation stuff for quite some time ...

The patch below does just that and also has the other vmode fix
(vmode =3D yres * linelength /* instead of yres * xres * depth >> 3 */)."

=2D Patched rediffed against 2.6.9-rc3-mm2.

=2D Modified documentation about the changes.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 Documentation/fb/vesafb.txt |    7 ++++++-
 drivers/video/vesafb.c      |   25 ++++++++++++++++---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff -uprN linux-2.6.9-rc3-mm2-orig/Documentation/fb/vesafb.txt linux-2.6.9=
=2Drc3-mm2/Documentation/fb/vesafb.txt
=2D-- linux-2.6.9-rc3-mm2-orig/Documentation/fb/vesafb.txt	2004-10-05 05:25=
:09.672888064 +0800
+++ linux-2.6.9-rc3-mm2/Documentation/fb/vesafb.txt	2004-10-05 05:24:20.374=
382576 +0800
@@ -146,11 +146,16 @@ pmipal	Use the protected mode interface=20
=20
 mtrr	setup memory type range registers for the vesafb framebuffer.
=20
=2Dvram:n	remap 'n' MiB of video RAM. If 0 or not specified, remap memory
+vremap:n
+        remap 'n' MiB of video RAM. If 0 or not specified, remap memory
 	according to video mode. (2.5.66 patch/idea by Antonino Daplas
 	reversed to give override possibility (allocate more fb memory
 	than the kernel would) to 2.4 by tmb@iki.fi)
=20
+vtotal:n
+        if the video BIOS of your card incorrectly determines the total
+        amount of video RAM, use this option to override the BIOS (in MiB).
+
 Have fun!
=20
   Gerd
diff -uprN linux-2.6.9-rc3-mm2-orig/drivers/video/vesafb.c linux-2.6.9-rc3-=
mm2/drivers/video/vesafb.c
=2D-- linux-2.6.9-rc3-mm2-orig/drivers/video/vesafb.c	2004-10-05 05:20:37.0=
00000000 +0800
+++ linux-2.6.9-rc3-mm2/drivers/video/vesafb.c	2004-10-05 05:29:54.58157536=
0 +0800
@@ -49,7 +49,8 @@ static struct fb_fix_screeninfo vesafb_f
=20
 static int             inverse   =3D 0;
 static int             mtrr      =3D 1;
=2Dstatic int	       vram __initdata =3D 0; /* Set amount of memory to be u=
sed */
+static int	       vram_remap __initdata =3D 0; /* Set amount of memory to =
be used */
+static int	       vram_total __initdata =3D 0; /* Set total amount of memo=
ry */
 static int             pmi_setpal =3D 0;	/* pmi for palette changes ??? */
 static int             ypan       =3D 0;  /* 0..nothing, 1..ypan, 2..ywrap=
 */
 static unsigned short  *pmi_base  =3D NULL;
@@ -209,8 +210,10 @@ int __init vesafb_setup(char *options)
 			mtrr=3D1;
 		else if (! strcmp(this_opt, "nomtrr"))
 			mtrr=3D0;
=2D		else if (! strncmp(this_opt, "vram:", 5))
=2D			vram =3D simple_strtoul(this_opt+5, NULL, 0);
+		else if (! strncmp(this_opt, "vtotal:", 7))
+			vram_total =3D simple_strtoul(this_opt+7, NULL, 0);
+		else if (! strncmp(this_opt, "vremap:", 7))
+			vram_remap =3D simple_strtoul(this_opt+7, NULL, 0);
 	}
 	return 0;
 }
@@ -240,11 +243,14 @@ static int __init vesafb_probe(struct de
 	/*   size_vmode -- that is the amount of memory needed for the
 	 *                 used video mode, i.e. the minimum amount of
 	 *                 memory we need. */
=2D	size_vmode =3D vesafb_fix.line_length * vesafb_defined.yres;
+	size_vmode =3D vesafb_defined.yres * vesafb_fix.line_length;
=20
 	/*   size_total -- all video memory we have. Used for mtrr
=2D	 *                 entries and bounds checking. */
+	 *                 entries, ressource allocation and bounds
+	 *                 checking. */
 	size_total =3D screen_info.lfb_size * 65536;
+	if (vram_total)
+		size_total =3D vram_total * 1024 * 1024;
 	if (size_total < size_vmode)
 		size_total =3D size_vmode;
=20
@@ -252,10 +258,11 @@ static int __init vesafb_probe(struct de
 	 *                 use for vesafb.  With modern cards it is no
 	 *                 option to simply use size_total as that
 	 *                 wastes plenty of kernel address space. */
=2D	size_remap =3D size_vmode * 2;
=2D	if (vram)
=2D		size_remap =3D vram * 1024 * 1024;
=2D
+	size_remap  =3D size_vmode * 2;
+	if (vram_remap)
+		size_remap =3D vram_remap * 1024 * 1024;
+	if (size_remap < size_vmode)
+		size_remap =3D size_vmode;
 	if (size_remap > size_total)
 		size_remap =3D size_total;
 	vesafb_fix.smem_len =3D size_remap;




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
