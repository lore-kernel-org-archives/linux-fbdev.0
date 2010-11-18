From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Nov 2010 06:00:08 +0000
Subject: Re: [patch 1/2] fbcmap: cleanup white space in fb_alloc_cmap()
Message-Id: <20101118060007.GC12227@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101027093716.GD6062@bicker> <20101105134018.2c11f283.akpm@linux-foundation.org> <20101113100718.GB1795@bicker> <20101115044820.GA8489@linux-sh.org> <20101116090119.GA31724@bicker> <20101027093716.GD6062@bicker> <20101105134018.2c11f283.akpm@linux-foundation.org> <20101113100638.GA1795@bicker>
In-Reply-To: <20101116090119.GA31724@bicker> <20101113100638.GA1795@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <error27@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, Nov 13, 2010 at 01:06:38PM +0300, Dan Carpenter wrote:
> checkpatch.pl and Andrew Morton both complained about the indenting in
> fb_alloc_cmap()

On Tue, Nov 16, 2010 at 12:11:02PM +0300, Dan Carpenter wrote:
> There is an integer overflow in fb_set_user_cmap() because cmap->len * 2
> can wrap.  It's basically harmless.  Your terminal will be messed up
> until you type reset.
> 
> This patch does three things to fix the bug.
> 
> First, it checks the return value of fb_copy_cmap() in fb_alloc_cmap().
> That is enough to fix address the overflow.
> 
> Second it checks for the integer overflow in fb_set_user_cmap().
> 
> Lastly I wanted to cap "cmap->len" in fb_set_user_cmap() much lower
> because it gets used to determine the size of allocation.  Unfortunately
> no one knows what the limit should be.  Instead what this patch does
> is makes the allocation happen with GFP_KERNEL instead of GFP_ATOMIC
> and lets the kmalloc() decide what values of cmap->len are reasonable.
> To do this, the patch introduces a function called fb_alloc_cmap_gfp()
> which is like fb_alloc_cmap() except that it takes a GFP flag.

Both applied, thanks.
