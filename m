From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 00:21:13 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404280019070.23153-100000@phoenix.infradead.org>
References: <1083107454.16544.42.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIbt8-0000HS-Gs
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:21:18 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIbt7-0002DM-Tc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:21:18 -0700
In-Reply-To: <1083107454.16544.42.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: John Zielinski <grim@undead.cc>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > I can see how vgacon and fbcon would walk all over each other but how 
> > would a serial console
> > mess things up?
> 
> Same question... Where is the problem ?

Say two people are logged in. One on a serial console and another on the 
framebuffer console. The person starts X fbdev from the serial console. 
Ooops the fbcon user lost his console.

> We need several level of arbitration, I'm not sure hwo to do that at
> this point and I don't have time to dive into the DRI side of things.
> 
> Jon Smirl has been working on embedded mesa & moving DRI outside of
> X. Unfortunately, last I heard, he was still on his trip of re-inventing
> everything including replacing the fbdev's with his own stuff instead
> of moving from what we have ...

Ug. This is sad :-(





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
