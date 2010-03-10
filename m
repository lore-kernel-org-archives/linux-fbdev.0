From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 17:12:19 +0000
Subject: Re: Beginner question about fbdev performance
Message-Id: <alpine.LFD.2.00.1003101708530.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <85f9cb1d1003071616w52392c0dq828f99b20c597ef3@mail.gmail.com>
In-Reply-To: <85f9cb1d1003071616w52392c0dq828f99b20c597ef3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> Hi,
> 
> Why is it that the unaccelerated framebuffer device is slower than
> e.g. an accelerated X session when blitting data from main memory?
> Shouldn't both cases involve simply copying data from RAM to VRAM?
> What is the bottleneck in the former case?

Its all about the the transfer method. An unaccelerated draw transfers 
image data over the pci bus pixel by pixel. The accelerated session 
usually used a DMA transfer. Yes a framebuffer could use a DMA transfer in 
the driver but that is only used internally by the console system. Its not 
avaliable to userland for use. 
