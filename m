From: David Miller <davem@davemloft.net>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 12:35:14 -0800 (PST)
Message-ID: <20070302.123514.35465791.davem@davemloft.net>
References: <20070301184531.b3aeafe3.akpm@linux-foundation.org>
	<87tzx35zkc.fsf@sycorax.lbl.gov>
	<20070302122920.a2967ebf.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNETG-0007I2-Kv for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:35:18 -0800
Received: from [74.93.104.97] (helo=sunset.davemloft.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNETG-0006uT-7O
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:35:18 -0800
In-Reply-To: <20070302122920.a2967ebf.akpm@linux-foundation.org>
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
To: akpm@linux-foundation.org
Cc: rpurdie@rpsys.net, romosan@sycorax.lbl.gov, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 2 Mar 2007 12:29:20 -0800

> On Fri, 02 Mar 2007 09:24:03 -0800
> Alex Romosan <romosan@sycorax.lbl.gov> wrote:
> 
> > Andrew Morton <akpm@linux-foundation.org> writes:
> > 
> > > On Wed, 28 Feb 2007 08:32:43 -0800
> > > Alex Romosan <romosan@sycorax.lbl.gov> wrote:
> > >
> > >> the backlight on my thinkpad still (2.6.20 worked fine) doesn't come
> > >> on if i have the radeon backlight enabled. without it, i guess it's
> > >> the ibm acpi modules that controls the backlight and it seems to work
> > >> fine.
> > >> 
> > >
> > > Unclear. Are you saying that the backlight comes on OK if you use
> > > the IBM acpi module?
> > 
> > yes, if i disable the radeon backlight and use the ibm acpi module,
> > than the backlight works. if i enable the radeon backlight, the screen
> > stays dark and i can't turn it on (i tried using radeontool to control
> > it but nothing happened).
> 
> Richard, is this actually a bug, or is it a config error or something like that?
> 
> And should we track it as a post-2.6.20 regression?

Why don't we compromise for 2.6.21 by marking the Radeon backlight
stuff EXPERIMENTAL until the cases where IBM ACPI works and the
Radeon backlight stuff does not are worked out?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
