From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] fbdev: uvesafb driver
Date: Sat, 23 Jun 2007 16:36:39 -0700
Message-ID: <20070623163639.f6b4f20d.akpm@linux-foundation.org>
References: <20070623105243.GD12623@spock.one.pl>
	<20070623113557.f0295218.akpm@linux-foundation.org>
	<20070623232033.GB7148@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I2F9x-0007hN-Ng for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 16:36:53 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I2F9w-0004Jm-G8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Jun 2007 16:36:53 -0700
In-Reply-To: <20070623232033.GB7148@spock.one.pl>
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
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 24 Jun 2007 01:20:33 +0200 Michal Januszewski <spock@gentoo.org> wrote:

> > > +config FB_UVESA
> > > +	tristate "Userspace VESA VGA graphics support"
> > > +	depends on FB && CONNECTOR
> > 
> > These dependencies are insufficient.
> 
> What exactly is missing here?  A dep on X86?

Yes.  From your other comments it appears that a dependency on X86_32 is
needed.

>  This would indicate the
> arches on which the driver has actually been tested.  But which arches
> are supported and which aren't is, in the end, up to the userspace helper.

The other architectures won't compile: they don't have mtrr.h

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
