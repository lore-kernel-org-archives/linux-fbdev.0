From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
Date: 07 Aug 2003 11:38:22 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060249101.1077.67.camel@gaston>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mix-lyon-308-2-184.w80-9.abo.wanadoo.fr ([80.9.175.184] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19khEk-0004fa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 02:39:11 -0700
In-Reply-To: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
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
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>

On Thu, 2003-08-07 at 01:52, James Simmons wrote:
> > James, if you are ok, can you get that upstream to Linus asap so
> > I can start pushing the driver bits for radeon & aty128 ?
> 
> Working on it. I'm thinking about also how it effects userland and how 
> userland affects the console if present. Basically the logic will go 
> 
> pci suspend ->  framebuffer driver supend function -> call each client
> 
> Just give me a few days to piece it together.

Right now, we don't have a proper userland notification. So far, the
main affected thing is XFree, but this is ok as it will have received
a suspend request via /dev/apm_bios (which we emulate on PowerMacs),
and so won't touch the framebuffer until resumed.

There isn't much we can do against a userland client tapping the
framebuffer that it mmap'ed previously. I don't know how feasible it
would be to sort of "hack" this process mapping on the fly (would
involve some nasty SMP synchronisation issues) so that the userland
process is just put to sleep on fb access while the fb is suspended
(or get a SEGV). We probably want to extend the notification mecanism
to userland in some way, but this isn't something i cover in this
patch.

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
