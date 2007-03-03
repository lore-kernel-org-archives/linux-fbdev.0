From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 02 Mar 2007 21:34:43 -0800
Message-ID: <87k5xyq498.fsf@sycorax.lbl.gov>
References: <87ps7uutsk.fsf@sycorax.lbl.gov>
	<20070301184531.b3aeafe3.akpm@linux-foundation.org>
	<87tzx35zkc.fsf@sycorax.lbl.gov>
	<20070302122920.a2967ebf.akpm@linux-foundation.org>
	<1172878338.11149.198.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933379AbXCCFfZ@vger.kernel.org>
In-Reply-To: <1172878338.11149.198.camel@localhost.localdomain> (message from
	Richard Purdie on Fri, 02 Mar 2007 23:32:18 +0000)
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Antonino A. Daplas" <adaplas@gmail.com>, James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, "David S. Miller" <davem@davemloft.net>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Yaroslav Halchenko <lists@onerussian.com>

Richard Purdie <rpurdie@rpsys.net> writes:

> I propose the following patch (I was previously waiting on James for
> this). It avoids backing out the problematic Kconfig changes but
> means a user has to explicitly enable the backlight via a kernel or
> module parameter.
>
> Can people with backlight problems try enabling them in Kconfig but
> applying the following patch? Hopefully I have you all cc'd.
>
> If it works I will add it to the other fix I have queued and pass to
> Linus via the backlight tree. If it doesn't, I will revert the
> problematic Kconfig changes for the next -rc.

with the patch applied i can boot into 2.6.21-rc2 and have a working
backlight when i enable radeon backlight support. so i guess the patch
successfully disables the new radeon backlight stuff on my thinkpad
and therefore it does what it says it does.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
