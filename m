From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 10:32:22 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404291030370.17712@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
 <20040428070832.GA23411@guug.org> <1083147416.18416.24.camel@thor.asgaard.local>
 <20040428163730.GA24448@guug.org> <1083191201.18413.73.camel@thor.asgaard.local>
 <1083195769.20089.106.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ6y5-0004io-TA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 01:32:29 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ6y5-0007CE-B8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 29 Apr 2004 01:32:29 -0700
In-Reply-To: <1083195769.20089.106.camel@gaston>
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
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 29 Apr 2004, Benjamin Herrenschmidt wrote:
> One of the ideas we had after discussing with Keith Packard that the
> model should be a library that deals with all the settings of the
> displays, the geometry of the desktop(s) (relative position of screens),
> modes, etc... That library would interface to the various drivers via

And it could also handle the blending of multiple planes (one fbdev per plane)?
In some sense blending (possibly scaled) planes is similar to the relative
position of screens.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
