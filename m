From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK updates] fbdev changes updates.
Date: Tue, 29 Oct 2002 14:38:51 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0210291437050.1363-100000@maxwell.earthlink.net>
References: <20021029200838.GA27552@suse.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021029200838.GA27552@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Antonino Daplas <adaplas@pol.net>


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

Best to ask the author of the i810 framebuffer driver. He can tell you his
need for AGP stuff. I CC.
