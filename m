From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Thu, 3 Jun 2004 23:07:08 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406032307.08205.adaplas@hotpop.com>
References: <20040603024412.GE20951@havoc.gtf.org> <40BEF4ED.7090909@winischhofer.net> <1086269209.40bf27191fe1c@mail.theboonies.us>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVtoK-0005lL-1j
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 08:07:16 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BVtoJ-00006X-KB
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Jun 2004 08:07:15 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 01D7D57D93D
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  3 Jun 2004 14:32:59 +0000 (UTC)
In-Reply-To: <1086269209.40bf27191fe1c@mail.theboonies.us>
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
To: David Eger <eger-dated-1086874014.cda599@theboonies.us>, David Eger <eger-sender-da68b9@theboonies.us>, Thomas Winischhofer <thomas@winischhofer.net>
Cc: David Eger <eger@havoc.gtf.org>, linux-fbdev-devel@lists.sourceforge.net

On Thursday 03 June 2004 21:26, David Eger wrote:
> Quoting Thomas Winischhofer <thomas@winischhofer.net>:
> > David Eger wrote:
> > > The following patch updates sisfb for the new fb accel capabilities
> > > patch I'm sending upstream.  By default, this patch will rely on your
> > > copyarea() and fillrect() accel functions instead of the panning.
> >
> > Could you give me any hint why this should be faster than panning?
>
> The logic to prefer copyarea()/fillrect() to panning is in the main patch. 
> If panning is faster than using these for most cards, then the default when
> both are available should be panning as you say.  But I'll need numbers to
> determine that ;-)  I think many drivers just map a chunk of video ram just
> big enough for the requested resolution, so panning does zero for them :-/

I have benchamarked them before (sometime last year).  Panning (with vyres at 
least 2x yres) is significantly faster than without panning.  If I remember 
correctly, I tested at 1024x768, 8bpp, vyres = 4*yres, all drawing functions 
are accelerated.  Without panning, 'time cat /usr/src/linux/Documentation' 
finished in around 2 seconds.  With panning, it was done in 0.5 sec.

And if vyres = yres, then the driver should disable the panning/wrapping flag.  
Or fbcon should at least recognize that panning may be impossible or not very 
efficient if vyres < yres*2.

>
> > 1) fillrect and copyarea WERE (resp. ARE) being called here despite your
> > previous statement that they were not. Fillrect is used to clear every
> > line after pressing enter, and copyrect was used to copy the buffer to
> > the start of the virtual screen when the end was reached.)
>
> bizarre.  For radeonfb, fillrect() was called to clear the last line as you
> say, but copyarea() never was.  I'll have to dig back through the old code
> to really grok your statement.

Yes, this is true.  Once you've scrolled down to the end of virtual memory, 
the last screenful of data will be copied to the beginning of the 
framebuffer.  Then the whole scrolling process starts all over again. 

(This is what I was trying to point out before, panning will always involve a 
copyarea.  Also, instead of copying, maybe  the last screenful of data can be 
redrawn.  Advantage to framebuffers which has panning but with slow fb reads.  
Currently, the latter is not available).
  
Tony




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
