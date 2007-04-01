From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbdev sysfs imrovements
Date: Sat, 31 Mar 2007 18:24:00 -0700
Message-ID: <20070331182400.317728d7.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
	<20070326195807.184474d7.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0704010156001.5314@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HXonu-0001Dp-R4 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 18:24:23 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HXont-0000SV-94
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 31 Mar 2007 18:24:22 -0700
In-Reply-To: <Pine.LNX.4.64.0704010156001.5314@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, airlied@linux.ie, greg@kroah.com, linux-kernel@vger.kernel.org, geert@linux-m68k.org

> On Sun, 1 Apr 2007 01:56:28 +0100 (BST) James Simmons <jsimmons@infradead.org> wrote:
> 
> I can't seem to duplicate this error.

OK, I'll poke at it some more.

>  Do you have any patches applied to 
> the nvidia driver?

I don't think so - whatever's in -mm.

> On Mon, 26 Mar 2007, Andrew Morton wrote:
> 
> > On Tue, 20 Mar 2007 14:25:49 +0000 (GMT) James Simmons <jsimmons@infradead.org> wrote:
> > 
> > > This patch does several things to allow the underlying hardware to be 
> > > shared amount many devices. The most important thing is the use of
> > > the created device via device_create instead of the hardware device. No 
> > > longer should fbdev drivers use the xxx_set_drvdata with the parent
> > > bus device. The second change is having a bus independent power management
> > > for the framebuffer driver. The final change is using the release method 
> > > to cleanup the device. The reason again is to make the fbdev driver 
> > > independent of the bus parent device. Feedback is welcomed.
> > 
> > Causes an early crash on the powermac G5.
> > 
> > http://userweb.kernel.org/~akpm/s5000489.jpg (the oops is the usual powerpc
> > mess)
> > 
> > config at http://userweb.kernel.org/~akpm/config-g5.txt
> > 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
