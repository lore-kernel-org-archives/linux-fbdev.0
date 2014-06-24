From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 24 Jun 2014 13:51:01 +0000
Subject: Re: [PATCH] video: hyperv: hyperv_fb: refresh the VM screen by force on VM panic
Message-Id: <20140624135101.GB10115@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403569757-2622-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1403569757-2622-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dexuan Cui <decui@microsoft.com>
Cc: linux-fbdev@vger.kernel.org, jasowang@redhat.com, driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com, olaf@aepfle.de, apw@canonical.com, plagnioj@jcrosoft.com, haiyangz@microsoft.com

On Tue, Jun 24, 2014 at 08:29:17AM +0800, Dexuan Cui wrote:
> Currently the VSC has no chance to notify the VSP of the dirty rectangle on VM
> panic because the notification work is done in a workqueue, and in panic() the
> kernel typically ends up in an infinite loop, and a typical kernel config has
> CONFIG_PREEMPT_VOLUNTARY=y and CONFIG_PREEMPT is not set, so a context switch
> can't happen in panic() and the workqueue won't have a chance to run. As a
> result, the VM Connection window can't refresh until it's closed and we
> re-connect to the VM.
> 
> We can register a handler on panic_notifier_list: the handler can notify
> the VSC and switch the framebuffer driver to a "synchronous mode", meaning
> the VSC flushes any future framebuffer change to the VSP immediately.
> 
> MS-TFS: 157532

What is this line for?

thanks,

greg k-h
