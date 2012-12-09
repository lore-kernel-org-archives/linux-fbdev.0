From: Tony Prisk <linux@prisktech.co.nz>
Date: Sun, 09 Dec 2012 23:44:38 +0000
Subject: Re: [Bulk] [PATCH] drivers/video/wm8505fb.c: use devm_ functions
Message-Id: <1355096678.6821.3.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355076491-2246-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1355076491-2246-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 2012-12-09 at 19:08 +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.
> 
> The patch makes some other cleanups.  First, the original code used
> devm_kzalloc, but kfree.  This would lead to a double free.  The problem
> was found using the following semantic match (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@
> expression x,e;
> @@
> x = devm_kzalloc(...)
> ... when != x = e
> ?-kfree(x,...);
> // </smpl>
> 
> The error-handing code of devm_request_and_ioremap does not print any
> warning message, because devm_request_and_ioremap does this.
> 
> The call to dma_alloc_coherent is converted to its devm equivalent,
> dmam_alloc_coherent.  This implicitly introduces a call to
> dmam_free_coherent, which was completly missing in the original code.
> 
> A semicolon is removed at the end of the error-handling code for the call
> to dma_alloc_coherent.
> 
> The block of code calling fb_alloc_cmap is moved below the block of code
> calling wm8505fb_set_par, so that the error-handing code of the call to
> wm8505fb_set_par can just return ret.  This way there is only one block of
> error-handling code that needs to call fb_dealloc_cmap, and so this is
> moved up to the place where it is needed, eliminating the need for all
> gotos and labels in the function.  This was suggested by Tony Prisk.
> 
> The initializations of fbi and ret at the beginning of the function are not
> necessary and are removed.  The call platform_set_drvdata(pdev, NULL); at
> the end of the function is also removed.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
> Only compiled.  Not tested.


Thanks Julia,

I will include this with the other patches we have for fbdev. I have
tested this on WM8650 and all appears fine.

Regards
Tony P

