From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
Date: 30 Jul 2003 08:22:44 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1059567764.8538.76.camel@gaston>
References: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
	 <1059510171.8538.53.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hpzY-00029a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 30 Jul 2003 05:23:40 -0700
In-Reply-To: <1059510171.8538.53.camel@gaston>
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
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I knew it was a matter of time before "client" management would happen. 
> > Is this a 2.6.X thing tho or shoudl we wait for the next developement 
> > cycle. I don't mind working on experimental stuff.

Note, BTW, there's also a locking issue. Typically, we must make sure
the fbcon (which may be running another CPU) have finished doing whatever
it was doing before returning, and we don't get any mode change or 
whatever ioctl initiated thing at that moment (or be in the middle of
doing it).

Right now, my code assumes any operation on the fbdev is protected by
the console sem. However, looking at the console & fbmem code, that is
not always true. Typically, userland ioctls in fbmem aren't, and vt.c
may call into consoles in some cases without holding it neither.

That should probably be fixed, though I haven't had time to work on
it yet.

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
