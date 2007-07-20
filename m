From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [git patches] two warning fixes
Date: Fri, 20 Jul 2007 20:34:46 +0200
Message-ID: <m3644e2abd.fsf@maximus.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
	<469ECD29.2010909@garzik.org> <m3r6n4bjgg.fsf@maximus.localdomain>
	<alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764621AbXGTSfG@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.999.0707191100480.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Thu, 19 Jul 2007 11:04:29 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> More people *should* generally ask themselves: "was the warning worth it?" 
> and then, if the answer is "no", they shouldn't add code, they should 
> remove the thing that causes the warning in the first place.

Sure. If a routine uses must_check yet its return value may be
safely ignored then that must_check is simply misplaced and should
be removed. It does not mean all must_checks are bad - each of them
isn't bad unless one can demonstrate it is.

Back to sysfs_create_bin_file() - if one can demonstrate a caller
can safely ignore the return value (which, it seems, is the
case), then exactly this very must_check should be removed.
-- 
Krzysztof Halasa
