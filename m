From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Date: Thu, 7 Aug 2003 12:03:09 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030807100309.GB166@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out2.iol.cz ([194.228.2.87])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19khcJ-0003ex-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 03:03:32 -0700
Content-Disposition: inline
In-Reply-To: <1060249101.1077.67.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>

Hi!

> > > James, if you are ok, can you get that upstream to Linus asap so
> > > I can start pushing the driver bits for radeon & aty128 ?
> > 
> > Working on it. I'm thinking about also how it effects userland and how 
> > userland affects the console if present. Basically the logic will go 
> > 
> > pci suspend ->  framebuffer driver supend function -> call each client
> > 
> > Just give me a few days to piece it together.
> 
> Right now, we don't have a proper userland notification. So far, the
> main affected thing is XFree, but this is ok as it will have received
> a suspend request via /dev/apm_bios (which we emulate on PowerMacs),
> and so won't touch the framebuffer until resumed.
> 
> There isn't much we can do against a userland client tapping the
> framebuffer that it mmap'ed previously. I don't know how feasible it
> would be to sort of "hack" this process mapping on the fly (would
> involve some nasty SMP synchronisation issues) so that the userland
> process is just put to sleep on fb access while the fb is suspended
> (or get a SEGV). We probably want to extend the notification mecanism
> to userland in some way, but this isn't something i cover in this
> patch.

I believe solution to this is simple: always switch to kernel-owned
console during suspend. (swsusp does it, there's patch for S3 to do
the same). That way, Xfree (or qtopia or whoever) should clean up
after themselves and leave the console to the kernel. (See
kernel/power/console.c)
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
