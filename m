From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer with banked memory
Date: 31 Oct 2002 19:04:32 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1036062186.638.23.camel@daplas>
References: <20021031040228.12091.qmail@web14205.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187DAz-0007HQ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 03:07:49 -0800
In-Reply-To: <20021031040228.12091.qmail@web14205.mail.yahoo.com>
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
To: alain volmat <avolmat@yahoo.fr>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2002-10-31 at 12:02, alain volmat wrote:
> 
> What about adding fb_write / fb_read function in the
> framebuffer (device dependant) driver. The same way as
> for fb_mmap. I saw that at the beginning of fb_mmap in
> fbmem.c, there is a test to see if the device driver
> contains its own fb_mmap function, if so the device
> driver fb_mmap will be used instead of the "generic"
> fb_mmap. What about doing the same thing for fb_write
> / fb_read.
> 
I've seen a post by James sometimes ago about adding fb_write and
fb_read to info->fbops.  

Tony



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
