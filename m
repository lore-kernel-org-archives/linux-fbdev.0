From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdv/fbcon pending problems
Date: Wed, 25 Feb 2004 13:33:00 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077676380.1129.55.camel@gaston>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
	 <1077672591.978.49.camel@gaston>  <20040225021808.GB17390@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Avp62-0004Si-8S
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 18:48:26 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Avoku-0000Tr-Hd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 18:26:36 -0800
In-Reply-To: <20040225021808.GB17390@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Hmm, how does winxp and macosx get their respectives video modes,
> what is missing in fbdev for that? MacOSX always gives you valid modes
> including refresh rates per adaptor/monitor, WinXP always give you valid
> modes and valid refresh rates for the video card, you actually
> 'Apply' to test, most of the time it simply works.

They do the same as I described. As you wrote, it works most of the
time. That's the whole point. You submit a "proposed" configuration
and gets back something .... most of the time, you do get back what
you asked. But you _might_ not. In some cases, what will happen is
that the "other" head will be affected. For example, enabling
mirroring on a non-4.3 LCD laptop like a titanium powerbook while
having a 4.3 display (CRT) plugged on the second output will cause
the LCD to be resized to a 4.3 ratio in MacOS.
So in this case, you get _more_ than what you asked.

> Great! i think your idea is great, does that library will be xserver
> dependant or will be an independent lib so others projects like mine
> could benefit from it?  Any bits somewhere?  This alone could boom
> and revolutionize the graphics solutions for linux.  A step in the
> right direction for "World Domination" in the desktop field.

It's meant to be independant of anything else but the actual low
level driver model. Xserver would be one client, but others could
enter the game of course ;)

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
