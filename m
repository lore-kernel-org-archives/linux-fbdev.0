From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: writing to a floating point register ?
Date: Wed, 5 Feb 2003 12:02:27 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205110227.GA977@iliana>
References: <20030205103837.GA817@iliana> <Pine.GSO.4.21.0302051140460.16681-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gNKF-0003ux-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 03:02:43 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0302051140460.16681-100000@vervain.sonytel.be>
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

On Wed, Feb 05, 2003 at 11:44:23AM +0100, Geert Uytterhoeven wrote:
> On Wed, 5 Feb 2003, Sven Luther wrote:
> > On Wed, Feb 05, 2003 at 11:28:58AM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 5 Feb 2003, Sven Luther wrote:
> > > > while writing a fbdev driver, i need to write a value to a floating
> > > > point register. Do we have any macro doing this, or should i need to
> > > > calculate the sign, mantissa and exponent by hand ?
> > > > 
> > > > Just doing a unsigned int cast would round the value i think, and thus
> > > > not give the right result.
> > > 
> > > You cannot use floating point math in the kernel.
> > > 
> > > What exactly are you trying to achieve?
> > 
> > Well, my framebuffer is not linear, and i have to enable a bypass unit
> > to fake a linear framebuffer. This bypass unit need that i write the
> > bytestride/64 32bit floating point value in a register.
> > 
> > for example : 1024 in 32 bpp => 4*1024/64 = 64.
> > 
> > 64 is 0100 0000 or 1.0 * 2^6.
> > 
> > So i have sign = 0, exp = 127+6=133 = 10000101, and mantissa = 0.
> > 
> > which gives 0100 0010 1000 0000 ... or 0x42 80 00 00.
> > 
> > I was hoping that i would not need to do this calculation by hand, but i
> > guess it is not possible, since like you said, we cannot use the FP
> > unit in the kernel.
> 
> Even if you could, it would work for 32-bit IEEE floating point format only.
> Is the hardware register format IEEE compatible.

Mmm, sure, didn't think of this. Would endianess and other such issue 
not be a problem for this kind of calculation ? Would it make sense to
have a special macro available for this kind of thing, like we have for
writing 8, 16 or 32 bits ?

> Anyway, the calculation is not that difficult.

Sure ...

> Perhaps you can even restrict line_length to be a multiple of 64 in all cases,
> in which case it's even made more easy?

Are all video modes we want to use multiples of 64 ? I guess yes.

> Does the hardware register allow denormalized numbers? Since you want to divide
> by 64 only, this would allow you to use a fixed exponent.

Erm, no idea, will need to try. That say, i don't know much about
floating point numbers, so i really don't know all that much about
denormalized numbers.

Mmm, i guess you mean that since we divide by 64, the mantissa would
always be 0 (1.000...) and we only need to write 127 + log2(value) in it
?  
Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
