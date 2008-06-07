From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Bugme-new] [Bug 10877] New: black screen
 when booting using vesafb
Date: Sat, 7 Jun 2008 10:26:45 +0200
Message-ID: <20080607102645.d46a5b5b.krzysztof.h1@poczta.fm>
References: <bug-10877-10286@http.bugzilla.kernel.org/>
	<20080606140907.bb35fc27.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4uDf-00086W-Ch for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:56:15 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4uDd-00009S-RW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 01:56:15 -0700
In-Reply-To: <20080606140907.bb35fc27.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: born.into.silence@gmail.com, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Fri, 6 Jun 2008 14:09:07 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
> 
> On Fri,  6 Jun 2008 13:54:30 -0700 (PDT)
> bugme-daemon@bugzilla.kernel.org wrote:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=10877
> > 
> >            Summary: black screen when booting using vesafb
(...)
> > Latest working kernel version: None
> > Earliest failing kernel version: 2.6.24
> > Distribution: gentoo
> > Hardware Environment: Asus m51se laptop
> > Software Environment:
> > Problem Description: Screen goes black when using vga=xxx setting on boot, but
> > the radeon HD 3470 is said to be vesa-compliant. Tested values : 791, 788, 791,
> > 789. System keeps booting (I can ssh the box)
> > 
> > Steps to reproduce: boot with vga=xxx
> 
> istr we've seen other reports of recent problems with vga=, but I don't
> recall the outcome?
> 

A similar bug is 10766 reported on Nvidia Geforce MX 440. I was not able to
reproduce it on cards I have. I will try more.

I was promised to borrow a laptop with GeForce MX 4x0 on board to test.

Regards,
Krzysztof


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
