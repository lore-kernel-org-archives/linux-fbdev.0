From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK updates] fbdev changes updates.
Date: Tue, 29 Oct 2002 14:07:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0210291404390.1363-100000@maxwell.earthlink.net>
References: <20021029200838.GA27552@suse.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021029200838.GA27552@suse.de>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


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

The reason I did this was to prevent adding another chuck of agp code. The
current work around for AGP fbdev drivers to have there OWN AGP code. So
we can leave the agp drivers where they are at or the framebuffer layer
can have its own AGP code for itself. Which way do you think it should be
done?

1) Fbdev layer has it own AGP layer

2) Use already existing AGP layer code.
