From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Thu, 29 Apr 2004 09:31:51 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083195110.29596.101.camel@gaston>
References: <Pine.LNX.4.44.0404281746550.1187-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIydL-0006Im-9x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:38:31 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIydK-00065E-KD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 16:38:30 -0700
In-Reply-To: <Pine.LNX.4.44.0404281746550.1187-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-04-29 at 02:48, James Simmons wrote:
> > > Agreed. We need a per-VT var.
> > > 
> > > The way I see it (and have always seen it), fbcon implements a text console _on
> > > top of_ fbdev, just like vgacon implements a text console on top of the VGA
> > > hardware. Not the other way around!
> > 
> > Then I must say we are in violent agreement :)
> 
> How do you feel about using modedb handling in fbcon. Let me create this 
> patch and test it out. If it works then we can resolve this issue.

No, no, no...

First, we would have to fix all drivers to properly probe monitors or
provide some valid monitor data for things that cannot be probed. Then,
I don't think modedb is really an fbcon matter. I completely agree with
Geert here, I think the current scheme is backward.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
