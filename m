From: Kronos <kronos@people.it>
Subject: Re: [PATCH] radeonfb: DDC i2c fix
Date: Sat, 12 Mar 2005 02:06:13 +0100
Message-ID: <20050312010613.GA14837@dreamland.darkstar.lan>
References: <1110519970.5751.17.camel@gaston> <20050311201326.GA7379@dreamland.darkstar.lan> <1110585137.5751.122.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9v4W-00038M-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 17:05:40 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9v4V-0002eC-2o
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 17:05:40 -0800
Content-Disposition: inline
In-Reply-To: <1110585137.5751.122.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@people.it>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

Il Sat, Mar 12, 2005 at 10:52:17AM +1100, Benjamin Herrenschmidt ha scritto: 
> On Fri, 2005-03-11 at 21:13 +0100, Kronos wrote:
> > Il Fri, Mar 11, 2005 at 04:46:10PM +1100, Benjamin Herrenschmidt ha scritto: 
> > > The radeonfb code for DDC probing (like it's X.org counterpart) uses to
> > > leave the DDC clock & data lines asserted after the probing is complete.
> > > This causes problems with some Apple monitors like the new Cinema HD
> > > 23", who will turn themselves off when that happens. This fixes it.
> > 
> > Fix is correct, but comment is not ;) After the loop SCL and SDA are
> > left low. Pulling them high puts the I2C bus in the stop condition.
> 
> Well, they are pull-up lines. I'm not pulling them high per-se, I'm
> "releasing" them to their natural state, which is high ;) The ATI code
> does some weird shit around the i2c transfer proper, and I don't know
> exactly why.

When I wrote that code I asked a clarification from ATI (IIRC I spoke
with Hui Yu) and they said that it was needed to cover some strange
corner case.
My tests showed that I was able to read EDID even without that black
magic but since the code originated from ATI I left it in place.

> I don't have any spec about DDC2 though, my understand is
> that it's more than just i2c EEPROM though.

I don't have DDC2 spec because VESA.org prices are too high... but I
know that it's based on I2C protocol and it follows I2C format (ie.
start-stop sequencies and so on).
AFAIK for EDID initiating a read at the right address is enough, but
DDC2 is meant to be bi-directional to control brightness, contrast, you
name it. I'm clueless on this part of DCC2.

Luca
-- 
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
