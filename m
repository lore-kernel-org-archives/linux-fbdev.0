From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 03 Dec 2003 09:22:38 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1070403757.4300.75.camel@gaston>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARIvX-0004lW-QG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 14:23:27 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1ARIvX-0001HS-Ci
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 14:23:27 -0800
In-Reply-To: <3FCC4018.4020503@undead.cc>
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
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> I breifly tried it on one machine that had a Nvidia TNT2 in it and it 
> worked fine.   I just tried it on my 9200 and I get the magenta/cyan 
> thing as well. 

Little or big endian machine ? Rivafb is accelerated in 2.6 (radeonfb
is not). Can you check if that makes any difference ? I'll do some
more tests here to try to figure it out, but so far, XFree had proper
colors even when using radeonfb (UseFBDev set to "true").

Ben.





-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
