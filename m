From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] broken cfb* support in the 2.5.31-bk
Date: Wed, 14 Aug 2002 21:30:54 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41232.7997539707$1029386400@news.gmane.org>
References: <20020814192327.GD37217@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fCNL-0000yp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 14 Aug 2002 21:36:47 -0700
In-Reply-To: <20020814192327.GD37217@ppc.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


> Hi Linus, hello others,
>   please apply this.
>
> line_length, type and visual moved from display struct to the fb_info's fix
> structure during last fbdev updates. Unfortunately generic code was not updated
> together, so now every fbdev driver is broken.

That was done to push people to port there drivers to the new api. I
applied the patch to the Bk repository but expect more breakage.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
