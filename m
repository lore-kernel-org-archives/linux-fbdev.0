From: David Eger <eger@havoc.gtf.org>
Subject: Re: cirrusfb status report
Date: Thu, 17 Jun 2004 15:54:30 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617195430.GA4682@havoc.gtf.org>
References: <20040615185355.GA12307@havoc.gtf.org> <Pine.LNX.4.56.0406152328230.4653@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb2y5-00022e-TZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 12:54:37 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb2y5-0003Jh-K8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 12:54:37 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406152328230.4653@pentafluge.infradead.org>
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
To: jsimmons@pentafluge.infradead.org
Cc: Jeff Garzik <garzik@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Jun 15, 2004 at 11:28:38PM +0100, jsimmons@pentafluge.infradead.org wrote:
> 
> I just bought this card so I'm willing to give it a try.

The cirrusfb driver is for some old cards.  Garage sale? ;-)
I finally tracked down a screen corruption issue.. you have to wait
till BLT's are done to do a pan().  This probably affects 2.4 as well.

The patch is at:

http://www.yak.net/random/fbdev-patches/cirrusfb-2.6-update.patch

ZORRO is still busted, and my monitor freaks out when I try anything
but 640x480x8.  Is this something that modedb could help out with?
If you can figure it, I'd gladly accept a patch for it :-D

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
