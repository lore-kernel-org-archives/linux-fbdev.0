From: Kronos <kronos@people.it>
Subject: Re: [PATCH] radeonfb: DDC i2c fix
Date: Fri, 11 Mar 2005 21:13:26 +0100
Message-ID: <20050311201326.GA7379@dreamland.darkstar.lan>
References: <1110519970.5751.17.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9qVD-00039r-Vr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 12:12:55 -0800
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D9qVB-0001Ac-Kq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Mar 2005 12:12:55 -0800
Content-Disposition: inline
In-Reply-To: <1110519970.5751.17.camel@gaston>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Il Fri, Mar 11, 2005 at 04:46:10PM +1100, Benjamin Herrenschmidt ha scritto: 
> The radeonfb code for DDC probing (like it's X.org counterpart) uses to
> leave the DDC clock & data lines asserted after the probing is complete.
> This causes problems with some Apple monitors like the new Cinema HD
> 23", who will turn themselves off when that happens. This fixes it.

Fix is correct, but comment is not ;) After the loop SCL and SDA are
left low. Pulling them high puts the I2C bus in the stop condition.

Luca
-- 
Home: http://kronoz.cjb.net
Inquietudine sintetica
Solo, davanti all'ignoto
Tienimi stretto a te


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
