From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 27 Dec 2010 15:30:11 +0000
Subject: Re: A query on frame buffers
Message-Id: <20101227153011.GD3728@dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
In-Reply-To: <AANLkTimBpZHwS81BeFxC0dG7mvMg6UaAnFMv6oj04j+Z@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Dec 21, 2010 at 04:51:04AM +0000, Prasad Joshi wrote:
> Hello All,
> 
> This is probably my first mail on this mailing list. I am working on a
> university project on Nvidia or any GPU Pass-through in KVM. I have a

You picking the hard ones first, eh? I would suggest you do Intel
or ATI as they have actually posted patches for this.

> question related to framebuffer.
> 
> I was reading few documents on XEN VGA pass-through, the document says
> the first step for pass-through is mapping the framebuffers in the VM
> at specific address, specifically speaking 0xA0000 till 0xC0000.

I would suggest you look at the code - there have been some patches
posted by AMD engineers on xen-devel for this.
