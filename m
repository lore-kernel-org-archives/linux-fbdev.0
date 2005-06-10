From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Re: [2.6.11 Permedia-2 Framebuffer] driver
 broken (?).
Date: Fri, 10 Jun 2005 07:30:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0506100729380.4903@poirot.grange>
References: <XFMail.20050609153553.jim.hague@acm.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgnV1-00074x-Ij
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 10:40:55 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DgnUz-0006eW-9q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Jun 2005 10:40:55 -0700
In-Reply-To: <XFMail.20050609153553.jim.hague@acm.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 9 Jun 2005, Jim Hague wrote:

> > Confirmed - with CONFIG_FB_PM2_FIFO_DISCONNECT fb is still orange, without 
> > - no problem.
> 
> I've just acquired a GLoria Synergy+ off EBay, and you'll be glad to hear it is
> showing the same symptoms that you're seeing. Booting with FIFO_DISCONNECT gies
> orange text on black background, 640x480, ignoring the requested video mode.
> Depending on the phase of the moon, the 3c905 can't read it's MAC address or
> the sound card driver fails to start.
> 
> Switching off FIFO_DISCONNECT turns the text white, *but* the other problems
> persist for me. There's definitely something quite horrible going on. I will be
> investigating when I get the time.

Cool! Good luck!

Guennadi
---
Guennadi Liakhovetski



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
