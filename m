From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Thu, 29 Apr 2004 09:29:02 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083194942.21436.96.camel@gaston>
References: <Pine.LNX.4.44.0404281709260.1187-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIyah-0005fs-VK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:35:47 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIyah-0005ZP-Ix
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:35:47 -0700
In-Reply-To: <Pine.LNX.4.44.0404281709260.1187-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


>   But we do have the proper data already. Its called modedb. I have two 
> reasons for why I hate to have a var in struct display. One is that it
> makes fbcon heavier. You now have a extra var in every struct display. 
> Usually the user has several if not all VCs at the same resolution. That 
> means there is alot of duplication of the same data for now reason. If we 
> use modedb to fill in the extra data then we don't need the extra data in
> each struct display. The bonus there is permentally stored data to represent 
> that one mode to everybody!! Much lighter.

I don't agree... again. What is the semantics _users_ are the most
comfortable with ? an stty size or a resolution ? All OSes so far
let user pick up resolutions (w/h/freq), this is the thing users are
getting used to :) That's how we should, via fbset or whatever other
tool we have, set a resolution. The actual fbcon size is just a side
effect of the resolution and font size.

Modedb isn't always a solution with some fancy displays too...

Also, if I ever start doing dual head, I'll have interesting side
effects to deal with, which means for example  that enabling mirroring
will possibly change the resolution of the primary head. That means that
I'll have to trigger a mode change in console based on ... a resolution,
not a console size. I just want the console size to adapt.

Now, wether this mode is common to all VCs or per-VC is a different
story, I tend to like when it's per-VC for various reasons, one of them
beeing that if I set something that doesn't work, I can always go back
to my working VC :)

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
