From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Fri, 12 Sep 2003 18:46:50 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309121844480.5017-100000@phoenix.infradead.org>
References: <Pine.GSO.4.21.0309092258330.3869-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xs0W-0002Te-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 10:46:56 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xs0V-0005Gh-KD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 10:46:56 -0700
In-Reply-To: <Pine.GSO.4.21.0309092258330.3869-100000@waterleaf.sonytel.be>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kronos <kronos@kronoz.cjb.net>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Tue, 9 Sep 2003, Benjamin Herrenschmidt wrote:
> > On Tue, 2003-09-09 at 21:24, Kronos wrote:
> > > +static struct class fb_class = {
> > > +	.name		= "video",
> > 
> > I'd rather use "display" here. "video" is too broad and will cause
> > confusion with multimedia stuff.
> 
> Exactly my comment. I was thinking about `graphics' instead of `video',
> but indeed `display' sounds better. Gr{oetje,eeting}s,

I prefere graphics myself. Display sounds to generic. That is what video 
and graphics output is piped to. Since fbdev doesn't handle video ouput 
normally this is kind of fuzzy sounding.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
