From: Kronos <kronos@people.it>
Subject: Re: [2.6.10-rc2] Regression in cursor code
Date: Sat, 20 Nov 2004 16:38:32 +0100
Message-ID: <20041120153831.GA5104@dreamland.darkstar.lan>
References: <20041119174542.GA5002@dreamland.darkstar.lan> <200411200512.22249.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVXK2-0003DL-HG
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 07:38:46 -0800
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CVXK1-0007Y9-7r
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 20 Nov 2004 07:38:46 -0800
Content-Disposition: inline
In-Reply-To: <200411200512.22249.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Sat, Nov 20, 2004 at 05:12:20AM +0800, Antonino A. Daplas ha scritto: 
> On Saturday 20 November 2004 01:45, Kronos wrote:
> > Hi,
> > I just tried 2.6.10-rc2 and there's a regression in cursor code. The
> > cursor disappear when I start a ncurses-based application and the switch
> > to another console.
> >
> > Step to reproduce:
> > 1) Start a ncurses application (like tin, mutt, alsamixer)
> > 2) Switch vt: cursor is gone.
> >
> > With tin, mutt, alsamixer it's 100% reproducible. It doesn't happen with
> > ViM though...
> >
> > I'm using radeonfb (new one) on a R300; I tried with and without X and
> > it doesn't make any difference.
> >
> > I'm sorry that I can't be more precise about the bug but I'm very busy.
> > I can try to track it down next week if it's needed.
> 
> Try 2.6.10-rc2-mm1 or apply this particular changeset:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch

Yes, now it's working.

Thank you,
Luca
-- 
Home: http://kronoz.cjb.net
"Di tutte le perversioni sessuali, la castita` e` la piu` strana".
Anatole France


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
