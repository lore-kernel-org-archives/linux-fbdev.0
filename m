From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: still ..Confused about atyfb and M1
Date: Thu, 5 Feb 2004 21:16:01 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
 <401FF39B.7090406@bitworks.com> <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
 <40210CEA.5080102@bitworks.com> <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
 <4022838A.8010502@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aopv6-0007IH-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 12:16:16 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aopv5-0001CW-LB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 12:16:16 -0800
In-Reply-To: <4022838A.8010502@bitworks.com>
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
To: Richard Smith <rsmith@bitworks.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 5 Feb 2004, Richard Smith wrote:
> Geert Uytterhoeven wrote:
> >>How much?  Are things like the ammount and type of RAM autodetected or
> >>just read from registers that the BIOS is supposed to set?
>
> > Atyfb reads them from the registers.
>
> So this is probally why all the values are jacked up.  They probally
> aren't set correctly to begin with.  I'll try hardcodeing them in the
> driver with what I think they should be.

You may have to program the memory control for the correct type of memory, too.

> > 1002:4c4d
>
> Wonder why your device ID is differnet than mine.  Can you send me a

Because mine is AGP and yours is PCI?

> 'lspci -vv' of your M1?

I can, but not right now. If the answer above doesn't satisfy you, just ask
again.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
