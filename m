From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 2 Mar 2007 12:29:20 -0800
Message-ID: <20070302122920.a2967ebf.akpm@linux-foundation.org>
References: <87ps7uutsk.fsf@sycorax.lbl.gov>
	<20070301184531.b3aeafe3.akpm@linux-foundation.org>
	<87tzx35zkc.fsf@sycorax.lbl.gov>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HNENZ-0006f2-6S for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:29:25 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HNENX-0007ug-Sh
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 02 Mar 2007 12:29:25 -0800
In-Reply-To: <87tzx35zkc.fsf@sycorax.lbl.gov>
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
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Richard Purdie <rpurdie@rpsys.net>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 02 Mar 2007 09:24:03 -0800
Alex Romosan <romosan@sycorax.lbl.gov> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Wed, 28 Feb 2007 08:32:43 -0800
> > Alex Romosan <romosan@sycorax.lbl.gov> wrote:
> >
> >> the backlight on my thinkpad still (2.6.20 worked fine) doesn't come
> >> on if i have the radeon backlight enabled. without it, i guess it's
> >> the ibm acpi modules that controls the backlight and it seems to work
> >> fine.
> >> 
> >
> > Unclear. Are you saying that the backlight comes on OK if you use
> > the IBM acpi module?
> 
> yes, if i disable the radeon backlight and use the ibm acpi module,
> than the backlight works. if i enable the radeon backlight, the screen
> stays dark and i can't turn it on (i tried using radeontool to control
> it but nothing happened).

Richard, is this actually a bug, or is it a config error or something like that?

And should we track it as a post-2.6.20 regression?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
