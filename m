From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve
	diagnostics
Date: Thu, 20 Sep 2007 15:04:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
	<20070919172412.725508d0.akpm@linux-foundation.org>
	<Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
	<alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IYMdu-0006Ey-Me for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 07:04:34 -0700
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IYMds-0005EZ-UC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 20 Sep 2007 07:04:34 -0700
In-Reply-To: <alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Satyam Sharma <satyam@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org

Hi Satyam,

> Firstly, "may be used uninitialized" can still be a bug.

 Of course -- essentially GCC cannot really figure out whether all the 
possible paths of execution include initialisation or not and complains 
just in case.

> Secondly, latest gcc is *horribly* buggy (and has been so for last several
> releases including 4.1, 4.2 and 4.3 -- 3.x was good). See:
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33327
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
> 
> We'd been hurling all sorts of abuses on gcc for quite long (when it fails
> to detect these "false positive" cases), but now, it turns out it is quite
> easy to write *genuinely* buggy code that still won't get any warnings,
> neither the "is used" nor "may be used" one!

 GCC for MIPS used to be problematic enough elsewhere I do not want to 
turn back.  Even 4.0.x generates bad code, e.g. fs/partitions/msdos.c gets 
miscompiled for the big endianness (but not for the little one!).  
Compared to that some useless warnings are negligible.  This 4.1.2 version 
has triggered no problems with the kernel yet (though I suspect it is 
still so-so -- e.g. gmp gets miscompiled; which used to be fine with 
4.0.x, oddly enough).

> In short, there are three ways to fix these false positive warnings:
> 
> 1. Do nothing, there are enough "uninitialized variable" warnings anyway,
>    and hopefully, one day GCC would clean up its act.
> 
> 2. Use uninitialized_var() to shut it up (only if it's genuinely bogus).
> 
> 3. Do something like the following legendary patch [1]:
> 
> http://kegel.com/crosstool/crosstool-0.43/patches/linux-2.6.11.3/arch_alpha_kernel_srcons.patch
> 
> i.e., explicitly change the structure/logic of the function to make it
> obvious enough to gcc that the variable will not be used uninitialized.

 Perhaps preinitialising to an error value such as -EINVAL would be of 
more sense.  This way any error paths lacking initialisation are still 
reported as errors, even though the classification might be wrong.  In 
fact more exotic one might be chosen (the glibc manual has some nice 
proposals if none of these we currently define fits) so the mistake is 
more obvious.

  Maciej

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
