From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BK updates] fbdev changes updates.
Date: 29 Oct 2002 22:31:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1035930664.1603.23.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.33.0210291240170.14451-100000@maxwell.earthlink.net> 
	<20021029200838.GA27552@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021029200838.GA27552@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Dave Jones <davej@codemonkey.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, Linus Torvalds <torvalds@transmeta.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-10-29 at 20:08, Dave Jones wrote:
> On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
>  > The reason for this is we will see in the future embedded ix86
>  > boards with things like i810 framebuffers with NO vga core. In this case
>  > we will need a fbdev driver for a graphical console. Thus the agp code
>  > must be started before the fbdev layer.
> 
> Can you explain exactly what the agpgart code is doing that needs
> to be done earlier than framebuffer ? I don't see any reason for this
> change. There should be no GART mappings until we've booted userspace
> (except for the case of IOMMU)

The i8xx draws the frame buffer memory from AGP as well as the texture
mappings and other goodies. The practical impact of that is that if you
want any useful video mode you need AGP initialized first. For UMA video
devices its an extremely neat way of avoiding pre-allocation of fixed
size frame buffers before the OS boots
