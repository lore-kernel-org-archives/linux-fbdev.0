From: James Simmons <jsimmons@infradead.org>
Subject: Re: PATCH: tdfxfb palette fix for 2.6.0-test2
Date: Tue, 29 Jul 2003 23:26:20 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307292325210.5874-100000@phoenix.infradead.org>
References: <20030729221411.GA3434@satan.blackhosts>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pub234.cambridge.redhat.com ([213.86.99.234] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19hcvu-0001Le-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 29 Jul 2003 15:27:03 -0700
In-Reply-To: <20030729221411.GA3434@satan.blackhosts>
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
To: Jakub Bogusz <qboosh@pld.org.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


I have patches that fix this. I will make a new patch soon against 
test 2.

> Hello,
> 
> In 2.6.0-test2 text palette is broken in 16/24/32bpp modes on tdfxfb
> console (because of not using component length information).
> This patch fixes it; see also note inside.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
