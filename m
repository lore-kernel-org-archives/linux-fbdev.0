From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: fbcon scrolling madness + fbset corruption
Date: Wed, 5 Feb 2003 15:51:27 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205155127.B28758@flint.arm.linux.org.uk>
References: <20030119200340.A13758@flint.arm.linux.org.uk> <1043026112.988.4.camel@localhost.localdomain> <20030202195744.C32007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gRqH-0000o2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 07:52:06 -0800
Content-Disposition: inline
In-Reply-To: <20030202195744.C32007@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Feb 02, 2003 at 07:57:44PM +0000
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
To: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>

No one's commented on this yet.

James?

On Sun, Feb 02, 2003 at 07:57:44PM +0000, Russell King wrote:
> This doesn't appear to solve the ywrap problem - I still get
> places where the screen doesn't scroll.  I decided to write a
> small program to dump out the contents of fb_var_screeninfo, and
> where stuff goes horribly wrong:
> 
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+2352
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+2392
> 
> Up to the point where it goes wrong:
> 
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+528
> bash-2.04# ./tst
> Visible: 1280x1024
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+568
> bash-2.04# ./tst
> Visible: 1280x1024	<--- this is the last line on the screen
> Virtual: 1280x1632
> BPP    : 8
> Offset : +0+608
> bash-2.04#
> 
> So it looks like something isn't limiting the yoffset in the generic
> console layer; an xoffset of 2392 when the maximum virtual Y is 1632
> is just nonsense.
> 
> I also noticed an additional problem with fbcon: if I change the
> resolution using fbset, the change occurs, except I end up with
> corrupted mess on the screen (the reminents of the original display.)
> The shell prompt is nowhere to be seen.
> 
> Hitting ^L clears the screen and then the shell prompt is visiable.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
