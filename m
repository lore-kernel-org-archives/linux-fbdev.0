From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 20:49:25 +0800
Message-ID: <200503012049.25809.adaplas@hotpop.com>
References: <20050301024118.GF4021@stusta.de>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050301024118.GF4021@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> Hi,
>
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
>
> Do modular framebuffers really make sense?
>
> OK, distributions like to make everything modular, but all the
> framebuffer drivers I've looked at parse driver specific options in
> their *_setup function only in the non-modular case.
>
> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

Only a few drivers are capable of being unloaded with the possiblity of
restoring the vga console (i810fb and rivafb), when CONFIG_FBCON = n.

If CONFIG_FBCON=y, it's not possible to unload the module unless 2 drivers
are loaded at the same time. One driver can be mapped to the console, so the
other can be unloaded.  Although not important from the user's POV, it is
quite helpful when debugging/developing drivers.

Currently fbcon cannot be unloaded, it will freeze the system.

Tony
