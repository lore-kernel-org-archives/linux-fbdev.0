From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 03 Dec 2003 11:19:53 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1070410792.21174.83.camel@gaston>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>
	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARKl0-00026q-IY
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:20:42 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1ARKl0-0003V0-4V
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:20:42 -0800
In-Reply-To: <3FCD17D5.4040804@undead.cc>
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


> Little.  It's an single processor Athalon box.  I'll do the test later 
> tonight as I don't want to reboot the other machine at the moment.

Ok, so this isn't an endian problem in the cfb_ routines. Thanks.
I'll try to figure out what's up here as well later this week, I'm
a bit too busy with other things at the moment.

Ben.




-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
