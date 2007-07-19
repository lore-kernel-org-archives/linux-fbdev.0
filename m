From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 15:38:46 +0200
Message-ID: <m3vecgbjix.fsf@maximus.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937267AbXGSNjA@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Wed, 18 Jul 2007 18:37:53 -0700 (PDT)")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So let's make a new rule:
>
>   We absolutely NEVER add things like "must_check" unless not checking 
>   causes a real and obvious SECURITY ISSUE.

Oh, come on, almost every kernel bug is a potential security issue.

IMHO, if the function can only fail due to a kernel bug, it should
return void and, in case of bug, explode with BUG_ON() or something
like that. Sure, must_check doesn't apply too well to void.

But, if I have functions which can fail for legitimate (not kernel
bug) reasons, and I know ignoring their return values would always
be a bug, then must_check seems an obvious best and simple defense
against that.
-- 
Krzysztof Halasa
