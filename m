From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Wed, 28 Apr 2004 10:12:54 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083111174.20089.8.camel@gaston>
References: <Pine.LNX.4.44.0404280051480.23153-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIcml-0001yE-QS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:18:47 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIcml-0004oG-C0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 17:18:47 -0700
In-Reply-To: <Pine.LNX.4.44.0404280051480.23153-100000@phoenix.infradead.org>
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

On Wed, 2004-04-28 at 09:57, James Simmons wrote:
> > Nah, it's a lot easier to restore the state you need than to
> > save/restore everything. It's not even always possible to save/restore
> > everything (think: write only registers).
> 
> If this is true then it would be better if we have the below logic.
> 
> struct vc_data --> native driver layer --> fbdev.
> 
> instead of save/restore the var for each VC.

I think we are not understanding eachother....

The save/restore thing is a different matter than the var thing
altogether....

The var for each vc is simply having a different mode for each VC
and not relying on the doggy magic mode setting done by fbcon to
set a mode matching the VC size. fbcon is responsible for setting
the proper mode for each VC upon entry to that VC, and so with the
above, that mean just having a var per VC.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
