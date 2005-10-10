From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: VESA, EDID & flat panels
Date: Mon, 10 Oct 2005 15:50:46 +1000
Message-ID: <1128923447.17365.117.camel@gaston>
References: <1128380013.8267.125.camel@gaston>
	 <8a0c36780510031618m48c55f45u648d867bcf0130d2@mail.gmail.com>
	 <1128397436.31063.0.camel@gaston> <434220D0.3020101@gmail.com>
	 <1128407961.31063.50.camel@gaston> <43423666.8090001@gmail.com>
	 <1128415836.6291.12.camel@gaston>
	 <8a0c36780510040535g16a3074p66384d8b07d03ea1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOqbV-0004Uf-IA
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 22:53:41 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EOqbb-0001PY-GP
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 09 Oct 2005 22:53:48 -0700
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j9A5igWG032577
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Oct 2005 00:44:43 -0500
In-Reply-To: <8a0c36780510040535g16a3074p66384d8b07d03ea1@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, 2005-10-04 at 07:35 -0500, Richard Smith wrote:
> > So I wonder how widespread really is that EEDID stuff... I'm afraid the
> > reason a lot of monitors come with a windows install CD is that they do
> > _not_ provide those infos via EDID, but windows has a database with
> > per-monitor infos (as Apple actually has in OS X) and we should probably
> > do something similar. (but not in the kernel)
> 
> Our experience agrees with you that the EEDID stuff is not well used. 
> We make some LCD driver products and I'm pretty sure we didn't include
> the EEDID info.
> 
> I gave the specs a quick look and I don't see anything in (thats
> obvious) there that would allow you to see if the panel is 666 or 888.
> The specs are somewhat less than clear in several cases so I'll be
> happy to review any sections closer if you think one might be a
> possibility.

Look at the EDID EXTENSIONS spec. Extension 0x40 contains the panel
component bit definition iirc. I found so far only one monitor that
implemented that extended block (the Apple 23" Cinema HD display) but
the content seem to be junk =P

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
