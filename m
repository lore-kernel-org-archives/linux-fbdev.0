From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Interlace for rivafb driver
Date: Wed, 12 Feb 2003 20:09:52 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302122009260.31435-100000@phoenix.infradead.org>
References: <1043966131.1041.5.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j3D9-0007nh-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 12:10:28 -0800
In-Reply-To: <1043966131.1041.5.camel@localhost.localdomain>
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
Cc: Fredrik Noring <noring@nocrew.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I applied your direct color patch. The X server has issues without it as 
> > well. For some reason the screen is cut in half and the colors are wrong.
> > Even when I leave X. The only solution is to switch back to 8 bpp mode.
> > 
> 
> I get this too.  For some reason, X fails to dynamically set rivafb to
> the mode it wants to use.  So, I have to use fbset first to set rivafb
> to the mode and visual X is going to use.  After doing this, I get
> XFBdev working nicely (at Depth 15).
> 
> I have no problems with DirectFB though.

Ug. Well the driver is really coming along. This is without specs. 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
