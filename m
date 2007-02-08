From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 8 Feb 2007 17:56:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702081756270.7686@pentafluge.infradead.org>
References: <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
	<20070205201824.GA13431@dreamland.darkstar.lan>
	<cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
	<Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
	<20070207234837.GA27822@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFDWA-0004fq-Np for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 09:57:11 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFDW7-0002EG-Ag
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 09:57:10 -0800
In-Reply-To: <20070207234837.GA27822@dreamland.darkstar.lan>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org


> > There is no stand alone nvidia card i2c driver. Its the issue of sharing 
> > device interfaces with the same hardware problem again!!! 
> 
> Nah, nvidiafb registers the I2C busses, you can drive them with whatever
> you want through the devices exported by I2C core.
> The fact the none of them work makes me think that the EDID is coming
> from the BIOS, we do VBE calls in real mode during early kernel setup.

What I meant is we can't load the i2c code seperate from the fbdev driver.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
