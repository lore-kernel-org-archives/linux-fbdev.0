From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix switch from XFree
Date: Wed, 11 Feb 2004 09:13:42 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076451222.868.51.camel@gaston>
References: <1076409397.873.6.camel@gaston> <20040210110622.GA1913@lambda>
	 <1076411840.874.18.camel@gaston>  <20040210112820.GA2273@lambda>
	 <1076412661.874.21.camel@gaston>
	 <Pine.GSO.4.58.0402101334030.2261@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqg9A-0000Lj-ER
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 14:14:24 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aqg8z-0005IN-5l
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 14:14:13 -0800
In-Reply-To: <Pine.GSO.4.58.0402101334030.2261@waterleaf.sonytel.be>
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
Cc: Sven Luther <sven.luther@wanadoo.fr>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-02-10 at 23:34, Geert Uytterhoeven wrote:
> On Tue, 10 Feb 2004, Benjamin Herrenschmidt wrote:
> > > Or to use a different pipe, if the hardware provides accelerated context
> > > switching :)).
> >
> > Do we really care ? This is VT switch...
> 
> What about resetting the accel engine when switching from KD_GRAPHICS to
> KD_TEXT?

Did you read my original mail ? :)

With this patch, I force a set_par, which resets the mode and the engine
on a switch from a KD_GRAPHICS VT to a KD_TEXT VT. I don't do anything
at this point when the current console is switched from KD_GFX to KD_TEXT
without involving a VT swith as, afaik, there's no fbcon hook for that
at this point. (A hack would be possible, but I want to avoid it).

Ben.




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
