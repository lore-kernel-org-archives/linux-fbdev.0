From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] broken cfb* support in the
Date: Thu, 15 Aug 2002 12:30:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <212B36E116D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17fHu9-0000lZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Aug 2002 03:31:01 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On 14 Aug 02 at 21:30, James Simmons wrote:
> > Hi Linus, hello others,
> >   please apply this.
> >
> > line_length, type and visual moved from display struct to the fb_info's fix
> > structure during last fbdev updates. Unfortunately generic code was not updated
> > together, so now every fbdev driver is broken.
> 
> That was done to push people to port there drivers to the new api. I
> applied the patch to the Bk repository but expect more breakage.

Which new API? If you are going to remove logo and unaccelerated fbcon-cfb*,
then remove them completely. If you are not going to remove unaccelerated
fbcon-cfb*, then there is no reason for breaking them.

I'm not going to remove unaccelerated code from the matroxfb. Never.
                                                     Petr Vandrovec
                                                     vandrove@vc.cvut.cz


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
