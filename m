From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH 3/4] fbdev: uvesafb driver
Date: Sun, 24 Jun 2007 13:15:21 +0200
Message-ID: <20070624111521.GA8042@spock.one.pl>
References: <20070623105243.GD12623@spock.one.pl>
	<20070623113557.f0295218.akpm@linux-foundation.org>
	<20070623232033.GB7148@spock.one.pl>
	<20070623163639.f6b4f20d.akpm@linux-foundation.org>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I2Q45-0000nF-SB for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Jun 2007 04:15:33 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I2Q45-00064T-Dh
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Jun 2007 04:15:33 -0700
Content-Disposition: inline
In-Reply-To: <20070623163639.f6b4f20d.akpm@linux-foundation.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Jun 23, 2007 at 04:36:39PM -0700, Andrew Morton wrote:
> On Sun, 24 Jun 2007 01:20:33 +0200 Michal Januszewski <spock@gentoo.org> wrote:
> 
> > > > +config FB_UVESA
> > > > +	tristate "Userspace VESA VGA graphics support"
> > > > +	depends on FB && CONNECTOR
> > > 
> > > These dependencies are insufficient.
> > 
> > What exactly is missing here?  A dep on X86?
> 
> Yes.  From your other comments it appears that a dependency on X86_32 is
> needed.

X86_32 is only needed for a bunch of specific operations that make use of
the PMI.  The driver can work without those (it has already been tested
on X86_64, where PMI cannot be used).
 
> >  This would indicate the
> > arches on which the driver has actually been tested.  But which arches
> > are supported and which aren't is, in the end, up to the userspace helper.
> 
> The other architectures won't compile: they don't have mtrr.h

That was my mistake of not putting the mtrr.h include inside a #ifdef
CONFIG_MTRR.  After fixing that and a few other things you pointed out
in your previous message, I was able to successfully compile uvesafb for
PPC (using a cross-compiler).

Best regards,
Michal


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
