From: Greg KH <greg@kroah.com>
Date: Thu, 18 Feb 2010 15:54:56 +0000
Subject: Re: [PATCH 3/10] udlfb: pre-allocated urb list helpers
Message-Id: <20100218155456.GC21785@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245155.4353.3298.camel@bernie-aspireone>
In-Reply-To: <1266245155.4353.3298.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 06:45:55AM -0800, Bernie Thompson wrote:
> Add functions to pre-allocate and free usb bulk urbs for core render path.
> 
> Udlfb currently allocates a single urb, guarded by a mutex, that is a key
> bottleneck. Because udlfb sends so much data, preallocation is most efficient.

I'm not going to reject this patch, but are you sure about this being
needed?  The code path for creating a new urb is very tiny, just a
memory allocation.  Is that really noticable in any benchmarks or cpu
usage that you have found?

curious,

greg k-h
