From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [2.5.42] screen corruption with vesafb
Date: 15 Oct 2002 02:47:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1034621170.570.54.camel@daplas>
References: <874rbqzerv.fsf@gswi1164.jochen.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181AIy-00064i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 11:51:04 -0700
In-Reply-To: <874rbqzerv.fsf@gswi1164.jochen.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jochen Hein <jochen@jochen.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2002-10-13 at 20:47, Jochen Hein wrote: 
> 
> When running Emacs on a framebuffer console and inserting characters
> in the middle of a line, the character after the cursor get corrupted
> in two of three tries.  A redraw (Ctrl-L) fixes it, so I suspect a
> framebuffer bug.  I can provide a screenshot if there is a need.
> 
I experienced similar problems before.  In my case, this was due to
problems with cfbfillrect.c and cfbcopyarea.c.  

Geert wrote similar routines in the CVS version of fbtest.  I modified
them so they can be used as drop-in replacements for the kernel
framebuffer.  See the thread "Console Rotation" last month. 

Tony



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
