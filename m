From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 13 Dec 2009 19:43:43 +0000
Subject: Re: [PATCH 7/9] drivers/video: Correct code taking the size of a
Message-Id: <20091213114343.a60828d3.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.0912131242240.24267@ask.diku.dk>
	<4B24E3AB.9040609@gmx.de>
In-Reply-To: <4B24E3AB.9040609@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Julia Lawall <julia@diku.dk>, JosephChan@via.com.tw, Scott Fang <ScottFang@viatech.com.cn>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, 13 Dec 2009 13:52:59 +0100 Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:

> Hi Julia, Andrew,
> 
> Julia Lawall schrieb:
> > From: Julia Lawall <julia@diku.dk>
> > 
> > sizeof(viafb_gamma_table) is just the size of the pointer.  This is changed
> > to the size used when calling kmalloc to initialize the pointer.
> 
> this is the second patch addressing this issue ending up in my mailbox. 
> At least this one is technically correct so feel free to upstream it.
> However I vote for removing this ioctl hell from viafb as most of them 
> duplicate framebuffer functionality or have unknown (not clearly 
> defined) functionality or at least solve a generic problem with a custom 
> ioctl (which I consider bad). I had a patch ready to move this stuff to 
> an extra file and print a warning that it is subject to be removed. I 
> feel a bit uncomfortable about repairing broken stuff prior to removing it.
> Any comments on this subject?
> 

I favour both repairing and removing broken stuff ;)

We may as well fix it if problems are known.  Perhaps someone is
hitting the problem at runtime in an older kernel and needs a patch to
backport.  Perhaps we later decide to revert the removal, thus
reinstating the known bug.

