From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ; -)
Date: Wed, 28 Apr 2004 18:14:46 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281814150.1187-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404281034530.3644@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIse3-0001Jk-4F
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:14:51 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIse2-0006fT-Iz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:14:50 -0700
In-Reply-To: <Pine.GSO.4.58.0404281034530.3644@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Since accelerated drawing functions have no relevence whatsoever in userspace,
> > placing it in fb_info is better.  But I won't disagree if it's placed in
> > fb_fix_screeninfo.
> 
> Point taken.

So shoudl be palce it in fb_info then? Are we in agreement on this?




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
