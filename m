From: Alex Romosan <romosan@sycorax.lbl.gov>
Subject: Re: no backlight on radeon after recent kernel "upgrade"s
Date: Wed, 21 Feb 2007 20:58:29 -0800
Message-ID: <87vehurdoq.fsf@sycorax.lbl.gov>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750870AbXBVE6x@vger.kernel.org>
In-Reply-To: <1172097718.5790.29.camel@localhost.localdomain> (message from
	Richard Purdie on Wed, 21 Feb 2007 22:41:57 +0000)
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Richard Purdie <rpurdie@rpsys.net> writes:

> If FB_RADEON_BACKLIGHT wasn't set for 2.6.20, can you try 2.6.21-rc1
> with that option disabled?

i've disabled FB_RADEON_BACKLIGHT (FB_BACKLIGHT also got deselected)
and i managed to boot into 2.6.21-rc1 and have a working backlight.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
