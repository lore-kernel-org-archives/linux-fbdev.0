From: Tim Tassonis <timtas@cubic.ch>
Subject: Re: [git patches] two warning fixes
Date: Fri, 20 Jul 2007 14:54:03 +0200
Message-ID: <46A0B06B.3060701@cubic.ch>
References: <20070718235504.GA9601@havoc.gtf.org> <alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org> <m3vecgbjix.fsf@maximus.localdomain> <alpine.LFD.0.999.0707191056010.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760703AbXGTNWy@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.999.0707191056010.27353@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Linus Torvalds wrote:

> 
> I think "must_check" is an abomination. It makes the callee dictate what 
> the caller has to do, but dammit, if the callee really "knows" its errors 
> are that serious, it should damn well handle them itself.
> 
> The whole "sysfs_create_file()" thing is an example of that. If it fails, 
> it fails. The caller can't do anythign about it anyway, except perhaps 
> print a message.  Why the hell does such a function have the "right" to 
> dictate what the user should do?

Well, that's just how OO fascists think. An object dictates to the user 
what he/she can do with it, as opposed to the user can do what he 
wants/needs.


Tim
