From: Antonino Daplas <adaplas@pol.net>
Subject: Re: vesafb problem with 1GB Ram and possible
	fix
Date: 29 Mar 2003 18:41:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048910026.1000.17.camel@localhost.localdomain>
References: <3E8329D2.7040909@comcast.net>
	<20030327190222.GA4060@middle.of.nowhere> <3E837ADD.9080209@comcast.net> 
	<3E84B7CB.1010604@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bKfINfS26rW52J5qezp+"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zE6C-0001Hx-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Mar 2003 03:02:08 -0800
In-Reply-To: <3E84B7CB.1010604@comcast.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Walt H <waltabbyh@comcast.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-bKfINfS26rW52J5qezp+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-03-29 at 04:59, Walt H wrote:
> I've got a Chaintech 7KDD dual processor 760MPX MB with 1 GB RAM. I had 
>    problem getting vesafb or rivafb to work. I got ioremap errors during 
> nitialization, which appear to be because vesafb tries to ioremap the 
> entire 128MB framebuffer of my video card. It's a GeForce 4 Ti4600 with 
> 128MB Ram. Through correspondence on the general linux-kernel mailing 
> list, I learned about changing the vmalloc reserved space from 128 to 
> 256MB, but that didn't work for me as it evidently blows away high-mem IO.
> 
> Well, here's what I've done. I've made a change in video/vesafb.c to
> change __init vesafb_init to only allocate the amount of memory required 
>   for the requested video mode of the framebuffer (I think). So far, it 
> appears to work fine. I haven't tried many modes yet, but it's worked 
> with what I've thrown at it. Thanks again,
> 
> The trivial change I made was changing this:
> 
> video_size	= screen_info.lfb_size * 65536;
> 
> to this:
> 
> video_size	= screen_info.lfb_width * screen_info.lfb_height * video_bpp;
> 
> 
> I'm not a kernel hacker, so if I'm overlooking something please let me 
> know. I've tested this a fair amount and it appears to be working on my 
> end. Please CC me on any replies. Thanks,
> 
> -Walt

I've submitted a similar patch to address problems such as the one
you're encountering.  It just adds an extra boot option to specify
amount of memory to remap.  Some applications will need more graphics
memory than the minimum required to display a particular mode (such as
for buffer flipping, offscreen caching, etc).  Attached is the message I
sent to the list a few days ago.

Tony



 

--=-bKfINfS26rW52J5qezp+
Content-Disposition: attachment; filename=vesafb.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=vesafb.txt; charset=ANSI_X3.4-1968

From linux-fbdev-devel-admin@lists.sourceforge.net Thu Mar 27 15:41:09 200=
3
Return-Path: <linux-fbdev-devel-admin@lists.sourceforge.net>
X-Sieve: cmu-sieve 2.0
Received: from sc8-sf-list2.sourceforge.net (lists.sourceforge.net
	[66.35.250.206]) by tom.po.com (8.12.8/8.12.2) with ESMTP id h2RKf9fP02780=
6
	for <adaplas@pol.net>; Thu, 27 Mar 2003 15:41:09 -0500 (EST)
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.13]
	helo=3Dsc8-sf-list1.sourceforge.net) by sc8-sf-list2.sourceforge.net with
	esmtp (Exim 3.31-VA-mm2 #1 (Debian)) id 18yeA1-0003Q5-00; Thu, 27 Mar 2003
	12:39:41 -0800
Received: from pine.compass.com.ph ([202.70.96.37]) by
	sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian)) id
	18ye9G-0003zY-00 for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Ma=
r
	2003 12:38:54 -0800
Received: (qmail 78519 invoked from network); 27 Mar 2003 20:38:50 -0000
Received: from ap-202-70-105-57.compass.com.ph (202.70.105.57) by
	pine.compass.com.ph with SMTP; 27 Mar 2003 20:38:50 -0000
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1048796361.977.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)=20
Subject: [Linux-fbdev-devel] [PATCH]: vesafb - vram option
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
X-BeenThere: linux-fbdev-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help:
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=3Dhelp>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe:
	<https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=3Dsubscrib=
e>
List-Id: <linux-fbdev-devel.lists.sourceforge.net>
List-Unsubscribe:
	<https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=3Dunsubscr=
ibe>
List-Archive:
	<http://sourceforge.net/mailarchive/forum.php?forum=3Dlinux-fbdev-devel>
X-Original-Date: 28 Mar 2003 04:20:12 +0800
Date: 28 Mar 2003 04:20:12 +0800
X-Evolution-Source: pop://adaplas@pop.po.com/inbox
Content-Transfer-Encoding: 8bit

Attached is a diff against linux-2.5.66.

- Added vesafb option to specify amount of video RAM to remap.  This is
perhaps useful for people with machines with large amounts of system and
graphics RAM and vesafb fails to load due to failure to ioremap.

To use:  to remap only 1MiB of ram, add the ff. in your boot option:

video=3Dvesafb:vram:1,<your other options>

Tony

diff -Naur linux-2.5.66-orig/Documentation/fb/vesafb.txt linux-2.5.66/Docum=
entation/fb/vesafb.txt
--- linux-2.5.66-orig/Documentation/fb/vesafb.txt	2003-03-26 02:24:54.00000=
0000 +0000
+++ linux-2.5.66/Documentation/fb/vesafb.txt	2003-03-27 20:10:01.000000000 =
+0000
@@ -146,7 +146,9 @@
=20
 mtrr	setup memory type range registers for the vesafb framebuffer.
=20
-
+vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap all
+	available video RAM.=20
+ =20
 Have fun!
=20
   Gerd
diff -Naur linux-2.5.66-orig/drivers/video/vesafb.c linux-2.5.66/drivers/vi=
deo/vesafb.c
--- linux-2.5.66-orig/drivers/video/vesafb.c	2003-02-16 00:49:23.000000000 =
+0000
+++ linux-2.5.66/drivers/video/vesafb.c	2003-03-27 20:01:11.000000000 +0000
@@ -50,7 +50,7 @@
=20
 static int             inverse   =3D 0;
 static int             mtrr      =3D 0;
-
+static int        vram __initdata =3D 0;
 static int             pmi_setpal =3D 0;	/* pmi for palette changes ??? */
 static int             ypan       =3D 0;  /* 0..nothing, 1..ypan, 2..ywrap=
 */
 static unsigned short  *pmi_base  =3D 0;
@@ -206,6 +206,8 @@
 			pmi_setpal=3D1;
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=3D1;
+		else if (! strncmp(this_opt, "vram:", 5))
+			vram =3D simple_strtoul(this_opt+5, NULL, 0);
 	}
 	return 0;
 }
@@ -226,6 +228,8 @@
 	vesafb_defined.yres =3D screen_info.lfb_height;
 	vesafb_fix.line_length =3D screen_info.lfb_linelength;
 	vesafb_fix.smem_len =3D screen_info.lfb_size * 65536;
+	if (vram && vram * 1024 * 1024 < vesafb_fix.smem_len)
+		vesafb_fix.smem_len =3D vram * 1024 * 1024;
 	vesafb_fix.visual   =3D (vesafb_defined.bits_per_pixel =3D=3D 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
=20



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--=-bKfINfS26rW52J5qezp+--




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
