From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] neofb patches
Date: Wed, 28 Apr 2004 10:27:46 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281026410.3644@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
 <20040428070832.GA23411@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkQ9-0002IS-3S
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:27:57 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkQ8-00073s-LD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:27:56 -0700
In-Reply-To: <20040428070832.GA23411@guug.org>
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
To: Otto Solares <solca@guug.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, Otto Solares wrote:
> I currently have now.  I like the fbdev abstraction but it has
> too many limitations:
>
> - It should exist a field in the fixed info for the bus_id, so
>   intelligent apps will realize which card is attached to a fbdev.

Should be fixed soon with sysfs in 2.6.

> C'mon James, Ben, Geert, driver writers, let's fix the layer!

Time, time, time...

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
