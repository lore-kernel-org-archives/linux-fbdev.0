From: Bill Nottingham <notting@redhat.com>
Subject: Re: Hotplug blacklist and video devices
Date: Fri, 18 Feb 2005 16:08:22 -0500
Message-ID: <20050218210822.GB8588@nostromo.devel.redhat.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e4733910502181251ea2b95e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

Jon Smirl (jonsmirl@gmail.com) said: 
> Why are all of the framebuffer drivers on the hotplug blacklist?

Well, that probably depends on your distribution. :)

Under Fedora (and RHEL), they're there because we generally
don't want to load them unless the user asked for them.

Bill
