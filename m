From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] fbdev sysfs imrovements
Date: Sun, 1 Apr 2007 01:56:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704010156001.5314@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0703192055090.27580@pentafluge.infradead.org>
 <20070326195807.184474d7.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751059AbXDAA4j@vger.kernel.org>
In-Reply-To: <20070326195807.184474d7.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <greg@kroah.com>


I can't seem to duplicate this error. Do you have any patches applied to 
the nvidia driver?

On Mon, 26 Mar 2007, Andrew Morton wrote:

> On Tue, 20 Mar 2007 14:25:49 +0000 (GMT) James Simmons <jsimmons@infradead.org> wrote:
> 
> > This patch does several things to allow the underlying hardware to be 
> > shared amount many devices. The most important thing is the use of
> > the created device via device_create instead of the hardware device. No 
> > longer should fbdev drivers use the xxx_set_drvdata with the parent
> > bus device. The second change is having a bus independent power management
> > for the framebuffer driver. The final change is using the release method 
> > to cleanup the device. The reason again is to make the fbdev driver 
> > independent of the bus parent device. Feedback is welcomed.
> 
> Causes an early crash on the powermac G5.
> 
> http://userweb.kernel.org/~akpm/s5000489.jpg (the oops is the usual powerpc
> mess)
> 
> config at http://userweb.kernel.org/~akpm/config-g5.txt
> 
