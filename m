From: David Eger <eger@havoc.gtf.org>
Subject: cirrusfb status report
Date: Tue, 15 Jun 2004 14:53:55 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040615185355.GA12307@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaJD4-0003Y0-RI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 12:03:02 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaJD4-0000B1-Do
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 12:03:02 -0700
Content-Disposition: inline
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
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

So I have the cirrus fb driver ported to 2.6, with a few caveats:

+ ZORRO is busted (don't have the hardware... once i get things nice
  on x86, I'll look about fixing ZORRO.  Hey geert - do you still have
  hardware to test this>?)
+ the only mode it likes is 640x480 (but then, that's the only one 
  i got working with the 2.4 driver, so, maybe that's not a regression...)
+ inserting it as a module just leaves crap all over the screen

I ended up doing a lot of things like 's/fb_info/cinfo/g' so the diff
is gonna look like the whole file, though I haven't (yet) changed any
of the actual register-writing logic.

Is there anyone else with cirrus logic video boards lying around who will
be interested in testing the new driver in a couple of days?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
