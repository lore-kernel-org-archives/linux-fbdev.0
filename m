From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] no backlight on radeon after recent kernel
 "upgrade"s
Date: Wed, 28 Feb 2007 16:55:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702281654230.14127@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0702220109450.17121@pentafluge.infradead.org>
 <20070222020951.GR7920@ca-server1.us.oracle.com>
 <Pine.LNX.4.64.0702221549530.29542@pentafluge.infradead.org>
 <20070222.092812.112620509.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933092AbXB1Q4v@vger.kernel.org>
In-Reply-To: <20070222.092812.112620509.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Joel.Becker@oracle.com, lists@onerussian.com, rpurdie@rpsys.net, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


So the problem is not the configuration but that for some reason the 
backlight state is set to off by default.


On Thu, 22 Feb 2007, David Miller wrote:

> From: James Simmons <jsimmons@infradead.org>
> Date: Thu, 22 Feb 2007 15:55:24 +0000 (GMT)
> 
> > I just tested various confirations of backlight support. Backlight is 
> > ALWAYS selected by default when you select a particular fbdev driver that 
> > has backlight support. You just have the option to turn it off if you 
> > want. These problems are showing up because of stale .config files.
> 
> BTW, enabling the backlight option broke things for me with
> Radeon on sparc64 too, FWIW.
> 
> And when the option was presented to me for the first time,
> the default was yes, so that's what I gave it.
> 
> This is what a lot of users would see.
> 
