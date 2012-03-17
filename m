From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Problem with framebuffer mmap on platforms with large addressing
Date: Sat, 17 Mar 2012 20:04:21 +0400
Message-ID: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: linux-fbdev-devel@lists.sourceforge.net, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Josh Boyer <jwboyer@gmail.com>, Matt Porter <mporter@kernel.crashing.org>

Hello,

I'm trying to make framebuffer to work on PPC460EX board (canyonlands).

The peculiarity of this platform is the fact that it has
sizeof(unsigned long) = 4,
but physical address on it is 36 bits width. It is a common to various pieces
of the code to expect that unsigned long variable is able to contain physical
address. Most of those places are easy to fix.

The problem I'm stuck with is a fb_mmap() code. To find a right memory to map
it uses information from struct fb_fix_screeninfo provided by the driver.
This structure uses two unsigned long fields to hold physical addresses
(smem_start and mmio_start). It would be easy to change that structure
to use phys_addr_t instead of unsigned long, but this structure is a part
of userspace ABI. It is returned to userspace on FBIOGET_FSCREENINFO ioctl.
And now I'm stuck with it.

In my driver code I have just overwritten the fb_mmap function with
driver-private
fb_mmap callback supporting 64-bit addressing, but this doesn't look like
a generic and correct solution.

What is the best way to fix this problem? Should we break ABI with the goal
of correctness? Should we add new FBIOGET_FSCREENINFO2, which will
return a correct structure with phys_addr_t (or simply u64) fields and make
FBIOGET_FSCREENINFO a wrapper returning partially bogus structure
(with smem_start and mmio_start fields being truncated to just unsigned long)?
What would developers recommend?


Thank you.


-- 
With best wishes
Dmitry
