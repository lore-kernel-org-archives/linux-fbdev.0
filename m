From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 24 Apr 2015 07:42:04 +0000
Subject: Re: what's the difference between smem_start and mmio_start?
Message-Id: <20150424073004.GE3489@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADvLq87aq7m-xuf6XbOq7rDDjLORwiW-5O0qd5tfm+_H_xd05w@mail.gmail.com>
In-Reply-To: <CADvLq87aq7m-xuf6XbOq7rDDjLORwiW-5O0qd5tfm+_H_xd05w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Apr 18, 2015 at 03:46:48PM +0800, z f wrote:
> what's the difference between smem_start member and mmio_start member
> in struct fb_fix_screeninfo?

let me try, but I am not sure that I am fully correct.
smem_start gives you the starting address where your framebuffer memory
starts. mmio_start will give you the memory address from where you can
access memory mapped io ports.
I dont think that all the hardware will follow the same location rules.

like, if you consider the driver that I have in staging/sm7xxfb,
the memory map is like:

________________________________  0MB
|				|	
|  display memory		|
|				|
|				|
|_______________________________| 4MB
|				|
|_______________________________| 5MB
|				|
| memory mapped io port  	|
|				|
|_______________________________|

so here I have:

smem_start = pci_resource_start (pdev, 0);
mmio_start = smem_start + 4MB

but if you see the radeon driver you will see thay have
smem_start = pci_resource_start (pdev, 0);
and
mmio_start = pci_resource_start (pdev, 2);

regards
sudip
