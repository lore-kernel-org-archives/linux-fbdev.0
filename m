From: Philip Brown <phil@bolthole.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Mon, 27 Oct 2003 19:27:47 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031027192747.A61679@bolthole.com>
References: <1067298909.26680.22.camel@gaston> <Pine.LNX.4.44.0310271753180.1600-100000@home.osdl.org>
Reply-To: Philip Brown <phil@bolthole.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AEKXG-0001KZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Oct 2003 19:28:46 -0800
Received: from bolthole.com ([192.220.72.215])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AEKWK-0002Vt-IV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 27 Oct 2003 19:27:48 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310271753180.1600-100000@home.osdl.org>; from torvalds@osdl.org on Mon, Oct 27, 2003 at 06:13:32PM -0800
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Oct 27, 2003 at 06:13:32PM -0800, Linus Torvalds wrote:
>..
> So the thing should really just have 
>  - discovery and attach/detach
>  - interrupt event notification (and it can't just be "an interrupt 
>    happened" - the interrupt driver actually has to know enough to ACK the
>    interrupt, so that we can tell user space that an interrupt happened 
>    without having to disable the interrupt until the event goes away)
>  - serialization (ie a lock) and waiting for events ("engine idle" or 
>    "command queue less than half full")
>  - DMA arbitration and setup.
>[....]
> So the low-level driver wouldn't know about palettes or cursors or any 
> "high-level" concepts like that. It would have a few locks to make sure 
> that the users that try to access the things don't stop on each other, 
> nothing more (maybe the locks themselves would be grouped into "palette 
> lock" vs "cursor lock" vs "DMA engine lock" since hardware may be threaded 
> enough to allow it, but the point is that the low-level driver wouldn't 
> actually _do_ anything, it only allows others to do what they want without 
> stomping on each others toes).

Sounds like a good idea. Simple Is Better.

Now, would that "DMA arbitration" include
"submit a chunk o dma memory for GPU processing",

or would it just allow [whatever] to map the registers, and basically say,
"I'll tell you when something completes (aka sends an interrupt)
 but it's up to you to START it"





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
