From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH][FBDEV]: fb_putcs() and fb_setfont()
 methods
Date: Sat, 4 Jan 2003 21:07:29 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
References: <1041672313.958.17.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UvWW-0004Dj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 04 Jan 2003 13:08:05 -0800
In-Reply-To: <1041672313.958.17.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>


Rejected. I have put thought into it and the whole point was to not allow 
the fbdev layer to touch console data. I stand firm on this!!! The reason 
being is the core console layer is going to change the next development 
cycle. We have to change to deal with things like the PC9800 type hardware 
that support more than 512 fonts. Do we realy want to break every fbdev 
driver again. This way the breakage is once and for all. Its is also a 
pandoras box. If we place these hooks in we end up with the same crappy 
driver problem we had before. I never heard anyone every say the old api 
we clean. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
