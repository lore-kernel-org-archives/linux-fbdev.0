From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 19:34:30 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051932120.27760-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0303052027070.18954-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qefR-0000F0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 11:35:05 -0800
In-Reply-To: <Pine.GSO.4.21.0303052027070.18954-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>, Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Do you remember how modes were set before the existence of fbset? I guess not
> :-)

before my time.

> A driver could support up to 31 modes (cfr. the old minors). You changed mode
> by touch'ing the /dev/fb0my_favorite_mode special device that corresponded to
> the mode you wanted.

Yuck!!!!
 
> > userland database I often couldn't change video modes after booting. 
> 
> Ugh, those are serious driver bugs....

So the arrgument that fbset is the solution to all problems is bogus IMO.

> > We should split the monitor programing stuff out from stuff like bpp etc.
> > Now if you think about it we can do things like change the bpp without 
> > having to redo the monitor programming. This is the flaw with the old and 
> > even the new api. 
> 
> You could have done that from the beginning. Just look at which fields have
> changed and which haven't.

I should of but didn't because I knew driver would take teh path of lest 
resistance to port there drivers. TO much change would have made the 
current situtation much much worst. 



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
