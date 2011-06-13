From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Jun 2011 04:00:04 +0000
Subject: Re: [PATCH] fb.h: ARM uses __raw_{read/write}
Message-Id: <20110613040003.GA29731@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201106101731.08578.hartleys@visionengravers.com>
In-Reply-To: <201106101731.08578.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 10, 2011 at 05:31:08PM -0700, H Hartley Sweeten wrote:
> ARM provides __raw_{read/write}* functions for memory access. These
> should be used instead of the default '(*(volatile' stuff to make sure the
> memory accesses are typesafe (void __iomem *).
> 
> This also fixes a number of sparse warning like:
> 
>   warning: cast removes address space of expression
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> 
I'm not sure what semantics are desirable for ARM here, so I'll wait for
Russell to reply.

This wrapping will basically mean that the fb_read/write ops are using
__raw_xxx variants while the memset and memcpy wrappers will be using the
regular read/write[bwl] routines which contain __iormb() calls. Given
that ioread/write and friends all wrap in to the normal versions with the
barriers, I would suppose that this is the default behaviour that is
desired, as opposed to wrapping in to the __raw_xxx variants directly.
