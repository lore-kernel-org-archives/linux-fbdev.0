From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
	module
Date: 06 Dec 2002 20:27:16 +0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039188475.1405.0.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0212060051080.31967-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212060051080.31967-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2002-12-06 at 05:53, James Simmons wrote:
> > 
> > Only the structure definition of fb_vgastate is in fb.h.  For drivers
> > without a vga core, they'll just won't link to it and it won't be
> > compiled.  Plus, vga.h is not a common header (not located in
> > include/asm or include/linux) and it contains a lot of declarations and
> > definitions which are irrelevant to most drivers or are already
> > duplicated.  This will be messier, I think.  
> 
> I like to move vga.h to include/video. And yes I like to clean it up. The 
> reason is I like to implement the function in vga.h and some in vgastate 
> into vgacon.c. It would be nice if vgacon could support different hardware 
> states per VC instead of changing every virtual console for everything. 
> The other dream is I like to see vgacon become firmware independent. 
> 
OK.

Tony
