From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [directfb-dev] Re: [ANNOUNCE]: VM86 Daemon
Date: 01 Apr 2003 21:38:55 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049204274.1050.31.camel@localhost.localdomain>
References: <20030401040106.65664.qmail@web14906.mail.yahoo.com>
	<1049188090.1031.41.camel@localhost.localdomain> 
	<20030401120835.GA30421@skunk.convergence.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190M2k-0001Co-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 05:43:15 -0800
In-Reply-To: <20030401120835.GA30421@skunk.convergence.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Kendall Bennett <KendallB@scitechsoft.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DirectFB-devel <directfb-dev@directfb.org>

On Tue, 2003-04-01 at 20:08, Denis Oliver Kropp wrote:
>
> I'm wondering if there are plans to have /dev/fbX provide
> bus/device/function number for easier mapping. It's PCI related,
> but it would help fbDRI etc.
>

Not too sure about this.
 
> > > also be able to get the /dev/fb code into the kernel.
> > > Getting a driver in that creates /dev/vm86 is going to
> > > be harder. 
> > 
> > I would rather have the code rejected than back-dooring it behind fbdev.
> > If it's going to be accepted, it has to be on its own merit.
> 
> If vm86 doesn't (need to) know anything about the framebuffer drivers
> I would prefer an extra device, too.

Yes, /dev/vm86 is completely separate from /dev/fbX.

> 
> Why is it called /dev/vm86 if it's not restricted to x86?
> Sounds more like a /dev/firmwared or /dev/biosd.
> 

It actually started as /dev/vesafb.  It seems that it can still become
more generic.  There are at least 2 ideas on this though:

1.  Make primary protocol x86 encoded, and just let the daemon convert
it to something the backend will understand.  For example, VBE int 0x10
ax = 0x4f01 (Set Video mode), will be encoded by the daemon into another
protocol depending on the backend. This will be easy for /dev/vm86, hard
for the daemon.

2  Make /dev/vm86 also pass non-x86 requests.  This will be hard for
/dev/vm86, but easy for the daemon.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
