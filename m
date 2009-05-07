From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cg3: use standard fields for framebuffer physical
 address and length
Date: Thu, 07 May 2009 11:42:30 -0700 (PDT)
Message-ID: <20090507.114230.248161472.davem@davemloft.net>
References: <20090505084505.C94E615F7883@f12.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20090505084505.C94E615F7883@f12.poczta.interia.pl>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: Text/Plain; charset="us-ascii"
To: krzysztof.h1@poczta.fm
Cc: linux-fbdev-devel@lists.sourceforge.net, sparclinux@vger.kernel.org

From: krzysztof.h1@poczta.fm
Date: 05 May 2009 10:45:05 +0200

> However, there is no adjustment to the smem_start outside the
> driver. It is used only to be displayed by the fbset (which is
> general and does not understand the IO spaces).  Another usage is
> inside the fb_mmap but only if there is no local fb_mmap function
> defined by the driver. It is not a case for all sbus drivers.

Good point, OK, I'm fine with these changes:

Acked-by: David S. Miller <davem@davemloft.net>
