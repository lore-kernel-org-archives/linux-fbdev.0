From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: still ..Confused about atyfb and M1
Date: Fri, 06 Feb 2004 09:57:34 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076021854.8483.119.camel@gaston>
References: <Pine.LNX.4.44.0401302147390.22830-100000@phoenix.infradead.org>
	 <401FF39B.7090406@bitworks.com>
	 <Pine.GSO.4.58.0402041003560.20790@waterleaf.sonytel.be>
	 <40210CEA.5080102@bitworks.com>
	 <Pine.GSO.4.58.0402041634100.22483@waterleaf.sonytel.be>
	 <4022838A.8010502@bitworks.com>
	 <Pine.GSO.4.58.0402052114480.20594@waterleaf.sonytel.be>
	 <4022B783.8070002@bitworks.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AosTY-0001DE-E7
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 15:00:00 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AosTX-0004Xr-Om
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 Feb 2004 15:00:00 -0800
In-Reply-To: <4022B783.8070002@bitworks.com>
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
To: RSmith@bitworks.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2004-02-06 at 08:37, Richard Smith wrote:
> Geert Uytterhoeven wrote:
> 
> >>>1002:4c4d
> >>
> >>Wonder why your device ID is differnet than mine.  Can you send me a
> >
> > Because mine is AGP and yours is PCI?
> 
> Should not matter.  Chip has both interfaces on it and AGP is just PCI 
> with some additional signals.

No, ATI used to have both versions of the chip with different IDs

> >>'lspci -vv' of your M1?
> > I can, but not right now. If the answer above doesn't satisfy you, just ask
> > again.
> > 
> 
> No rush. Im messing with a different project right now anyway.  But yes 
> I'd still like a -vv of your chip when you can.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
