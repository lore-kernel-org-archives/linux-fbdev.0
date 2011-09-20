From: Andrea Righi <arighi@develer.com>
Date: Tue, 20 Sep 2011 22:20:45 +0000
Subject: Re: [patch 1/1] fb: fix potential deadlock between lock_fb_info and
Message-Id: <20110920222045.GB11829@thinkpad>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201109202111.p8KLBAJD019239@wpaz13.hot.corp.google.com>
In-Reply-To: <201109202111.p8KLBAJD019239@wpaz13.hot.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Sep 20, 2011 at 09:46:08PM +0000, Florian Tobias Schandinat wrote:
> Hi Andrew,
> 
> On 09/20/2011 09:11 PM, akpm@google.com wrote:
> > From: Andrea Righi <arighi@develer.com>
> > Subject: fb: fix potential deadlock between lock_fb_info and console_lock
> > 
> > fb_set_suspend() must be called with the console semaphore held, which
> > means the code path coming in here will first take the console_lock() and
> > then call lock_fb_info().
> > 
> > However several framebuffer ioctl commands acquire these locks in reverse
> > order (lock_fb_info() and then console_lock()).  This gives rise to
> > potential AB-BA deadlock.
> > 
> > Fix this by changing the order of acquisition in the ioctl commands that
> > make use of console_lock().
> 
> I already have another patch [1] that fixes the same issue in a different way.
> It looks less risky than yours and got more feedback.
> 
> 
> Best regards,
> 
> Florian Tobias Schandinat
> 
> 
> [1] http://marc.info/?l=linux-kernel&m0833638508657&w=2

Looks better than my version.

For what it's worth it:

Reviewed-by: Andrea Righi <andrea@betterlinux.com>

Thanks,
-Andrea
