From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: fbcon scrolling madness + fbset corruption
Date: Sun, 2 Feb 2003 19:57:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030202195744.C32007@flint.arm.linux.org.uk>
References: <20030119200340.A13758@flint.arm.linux.org.uk> <1043026112.988.4.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1043026112.988.4.camel@localhost.localdomain>; from adaplas@pol.net on Mon, Jan 20, 2003 at 09:29:38AM +0800
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

On Mon, Jan 20, 2003 at 09:29:38AM +0800, Antonino Daplas wrote:
> fb_pan_display() does not test for YWRAP.  Can you try this?

This doesn't appear to solve the ywrap problem - I still get
places where the screen doesn't scroll.  I decided to write a
small program to dump out the contents of fb_var_screeninfo, and
where stuff goes horribly wrong:

bash-2.04# ./tst
Visible: 1280x1024
Virtual: 1280x1632
BPP    : 8
Offset : +0+2352
bash-2.04# ./tst
Visible: 1280x1024
Virtual: 1280x1632
BPP    : 8
Offset : +0+2392

Up to the point where it goes wrong:

bash-2.04# ./tst
Visible: 1280x1024
Virtual: 1280x1632
BPP    : 8
Offset : +0+528
bash-2.04# ./tst
Visible: 1280x1024
Virtual: 1280x1632
BPP    : 8
Offset : +0+568
bash-2.04# ./tst
Visible: 1280x1024	<--- this is the last line on the screen
Virtual: 1280x1632
BPP    : 8
Offset : +0+608
bash-2.04#

So it looks like something isn't limiting the yoffset in the generic
console layer; an xoffset of 2392 when the maximum virtual Y is 1632
is just nonsense.

I also noticed an additional problem with fbcon: if I change the
resolution using fbset, the change occurs, except I end up with
corrupted mess on the screen (the reminents of the original display.)
The shell prompt is nowhere to be seen.

Hitting ^L clears the screen and then the shell prompt is visiable.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
