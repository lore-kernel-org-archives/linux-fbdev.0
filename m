From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 05/16] viafb: Determine type of 2D engine and store it
 in chip_info
Date: Sun, 18 Apr 2010 20:00:24 +0200
Message-ID: <20100418180024.GY18200@prithivi.gnumonks.org>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
 <1270746946-12467-6-git-send-email-corbet@lwn.net>
 <4BBE9CFC.2020804@gmx.de>
 <20100409141127.42e4e1fa@bike.lwn.net>
 <4BBF8F48.2070902@gmx.de>
 <20100418113430.53760f99@bike.lwn.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100418113430.53760f99@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Hi!

On Sun, Apr 18, 2010 at 11:34:30AM -0600, Jonathan Corbet wrote:

> In the absence of that, the only course of action which makes sense is
> to simply fail the initialization if an unknown chip type shows up
> there.  That's easy, and I can do it.  But, given that this was a
> "minor nit," can we leave it as-is for now?  There's a *lot* of things
> to clean up in this driver, I'd like to make it better a step at a time
> rather than trying to do the whole thing at once.

i agree with that step by step strategy.

I always felt conservative about making too big changes.  After all, it is hard
to find people who actually own and use all those various models of graphics
chips, and even more so: who want to try + test recent mainline and check for
regressions :(

VIA's resources are extremely limited, and they can barely complete the work
required for new products...  I know it's unfortunate, but VIA is a very small
company.

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
