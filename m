From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer with banked memory
Date: 01 Nov 2002 05:16:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036098840.654.6.camel@daplas>
References: <Pine.LNX.4.33.0210311343390.1721-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187Mkt-0005jv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 13:21:31 -0800
In-Reply-To: <Pine.LNX.4.33.0210311343390.1721-100000@maxwell.earthlink.net>
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
To: James Simmons <jsimmons@infradead.org>
Cc: alain volmat <avolmat@yahoo.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2002-11-01 at 05:44, James Simmons wrote:
> 
> > On Thu, 2002-10-31 at 12:02, alain volmat wrote:
> > >
> > > What about adding fb_write / fb_read function in the
> > > framebuffer (device dependant) driver. The same way as
> > > for fb_mmap. I saw that at the beginning of fb_mmap in
> > > fbmem.c, there is a test to see if the device driver
> > > contains its own fb_mmap function, if so the device
> > > driver fb_mmap will be used instead of the "generic"
> > > fb_mmap. What about doing the same thing for fb_write
> > > / fb_read.
> > >
> > I've seen a post by James sometimes ago about adding fb_write and
> > fb_read to info->fbops.
> 
> Correct. The next set of fbdev changes will include this plus I added
> fb_sync!!! Iknow this will make you happy:-)
> 

Indeed :-), not just me, but others too, I guess. Selective hardware
syncs will maximize the graphics instruction pipeline.

Tony



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
