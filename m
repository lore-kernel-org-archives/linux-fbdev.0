From: James Simmons <jsimmons@infradead.org>
Subject: Re: hw cursor is corrupted on Mach64
Date: Tue, 6 Jan 2004 17:15:38 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401061715250.18404-100000@phoenix.infradead.org>
References: <200311302153.21125.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adunt-0004Dz-Ai
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 09:15:41 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aduns-0005IC-M4
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 09:15:41 -0800
In-Reply-To: <200311302153.21125.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


Applied. Missed clearing the default mask.


On Sun, 30 Nov 2003, Alexander Kern wrote:

> This patch cures corruption of HW-cursor!
> 
> bye
> Alex
> 
> Am Freitag, 21. November 2003 19:45 schrieb Alexander Kern:
> > Hi,
> >
> > does know anybody, what is mask layout in
> >
> > void aty_set_cursor_shape(struct fb_info *info, u8 *dst, u8 *src, unsigned
> > int width)
> >
> > I think, here is a corrupted mask! First scanlines are
> > FF FF <- seems to be correct, but the rest A5 A5 A5 A5...
> > And is it top - bottom or bottom - top ?
> >
> > Regards Alex
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > Does SourceForge.net help you be more productive?  Does it
> > help you create better code?  SHARE THE LOVE, and help us help
> > YOU!  Click Here: http://sourceforge.net/donate/
> > _______________________________________________
> > Linux-fbdev-devel mailing list
> > Linux-fbdev-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
