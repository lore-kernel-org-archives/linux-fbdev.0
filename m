From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] cyber2000fb.c: misc cleanups
Date: Sun, 21 Nov 2004 20:47:52 +0000
Message-ID: <20041121204752.A23300@flint.arm.linux.org.uk>
References: <20041121153614.GR2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261710AbUKUUr7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041121153614.GR2829@stusta.de>; from bunk@stusta.de on Sun, Nov 21, 2004 at 04:36:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, Nov 21, 2004 at 04:36:14PM +0100, Adrian Bunk wrote:
> The patch below ncludes the following cleanups for 
> drivers/video/cyber2000fb.c:
> - remove five EXPORT_SYMBOL'ed but completely unused functions
> - make some needlessly global code static

These are used by the video capture code which isn't merged, but is
used by people.  Rejected.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
