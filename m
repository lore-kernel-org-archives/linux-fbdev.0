From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 16:37:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200310271537.30435.ioe-lkml__21583.9665303522$1067274709@rameria.de>
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org> <3F9ACC58.5010707@pobox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AE8gG-0001rg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 06:49:16 -0800
Received: from smtprelay02.ispgateway.de ([62.67.200.157])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AE8ba-00072L-B9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Oct 2003 06:44:26 -0800
In-Reply-To: <3F9ACC58.5010707@pobox.com>
Content-Disposition: inline
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
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@osdl.org>

On Saturday 25 October 2003 21:17, Jeff Garzik wrote:
> Graphics processors are growing more general, too -- moving towards
> generic vector/data processing engines.  I bet you'll see an optimal
> model emerge where you have some sort of "JIT" for GPU microcode in
> userspace.  Multiple apps pipeline X/GL/hardware commands into the JIT,
> which in turn pipelines data and microcode commands to the GPU kernel
> driver.

These "JIT" is needed also for another reason: 

	There are contraints for GPU commands and the pipelines need to
	be modelled, like CPU piplines are modelled in a compiler. But
	more like the pipelines of some early long instruction word
	processors, where issuing to a used pipeline will cause random
	behavior and crashes. So the JIT doesn't should also emit
	synchronization points. 

With this JIT in place, there need to be just some hardware description
files (backends) and some API (GL, DirectX, X) description files
(frontends).

Now we just need some funding for that and the datasheets. Then it's
doable.

I see just one showstopper: Cheating in benchmarks isn't possible anymore.

PS: That's basically the GGI approach taken further.

Regards

Ingo Oeser




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
