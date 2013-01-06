From: Alexander Holler <holler@ahsoftware.de>
Date: Sun, 06 Jan 2013 12:46:37 +0000
Subject: Re: [PATCH] fb: udlfb: fix scheduling while atomic.
Message-Id: <50E9722D.2090602@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50E81166.6050605@ahsoftware.de> <1357386129-763-1-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1357386129-763-1-git-send-email-holler@ahsoftware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Holler <holler@ahsoftware.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Bernie Thompson <bernie@plugable.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Glendinning <steve.glendinning@shawell.net>, Dave Airlie <airlied@redhat.com>, stable@vger.kernel.org

Am 05.01.2013 12:42, schrieb Alexander Holler:
> The console functions are using spinlocks while calling fb-driver ops
> but udlfb waits for a semaphore in many ops. This results in the BUG
> "scheduling while atomic". One of those call flows is e.g.
>
> vt_console_print() (spinlock printing_lock)
> 	(...)
> 	dlfb_ops_imageblit()
>                          dlfb_handle_damage()
>                                  dlfb_get_urb()
> 					down_timeout(semaphore)
> BUG: scheduling while atomic
> (...)
> vt_console_print() (release spinlock printing_lock)
>
> Fix this through a workqueue for dlfb_handle_damage().
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>


Having had a second look at my patch for udlfb, I'm not sure it will 
work with more than one of those devices attached. I think my approach 
to just add one (static) workqueue might not work in such a case, at 
least it looks so to me. But I'm unable to test it, as I only have one 
of those devices.

Having had a look at udl, I wonder why udlfb still has to be around. But 
because udl currently doesn't work here too, I'm not sure what 
functionality udl misses which udlfb still has.

So to conclude, my patch works as a workaround if only one of those 
devices will be attached, but currently should not be included into the 
kernel.

I don't know if I will make another version of that patch, as I will 
first have a deeper look at udl (if I find the time).

Regards,

Alexander

