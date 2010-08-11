From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 11 Aug 2010 20:41:36 +0000
Subject: Re: [PATCH] matroxfb: fix incorrect use of memcpy_toio()
Message-Id: <20100811134136.c53f8eba.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201008112227.44990.linux@rainbow-software.org>
In-Reply-To: <201008112227.44990.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Jean Delvare <khali@linux-fr.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Wed, 11 Aug 2010 22:27:42 +0200
Ondrej Zary <linux@rainbow-software.org> wrote:

> Fix incorrect use of memcpy_toio() in matroxfb that broke in 2.6.34 on x86.
> 

Thanks.

What was incorrect about it?  And what is the user-visible effect of
this regression?

