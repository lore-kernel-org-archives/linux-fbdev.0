From: Satyam Sharma <satyam@infradead.org>
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
Date: Thu, 20 Sep 2007 19:54:31 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0709201946130.17093@enigma.security.iitk.ac.in>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
 <20070919172412.725508d0.akpm@linux-foundation.org>
 <Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
 <alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
 <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757142AbXITOVw@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org



On Thu, 20 Sep 2007, Maciej W. Rozycki wrote:
> 
>  Perhaps preinitialising to an error value such as -EINVAL would be of
> more sense.  This way any error paths lacking initialisation are still
> reported as errors, even though the classification might be wrong.

Eeee ... at least I wouldn't prefer that. Why not simply use the
"int x = x;" trick (which is what uninitialized_var() does) -- it shuts
up the warning, and does *nothing* else. The bug will not be hidden, if
there's bad misbehaviour happening due to the bug, it will continue to
happen that way -- thus bringing our attention to it. Pre-initializing
to -EINVAL (or whatever) has the problem that when the bug actually
triggers, something unrelated might happen higher up the callchain, and
we'd be scratching our heads in a "why are we getting a -EINVAL here?"
kind of way ... worse still, we might think that this was _really_ an
EINVAL and go about debugging it ...

Plus, pre-initializing to -EINVAL (or even 0) will waste some bytes in
kernel text size, but no such overhead with uninitialized_var() :-)


Satyam
