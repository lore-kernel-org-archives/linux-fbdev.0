From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 10:38:24 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031027153824.GA19711__16881.3850069002$1067277486@gtf.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <3F9D3643.9030400@tungstengraphics.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3F9D3643.9030400@tungstengraphics.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

On Mon, Oct 27, 2003 at 03:14:11PM +0000, Keith Whitwell wrote:
> Jeff Garzik wrote:
> >Thank you for saying it.  This is what I have been preaching (quietly) 
> >for years -- command submission and synchronization (and thus, DMA/irq 
> >handling) needs to be in the kernel.  Everything else can be in 
> >userspace (excluding hardware enable/enumerate, of course).
> 
> To enable secure direct rendering on current hardware (ie without secure 
> command submission mechanisms), you need command valididation somewhere.  
> This could be a layer on top of the minimal dma engine Linus describes.

Certainly.


> >Graphics processors are growing more general, too -- moving towards 
> >generic vector/data processing engines.  I bet you'll see an optimal 
> >model emerge where you have some sort of "JIT" for GPU microcode in 
> >userspace.  
> 
> You mean like the programmable fragment and vertex hardware that has been 
> in use for a couple of years now?

I mean, taking current fragment and vertex processing and making it
even _more_ general.  Which has already happened, on one particular chip
maker's chip...

	Jeff





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
