From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 00:51:12 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
References: <1083108311.16476.56.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcM9-0005ps-FP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:51:17 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BIcM9-0005Bu-3v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 16:51:17 -0700
In-Reply-To: <1083108311.16476.56.camel@gaston>
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
Cc: John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > I refuse to have hacks to deal with a cripple VT system. What is 
> > acceptable is that we add what we need to struct vc_data. You do that and 
> > I have no problem then. From what I can see we need the following.
> > 
> > 1) Color depth.
> > 2) Frequency.
> > 3) Over scan color.
> 
> No, no, no ... We don't need those, we need a var structure, that's all.

No. Look the logic should go from the upper VT layer to the lower driver 
to accomplish something. Not the reverse.

struct vc_data -> native console driver structure --> fbdev

Not.

fbdev --> native console driver --> struct vc_data.

This was the way it uses to be. If this is the case then I suggest we 
write our own vt.c and vt_ioctl.c for the fbcon layer. We shouldn't even
use struct vc_data then. In fact each fbdev driver should be independent 
console drivers. That is how 2.4.X was. Each driver was nearly its own 
console driver. We need to go one way or the other. 


 



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
