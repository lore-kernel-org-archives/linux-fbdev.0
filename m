From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: hw cursor is corrupted on Mach64
Date: Sun, 30 Nov 2003 21:53:21 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200311302153.21125.alex.kern@gmx.de>
References: <200311211945.30242.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Bjly/Mx0fV/SPmM"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQYcf-0000iN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 30 Nov 2003 12:56:53 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AQYce-0006lP-F2
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 30 Nov 2003 12:56:52 -0800
In-Reply-To: <200311211945.30242.alex.kern@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--Boundary-00=_Bjly/Mx0fV/SPmM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch cures corruption of HW-cursor!

bye
Alex

Am Freitag, 21. November 2003 19:45 schrieb Alexander Kern:
> Hi,
>
> does know anybody, what is mask layout in
>
> void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned
> int width)
>
> I think, here is a corrupted mask! First scanlines are
> FF FF <- seems to be correct, but the rest A5 A5 A5 A5...
> And is it top - bottom or bottom - top ?
>
> Regards Alex
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Boundary-00=_Bjly/Mx0fV/SPmM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fbcon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fbcon.patch"

--- fbcon.c.orig	2003-10-31 20:20:30.000000000 +0100
+++ fbcon.c	2003-11-30 21:43:24.000000000 +0100
@@ -1046,13 +1046,14 @@
                         dst = kmalloc(size, GFP_ATOMIC);
                         if (!dst)
                                 return;
+                        memset(dst, 0, size);
                         
                         cursor.set |= FB_CUR_SETSHAPE;
                         if (info->cursor.mask)
                                 kfree(info->cursor.mask);
                         info->cursor.mask = dst;
 
-                        for (i = 0; i < cur_height; i++) {
+                        for (i = 0; i < vc->vc_font.height; i++) {
                                 for (c = 0; c < s_pitch; c++)
                                         *dst++ = 0xff ^ *src++;
                         }       

--Boundary-00=_Bjly/Mx0fV/SPmM--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
