From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Hotplug blacklist and video devices
Date: Sat, 19 Feb 2005 11:54:57 -0800
Message-ID: <42179991.6090808@goop.org>
References: <9e4733910502181251ea2b95e@mail.gmail.com>	 <20050218210822.GB8588@nostromo.devel.redhat.com>	 <9e47339105021813146cf69759@mail.gmail.com>	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk> <9e47339105021907561c4f408c@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <9e47339105021907561c4f408c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>, lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl wrote:

>I didn't say make framebuffer depend on DRM, you can still unload DRM
>before suspend.  It's the other way around DRM needs framebuffer.
>
Only if you want to see the output, surely?  I have an application which 
doesn't need a framebuffer (or more strictly, scan-out), but does use DRM.

    J
