From: Kaj-Michael Lang <milang@tal.org>
Subject: Re: writing a framebuffer driver and font
	problem..
Date: Fri, 31 Oct 2003 13:34:20 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1067600060.30097.1.camel@toriamos.abo.fi>
References: <Pine.GSO.4.21.0310311118590.17237-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFXYN-00089g-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 31 Oct 2003 03:34:55 -0800
Received: from toriamos.abo.fi ([130.232.153.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AFXYM-0005cy-Rq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 31 Oct 2003 03:34:55 -0800
In-Reply-To: <Pine.GSO.4.21.0310311118590.17237-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-10-31 at 12:41, Geert Uytterhoeven wrote:
> Are you using 2.4 or 2.6?

2.4 for now, but I'm going to port it over to 2.6.

> You have to swap the character data in
> drivers/video/fbcon-mfb.c:fbcon_mfb_putc{,s}() (2.4.x) or
> drivers/video/cfbimgblt.c.

Ok.. stupid question.. how do I do that ?

-- 
Kaj-Michael Lang <milang@tal.org>



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
