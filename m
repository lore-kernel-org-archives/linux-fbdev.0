From: Bill Nottingham <notting@redhat.com>
Subject: Re: Hotplug blacklist and video devices
Date: Mon, 21 Feb 2005 14:08:13 -0500
Message-ID: <20050221190812.GA30832@nostromo.devel.redhat.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com> <20050218210822.GB8588@nostromo.devel.redhat.com> <9e47339105021813146cf69759@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl (jonsmirl@gmail.com) said: 
> Is there a specific reason why they are blocked? 
> 
> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded. If you back
> up further this is part of fixing X so that it won't mess with the
> hardware from user space. Mode setting would come from the framebuffer
> driver instead of the X 2D XAA driver.

If it's a hard module dep, I don't see how that would be a problem;
that would ignore the blacklist.

Bill
