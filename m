From: Alexander Kern <alex.kern@gmx.de>
Subject: hw cursor is corrupted on Mach64
Date: Fri, 21 Nov 2003 19:45:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200311211945.30242.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ANHV0-0006Cv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Nov 2003 12:03:26 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ANHUz-00089j-NL
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Nov 2003 12:03:25 -0800
Content-Disposition: inline
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Hi,

does know anybody, what is mask layout in 

void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned int 
width)

I think, here is a corrupted mask! First scanlines are
FF FF <- seems to be correct, but the rest A5 A5 A5 A5...
And is it top - bottom or bottom - top ?

Regards Alex



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
