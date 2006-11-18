From: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Sat, 18 Nov 2006 11:34:41 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
References: <20061118000235.GV31879@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754366AbWKRKfq@vger.kernel.org>
In-Reply-To: <20061118000235.GV31879@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com

On Sat, 18 Nov 2006, Adrian Bunk wrote:

> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
>
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI

FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
the final one soonish.

	Michael
