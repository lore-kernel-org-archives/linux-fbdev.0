From: James Simmons <jsimmons@infradead.org>
Subject: [BK fbdev updates]
Date: Wed, 30 Oct 2002 13:42:21 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0210301331210.1392-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

  The latest changes to the framebuffer layer are avaiable to be merged.
The changes include the final removal of all console related code in the
low level drivers. This allows for a very simple api. Also with this
design is to possible to run a test/debug a fbdev driver without the
framebuffer console. We can use another console system to see the results
of what we have done. This will allow greater speed at developing a new
driver because of the new simple api and the new approaches at
debugging them. Please merge with your tree.

bk://fbdev.bkbits.net/fbdev-2.5


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net
