From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: 2.6.0-test2 does not boot with matroxfb
Date: Fri, 15 Aug 2003 23:36:44 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0308152333200.30952-100000@phoenix.infradead.org>
References: <20030814231409.GA745@rushmore>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pub234.cambridge.redhat.com ([213.86.99.234] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19nnCB-000195-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Aug 2003 15:37:19 -0700
In-Reply-To: <20030814231409.GA745@rushmore>
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
To: rwhron@earthlink.net
Cc: vandrove@vc.cvut.cz, linux-fbdev-devel@lists.sourceforge.net


> Petr's patch is mandatory to get mga400 to do all this at the same time:
> 
> o multiple fast high res (240x90 char) virtual text consoles.

At present only fbdev is mapped to the console and the rest have to mapped 
by con2fb. That should work. I really didn't want to push forcing all the 
framebuffers to a console because it is a very common setup to have one 
framebuffer used for graphics developement and the other for a console. 
We used that alot at my job at Transvirtual. I still use this setup from 
time to time. 

> o graphics in console with "links -g"

Links ??? the web browser. I tried that option and it complained.

> o X11

Ug. I haven't figured that one out yet. I need to make fbcon fully restore 
the hardware state for each card. 



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
