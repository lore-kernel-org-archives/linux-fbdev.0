From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix fb_info->lock and
 mm->mmap_sem ...} causes Xfbdev not working
Date: Sat, 11 Apr 2009 08:04:15 +0200
Message-ID: <20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755801AbZDKGCa@vger.kernel.org>
In-Reply-To: <20090410220521.GB21294@linux>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidjaar@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>

On Sat, 11 Apr 2009 00:05:22 +0200
Andrea Righi <righi.andrea@gmail.com> wrote:

> 
> mmmh... I may have missed something, but the common fb_mmap() should
> acquire mm->mmap_sem and then info->lock, while fb_ioctl() can do that
> in reverse order (info->lock first and then mm->mmap_sem) causing the
> circular locking dependency. Are you sure that pushing info->lock down
> each driver's fb_mmap will fix the problem?

Right. The fb_mmap is called with the mmap_sem already held.
I will try other possibilities like breaking info->lock() into two
mutexex.

Something should be done to solve this problem.

Best regards,
Krzysztof

----------------------------------------------------------------------
Oblej swoich znajomych... wirtualnie! ;)
http://link.interia.pl/f2119
