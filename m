From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against
 2.6.7-rc2)
Date: Thu, 03 Jun 2004 22:46:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <40BF8E10.5020107@winischhofer.net>
References: <20040603023653.GA20951@havoc.gtf.org>	<200406032307.13121.adaplas@hotpop.com> <1086285678.40bf676e1da4d@mail.theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264297AbUFCUsY@vger.kernel.org>
In-Reply-To: <1086285678.40bf676e1da4d@mail.theboonies.us>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Eger <eger@theboonies.us>
Cc: adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

David Eger wrote:
> I coded your pseudocode up, and I'm convinced now that you and Thomas are right.
>  We should prefer panning when it's available
> cat /usr/src/linux/MAINTAINERS is 0.3 seconds instead of 1.5 seconds.
> 
> On the down side, panning makes screen corruption for me... time to investigate
> to see if fbcon or radeonfb is to blame... perhaps panning is just incompatible
> with accel engine at all in radeon...

Sisfb has been using panning for ages and I never saw or heard about 
screen corruption. Looks very much like the radeon driver is skrewed...

However, I don't think the engine is "incompatible" with panning. 
Panning means just to change the display start address, I can't imaging 
that the engine would care about that.

What sort of "screen corruption" do you get?

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
