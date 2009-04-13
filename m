From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix fb_info->lock and mm->mmap_sem ...} causes Xfbdev not working
Date: Tue, 14 Apr 2009 01:34:47 +0200
Message-ID: <m21vrwi0vc.fsf@igel.home>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
	<20090410222122.87be60f6.krzysztof.h1@poczta.fm>
	<20090410220521.GB21294@linux>
	<20090411080415.7fe924a2.krzysztof.h1@poczta.fm>
	<49E05C36.9040204@s5r6.in-berlin.de> <20090411110840.GA7108@linux>
	<20090411150359.GA8265@linux>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754627AbZDMXf2@vger.kernel.org>
In-Reply-To: <20090411150359.GA8265@linux> (Andrea Righi's message of "Sat, 11
	Apr 2009 17:04:00 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Eric Miao <eric.y.miao@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidjaar@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Pavel Roskin <proski@gnu.org>

Andrea Righi <righi.andrea@gmail.com> writes:

> Tested intelfb and X11 with fbdev. It seems to work fine, but I may be
> unable to test the mode switching right now:
>
>   intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
>
> It would be great if someone could help me to test this patch (against
> latest Linus' git - no need to revert 66c1ca).

I can confirm that it fixes the issue.  Tested with radeonfb and MOL.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
