From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] video: includecheck fix: msm, mddi.c
Date: Sat, 26 Sep 2009 13:35:58 +0200
Message-ID: <20090926113558.GA3105@ucw.cz>
References: <1253790872.5860.13.camel@ht.satnam>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752398AbZIZLof@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1253790872.5860.13.camel@ht.satnam>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Brian Swetland <swetland@google.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Rebecca Schultz Zavin <rebecca@android.com>, Dima Zavin <dima@android.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thu 2009-09-24 16:44:32, Jaswinder Singh Rajput wrote:
> 
> fix the following 'make includecheck' warning:
> 
>   drivers/video/msm/mddi.c: linux/delay.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
