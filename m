From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Advice sought on approach.
Date: 05 Mar 2003 12:37:35 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046867855.2505.200.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from nimbus19.internetters.co.uk ([209.61.216.65])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qY9a-0007Qa-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 04:37:46 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I'm writting a framebuffer driver for an embedded system that has a
overlayed video display (TV picture + Overlayed text). To do this I have
to keep track of both the main pixel memory and a mask that the hardware
uses to display things. This is also compilcated by the fact I can't
access this memory directly, it is done through a small addr/data port
on the hardware so obviosuly I want to minimise the amount of data I
push through this (by doing it only when required).

Having read the fb-dev docs on www.linux-fbdev.org I'm a little confused
as to what actually puts data into the framebuffer. Most of the
framebuffer drivers just seem to deal with resolution and colourmap
settings. Is this a case of having to re-implement the fbcon drivers as
well to get what I want?

Are there any examples of drivers that have a similar architecture that
would be worth looking at? I've had a look at the vfb.c code but again
that seems too simplistic compared to what I'll need.

Final question, the docs refer to 2.2. Is this because under 2.4
framebuffer drivers are not fundamentally differnt?


-- 
Alex, homepage: http://www.bennee.com/~alex/

Any sufficiently advanced bug is indistinguishable from a feature.
		-- Rich Kulawiec



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
