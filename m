From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] neofb patches
Date: Thu, 29 Apr 2004 11:20:20 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1083201619.21436.114.camel@gaston>
References: <Pine.LNX.4.44.0404271938330.20536-100000@phoenix.infradead.org>
	 <408EE34F.8080106@undead.cc> <1083107454.16544.42.camel@gaston>
	 <20040428002037.GE22495@guug.org> <1083112565.20473.10.camel@gaston>
	 <20040428070832.GA23411@guug.org>
	 <1083147416.18416.24.camel@thor.asgaard.local>
	 <20040428163730.GA24448@guug.org>
	 <1083191201.18413.73.camel@thor.asgaard.local>
	 <1083195769.20089.106.camel@gaston>  <20040429010612.GC24584@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJ0KP-0001nc-8L
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:27:05 -0700
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BJ0KN-0004CE-FY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 18:27:03 -0700
In-Reply-To: <20040429010612.GC24584@guug.org>
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
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> I would like to see that basic stuff being done in the kernel like
> mode setting.  The drivers should have a better idea of modes than
> libraries in userspace.

Not really. The driver can extract the EDID infos from the card,
but as far as building mode lists, at one point, we really want
that to be moved down to userspace. One of the problems is that
a lot of monitors have bogus EDID blocks. We need a mecanism to
provide "overrides" based on manufacturer/product ID for example,
I don't think it's something that should be in the kernel.

Also, for something like dbus notification of clients, userspace
is better suited.

Finally, the geometry of screens is something that has nothing to
do in the kernel imho.

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
