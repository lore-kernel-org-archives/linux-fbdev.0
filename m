From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.51 -- rivafb is whacky (characters
 flipped on vertical axis, 640x480 usable area shown inside a higher-res
 area, etc).
Date: Fri, 13 Dec 2002 05:09:34 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212130508050.10929-100000@phoenix.infradead.org>
References: <1039705243.1006.1.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Mi5U-0003Xb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 21:10:12 -0800
In-Reply-To: <1039705243.1006.1.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Miles Lane <miles.lane@attbi.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Can you test the attached patch (rivafb1.diff)?  It fixes some things: 

I tested the patch. The colors are still messed up :-( I'm running at 8 
bpp mode. I applied the patch since it fixed some important things. 
I also add support and more functionality. I still have some to go.
 



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
