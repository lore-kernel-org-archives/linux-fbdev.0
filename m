From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 15 Jun 2011 11:52:47 +0000
Subject: Re: [PATCH] video: Add GRVGA framebuffer device driver
Message-Id: <4DF89D0F.9040801@gaisler.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Geert Uytterhoeven wrote:

> At first sight, nothing in this driver seems to be SPARC-specific, so
> perhaps this can be relaxed
> to e.g. depends on OF_DEVICE?
> 


It uses of_ioremap/unmap which are SPARC-specific. I have been bitten by things like this before 
when thinking I was portable so this time I just depended on SPARC. The core is not used on any
other platforms and is not very likely to be used either.



> Please remove the cast and use %p to format the address.

Will do.

Thanks,
Kristoffer Glembo
