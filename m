From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 15:27:03 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>
References: <20030306103156.GA864@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qxHX-0004e0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 07:27:40 -0800
In-Reply-To: <20030306103156.GA864@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > (see fb_get_mode() and fb_validate_mode() in fbmon.c)
> > 
> > And if you use very narrow vsync and hsync ranges, then the "stale"
> > pixelclock will always most certainly be invalid.
> 
> BTW, do we have an easy way of knowing if it is an LCD or analog monitor
> which is attached to the card (or even a TV) ? I think the radeonfb
> knows how to do this, not sure though.

Not that I know of.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
