From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge,
	updated
Date: Sun, 25 Feb 2007 05:04:28 +0800
Message-ID: <1172351068.4415.1.camel@daplas>
References: <20070209193405.GB2637@localhost.localdomain>
	<1172102733.4217.38.camel@daplas>
	<20070223124557.GA13443@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HL41s-0005qp-Ja for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 13:02:05 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HL41s-0005FS-0j
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Feb 2007 13:02:04 -0800
Received: by py-out-1112.google.com with SMTP id a29so455899pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 24 Feb 2007 13:02:03 -0800 (PST)
In-Reply-To: <20070223124557.GA13443@localhost.localdomain>
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
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On Fri, 2007-02-23 at 13:45 +0100, Ondrej Zajicek wrote:
> On Thu, Feb 22, 2007 at 08:05:33AM +0800, Antonino A. Daplas wrote:
> > On Fri, 2007-02-09 at 20:34 +0100, Ondrej Zajicek wrote: 
> > > This patch adds driver for S3 Trio / S3 Virge. Driver is tested
> > > with most versions of S3 Trio and S3 Virge, on i386.
> > > It is tested both as compiled-in and module. It is against
> > > linux-2.6.20 .
> > > 
> > > This is version 3. There are some minor modifications from version 2
> > > (mostly coding style cleanups).
> > 
> > Nice, the first driver to use tileblit :-)
> > 
> > Since this driver is already in the -mm tree, can you resubmit a diff
> > against that? 
> 
> This driver was removed from -mm tree, because it is in 2.6.21-rc1 .
> So it is probably unnnecessary to resubmit a diff, isn't it?
> 

Okay, I thought the one in the tree was an older version. Thanks for
clarifying.

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
