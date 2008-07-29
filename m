From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: kernel oops with framebuffer device vt8623fb
Date: Mon, 28 Jul 2008 20:48:17 -0700
Message-ID: <20080728204817.ebaa621b.akpm@linux-foundation.org>
References: <487E2911.5090701@gmx.net>
	<20080717013917.GA1695@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNgCp-0000KK-NU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 20:48:59 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNgCo-0005T9-GD
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 20:48:59 -0700
In-Reply-To: <20080717013917.GA1695@localhost.localdomain>
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
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: MadLoisae@gmx.net, linux-fbdev-devel@lists.sourceforge.net, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org

On Thu, 17 Jul 2008 03:39:18 +0200 Ondrej Zajicek <santiago@crfreenet.org> wrote:

> On Wed, Jul 16, 2008 at 07:00:02PM +0200, MadLoisae@gmx.net wrote:
> > Hi!
> > 
> > I've updated my machine from 2.6.25.11 to 2.6.26 and I think I've found 
> > a problem.
> > 
> > If I load the module vt8623fb i get a kernel oops, if the VIA 8623 
> > display framebuffer driver is compiled direct into kernel the system 
> > hangs up very early at booting the kernel.
> 
> I am sorry for mistake, here is a patch for 2.6.26 fixing the bug:
> 
> Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

I went back through the email thread and wrote your changelog for you. 
Not a very good one though.

It would be better were you to write your changelogs, please.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
