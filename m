From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-rc5-mm4
Date: Tue, 3 Apr 2007 15:51:35 -0700
Message-ID: <20070403155135.ff7f3043.akpm@linux-foundation.org>
References: <20070402224745.71a25af7.akpm@linux-foundation.org>
	<20070404004005.2f21d514@werewolf-wl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HYrql-0002Gx-1N for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 15:51:39 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HYrqk-0006h6-Ne
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Apr 2007 15:51:39 -0700
In-Reply-To: <20070404004005.2f21d514@werewolf-wl>
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
To: "J.A. =?ISO-8859-1?Q?Magall=F3n ?=" <jamagallon@ono.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 4 Apr 2007 00:40:05 +0200
"J.A. Magall__n" <jamagallon@ono.com> wrote:

> On Mon, 2 Apr 2007 22:47:45 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.21-rc5/2.6.21-rc5-mm4/
> > 
> > - The oops in git-net.patch has been fixed, so that tree has been restored. 
> >   It is huge.
> > 
> > - Added the device-mapper development tree to the -mm lineup (Alasdair
> >   Kergon).  It is a quilt tree, living at
> >   ftp://ftp.kernel.org/pub/linux/kernel/people/agk/patches/2.6/editing/.
> > 
> > - Added davidel's signalfd stuff.
> > 
> 
> Something strange happens to me with this kernel.
> Gnome Screensaver hangs the box. Locked solid, no atl-sysrq-raw,
> no ssh. Nada.
> Do not know if it's itself, or something in X dpms.
> 
> Somebody else ?
> 

Do you know what the particualr screensaver is trying to do?  Does it do
whizzy 3d graphics, or does it just blank the screen, or...  ?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
