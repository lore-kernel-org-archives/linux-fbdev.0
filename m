From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mmotm] fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency
Date: Thu, 5 Feb 2009 02:49:25 +0100
Message-ID: <200902050249.27244.rjw@sisk.pl>
References: <498817E2.3020008@gmail.com> <1233783983-28802-1-git-send-email-righi.andrea@gmail.com> <200902050058.31680.rjw@sisk.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762043AbZBEBuH@vger.kernel.org>
In-Reply-To: <200902050058.31680.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>

On Thursday 05 February 2009, Rafael J. Wysocki wrote:
> On Wednesday 04 February 2009, Andrea Righi wrote:
> > Fix this circular locking dependencies in the frame buffer console
> > driver pushing down the mutex fb_info->lock.
> > 
> > Circular locking dependecies occur calling the blocking
> > fb_notifier_call_chain() with fb_info->lock held. Notifier callbacks can
> > try to acquire mm->mmap_sem, while fb_mmap() acquires the locks in the
> > reverse order mm->mmap_sem => fb_info->lock.
> 
> Does this fix a Bugzilla bug?  If so, then which one?

Never mind, found it.

Thanks,
Rafael
