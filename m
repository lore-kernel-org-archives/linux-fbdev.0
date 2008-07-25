From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] eink_apollofb: new driver for
 Apollo eInk controller.
Date: Fri, 25 Jul 2008 16:35:57 -0700
Message-ID: <20080725163557.ea286ee2.akpm@linux-foundation.org>
References: <1215787849-25580-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-1-git-send-email-jekhor@gmail.com>
	<1215788071-25764-2-git-send-email-jekhor@gmail.com>
	<20080712192013.1fb9519b.akpm@linux-foundation.org>
	<45a44e480807122002uaf7e452n563c42e186c944a1@mail.gmail.com>
	<87iqvaasc8.fsf@frontier.dottedmag.net>
	<45a44e480807131203s6f4ad6dfn507b6a1f22972b7@mail.gmail.com>
	<20080713191928.GA23528@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KMWpW-0004jw-1v for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jul 2008 16:36:10 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KMWpR-0005uu-G5
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 25 Jul 2008 16:36:05 -0700
In-Reply-To: <20080713191928.GA23528@jeknote.loshitsa1.net>
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
To: Yauhen Kharuzhy <jekhor@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jayakumar.lkml@gmail.com

On Sun, 13 Jul 2008 22:19:28 +0300
Yauhen Kharuzhy <jekhor@gmail.com> wrote:

> On Mon, Jul 14, 2008 at 03:03:05AM +0800, Jaya Kumar wrote:
> > On Sun, Jul 13, 2008 at 8:20 PM, Mikhail Gusarov
> > <dottedmag@dottedmag.net> wrote:
> > > Twas brillig at 11:02:29 13.07.2008 UTC+08 when jayakumar.lkml@gmail.com did gyre and gimble:
> > >
> > >  JK> However, I should point out that hecubafb is a driver for this same
> > >  JK> apollo controller.
> > >
> > > AFAICT from the diff, eink_apollofb already includes all the features of
> > > hecubafb, so that would be just renaming. Is it worth it?
> > >
> > > --
> > >
> > 
> > Hi Mikhail,
> > 
> > Looking at the posted code, it is the same code as hecubafb, renamed,
> > and with the 2-bit, partial update, and flash features added.
> Hardware abstraction layer (with platform_device framework) and rotation also :)
> 
> > The new
> > features are good but basically, its a fork of hecubafb. I'm
> > suggesting that rather than doing that, it would make more sense to
> > add those features to the existing hecubafb code. If any help is
> > needed in making that happen, please let me know, I'm happy to help.
> 
> I am agreed. I saw 'Apollo' name more frequently than any other, but
> it is not a matter of principe.
> 

I agree that having a separate-but-similar driver for the same hardware
is most undesirable.

I presently have
eink_apollofb-new-driver-for-apollo-eink-controller.patch on "hold"
status, waiting for some resolution here.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
