From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fbdev sysfs imrovements
Date: Mon, 26 Mar 2007 22:20:39 -0800
Message-ID: <20070326222039.feb9216d.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
	<20070326195807.184474d7.akpm@linux-foundation.org>
	<17928.46653.30238.153536@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HW533-0008A0-V4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 23:20:52 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HW533-00055r-Kg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Mar 2007 23:20:49 -0700
In-Reply-To: <17928.46653.30238.153536@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Uytterhoeven <geert@linux-m68k.org>, Geert@sc8-sf-spam2.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Tue, 27 Mar 2007 16:14:21 +1000 Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > http://userweb.kernel.org/~akpm/s5000489.jpg (the oops is the usual powerpc
> > mess)
> 
> Why do you have xmon enabled if you don't have any way to talk to it?
> 

gawd knows - I've been dragging that config along for over a year.

Maybe I subconsciously like seeing the mess it makes?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
