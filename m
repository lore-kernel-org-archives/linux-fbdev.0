From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Date: Thu, 7 Aug 2003 22:29:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030807202951.GB413@elf.ucw.cz>
References: <20030807100309.GB166@elf.ucw.cz> <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out2.iol.cz ([194.228.2.87])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19krOp-0006Jr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 13:30:15 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308071822270.13973-100000@phoenix.infradead.org>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>

Hi!

> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> Not very helpful on embedded systems that use the framebuffer without the 
> VT console. 

Okay, that might be a problem. But such system will need some special
notification... Is VT so much overhead?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
