From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Tue, 24 Feb 2004 09:53:20 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077576800.28487.80.camel@gaston>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
	 <1077496550.5960.9.camel@gaston>
	 <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
	 <1077533958.5942.42.camel@gaston>
	 <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvPCB-0005YL-BD
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 15:09:03 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AvP4J-0007t4-Rw
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 15:00:55 -0800
In-Reply-To: <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Alexander Kern <alex.kern@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 
> That's OK, as long as entries <= 15.
> 
> Using this register you cannot check for more than 15. There's another register
> for that, and the difference between PRO and older is in that second register.

Ok. But we never wait for more than 15. when filling the HOST_DATA, we wait
for 1 for each long word (maybe that is wrong, it's definitely sub optimal),
and we wait for at most 6 afiak when setting up.

Ben.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
