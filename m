From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [Linux-fbdev-devel] Type confusion in fbcon
Date: Fri, 20 Dec 2002 21:30:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20021220213056.A25155@flint.arm.linux.org.uk>
References: <20021219231415.A25145@flint.arm.linux.org.uk> <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212201808070.6471-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Fri, Dec 20, 2002 at 06:10:17PM +0000
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Dec 20, 2002 at 06:10:17PM +0000, James Simmons wrote:
> > I'll get back to bashing the sa1100fb driver to work out why fbcon is
> > producing a _completely_ blank display, despite characters being written
> > to it.
> 
> Did you figure out what was wrong?

Firstly, setting fix.line_length to zero (which the old API didn't care
about) caused one set of problems.

Secondly, the sa1100fb set_par function doesn't set the var RGB elements -
that's left to the check_var function.  Originally, we effectively did
a fb_set_var which took care of that for us.  Now we explicitly call
our check_var implementation prior to registering the framebuffer
driver with the fbcon core.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
