From: Aurelien Jacobs <aurel@gnuage.org>
Subject: [PATCH] vesafb memory size mismatch
Date: Fri, 1 Oct 2004 15:36:24 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041001153624.267a808b@homer.gnuage.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__1_Oct_2004_15_36_24_+0200_M.Cy/CiVvFKpPsa2"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDOOa-0004nI-Vp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Oct 2004 07:28:28 -0700
Received: from postfix3-1.free.fr ([213.228.0.44])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDOOW-0006ZU-93
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Oct 2004 07:28:28 -0700
Received: from server.gnuage.org (unknown [62.147.10.254])
	by postfix3-1.free.fr (Postfix) with ESMTP id 938E117357F
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  1 Oct 2004 16:28:22 +0200 (CEST)
Received: from homer.gnuage.org ([2002:52e3:5eac:1:211:2fff:fe2b:3fc3])
	by server.gnuage.org with smtp (Exim 4.34)
	id 1CDOP6-00011f-J2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Oct 2004 16:29:02 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--Multipart=_Fri__1_Oct_2004_15_36_24_+0200_M.Cy/CiVvFKpPsa2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I found a bug in the vesafb driver. The video memory size which is
reserved by vesafb do not correspond to the really needed memory.
Currently the needed memory is calculated using
screen_info.lfb_width * vesafb_defined.bits_per_pixel >> 3
This works with most cards because it's usually equal to
vesafb_fix.line_length.
But with some cards (voodoo3 in 24 bits mode) line_length is
greater than width * bytes_per_pixel (probably for alignment
purpose, line_length = 4096 on voodoo3 800x600-24).
Su currently, with such cards, writting in the second buffer
(as memory is allocated for double buffering) can go past the
end of reserved memory, overwritting some other memory area
and leading to a kernel crash.

So I wrote this tiny patch wich correct this bug.
I tested it successfully with different video cards (Matrox,
Nvidia, Sis, 3dfx) in different modes.

I don't know if it's the right place to send a patch for vesafb ?
Could you please direct me to the right place if it's not ?

Aurel

--Multipart=_Fri__1_Oct_2004_15_36_24_+0200_M.Cy/CiVvFKpPsa2
Content-Type: text/plain;
 name="vesafb-memory.diff"
Content-Disposition: attachment;
 filename="vesafb-memory.diff"
Content-Transfer-Encoding: 7bit

diff -Naur linux-2.6.8.1.orig/drivers/video/vesafb.c linux-2.6.8.1/drivers/video/vesafb.c
--- linux-2.6.8.1.orig/drivers/video/vesafb.c	2004-09-29 17:47:41.997524992 +0200
+++ linux-2.6.8.1/drivers/video/vesafb.c	2004-09-29 17:48:03.946188288 +0200
@@ -234,7 +234,7 @@
 	vesafb_fix.line_length = screen_info.lfb_linelength;
 
 	/* Allocate enough memory for double buffering */
-	vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * vesafb_defined.bits_per_pixel >> 2;
+	vesafb_fix.smem_len = 2 * screen_info.lfb_linelength * screen_info.lfb_height;
 
 	/* check that we don't remap more memory than old cards have */
 	if (vesafb_fix.smem_len > (screen_info.lfb_size * 65536))

--Multipart=_Fri__1_Oct_2004_15_36_24_+0200_M.Cy/CiVvFKpPsa2--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
