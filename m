From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Tue, 22 Feb 2005 16:42:35 -0500
Message-ID: <9e4733910502221342b560325@mail.gmail.com>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <9e473391050219230764b0dfd2@mail.gmail.com>
	 <200502221050.43534.jbarnes@sgi.com>
	 <1109105867.5411.128.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3hnn-0007x8-Sn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:42:43 -0800
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3hnm-0004Lg-AI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Feb 2005 13:42:43 -0800
Received: by rproxy.gmail.com with SMTP id z35so1007914rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Feb 2005 13:42:36 -0800 (PST)
In-Reply-To: <1109105867.5411.128.camel@gaston>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 23 Feb 2005 07:57:47 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2005-02-22 at 10:50 -0800, Jesse Barnes wrote:
> 
> > Nice, if this is combined with Ben's suggestion of using a firmware loader
> > type model to deal with POSTing, it seems like we're in pretty good shape.
> > Can you add documentation for this API to
> > Documentation/filesystems/sysfs-<foo>.txt (maybe the pci file or a new file)
> > so that userspace people will be able to figure out how to use it?
> >
> > Also, how does one know if a card is 'primary' or not?  I.e. some BIOSes will
> > POST all cards, some will POST only one, and some will POST none...
> 
> Well, that's something we need to figure out... While I do think the
> POSTing must be under driver control, as I explained, there is still
> that nasty notion of who has the stuff at 0xc0000 ... and if your
> firmware runs the x86 BIOS but doesn't keep the shadow around, then you
> are toast with a good deal of laptop chips.


With the ROM API code that is checked into the kernel on the x86 it
tracks the boot video device so that it knows which card C000 belongs
to. IORESOURCE_ROM_SHADOW is set in this case. If you do pci_map_rom()
on the boot device it returns you the contents of C000 not the actual
ROM.


> 
> The problem is that on some cards (ATIs for example), the BIOS will
> modify the image in RAM at c0000 and will put in there various infos,
> like panel type, PLL infos, etc... that can't always be obtained from
> the "hard" ROM (especially the panel infos). The driver (raeonfb or X,
> strace X and see it mmap'ing /dev/mem at c0000...) need those things.
> 
> Ben.
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
