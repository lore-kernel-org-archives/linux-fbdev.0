From: James Simmons <jsimmons@infradead.org>
Subject: Re: Framebuffer work is coming back.
Date: Wed, 7 Jan 2004 22:58:33 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401072236030.2265-100000@phoenix.infradead.org>
References: <200401072244.55572.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeMdK-0001ZJ-In
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 14:58:38 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AeMdK-0001eg-10
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 14:58:38 -0800
In-Reply-To: <200401072244.55572.alex.kern@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

 
> here is a one more patch for MACH64. This is an accelerated imgblit.

Nice !!! ;-) Only one problem I found when testing. If you pick the sun 
12x22 fonts at boot up some of the fonts are distorted. Once X starts 
and you go back to the console this problem goes away completely. This 
is using a non accelerated X server. 

P.S
Also I noticed that in the accelerated function you have HOST_XBPP. I like 
to give it a try for color expension. This would be cool sine this means 
we could have the 4 bpp penguin shown on any depth display!!!




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
