From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 10:43:09 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031027154309.GB19711@gtf.org>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com> <200310271537.30435.ioe-lkml@rameria.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200310271537.30435.ioe-lkml@rameria.de>
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
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@osdl.org>

On Mon, Oct 27, 2003 at 04:37:30PM +0200, Ingo Oeser wrote:
> On Saturday 25 October 2003 21:17, Jeff Garzik wrote:
> > Graphics processors are growing more general, too -- moving towards
> > generic vector/data processing engines.  I bet you'll see an optimal
> > model emerge where you have some sort of "JIT" for GPU microcode in
> > userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT,
> > which in turn pipelines data and microcode commands to the GPU kernel
> > driver.
> 
> These "JIT" is needed also for another reason: 
> 
> 	There are contraints for GPU commands and the pipelines need to
> 	be modelled, like CPU piplines are modelled in a compiler. But
> 	more like the pipelines of some early long instruction word
> 	processors, where issuing to a used pipeline will cause random
> 	behavior and crashes. So the JIT doesn't should also emit
> 	synchronization points. 
> 
> With this JIT in place, there need to be just some hardware description
> files (backends) and some API (GL, DirectX, X) description files
> (frontends).

I agree 60%  ;-)   This JIT emits GPU-specific microcode, so it should
lean towards being hardware-dependent.  Speed and efficiency IMO demand
that.

Looking at existing, open-source CPU JITs, there are certainly general
pieces and CPU-specific pieces.  But for GPUs, I think the best method
is to start at the more-GPU-specific end of the spectrum, and _evolve_
towards a more general solution, as hardware needs dictate.

In other terms, let the hardware drive the JIT design and evolution, and
don't over-design for a future that may never come.  That was part of
GGI's problem, IMO.


> Now we just need some funding for that and the datasheets. Then it's
> doable.

Yep ;-)


> I see just one showstopper: Cheating in benchmarks isn't possible anymore.
> 
> PS: That's basically the GGI approach taken further.

I followed GGI for a while.  Trying to be all things to all people was
their principle mistake.  As Pat Morita said in Karate Kid,
"Focus, Daniel-san!"  Be specific before general.

	Jeff





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
