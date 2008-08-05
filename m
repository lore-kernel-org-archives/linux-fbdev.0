From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: kernel oops with framebuffer device vt8623fb
Date: Tue, 5 Aug 2008 09:12:29 -0700
Message-ID: <20080805091229.a613d423.akpm@linux-foundation.org>
References: <487E2911.5090701@gmx.net>
	<20080717013917.GA1695@localhost.localdomain>
	<20080728204817.ebaa621b.akpm@linux-foundation.org>
	<489836D3.2050008@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQP9X-0005mb-Rj for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:12:52 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQP9W-0000KP-H7
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Aug 2008 09:12:51 -0700
In-Reply-To: <489836D3.2050008@chello.at>
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
To: alois.klingler@chello.at
Cc: linux-fbdev-devel@lists.sourceforge.net, MadLoisae@gmx.net, linux-kernel@vger.kernel.org, Alexey@sc8-sf-spam2.sourceforge.net, Dobriyan <adobriyan@gmail.com>

On Tue, 05 Aug 2008 13:17:39 +0200 "alois.klingler@chello.at" <alois.klingler@chello.at> wrote:

> 
> Andrew Morton wrote:
> > On Thu, 17 Jul 2008 03:39:18 +0200 Ondrej Zajicek <santiago@crfreenet.org> wrote:
> >
> >   
> >> On Wed, Jul 16, 2008 at 07:00:02PM +0200, MadLoisae@gmx.net wrote:
> >>     
> >>> Hi!
> >>>
> >>> I've updated my machine from 2.6.25.11 to 2.6.26 and I think I've found 
> >>> a problem.
> >>>
> >>> If I load the module vt8623fb i get a kernel oops, if the VIA 8623 
> >>> display framebuffer driver is compiled direct into kernel the system 
> >>> hangs up very early at booting the kernel.
> >>>       
> >> I am sorry for mistake, here is a patch for 2.6.26 fixing the bug:
> >>
> >> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
> >>     
> >
> > I went back through the email thread and wrote your changelog for you. 
> > Not a very good one though.
> >
> > It would be better were you to write your changelogs, please.
> >
>
> Hi!
> 
> This issue is still not fixed in 2.6.26.1 - may be there a way to commit 
> it in 2.6.26.2?
> 
> Still, the provided patch I got on 07/17/2008 works great ...
> 
> Thanks, anyway!
> 
> kind regards, Alois
> 

(top-posting repaired)

The fix will be in my next batch for Linus.  It'll be merged this week.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
