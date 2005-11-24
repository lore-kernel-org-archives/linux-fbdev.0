From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] Re: Console rotation problems
Date: Thu, 24 Nov 2005 18:13:51 +0800
Message-ID: <4385925F.8010108@gmail.com>
References: <1132793150.26560.357.camel@gaston>  <1132793556.26560.361.camel@gaston> <1132796831.26560.392.camel@gaston> <1132801542.26560.402.camel@gaston> <43855DBA.1050302@gmail.com> <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932628AbVKXKOu@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0511241042360.6400@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

Geert Uytterhoeven wrote:
> On Thu, 24 Nov 2005, Antonino A. Daplas wrote:
>> Benjamin Herrenschmidt wrote:
>>> Remove bogus usage of test/set_bit() from fbcon rotation code and just
>>> manipulate the bits directly. This fixes an oops on powerpc among others
>>> and should be faster. Seems to work fine on the G5 here.
>> Thanks, I reached a point when my head became muddled with bit 
>> manipulations, so I used arch-specific bitops but complete forgot
>> that they were atomic :-)
> 
> I haven't really looked at the rotation code, but I guess it can be optimized a
> lot by using similar techniques like c2p (chunky-to-planar) conversions.
> 

Actually, BenH's patch touched code that is in the slow path.  The font
rotation is done on the entire fontdata, then stored, on a console switch.
Thus the rest of the drawing functions need not do repetitive and expensive
bitmap rotation.

Scrolling performance of a normally oriented and upside-down rotation is
practically the same (1024x768 8x16 redraw).

con_rotate = 0
real    0m2.550s
user    0m0.000s
sys     0m2.543s

con_rotate = 2
real    0m2.559s
user    0m0.001s
sys     0m2.545s


CCW and CW rotation, is of course slower, because the blit direction
tends to be top->down, rather than left->right.

con_rotate = 1
real    0m4.675s
user    0m0.000s
sys     0m4.663s

con_rotate = 3
real    0m4.701s
user    0m0.001s
sys     0m4.684s
  
Tony
