From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 09:10:55 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083107454.16544.42.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIboh-0007sP-Cw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:16:43 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIbog-0001MV-Uf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:16:43 -0700
In-Reply-To: <408EE34F.8080106@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Alex Stewart <alex@foogod.com>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-04-28 at 08:48, John Zielinski wrote:
> James Simmons wrote:
> 
> >I wouldn't bank on that. I seen this solution fall short. Consider a system 
> >where we have a serial console, vgacon, and fbcon (say hgafb). Well I 
> >leave it to the imagination what can go wrong. 
> >  
> >
> I can see how vgacon and fbcon would walk all over each other but how 
> would a serial console
> mess things up?

Same question... Where is the problem ?

> >I agree we need arbitration. Eventually fbdev and dri have to merge. Mode 
> >setting is still best handled kernel side. That is just a reality.
> >
> >  
> >
> Arbitration would be best.  How would it be done generally?  Some 
> mechanism that arbitrates based on mem/io ranges or something else?

We need several level of arbitration, I'm not sure hwo to do that at
this point and I don't have time to dive into the DRI side of things.

Jon Smirl has been working on embedded mesa & moving DRI outside of
X. Unfortunately, last I heard, he was still on his trip of re-inventing
everything including replacing the fbdev's with his own stuff instead
of moving from what we have ...

Ben,



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
