From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:17:53 +0000
Subject: Re: [PATCH] drivers/video/udlfb bind framebuffer to interface.
Message-Id: <20110713081752.GD13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309910651-3483-1-git-send-email-bernie@plugable.com>
In-Reply-To: <1309910651-3483-1-git-send-email-bernie@plugable.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 05, 2011 at 05:04:11PM -0700, bernie@plugable.com wrote:
> Udlfb has been binding the framebuffer device to its parent, which
> isn't correct and causes confusion with operations like udev remove.
> 
> Coming plug and play multiseat support is dependent on this fix.
> 
> Signed-off-by: Bernie Thompson <bernie@plugable.com>

On Sun, Jul 10, 2011 at 12:30:00AM -0700, bernie@plugable.com wrote:
> Match udlfb only against vendor-specific class (e.g. only DisplayLink
> graphics, not composite standard audio class interfaces). This enables
> compatibility with composite graphics+audio devices (e.g. HDMI).
> 
> Match udlfb only against compatible subclass 0 and protocol 0 chips.
> DisplayLink's USB 3.0 generation chips increment these values
> to signal that they have a incompatible protocol, preventing udlfb
> from erroneously matching to hardware it does not support.
> 
> Tested to confirm proper behavior on both USB 2.0 and USB 3.0
> generation devices.
> 
> Reported-by: Andrew Kephart <akephart@akephart.org>
> Signed-off-by: Bernie Thompson <bernie@plugable.com>

Both queued for 3.0, thanks.
