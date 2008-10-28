From: David Miller <davem@davemloft.net>
Subject: Re: radeonfb lockup in .28-rc (bisected)
Date: Mon, 27 Oct 2008 17:00:08 -0700 (PDT)
Message-ID: <20081027.170008.112856238.davem@davemloft.net>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752257AbYJ1AAl@vger.kernel.org>
In-Reply-To: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: cloos@jhcloos.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, khc@pm.waw.pl, linux-fbdev-devel@lists.sourceforge.net

From: James Cloos <cloos@jhcloos.com>
Date: Mon, 27 Oct 2008 19:45:58 -0400

> Commit b1ee26bab1 breaks radeonfb on my inspiron 8100 (P3-M with a
> Mobility M7 LW [7500] (1002:4c57 1028:00e6)).

Please quote at least the headerline of the commit so that it can
come into our memory quickly when reading your report.

Here it is for the others:

commit b1ee26bab14886350ba12a5c10cbc0696ac679bf
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Oct 15 22:03:46 2008 -0700

    radeonfb: accelerate imageblit and other improvements
    
    Implement support for HW color expansion of 1bpp images, along with some
    improvements to the FIFO handling and other accel operations.
    
    The offset fixup code is now unnecessary as the fbcon core will call our
    set_par upon switch back from KD_GRAPHICS before anything else happens.  I
    removed it as it would slow down accel operations.
    
    The fifo wait has been improved to avoid hitting the HW register as often,
    and the various accel ops are now performing better caching of register
    values.
    
    Overall, this improve accel performances.  The imageblit acceleration does
    result in a small overall regression in performances on some machines (on
    the order of 5% on some x86), probably becaus the SW path provides a
    better bus utilisation, but I decided to ingnore that as the performances
    is still very good, and on the other hand, some machines such as some
    sparc64 get a 3 fold performance improvement.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Acked-by: David S. Miller <davem@davemloft.net>
    Cc: Krzysztof Halasa <khc@pm.waw.pl>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

> The boot is OK until init(8) starts; after init outputs its version info
> it calls rc(8), which starts by setting the fb font.  At that point any
> kernel with b1ee26bab1 locks hard.  The cursor stops flashing, magic
> sysrq stops working and the fan starts up after a few seconds.  (I can't
> tell whether it is the CPU or the GPU that heats up.)
> 
> If it is relevant, I use a 10x20 font, so the font change means the
> console converts from 200x75, 8x16 to 160x60, 10x20.

The actual key here is that when setfont runs, the framebuffer layer sets
the acceleration options for the framebuffer for the first time to their
final settings.

> The differences between rc2 and rc2+revert are limited
> to some changes in the size of the kernel:
> 
> -Memory: 512232k/524200k available (4376k kernel code, 11428k reserved, 1707k data, 320k init, 0k highmem)
> +Memory: 512272k/524200k available (4354k kernel code, 11388k reserved, 1693k data, 316k init, 0k highmem)

That's just all due to the text size change because of the different
acceleration code.
