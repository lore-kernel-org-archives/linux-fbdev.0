From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH] matroxfb: New framebuffer_alloc API and class_d
Date: Mon, 15 Sep 2003 22:24:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4CCE1F5E79@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yztr-0007Uf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:24:43 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yztq-0004Mk-UG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:24:43 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On 15 Sep 03 at 22:16, Kronos wrote:

> Hi,
> this patch converts driver/video/matrox to framebuffer_alloc. Now
> fb_info (and minfo) are dynamically allocated. This also voids the need 
> of a global matrox_fb_info if CONFIG_FB_MATROX_MULTIHEAD:
                             ^^^ if not defined

Whole point of CONFIG_FB_MATROX_MULTIHEAD is to use static structure
when MULTIHEAD is not set. It generates much faster driver for ia32 due
to smaller register pressure, as driver data can be addressed with fixed
address instructions. So if you are going to always allocate fbcon
dynamically, please also remove CONFIG_FB_MATROX_MULTIHEAD completely,
making it always enabled.

Besides that, what's the point of this change? Making driver slower, 
scattering its data over random memory places (so no cache locality...), 
or is there some benefit it brings in and which I missed?
                                        Thanks,
                                                Petr Vandrovec
                                                



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
