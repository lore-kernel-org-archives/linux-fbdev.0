From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: fbcon scrolling madness + fbset corruption
Date: Wed, 12 Feb 2003 23:55:54 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030212235553.E16409@flint.arm.linux.org.uk>
References: <20030202195744.C32007@flint.arm.linux.org.uk> <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18j6jd-00063l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Feb 2003 15:56:13 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302122024310.31435-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Wed, Feb 12, 2003 at 08:26:10PM +0000
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Feb 12, 2003 at 08:26:10PM +0000, James Simmons wrote:
> > So it looks like something isn't limiting the yoffset in the generic
> > console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> > is just nonsense.
> 
> I'm going to need to do some heavy cleaning in the next few days.
> 
> > I also noticed an additional problem with fbcon: if I change the
> > resolution using fbset, the change occurs, except I end up with
> > corrupted mess on the screen (the reminents of the original display.)
> > The shell prompt is nowhere to be seen.
> >
> > Hitting ^L clears the screen and then the shell prompt is visiable.
> 
> The method to use now is stty to change the console mode. It works :-)
> fbset is used to change the variable the vt terminals are not familiar 
> with such as bpp.

How do I ensure that such parameters as the refresh rate, hsync width and
offset, vsync width and offset are too my liking?

I've noticed that there seems to be some variation between the parameters
used, and I'd prefer to use my set since they match the host OS (it means
I don't have to keep readjusting the screen each time I change OS.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
