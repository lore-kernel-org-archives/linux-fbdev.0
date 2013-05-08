From: Rob Landley <rob@landley.net>
Date: Wed, 08 May 2013 20:58:30 +0000
Subject: Re: [PATCH V2] video: implement a simple framebuffer driver
Message-Id: <1368046710.18069.217@driftwood>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <201304300004.20320.arnd@arndb.de> <5182AF83.4080705@wwwdotorg.org>
 <1956593.M6NmITdEKh@avalon>
 <20130507143338.79b3d893fcdc3bd79fbe9a57@linux-foundation.org>
 <5189BA36.9000105@wwwdotorg.org>
In-Reply-To: <5189BA36.9000105@wwwdotorg.org> (from swarren@wwwdotorg.org on
 Tue May  7 21:36:38 2013)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/07/2013 09:36:38 PM, Stephen Warren wrote:
> On 05/07/2013 03:33 PM, Andrew Morton wrote:
...
> Subject: drivers/video: implement a simple framebuffer driver
> 
> A simple frame-buffer describes a raw memory region that may be  
> rendered
> to, with the assumption that the display hardware has already been set
> up to scan out from that buffer.
> 
> This is useful in cases where a bootloader exists and has set up the
> display hardware, but a Linux driver doesn't yet exist for the display
> hardware.
> 
> Examples use-cases include:

Virtual environments such as QEMU.

Rob