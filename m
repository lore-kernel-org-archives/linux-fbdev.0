From: Keith Whitwell <keith@tungstengraphics.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 15:50:20 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F9D3EBC.4010004__18647.1803150654$1067277909@tungstengraphics.com>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <3F9D3643.9030400@tungstengraphics.com> <20031027153824.GA19711@gtf.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031027153824.GA19711@gtf.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

Jeff Garzik wrote:
> On Mon, Oct 27, 2003 at 03:14:11PM +0000, Keith Whitwell wrote:
> 
>>Jeff Garzik wrote:
>>
>>>Thank you for saying it.  This is what I have been preaching (quietly) 
>>>for years -- command submission and synchronization (and thus, DMA/irq 
>>>handling) needs to be in the kernel.  Everything else can be in 
>>>userspace (excluding hardware enable/enumerate, of course).
>>
>>To enable secure direct rendering on current hardware (ie without secure 
>>command submission mechanisms), you need command valididation somewhere.  
>>This could be a layer on top of the minimal dma engine Linus describes.
> 
> 
> Certainly.
> 
> 
> 
>>>Graphics processors are growing more general, too -- moving towards 
>>>generic vector/data processing engines.  I bet you'll see an optimal 
>>>model emerge where you have some sort of "JIT" for GPU microcode in 
>>>userspace.  
>>
>>You mean like the programmable fragment and vertex hardware that has been 
>>in use for a couple of years now?
> 
> 
> I mean, taking current fragment and vertex processing and making it
> even _more_ general.  Which has already happened, on one particular chip
> maker's chip...

I think that generally you can view all the current generation of hardware as 
arbitary programmable devices, and most of the graphics drivers are doing 
code-generation for that hardware on the fly.  This isn't exactly new ground 
for graphics drivers as graphics hardware has alternated (I'm told) between 
fixed function and programmable cores multiple times now.

In addition, graphics drivers have been doing on-the-fly codegen for the host 
cpu since year dot.  The orignal software-rasterization SGI opengl drivers for 
windows were supposed to be pretty much state of the art in this respect.

Now that the barriers for codegen have lowered so dramatically (see, eg. 
http://fabrice.bellard.free.fr/tcc/), it is now feasible to talk of building a 
code-generating software rasterizer for mesa.

Keith


Keith



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
