From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] radeonfb: DDC i2c fix
Date: Sat, 12 Mar 2005 10:52:17 +1100
Message-ID: <1110585137.5751.122.camel@gaston>
References: <1110519970.5751.17.camel@gaston>
	 <20050311201326.GA7379@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9tvs-0007mp-Pt
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 15:52:40 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D9tvq-00059o-Jg
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 15:52:40 -0800
In-Reply-To: <20050311201326.GA7379@dreamland.darkstar.lan>
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
To: Kronos <kronos@people.it>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Fri, 2005-03-11 at 21:13 +0100, Kronos wrote:
> Il Fri, Mar 11, 2005 at 04:46:10PM +1100, Benjamin Herrenschmidt ha scritto: 
> > The radeonfb code for DDC probing (like it's X.org counterpart) uses to
> > leave the DDC clock & data lines asserted after the probing is complete.
> > This causes problems with some Apple monitors like the new Cinema HD
> > 23", who will turn themselves off when that happens. This fixes it.
> 
> Fix is correct, but comment is not ;) After the loop SCL and SDA are
> left low. Pulling them high puts the I2C bus in the stop condition.

Well, they are pull-up lines. I'm not pulling them high per-se, I'm
"releasing" them to their natural state, which is high ;) The ATI code
does some weird shit around the i2c transfer proper, and I don't know
exactly why. I don't have any spec about DDC2 though, my understand is
that it's more than just i2c EEPROM though. It used to leave the 2 lines
"assserted" at the end of the transfer (after the last stop condition)
and that sounded wrong and causes the misbehaviour  on the Apple
display ...

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
