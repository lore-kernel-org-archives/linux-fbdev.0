From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: Hotplug blacklist and video devices
Date: Sat, 19 Feb 2005 12:29:13 +0000
Message-ID: <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
References: <9e4733910502181251ea2b95e@mail.gmail.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <9e47339105021813146cf69759@mail.gmail.com>
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl <jonsmirl@gmail.com> wrote:

> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded. If you back
> up further this is part of fixing X so that it won't mess with the
> hardware from user space. Mode setting would come from the framebuffer
> driver instead of the X 2D XAA driver.

Please don't until all the framebuffer drivers are able to deal with
suspend and resume (which will also require some mechanism to switch
backlights back on). Currently, it's far easier to restore some amount
of state on a standard VGA or VESA mode. There's no real support for
doing so with most accelerated framebuffers.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
