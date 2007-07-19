From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 15:40:15 +0200
Message-ID: <m3r6n4bjgg.fsf@maximus.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<alpine.LFD.0.999.0707181834070.27353@woody.linux-foundation.org>
	<469ECD29.2010909@garzik.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S937652AbXGSNkv@vger.kernel.org>
In-Reply-To: <469ECD29.2010909@garzik.org> (Jeff Garzik's message of "Wed, 18 Jul 2007 22:32:09 -0400")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ak@suse.de, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

Jeff Garzik <jeff@garzik.org> writes:

> My overall goal is killing useless warnings
> that continually obscure real ones.

Precisely, the goal should be to make must_check (and similar things)
warn only in real cases.
-- 
Krzysztof Halasa
