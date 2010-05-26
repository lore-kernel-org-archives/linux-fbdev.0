From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 26 May 2010 13:50:28 +0000
Subject: Re: [PATCH 2/2] sm501fb.c: support mmap on PPC440SPe/PPC440EPx
Message-Id: <20100526155028.33c343de@mw.dip.t-dialin.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274867863-4238-2-git-send-email-agust@denx.de>
In-Reply-To: <1274867863-4238-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 26 May 2010 20:13:16 +0900
Ben Dooks <ben@simtec.co.uk> wrote:

> On 26/05/10 18:57, Anatolij Gustschin wrote:
> > Add driver specific mmap function to be able to mmap
> > frame buffer on PPC440SPe/PPC440EPx platforms. This
> > is needed because mmaping of the 36-bit physical
> > address of the frame buffer or MMIO is not supported
> > in generic fb_mmap().
> 
> Surely this is something we should be fixing in the
> main fb layer?

We need to store phys addresses > 32-bit somewhere. Changing
smem_start and mmio_start of the struct fb_fix_screeninfo to
unsigned long long would break user space compatibility.
How about adding smem_start_high and mmio_start_high to the
struct fb_fix_screeninfo for the purpose of storing upper
address bits?
