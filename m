From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Mar 2012 20:49:18 +0000
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
Message-Id: <1332362958.2982.41.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
 <4F6A2FEC.6040003@gmx.de>
In-Reply-To: <4F6A2FEC.6040003@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Tony Breeds <tbreeds@au1.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, 2012-03-21 at 19:45 +0000, Florian Tobias Schandinat wrote:
> I finally found where we started to discuss this issue, for reference
> "sm501fb.c: support mmap on PPC440SPe/PPC440EPx" back in May 2010.
> 
> The thing I don't remember is why we consider exporting the physical
> address to userspace desirable (or even necessary). Fixing the generic
> mmap would be trivial without breaking or adding any userspace ABI, I
> think. Just adding those things to fb_info and adjusting fb_mmap
> should
> do the trick, shouldn't it?

For historical reasons, things like X or directfb used it. Modern X
drivers shouldn't any more, but heh...

Cheers,
Ben.


