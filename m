From: Ondrej Zajicek <santiago@mail.cz>
Subject: Re: Framebuffer questions
Date: Thu, 16 Mar 2006 11:17:44 +0100
Message-ID: <20060316101744.GA3034@localhost.localdomain>
References: <20060315211022.GA4474@localhost.localdomain> <4418BD6A.9080600@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJpYH-0007pa-5E
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Mar 2006 02:17:53 -0800
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FJpYG-00025K-J9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Mar 2006 02:17:53 -0800
Received: from localhost.localdomain (feanorr.kolej.mff.cuni.cz [195.113.26.209])
	by smtp1.kolej.mff.cuni.cz (8.13.4/8.13.1) with ESMTP id k2GAHl2W071166
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Mar 2006 11:17:48 +0100 (CET)
	(envelope-from zajio1am@artax.karlin.mff.cuni.cz)
Received: from santiago by localhost.localdomain with local (Exim 4.50)
	id 1FJpY8-0000qc-R6
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Mar 2006 11:17:44 +0100
Content-Disposition: inline
In-Reply-To: <4418BD6A.9080600@gmail.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


Thank you for answers. Perhaps i found some time to write
some API documentation.

On Thu, Mar 16, 2006 at 09:20:42AM +0800, Antonino A. Daplas wrote:
> > - If i have to supply complete mode timings for videomode change
> >   why there is modedb.c and mode lines stored inside drivers?
> 
> Usually, these entries are used only on startup. Some drivers support
> built-in internal mode tables, some use standard algo's (GTF, CVT) to
> compute the mode timings. With these drivers, passing xres and yres is
> usually enough. 

So with these drivers it is not possible to set non-standard timings
(because other timing arguments are always ignored)? Or are there some
(standard or driver/specific) way to differentiate between set and
non-set additional timing arguments?

> > 
> > - What exactly is supposed to do FB_SYNC_BROADCAST ?
> > 
> 
> Use standard TV timings.

So it is rather equvalent to set standard TV timing values to appropriate
timing arguments and setting csync?

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
