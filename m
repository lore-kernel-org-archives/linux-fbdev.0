From: James Simmons <jsimmons@infradead.org>
Subject: Re: vesafb and too much RAM?
Date: Tue, 28 Jan 2003 19:22:54 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301281922120.12076-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301111150160.10295-100000@ie>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dbKS-0004Y1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jan 2003 11:23:29 -0800
In-Reply-To: <Pine.LNX.4.44.0301111150160.10295-100000@ie>
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
To: Matt Nanney <matt@ifox.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> I was running debian with a 2.4.20(-3 I believe) with vesafb with no
> problems with 512MB ram. I upgraded to 1GB and immediately I could not
> boot. I get as far as the LILO prompt, but as soon as I hit enter the
> screen goes black, the caps lock and scroll lock keyboard LEDs flash, and
> nothing save hitting the reset switch has any affect.

You have lots oe memory. Try turning on high memory support. This will 
make the problem go away.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
