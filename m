From: Zack <plinius@comcast.net>
Subject: Re: fbdraw 0.1 available
Date: Sun, 12 Sep 2004 17:31:20 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4144EA58.4080900@comcast.net>
References: <41426651.2010201@comcast.net> <200409120340.04133.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6ekT-0002uJ-Ta
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 17:31:13 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6ekS-0000Uq-GT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Sep 2004 17:31:13 -0700
In-Reply-To: <200409120340.04133.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

> 1. First, you need to follow Documentation/CodingStyle.

OK, I've made some strides in that direction.

> 2. Do not directly access framebuffer memory, use: 
> 3. Do not use copy_{to|from}_user when the destination/source is the
> framebuffer.
> 4. Do not memset the framebuffer.  You can probably create an equivalent
> function using fb_read/write.  (Once, we have fb_memset and fb_memcpy, but
> they're gone in 2.6).

Fixed.

Incidentally I am wondering, with cross-platform compatibility
in mind I have been coding assuming that fb_{read|write}[wl] must be
short/long aligned. Is that assumption correct?

I've also added my copyarea routine. At first I tried to make use
of cfb_copyarea but it proved very buggy in 24bpp.

New code is at http://home.comcast.net/~plinius.
Cheers,
Zack


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
