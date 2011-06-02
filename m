From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:20:39 +0000
Subject: Re: [PATCH 0/4] efifb speedup and fixes
Message-Id: <20110602082039.GH6087@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1306418703.git.luto@mit.edu>
In-Reply-To: <cover.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, May 26, 2011 at 10:13:30AM -0400, Andy Lutomirski wrote:
> Fbcon over efifb is so slow that I thought I needed a faster modem.
> It turns out that scrolling boot messages at 1024x768 pixels with
> uncached accesses can take longer than every other step of kernel
> bootup *combined*.
> 
> Fixing it is a one-liner, but I found some bugs while I was digging
> around.  One is a mismatched resource release (although not on my
> box), one is a harmless compiler warning, and one fixes all manner of
> badness that happens if you manually bind or unbind the efifb driver.
> 
> The speedup may or may not be 2.6.40 material, but the other fixes
> should probably go in.  (2/4 and 4/4 are possibly -stable candidates.)
> 
> Andy Lutomirski (4):
>   efifb: Enable write-combining
>   efifb: Fix mismatched request/release_mem_region
>   efifb: Fix an integer-to-pointer size warning
>   efifb: Disallow manual bind and unbind
> 
I've applied patches 1, 2, and 4 along with Peter's sign off. I've not
added a stable cc since neither were specifically regressions, so I'll
just let Greg naturally decide whether to take them or not.
