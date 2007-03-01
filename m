From: "Antonino Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH/RFC 2.6.20 1/2] fbdev,
	mm: Deferred IO support
Date: Fri, 2 Mar 2007 07:44:15 +0800
Message-ID: <b00ca3bd0703011544n6a9eccc8gfa9e44964bd68e9d@mail.gmail.com>
References: <20070225051312.17454.80741.sendpatchset@localhost>
	<20070301140131.GA6603@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMuwc-0004XG-18 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:44:19 -0800
Received: from nz-out-0506.google.com ([64.233.162.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMuwa-00005w-9x
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 15:44:17 -0800
Received: by nz-out-0506.google.com with SMTP id i11so1152115nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 01 Mar 2007 15:44:15 -0800 (PST)
In-Reply-To: <20070301140131.GA6603@linux-sh.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Paul Mundt <lethal@linux-sh.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 3/1/07, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Feb 25, 2007 at 06:13:12AM +0100, Jaya Kumar wrote:
> > This patch implements deferred IO support in fbdev. Deferred IO is a way to
> > delay and repurpose IO. This implementation is done using mm's page_mkwrite
> > and page_mkclean hooks in order to detect, delay and then rewrite IO. This
> > functionality is used by hecubafb.
> >
> Any updates on this? If there are no other concerns, it would be nice to
> at least get this in to -mm for testing if nothing else.

The driver is already in the -mm tree.

>
> Jaya, can you roll the fsync() patch in to your defio patch? There's not
> much point in keeping them separate.

The fsync() patch was not included by Jaya, I believe.

Tony

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
