From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: tdfx & multiple voodoo cards : supposed to work ?
Date: Thu, 30 Oct 2003 10:15:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031030091541.GA4422@iliana>
References: <20031029182532.GA1662@dreamland.darkstar.lan> <Pine.LNX.4.44.0310292000530.21040-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AF8uD-0002fD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 01:15:49 -0800
Received: from smtp5.wanadoo.fr ([193.252.22.26] helo=mwinf0502.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AF8uC-00056F-Oa
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 01:15:48 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310292000530.21040-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Oct 29, 2003 at 08:04:15PM +0000, James Simmons wrote:
> 
> > > I have had a report of someone trying to use two voodoo cards on a
> > > pegasos/ppc motherboard, and it freezing the kernel (2.4.22 kernel)
> > > 
> > > Is the tdfx fbdev supposed to be able to handle dual card setups, or not ?
> > 
> > No, the driver has a statically allocated fb_info. It will blow up.
> 
> Yeap. Also the driver uses the VGA legacy IO ports. It is possible to run 
> the driver without BIOS support. The specs have such info. I just haven't 
> got around to it.

Notice : this is on powerpc, but the pegasos OF has support for
emulating x86 bioses.

What about running fbdev only on the first head, and have XFree86
initialize the second head ? The problem is that just having the two
boards in the box freezes the kernel.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
