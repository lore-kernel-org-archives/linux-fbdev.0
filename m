From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fglrx + radeonfb leads to crashes?
Date: Thu, 18 Mar 2004 11:26:31 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1079569590.909.12.camel@gaston>
References: <200403172018.i2HKI5E0002012@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3laW-0006XP-0U
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:40:44 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B3laS-0005sy-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 16:40:41 -0800
In-Reply-To: <200403172018.i2HKI5E0002012@napali.hpl.hp.com>
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
To: davidm@hpl.hp.com
Cc: ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2004-03-18 at 07:18, David Mosberger wrote:
> Hi Ani,
> 
> I have a machine here with an ATI FireGL Z1 card.  It works fine with
> the ATI fglrx binary-only driver on 2.6.5-rc1.  However, if radeonfb
> is enabled and I try to stop the X server or switch away from it to
> another virtual console, then the screen display gets all messed up
> and the machine gets stuck.  When this hapens, I periodically see this
> kind of message:
> 
>   radeonfb: FIFO Timeout !
> 
> Now, this is on ia64 machine so at this point I'm just wondering
> whether this problem also shows up on other machines.  If it's an
> ia64-specific problem, I can look into it.  Otherwise, I guess I'll
> just disable radeonfp for now.

This is a known problem. I'm not sure at this point what ATI binary
driver is doing, I think it messes up the card internal memory map,
among others, and it definitely doesn't restore things properly when
beeing switched out.

I only have PPC machines so I can't experiment with it myself though.
The "fix" might be as simple as restoring MC_FB_LOCATION,
MC_AGP_LOCATION and the various offset when re-initing the mode (the
latest fbdev will trigger a mode restore & engine reset when switching
out from a KD_GRAPHICS console).

Ben.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
