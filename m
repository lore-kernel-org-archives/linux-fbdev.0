From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Hotplug blacklist and video devices
Date: Sat, 19 Feb 2005 10:56:48 -0500
Message-ID: <9e47339105021907561c4f408c@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2WyS-0008K6-DH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 07:56:52 -0800
Received: from rproxy.gmail.com ([64.233.170.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D2WyP-0006lA-QI
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 07:56:52 -0800
Received: by rproxy.gmail.com with SMTP id z35so109977rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 07:56:49 -0800 (PST)
In-Reply-To: <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
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
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 19 Feb 2005 12:29:13 +0000, Matthew Garrett
<mgarrett@chiark.greenend.org.uk> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> 
> > For example I'm looking at making changes to DRM such that DRM will
> > require the corresponding framebuffer driver to be loaded. If you back
> > up further this is part of fixing X so that it won't mess with the
> > hardware from user space. Mode setting would come from the framebuffer
> > driver instead of the X 2D XAA driver.
> 
> Please don't until all the framebuffer drivers are able to deal with
> suspend and resume (which will also require some mechanism to switch
> backlights back on). Currently, it's far easier to restore some amount
> of state on a standard VGA or VESA mode. There's no real support for
> doing so with most accelerated framebuffers.

I didn't say make framebuffer depend on DRM, you can still unload DRM
before suspend.  It's the other way around DRM needs framebuffer.
Suspend/resume are part of this. In the current model there is no way
for the DRM driver to see the suspend/resume events. I haven't tried
it but I suspect a suspend/resume with DRM running has a bad outcome
right now.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
