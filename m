From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: writing to a floating point register ?
Date: Wed, 5 Feb 2003 11:38:37 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205103837.GA817@iliana>
References: <20030205101753.GA1466@iliana> <Pine.GSO.4.21.0302051128310.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gMxE-0000fm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 02:38:56 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0302051128310.16681-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Wed, Feb 05, 2003 at 11:28:58AM +0100, Geert Uytterhoeven wrote:
> On Wed, 5 Feb 2003, Sven Luther wrote:
> > while writing a fbdev driver, i need to write a value to a floating
> > point register. Do we have any macro doing this, or should i need to
> > calculate the sign, mantissa and exponent by hand ?
> > 
> > Just doing a unsigned int cast would round the value i think, and thus
> > not give the right result.
> 
> You cannot use floating point math in the kernel.
> 
> What exactly are you trying to achieve?

Well, my framebuffer is not linear, and i have to enable a bypass unit
to fake a linear framebuffer. This bypass unit need that i write the
bytestride/64 32bit floating point value in a register.

for example : 1024 in 32 bpp => 4*1024/64 = 64.

64 is 0100 0000 or 1.0 * 2^6.

So i have sign = 0, exp = 127+6=133 = 10000101, and mantissa = 0.

which gives 0100 0010 1000 0000 ... or 0x42 80 00 00.

I was hoping that i would not need to do this calculation by hand, but i
guess it is not possible, since like you said, we cannot use the FP
unit in the kernel.

Or maybe there are some convenient macros available for that or
something ?

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
