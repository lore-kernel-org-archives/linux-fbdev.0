From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev changes.
Date: Fri, 18 Oct 2002 10:29:47 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210181028520.10832-100000@maxwell.earthlink.net>
References: <1034628378.1143.507.camel@tibook>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from gull.mail.pas.earthlink.net ([207.217.120.84])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182b2n-0005Mb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 10:36:17 -0700
In-Reply-To: <1034628378.1143.507.camel@tibook>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Wouldn't that complicate merges between the kernel and DRI CVS? At any
> rate, I think discussion related to the DRI should take place on
> dri-devel.

Okay the idea of mixing the drivers together was rejected. SO I just moved
the entire directory to drivers/video instead. People didn't seem to have
problem with that.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
