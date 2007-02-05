From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 0/7] RFC: Cell SPE
	logos
Date: Mon, 05 Feb 2007 13:14:11 +1100
Message-ID: <1170641652.2620.89.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
	<20070204133212.GA2032@elf.ucw.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HDtPG-0005Ym-5b for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Feb 2007 18:16:34 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+g0AKvdpyM7kwQD9m32TwlGwygiiBriyU=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HDtPE-0001rg-Ik
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Feb 2007 18:16:34 -0800
In-Reply-To: <20070204133212.GA2032@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sun, 2007-02-04 at 14:32 +0100, Pavel Machek wrote:
> Hi1
> 
> > I would like to hear your opinions about the patchset below (updated version
> > compared to yesterday, lkml added to the CC list).
> 
> Can you just blast these pictures from userspace? There's really no
> excuse to advertise SPEs from kernel....
> 
> What's next, I have powerful Intel graphics chipset in here, perhaps
> it is as powerful as SPE, shall I start adding little pictures for its
> pipelines?

By the same token, there is no excuse to have the logo code at all in
the kernel in the first place... it's cool though :-) And it's a config
option, so you don't have to have it....

Ben



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
