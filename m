From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: mode setting and console locking
Date: Sun, 16 May 2004 19:29:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517022938.48950.qmail@web14922.mail.yahoo.com>
References: <1084745020.6445.18.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPXso-00037C-HG
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 19:29:38 -0700
Received: from web14922.mail.yahoo.com ([216.136.225.6])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BPXso-0006PB-6E
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 19:29:38 -0700
In-Reply-To: <1084745020.6445.18.camel@gaston>
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
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

After about 100 reboots I have narrowed it down. The problem is coming from the
VT switch to get to XFree, not Xfree. I have a bare fbdev loaded on a secondary
device without a console attached to it. It should not be processing VT switches
but it is.

The bogus VT switch is causing it to restore garbage into the registers. When I
then set the mode from the xtern radeonfb gets hung in a loop in the write_pll
routine. The PLL write isn't completing because the chip state has been messed
up from the garbage restore.

I need to do more debugging to figure out why it is getting VT switch events.
How does a fbdev get notified of a VT switch?

The fbdev design is still broken. fbdev should not be touching the console
semaphore. The console semaphore should be handled in vga/fbconsole. If an fbdev
wants to protect against reentrancy each fbdev should have it's own semaphore
but printk is a console function and should be controlled from the console
driver, not the fbdev. An fbdev should function standalone and have no ties into
the VT system or console semaphore.

Think about the case of two or three video cards each with an fbdev loaded. It's
obvious then that an fbdev should have no ties to VT and console. 

What about this case?
x86 running vga console
then load fbdev

I think the fbdev should be inactive at this point. The only way to activate it
is to disable the vgacon. You can deactivate vgacon by loading fbcon or doing
something to move the console to a different device.

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Mon, 2004-05-17 at 01:25, Jon Smirl wrote:
> > I checked fbset from xterm on primary aty128fb, that works.
> > Then I checked fbset from xterm on radeon as my primary monitor, that
> worlks.
> > 
> > So it seems to be an interaction when the fbdev is a secondary device. The
> lock
> > up happens 100% of the time. Any ideas on what could be causing it?
> > 
> > Mode setting to CRT connected panel is broken every case I try.
> 
> I supose XFree and fbdev fighting each other, no ?
> 
> Ben.
> 
> 


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
