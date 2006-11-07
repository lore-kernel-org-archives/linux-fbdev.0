From: "Andrew Wade" <andrew.j.wade@gmail.com>
Subject: Re: 2.6.19-rc4-mm2
Date: Tue, 7 Nov 2006 10:57:46 -0500
Message-ID: <610823610611070757o38898dddm90ee66f1f3926d3e@mail.gmail.com>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
Reply-To: ajwade@alumni.uwaterloo.ca
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964797AbWKGP5t@vger.kernel.org>
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hello Charlotte,

> (Sorry, I don't know what timezone you're in, but I went home, cooked
> supper, ate supper, did two loads of laundry, slept for about seven
> hours, ate breakfast, did another load of laundry, and voted, and now
> I'm back!)

I'm EST (GMT-5). But the hours I'm online are somewhat erratic.

...
> If I can't repro it with this chip, if you want to mess around with it
> on yours, here's what I think we had to do... I believe the trick was
> to use 16bpp mode as far as what mode you write to the chip, and then
> double all the x coordinate values for things like offset, width, and
> pitch. You would have to do that to the accelerated routines also.

I'd be happy to mess around with the driver, but I won't have much
time to do so until tomorrow. I'll let you know if I find anything,
and of course I'll be happy to test patches.

-ajw
