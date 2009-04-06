From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: commit 66c1ca breaks fbdev mode switching
Date: Mon, 6 Apr 2009 20:47:18 +0200
Message-ID: <20090406204718.ce4909b3.krzysztof.h1@poczta.fm>
References: <498817E2.3020008@gmail.com>
	<1233783983-28802-1-git-send-email-righi.andrea@gmail.com>
	<200903221748.42871.arvidjaar@gmail.com>
	<200903221857.20473.rjw@sisk.pl>
	<20090322145219.ad294615.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757880AbZDFSqX@vger.kernel.org>
In-Reply-To: <20090322145219.ad294615.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidjaar@gmail.com>, Andrea Righi <righi.andrea@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>

Hi,

The commit 66c1ca breaks fbdev mode switching. The first mode
(selected with mode_option or during boot) is ok but every mode
switch with fbset locks up computer. If the commit is reverted
mode switching works correctly.

I do not understand why. I would be grateful if someone else
can confirm the problem as well.

The commit's details are:

commit 66c1ca019078220dc1bf968f2bb18421100ef147
Author: Andrea Righi <righi.andrea@gmail.com>
Date:   Tue Mar 31 15:25:18 2009 -0700

    fbmem: fix fb_info->lock and mm->mmap_sem circular locking dependency
    

Regards,
Krzysztof

----------------------------------------------------------------------
Kto lepiej radzi sobie w kuchni?
Odpowiedz i wygraj sprzet AGD! >> http://link.interia.pl/f2103 
