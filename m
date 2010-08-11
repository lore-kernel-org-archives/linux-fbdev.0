From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 11 Aug 2010 21:16:48 +0000
Subject: Re: [PATCH] matroxfb: fix incorrect use of memcpy_toio()
Message-Id: <201008112316.52063.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008112227.44990.linux@rainbow-software.org> <20100811134136.c53f8eba.akpm@linux-foundation.org>
In-Reply-To: <20100811134136.c53f8eba.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Jean Delvare <khali@linux-fr.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Wednesday 11 August 2010 22:41:36 Andrew Morton wrote:
> On Wed, 11 Aug 2010 22:27:42 +0200
>
> Ondrej Zary <linux@rainbow-software.org> wrote:
> > Fix incorrect use of memcpy_toio() in matroxfb that broke in 2.6.34 on
> > x86.
>
> Thanks.
>
> What was incorrect about it?  And what is the user-visible effect of
> this regression?

Screen is completely corrupted since 2.6.34. Bisection revealed that it's 
caused by commit 6175ddf06b6172046a329e3abfd9c901a43efd2e. H. Peter Anvin 
explained that memcpy_toio() does not copy data in 32bit chunks anymore on 
x86.

See: http://lkml.org/lkml/2010/8/2/409

-- 
Ondrej Zary
