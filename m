From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
Date: Tue, 29 Jul 2003 17:55:18 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
References: <1059487140.8537.35.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pub234.cambridge.redhat.com ([213.86.99.234] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hXlU-0007d6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jul 2003 09:55:56 -0700
In-Reply-To: <1059487140.8537.35.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > matroxfb tried to use a 'dead' for handling hot removal, but your code
> > looks definitely saner
> 
> My code wasn't really intended to deal with hot-removal, more with
> "what happens if printk occurs during the Power Management suspend
> sequence", but I tried to keep the notification mecanism simple
> enough so it could be used for that as well. Also, indeed, the fbcon
> changes should deal with hot-removal in some way (though you surely
> also want to "deatch" from the fbdev's in this case).
> 
> Among other things that could be used for is live monitor insertion/
> removal detection (some HW are able to do that), "pivot" monitor
> kind of things, etc... typically via the mode_changed hook.

I knew it was a matter of time before "client" management would happen. 
Is this a 2.6.X thing tho or shoudl we wait for the next developement 
cycle. I don't mind working on experimental stuff.




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
