From: Chris Heath <chris@heathens.co.nz>
Subject: Re: softcursor updates and stuff.
Date: Thu, 08 Apr 2004 01:54:55 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040408005533.9D05.CHRIS@heathens.co.nz>
References: <Pine.LNX.4.44.0403301912040.29836-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBSTq-0003IT-2a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Apr 2004 22:53:38 -0700
Received: from rwcrmhc11.comcast.net ([204.127.198.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BBSTp-0001OR-Pm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Apr 2004 22:53:37 -0700
In-Reply-To: <Pine.LNX.4.44.0403301912040.29836-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Chris Heath <chris@heathens.co.nz>

> 
> Note. 
>    The softcursor expect the framebuffer layout to be packed pixels.
> This is not the case for vga16fb and amifb.c. I know amifb is broken because of 
> the monitor detection code changes. As for vga16fb can anyone tell me 
> where I can find docs on how to read the framebuffer for a image?
  
I researched this myself a few months ago when I was adding vga16
support to fbiterm.  I never found a very good reference online, but
using [1] and a lot of experimentation, I came up with my own notes, see
below.  (Sorry, they are rather terse, but I hope helpful.)

Basically you a) set 3cf.5 to 0, b) set 3cf.4 to the plane number (0-3),
c) read the memory.  Repeat b) and c) for each plane.

Writing the full-color image back to the screen may actually be harder! 
To write value v to plane n at memory location p, you do this: a) set
3cf.5 to 0, b) set 3cf.3 to 16, c) set 3cf.8 to v, d) set 3cf.0 to 0, e)
set 3cf.1 to ~(1 << n), f) read from p, g) write v to p  (Thus far, the
appropriate bits have been set in plane n. Now we clear the complement.)
h) set 3cf.3 to 8, i) set 3cf.8 to ~v, j) set 3cf.0 to 15, k) read from
p, l) write v to p.

Ugh. Surely there's a better way.  I see that [1] mentions latch
registers may be directly accessible in 3fc.9-3fc.c, but this may not be
standard.

Would it be possible to restrict the cursor and image save/restore to be
within a single character boundary?  If so, you can set 3cf.5 to 8, set
3cf.7 to 15, set 3cf.2 to the foreground color and read video memory as
if it were monochrome.  It would be much simpler and faster, and writing
a bi-color image back to video is already implemented.

Chris


References:
[1] http://www.xs4all.nl/~ganswijk/chipdir/reg/vga.txt

My notes:

VGA graphics mode
-----------------

16-color VGA graphics uses a plane model.  However, all 4 planes are at the
SAME memory address!  Various flags in the VGA control registers determine
which planes are accessed/modified.  There are 9 VGA control registers,
all located at IO port 3cf (notation: 3cf.n, where n is 0..8).  IO port 3ce
controls which control register is currently visible.

When you read a byte from graphics memory, the value of all 4 planes gets
stored in VGA's internal 32-bit "latch" register.  This is converted into a
byte using the following algorithm:
  if (bit 3 of 3cf.5 is 0) {
    return the plane stored in bits 0 and 1 of 3cf.4
  } else {
    return 1 if (pixel color & 3cf.7) is equal to (3cf.2 & 3cf.7), 0 otherwise.
  }

When you write a byte, the following algorithm is used:
  switch (bits 0 and 1 of 3cf.5) {
    case 0:
      First, rotate the value written by (3fc.3 & 7).
      Pixels where 3cf.8 is 0 are copied from the latch.
      Pixels where value written is 1 get set to (3cf.0 | ~3cf.1) OP latch.
      Pixels where value written is 0 get set to (3cf.0 & 3cf.1) OP latch.
        (i.e. if 3cf.1 = 1 then plane bit copied from 3cf.0, otherwise
         copied from value written.)
      In some sense, this mode allows you to have a background and foreground
        color being written at the same time.  However, not all color 
        combinations are possible.
    case 1:
      All pixels are copied from the latch.
    case 2:
      (Note: bits 0-2 of 3cf.3 are not used)
      Pixels where 3cf.8 is 0 are copied from the latch.
      Pixels where 3cf.8 is 1 are set to (value written OP color in latch),
         where OP is determined by bits 3 and 4 of 3fc.3 
         -- 0 = ignore latch, 1 = AND, 2 = OR, 3 = XOR.
    case 3:
      (Note: value of 3cf.1 is not used)
      First, rotate the value written by (3fc.3 & 7).
      Pixels where (value written & 3cf.8) is 0 are copied from the latch.
      Pixels where (value written & 3cf.8) is 1 are set to 
         (color in 3cf.0 OP color in latch), where OP is as above.
  }




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
