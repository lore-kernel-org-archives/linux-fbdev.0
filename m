From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: please disconsider bl_mutex patch
Date: Sat, 15 Jul 2006 16:25:17 +0200
Message-ID: <20060715142517.GA30169@hansmi.ch>
References: <20060704015311.GJ27596@cathedrallabs.org>
	<44B8E204.30807@gmail.com>
	<20060715142242.GA4969@cathedrallabs.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1l5K-0001As-As for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 07:25:34 -0700
Received: from hansmi.home.forkbomb.ch ([213.144.146.165])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1l5H-0003wx-JS
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 07:25:34 -0700
Content-Disposition: inline
In-Reply-To: <20060715142242.GA4969@cathedrallabs.org>
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
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

Hello

On Sat, Jul 15, 2006 at 11:22:42AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > > 	just noticed that the bl_mutex removal from nvidiafb_blank() is
> > > 	wrong. while at that, noticed that recursive bl_mutex retrieval
> > > 	is also present at least on aty128fb and riva. checking how to
> > > 	fix it properly now.

> > What's the status of this patch?
> Michael Hanselmann is working in an improved version. How's the status
> on this Michael?

In mainline since a few days.

Commit:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e01af0384f54023b4548b7742952da2ffcafd4cd

Greets,
Michael

-- 
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/
The prayer of serenity applies here.  To both of us.  :-)
             -- Larry Wall in <199710141802.LAA22443@wall.org>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
