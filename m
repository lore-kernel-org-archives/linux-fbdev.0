From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Cbe-oss-dev] [PATCH 0/7] RFC: Cell SPE
	logos
Date: Wed, 7 Feb 2007 12:44:08 +0000
Message-ID: <20070207124408.GE4481@ucw.cz>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
	<20070204133212.GA2032@elf.ucw.cz>
	<1170641652.2620.89.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEmOV-0000EU-P5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 04:59:29 -0800
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEmOP-00029e-DH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 04:59:27 -0800
Content-Disposition: inline
In-Reply-To: <1170641652.2620.89.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Hi!

> > > I would like to hear your opinions about the patchset below (updated version
> > > compared to yesterday, lkml added to the CC list).
> > 
> > Can you just blast these pictures from userspace? There's really no
> > excuse to advertise SPEs from kernel....
> > 
> > What's next, I have powerful Intel graphics chipset in here, perhaps
> > it is as powerful as SPE, shall I start adding little pictures for its
> > pipelines?
> 
> By the same token, there is no excuse to have the logo code at all in
> the kernel in the first place... it's cool though :-) And it's a config
> option, so you don't have to have it....

I believe the old logo code was originally created for compatibility
with Solaris? :-).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
