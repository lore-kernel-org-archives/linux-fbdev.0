From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fbdev sysfs imrovements
Date: Tue, 27 Mar 2007 16:14:21 +1000
Message-ID: <17928.46653.30238.153536@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
	<20070326195807.184474d7.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HW4x1-0007bY-CE for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 23:14:35 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HW4wz-0004kn-UA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 23:14:35 -0700
In-Reply-To: <20070326195807.184474d7.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>

Andrew Morton writes:

> http://userweb.kernel.org/~akpm/s5000489.jpg (the oops is the usual powerpc
> mess)

Why do you have xmon enabled if you don't have any way to talk to it?

Paul.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
