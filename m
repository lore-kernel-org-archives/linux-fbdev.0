From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 0/4] Cell SPE logos
Date: Wed, 25 Jul 2007 19:29:58 +0000
Message-ID: <20070725192957.GC10208@ucw.cz>
References: <20070716135550.010775000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE34k-0002ML-2U for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 06:08:18 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE34d-00049d-7l
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 06:08:17 -0700
Content-Disposition: inline
In-Reply-To: <20070716135550.010775000@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org

Hi!

> The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
> threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
> When booting Linux, 2 penguins logos are shown on the graphical console by
> the standard frame buffer console logo code.
> 
> To emphasize the existence of the SPEs (which can be used under Linux), we
> added a second row of (smaller) helper penguin logos, one for each SPE.

Does this belong in kernel?

It is kernel boot log, not random advertising place. Various splash
projects can get you any graphics you want...


						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
