From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: EDID for radeonfb
Date: 21 Aug 2003 22:16:23 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061496982.18043.4.camel@gaston>
References: <20030819223350.GA838@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-4-31.w217-128.abo.wanadoo.fr ([217.128.74.31] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19pwgf-0004zB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 21 Aug 2003 14:09:41 -0700
In-Reply-To: <20030819223350.GA838@dreamland.darkstar.lan>
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
To: kronos@kronoz.cjb.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>


> Ok, I've a working implementation of the I2C code for radeonfb :)
> The bug was very stupid: 0x50 became 0x20 and I spent a couple of weeks
> wondering why it didn't work...
> 
> I've tested the code on a R300 board but it should work on any radeon. I
> need a couple of day to merge  it into radeonfb and to test. I'll send a
> patch ASAP.

Hi !

It would be real cool if you could start from the radeonfb version
that is at bk://ppc.bkbits.net/linuxppc-2.5-benh (It needs my previously
posted Power Management patch to fbdev to build, but you can just
comment out 2 lines to make it build & run without it).

I'm currently having maintainership of this driver and I'll have an
update sent to James rsn based on that tree, so that would simplify
the merging significantly.

Ben.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
