From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 13 Mar 2003 01:38:40 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047490650.1030.31.camel@localhost.localdomain>
References: <20030311234249.40244.qmail@web14914.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tAEO-0001Go-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 09:41:33 -0800
In-Reply-To: <20030311234249.40244.qmail@web14914.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-03-12 at 07:42, Jon Smirl wrote:
> --- Antonino Daplas <adaplas@pol.net> wrote:
> > Yikes!  No, it can't be done this way.  During the
> > early boot sequence,
> > the kernel is not yet decompressed and loaded, so
> > all the services the
> > kernel provides are still unavailable.  Unless you
> > want to walk, detect,
> > enable, etc the PCI subsystem in pure 16-bit
> > assembly...
> 
> You don't Linux to look at the PCI subsys you make
> calls into the system BIOS to find the devices.

That's not the only reason.  The problem is in 16-bit mode, the code can
only access an address range up to only 1MB.  PCI resources are located
above 16MB.  So in order to copy the ROM, it might be necessary to
switch to 32-bit mode, copy the ROM, switch back to 16-bit mode, etc.

Unless I missed some imported BIOS calls or other methods to do this or
something similar in real-mode...

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
