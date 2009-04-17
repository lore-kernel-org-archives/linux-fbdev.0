From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix fb_info->lock and
	mm->mmap_sem ...} causes Xfbdev not working
Date: Sat, 18 Apr 2009 00:51:11 +0200
Message-ID: <20090417225110.GA6972@linux>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com> <20090409125850.GA2727@linux> <20090410222122.87be60f6.krzysztof.h1@poczta.fm> <20090410220521.GB21294@linux> <20090411080415.7fe924a2.krzysztof.h1@poczta.fm> <49E05C36.9040204@s5r6.in-berlin.de> <20090411110840.GA7108@linux> <20090411150359.GA8265@linux> <20090417182507.0bd85ccc.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755457AbZDQWvc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090417182507.0bd85ccc.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Eric Miao <eric.y.miao@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidjaar@gmail.com>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Dave Jones <davej@redhat.com>, Harvey Harrison <harvey.harrison@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Pavel Roskin <proski@gnu.org>

On Fri, Apr 17, 2009 at 06:25:07PM +0200, Krzysztof Helt wrote:
> On Sat, 11 Apr 2009 17:04:00 +0200
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > It would be great if someone could help me to test this patch (against
> > latest Linus' git - no need to revert 66c1ca).
> > 
> 
> I can confirm the patch fixes the issue on radeonfb and cirrusfb drivers tested so far.
> 
> Regards,
> Krzysztof

Thanks for testing!
-Andrea
