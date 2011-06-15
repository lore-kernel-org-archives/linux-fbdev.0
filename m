From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Jun 2011 02:37:19 +0000
Subject: Re: [PATCH] EFIFB: Fix error handling
Message-Id: <20110615023718.GK17891@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110615003817.18883.41030.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110615003817.18883.41030.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: pjones@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, stable@kernel.org

On Wed, Jun 15, 2011 at 01:38:17AM +0100, David Howells wrote:
> Fix the error handling in the EFIFB driver if platform_driver_probe() fails.
> In that case, the code will pass the driver struct to the _device_
> unregistration function.  It presumably should pass a pointer to the device
> struct instead.
> 
> The compiler gives the following warning to indicate this:
> 
> drivers/video/efifb.c: In function 'efifb_init':
> drivers/video/efifb.c:544:3: warning: passing argument 1 of 'platform_device_unregister' from incompatible pointer type
> include/linux/platform_device.h:40:13: note: expected 'struct platform_device *' but argument is of type 'struct platform_driver *'
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Peter Jones <pjones@redhat.com>
> cc: linux-fbdev@vger.kernel.org
> cc: stable@kernel.org

Thanks, I've already queued a fix for this.
