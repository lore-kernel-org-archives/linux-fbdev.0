From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 20:05:15 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404281923360.1187-100000@phoenix.infradead.org>
References: <Pine.GSO.4.58.0404281948260.11982@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIuNv-0004b5-GH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 12:06:19 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIuNu-00083J-ND
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 12:06:19 -0700
In-Reply-To: <Pine.GSO.4.58.0404281948260.11982@waterleaf.sonytel.be>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > Your logic is only ever valid once every single fbdev is capable of
> > > doing proper mode management & validation. And even then, there isn't
> > > a 1:1 relationchip between a mode and an fbcon size.
> >
> >   But we do have the proper data already. Its called modedb. I have two
> 
> So I cannot have a mode that's not in modedb, since it won't survive switching
> VTs.

Well its a bug in fbdev that we can't alter the modedb. Especially that we 
have in struct fb_info struct fb_monspecs  which has a modedb field. We 
need to add the functionally to export the drivers modedb to userland and 
vice versa.

> > reasons for why I hate to have a var in struct display. One is that it
> > makes fbcon heavier. You now have a extra var in every struct display.
> 
> ... vs. a (non __init) modedb that stays in RAM after bootup.
> 
> Besides the initial mode (modedb, EDID, kernel arg, ...), I'd like to keep mode
> databases in userspace where possible.

That kind of sucks for modular fbdev drivers. Also with EDID data the 
driver creates the respected modedb it can work with. Consider the case 
where we have a fbdev driver all happy. Now we unplug the monitor and plug 
in a different kind. With the new monitor the old mode doesn't work. How 
do we handle this? Even if you say you can load the new database from 
userland before we change monitors we still have to create a database.
With EDID we can generate those modes. But its driver side. 

> > Usually the user has several if not all VCs at the same resolution. That
> > means there is alot of duplication of the same data for now reason. If we
> 
> Alternatively, make the vars in struct display pointers to reference counted
> data, so initially they all point to the same var. But I don't know if it's
> worth the extra effort.

Thats a possibity. Of course we still have modedb and it is needed for the 
above reasons.

> But I'm still limited to the modes in modedb.

Not if we fix modedb to take userland modes.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
