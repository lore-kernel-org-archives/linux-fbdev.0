From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
	one works ;-)
Date: Tue, 27 Apr 2004 20:09:30 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083060569.16473.2.camel@gaston>
References: <Pine.LNX.4.44.0404240035400.5826-100000@phoenix.infradead.org>
	 <1083025364.11575.4.camel@gaston>
	 <Pine.GSO.4.58.0404271050540.14434@waterleaf.sonytel.be>
	 <Pine.LNX.4.58.0404271119001.31905@rosencrantz.theboonies.us>
	 <Pine.GSO.4.58.0404271156250.14434@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIPcJ-0008RP-5w
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 03:15:07 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BIPcI-0004sH-OR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 27 Apr 2004 03:15:06 -0700
In-Reply-To: <Pine.GSO.4.58.0404271156250.14434@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Eger <eger@theboonies.us>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-04-27 at 19:57, Geert Uytterhoeven wrote:

> var.accel_flags / FB_ACCELF_TEXT is something different: you need to be able to
> disable hardware acceleration before your application touches the accel engine.

That was true in 2.4, I don't think this can apply reasonably well in 2.6.
In fact, from experience, the var tends to be "lost" easily, I'm not sure
why exactly.

On the other hand, I tend to think that if you have a KD_TEXT console,
accel is under fbcon control, if you have a KD_GRAPHICS console, then
the accel engine is under you control. I don't think any else make any
sense in fact

We really need to simplify all of that stuff, it's way too messy at the
moment.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
