From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] video: includecheck fix: da8xx-fb.c
Date: Sat, 3 Oct 2009 07:08:04 +0200
Message-ID: <20091003070804.68abad29.krzysztof.h1@wp.pl>
References: <1253790430.5860.11.camel@ht.satnam>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751724AbZJCEvi@vger.kernel.org>
In-Reply-To: <1253790430.5860.11.camel@ht.satnam>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>, Steve Chen <schen@mvista.com>, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, Andrew Morton <akpm@linux-foundation.org>, davinci <davinci-linux-open-source@linux.davincidsp.com>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thu, 24 Sep 2009 16:37:10 +0530
Jaswinder Singh Rajput <jaswinder@kernel.org> wrote:

> 
> fix the following 'make includecheck' warning:
> 
>   drivers/video/da8xx-fb.c: linux/device.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
> Cc: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> Cc: Steve Chen <schen@mvista.com>
> Cc: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/video/da8xx-fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
