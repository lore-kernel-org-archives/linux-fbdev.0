From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Hotplug blacklist and video devices
Date: Sat, 19 Feb 2005 16:51:01 +0000
Message-ID: <1108831861.4085.172.camel@tyrosine>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
	 <9e47339105021907561c4f408c@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105021907561c4f408c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>, lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-02-19 at 10:56 -0500, Jon Smirl wrote:

> I didn't say make framebuffer depend on DRM, you can still unload DRM
> before suspend.  It's the other way around DRM needs framebuffer.
> Suspend/resume are part of this. In the current model there is no way
> for the DRM driver to see the suspend/resume events. I haven't tried
> it but I suspect a suspend/resume with DRM running has a bad outcome
> right now.

Right. But for most machines, it's not possible to successfully resume
if an accelerated framebuffer driver is loaded. Until that's fixed,
tying DRM functionality to the framebuffer will make it impractical to
use DRM on laptops. That's a regression from the current situation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
