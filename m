From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ? + Mach64Gx question.
Date: Thu, 30 Oct 2003 07:49:40 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030064940.GC2115@iliana>
References: <20031029093653.GA4626@iliana> <20031029182532.GA1662@dreamland.darkstar.lan> <20031029195627.GA13626@iliana> <20031029202544.GA8953@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF6dE-0002wC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Oct 2003 22:50:08 -0800
Received: from smtp8.wanadoo.fr ([193.252.22.23] helo=mwinf0804.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AF6ct-0005Av-Fa
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Oct 2003 22:49:47 -0800
Content-Disposition: inline
In-Reply-To: <20031029202544.GA8953@dreamland.darkstar.lan>
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
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Oct 29, 2003 at 09:25:44PM +0100, Kronos wrote:
> Il Wed, Oct 29, 2003 at 08:56:27PM +0100, Sven Luther ha scritto: 
> > On Wed, Oct 29, 2003 at 07:25:32PM +0100, Kronos wrote:
> > > Il Wed, Oct 29, 2003 at 10:36:53AM +0100, Sven Luther ha scritto: 
> > > > Hello,
> > > > 
> > > > I have had a report of someone trying to use two voodoo cards on a
> > > > pegasos/ppc motherboard, and it freezing the kernel (2.4.22 kernel)
> > > > 
> > > > Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?
> > > 
> > > No, the driver has a statically allocated fb_info. It will blow up.
> > 
> > Ok, thought so, i am not sure though.
> 
> BTW, looking  at 2.6 it  seems that the  driver will work  with multiple
> cards.  Static vars have been removed so this problem is solved. I'm not
> sure that the  driver itself can handle more than  one card though. Give
> it a try.

I don't have the hardware directly, and i was reluctant to upgrade the
pegasos patches to 2.6.x, since i heard that radeonfb was causing some
trouble. And i only have a radeon 9000, a matrox millenium II that i can
work on this box.

BTW, i had had reports from Chris Tillman about what seems an fbdev
failure on his 9500 powermac with 2.4.22 kernels. The pci greaphic cards
declares to be a Mach64GX, and lspci gives :

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 02)
00:0f.0 VGA comppatible controller: ATI Technolgies Inc 210888GX [Mach64 GX] (rev 02)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)

00:0f.0 Class 0300: 1002:4758 (rev 02)
	Flags: stepping, medium devsel, IRQ 25
	Memory at 81000000 (32-bit, non-prefetchable)

Any idea on what is going on here (the kernel works, but there is no
video output).

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
