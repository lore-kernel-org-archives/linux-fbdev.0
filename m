From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
Subject: Re: [FBDEV updates] Newest framebuffer fixes.
Date: Thu, 10 Apr 2003 23:14:23 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.51L.0304102312090.626@piorun.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pollux.ds.pg.gda.pl ([213.192.76.3] ident=postfix)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193jNj-0007OC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 10 Apr 2003 14:14:52 -0700
In-Reply-To: <Pine.LNX.4.44.0304102005330.23030-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 10 Apr 2003, James Simmons wrote:
> Here are the latest framebuffer changes. Some driver updates and a
> massive cleanup of teh cursor code. Tony please test it on the i810
> chipset. I tested it on the Riva but there is one bug I can't seem to
> find. Please test this patch. It is against 2.5.67 BK. It shoudl work
> against 2.5.67 as well.

No, it doesn't. On clean 2.5.67:

# zcat fbdev.diff.gz |patch -p0
patching file linus-2.5/Documentation/devices.txt
patching file linus-2.5/drivers/video/aty/aty128fb.c
patching file linus-2.5/drivers/video/cfbimgblt.c
patching file linus-2.5/drivers/video/console/fbcon.c
patching file linus-2.5/drivers/video/console/fbcon.h
patching file linus-2.5/drivers/video/controlfb.c
patching file linus-2.5/drivers/video/fbcmap.c
patching file linus-2.5/drivers/video/fbmem.c
Hunk #3 FAILED at 639.
Hunk #4 succeeded at 705 (offset 1 line).
Hunk #6 succeeded at 848 (offset 1 line).
Hunk #8 succeeded at 931 (offset 1 line).
Hunk #10 succeeded at 974 (offset 1 line).
Hunk #12 succeeded at 997 (offset 1 line).
Hunk #14 succeeded at 1151 (offset 1 line).
1 out of 15 hunks FAILED -- saving rejects to file=20
linus-2.5/drivers/video/fbmem.c.rej
patching file linus-2.5/drivers/video/i810/i810.h
patching file linus-2.5/drivers/video/i810/i810_accel.c
patching file linus-2.5/drivers/video/i810/i810_dvt.c
patching file linus-2.5/drivers/video/i810/i810_gtf.c
patching file linus-2.5/drivers/video/i810/i810_main.c
patching file linus-2.5/drivers/video/i810/i810_main.h
patching file linus-2.5/drivers/video/imsttfb.c
patching file linus-2.5/drivers/video/logo/logo.c
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file linus-2.5/drivers/video/lo=
go/logo.c.rej
The next patch would create the file=20
linus-2.5/drivers/video/logo/logo_linux_clut224.c, which already exists!  A=
ssume -R? [n]
Apply anyway? [n]
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file linus-2.5/drivers/video/l=
ogo/logo_linux_clut224.c.rej
patching file linus-2.5/drivers/video/logo/logo_linux_mono.c
patching file linus-2.5/drivers/video/platinumfb.c
patching file linus-2.5/drivers/video/radeonfb.c
patching file linus-2.5/drivers/video/riva/fbdev.c
patching file linus-2.5/drivers/video/softcursor.c
patching file linus-2.5/drivers/video/tdfxfb.c
patching file linus-2.5/drivers/video/tgafb.c
patching file linus-2.5/drivers/video/vga16fb.c
patching file linus-2.5/include/linux/fb.h
patching file linus-2.5/include/linux/linux_logo.h


--=20
pozdr.  Pawe=B3 Go=B3aszewski       =20
---------------------------------
worth to see: http://www.againsttcpa.com/
CPU not found - software emulation...


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger=
=20
for complex code. Debugging C/C++ programs can leave you feeling lost and=20
disoriented. TotalView can help you find your way. Available on major UNIX =

and Linux platforms. Try it free. www.etnus.com
