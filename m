From: Greg KH <greg@kroah.com>
Date: Thu, 18 Feb 2010 15:59:37 +0000
Subject: Re: [PATCH 7/10] udlfb: improved rendering performance
Message-Id: <20100218155937.GE21785@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245181.4353.3302.camel@bernie-aspireone>
In-Reply-To: <1266245181.4353.3302.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Feb 15, 2010 at 06:46:21AM -0800, Bernie Thompson wrote:
> Rework rendering for improved performance
> 
> Approx 10-20% gain avg across several "benchmarks": x11perf, gtkperf, glxgears
> Moves from a single pre-alloc'd urb protected by a long-held mutex
> To a list of (4) pre-alloc'd urbs which can be dispatched asynchonously
> 
> Improved rendering algorithm to hardware with lower CPU consumption, 
> fewer system memory accesses, and slightly higher compression.
> 
> Better scalability to multiple processors, especially with
> multiple framebuffers active.

Very nice job, although it would be interesting to see if the
preallocated urbs really had any affect here :)

thanks,

greg k-h
