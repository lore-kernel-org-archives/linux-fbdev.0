From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] broken cfb* support in the
Date: Thu, 22 Aug 2002 11:34:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221132230.9077-100000@maxwell.earthlink.net>
References: <212B36E116D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gull.mail.pas.earthlink.net ([207.217.120.84])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hwsF-0003Ih-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 11:40:03 -0700
In-Reply-To: <212B36E116D@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> Which new API?

The one being worked on for the last 2 years.

> If you are going to remove logo and unaccelerated fbcon-cfb*,
> then remove them completely. If you are not going to remove unaccelerated
> fbcon-cfb*, then there is no reason for breaking them.

The next set of round of changes will will reimplement drawing the penguin
and will support 24 bpp mode. So we will be able to remove fbcon-cfb*
completely the next round.

> I'm not going to remove unaccelerated code from the matroxfb. Never.

Then implement your own soft accel functions.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
