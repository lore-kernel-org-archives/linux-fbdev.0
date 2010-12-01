From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Dec 2010 09:19:59 +0000
Subject: Re: [PATCH] video: da8xx: Register IRQ as last thing in driver probing.
Message-Id: <20101201091959.GB2982@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Nov 30, 2010 at 10:04:14PM +0200, caglarakyuz@gmail.com wrote:
> From: Caglar Akyuz <caglar@bilkon-kontrol.com.tr>
> 
> Following commit exposed a bug in driver:
> 
> 	"fbdev: da8xx/omap-l1xx: implement double buffering"
> 
> Bug is, if interrupt handler is called before initialization is
> finished, raster controller is enabled and following register
> modifications causes hardware to stay in a broken state.
> 
> By looking at this one may say that proper locking is missing in
> this driver, and a more proper fix should be prepared. However,
> aformentioned commit causes a regression in the driver and some
> fix to current one should be applied first.
> 
> Signed-off-by: Caglar Akyuz <caglar@bilkon-kontrol.com.tr>

Barring any objections from the davinci folks, I've queued this up.
