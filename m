From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont() methods
Date: Sat, 4 Jan 2003 21:12:24 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301042109340.24903-100000@phoenix.infradead.org>
References: <20030104204131.GD1319@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UvbI-0005qJ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 13:13:00 -0800
In-Reply-To: <20030104204131.GD1319@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


> I'll be happier with character coordinates for text mode. 

Yuck!! Using fbcon for text modes is just bloat. For hardware text mode it 
is much better to write a nice small console driver like newport_con.c

> could decide on case-by-case basis whether it will use its own code or 
> generic without touching pointer (without modifying potentially constant
> fb_ops structure common to all fbdev instances).

The patch was rejected. I working on your driver. I can throw in a text 
mode driver as well. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
