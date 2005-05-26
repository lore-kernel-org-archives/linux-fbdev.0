From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 4570] New: vesafb,
 Console goes black after some time of inactivity, but does not put monitor
 in standby
Date: Thu, 26 May 2005 00:12:20 -0700
Message-ID: <20050526001220.150b1835.akpm@osdl.org>
References: <20050501142120.0978d2f9.akpm@osdl.org>
	<Pine.LNX.4.62.0505021123180.28949@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbCYP-0001wK-Oe
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 00:13:17 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DbCYO-0006Iy-7w
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 26 May 2005 00:13:17 -0700
In-Reply-To: <Pine.LNX.4.62.0505021123180.28949@numbat.sonytel.be>
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
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bonbons67@internet.lu, linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Sun, 1 May 2005, Andrew Morton wrote:
> > Begin forwarded message:
> > 
> > Date: Sun, 1 May 2005 13:16:17 -0700
> > From: bugme-daemon@osdl.org
> > To: bugme-new@lists.osdl.org
> > Subject: [Bugme-new] [Bug 4570] New: vesafb, Console goes black after some time of inactivity, but does not put monitor in standby
> > 
> > 
> > http://bugme.osdl.org/show_bug.cgi?id=4570
> > 
> >            Summary: vesafb, Console goes black after some time of
> >                     inactivity, but does not put monitor in standby
> >     Kernel Version: 2.6.*
> >             Status: NEW
> >           Severity: normal
> >              Owner: jsimmons@infradead.org
> >          Submitter: bonbons67@internet.lu
> > 
> > 
> > Distribution: Gentoo 
> > Hardware Environment: 
> >     Does not matter, all my computers have same problem 
> > Software Environment: 
> > Problem Description: 
> > After some time of inactivity the console goes black, but does not put monitor   
> > into standby mode (this works in X with driver for the card, have not tried  
> > with vesa driver in X) 
> > What I would expect is that the monitor is put in stand-by when the console  
> > goes blank. (Tweaking with fbset does not help) 
> >  
> > Steps to reproduce: 
> > Work on linux console (not under X ;-)), then keep away from keyboard/mouse 
> > for some time.
> 
> man setterm(1).
> 
> Does it work if you don't use vesafb, but the plain VGA text console?
> 

Did we hear back on any of this?  Is the bug still present in 2.6.12-rc5?


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
