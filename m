From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [ PATCH-LINK ] fb accel capabilities - take 2
Date: Sat, 15 May 2004 15:58:32 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405151556280.7525@rosencrantz.theboonies.us>
References: <200405051047.00127.lucasvr@gobolinux.org>
Reply-To: David Eger <eger-dated-1085234045.9ffaa3@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOzc7-00065C-Ja
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 May 2004 06:54:07 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOzc7-0001l4-93
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 15 May 2004 06:54:07 -0700
In-Reply-To: <200405051047.00127.lucasvr@gobolinux.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


I've taken Geert's suggestion and put the framebuffer capabilities flags 
in fbinfo.flags as follows:

 /* FBIF = FB_Info.Flags */
 #define FBIF_MODULE		0x0001	/* Low-level driver is a module */
 #define FBIF_HWACCEL_DISABLED	0x0002

 /* hints */
 #define FBIF_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
 #define FBIF_READS_FAST		0x0080 /* soft-copy faster than rendering */

 /* hardware supported ops */
 #define FBIF_HWACCEL_NONE	0x0000
 #define FBIF_HWACCEL_COPYAREA	0x0100
 #define FBIF_HWACCEL_FILLRECT	0x0200
 #define FBIF_HWACCEL_ROTATE	0x0400
 #define FBIF_HWACCEL_IMAGEBLIT	0x0800
 #define FBIF_HWACCEL_XPAN	0x1000
 #define FBIF_HWACCEL_YPAN	0x2000
 #define FBIF_HWACCEL_YWRAP	0x4000

The patch is very large (40 kilobytes), but 27 of those kilobytes are just 
the work of running 's/FBINFO_FLAG_DEFAULT/FBIF_DEFAULT/g'.  I've posted the
patch at http://www.yak.net/random/fbdev-patches/accel-cap-take2

The files there are:

rev-1.1415.radeonfb-copyarea-corruption-fix.patch
	This is in the mainline kernel, but not yet applied to benh's tree ;)

rev-1.1416.james-console-init-cleanup.patch
	James's patch, modified to apply against benh's tree.

rev-1.1417.fb-accel-capabilities.patch
	Baseline patch to make framebuffer/fbcon interaction more sane by 
	basing the fbcon heuristics on capabilities advertized by underlying 
	framebuffer via the fb_info.flags field.

	This patch updates fbcon, fb.h, and skeletonfb.c.
	It also does a 's/FBINFO_FLAG_DEFAULT/FBIF_DEFAULT/g' on the fb drivers 
	to let them compile.  
	It does *not* yet update the drivers themselves.  They should compile 
	and work, but their hinting is not correct yet, meaning most fb drivers
	will be slow until I set the flags to the right hinting driver-by-driver.

If the patch looks good to you (James, Geert, BenH), I'd like to forward
it on to Linus followed by the individual driver updates (that'll take
a little longer -- I need to revise how drivers do things like remember
noaccel, etc. and update them).

-dte


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
