From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb on pegasos powerpc motherboard
	and X endianess problem
Date: 05 Jun 2003 09:59:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1054799986.701.20.camel@gaston>
References: <20030604145423.GA22876@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-25.w193-253.abo.wanadoo.fr ([193.253.250.25] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Npfi-0001wN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 01:00:30 -0700
In-Reply-To: <20030604145423.GA22876@iliana>
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
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-06-04 at 16:54, Sven Luther wrote:
> Hello,
> 
> I finally have a working pegasos motherboard as well as a working kernel
> with a 1.6 radeonfb. I have also installed Daniel Stone's X 4.3.0
> debian/sid packages, and notice the following :
> 
>   1) radeonfb works fine in 8bpp and 32bpp but depth 15 and 16 only give
>   me some very dark grey.

Can you try my devel tree version ?

(rsync.penguinppc.org::benh-devel)

>   2) when running X with the UseFBDev option the colors are bad, i guess
>   it is an endianess problem. (with and without accel)

What radeon card is this ?

>   3) When running X without the UseFBDev option, the colors are good,
>   but i get garbage when i return to the console. Not exactly garbage,
>   at first it is ok, but when i enter a line or somehow pan the screen,
>   the corruption start. Doing a vt switch and back redraws a clean
>   screen.

Known problem. This is actually a bit nasty. X doesn't fully restore the
engine state (and it's in fact quite difficult to know in which state
it should restore it) and there's no hook in the fbdev layer for
restoring things like that when switching from KD_GRAPHICS back to
KD_TEXT. I'm thinking about adding such a hook in 2.5. Usually, a VT
switch will trigger a restore of the engine state, at least it will
with my version of the driver.

> So, i think something is wrong. The kernel was forked around the
> 2.4.18-rc4 time in a messy way, i am actually working on bringing the
> patch in sync with the newer ppc trees. Matroxfb also had problems and
> Petr told me that it probably was an endianess issue back then. I am
> using a Radeon 9000 board.

Ok, there is a problem with older radeonfb's on these regarding
endianness, newer driver should work.

> So, since this is a pegasos, based on the pop specification, which in
> turn are related to the chrp ones, and i was told that most chrp
> motherboard did endianess inversion in the northbridge or something
> such, and i believe that the pegasos doesn't do so, is it possible that
> this is the cause, and that XFree86 know how to program the graphic card
> to do endianess conversion, and fbdev knows not, or maybe that the
> XFree86 radeon driver doesn't know how to act exactly and accidentally
> reverts the endianess conversion or something such.
> 
> Using the fbdev driver in xfree86, i get a seemingly working X, but the
> background X image is yellowish and the mode is not set correctly it is
> correct, but the image is a bit smaller than the screen, and centered or
> moved to the right.
> 
> Does someone know with more exactitude what the situation is exactly
> with regard the kernel and endianess conversion with the different
> powerpc subarches.

Endianness shouldn't be related to the subarch at all


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
