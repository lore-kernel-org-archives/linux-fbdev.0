From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer with banked memory
Date: Thu, 31 Oct 2002 13:44:14 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210311343390.1721-100000@maxwell.earthlink.net>
References: <1036062186.638.23.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187MHW-0008EY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 12:51:10 -0800
In-Reply-To: <1036062186.638.23.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: alain volmat <avolmat@yahoo.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> On Thu, 2002-10-31 at 12:02, alain volmat wrote:
> >
> > What about adding fb_write / fb_read function in the
> > framebuffer (device dependant) driver. The same way as
> > for fb_mmap. I saw that at the beginning of fb_mmap in
> > fbmem.c, there is a test to see if the device driver
> > contains its own fb_mmap function, if so the device
> > driver fb_mmap will be used instead of the "generic"
> > fb_mmap. What about doing the same thing for fb_write
> > / fb_read.
> >
> I've seen a post by James sometimes ago about adding fb_write and
> fb_read to info->fbops.

Correct. The next set of fbdev changes will include this plus I added
fb_sync!!! Iknow this will make you happy:-)



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
