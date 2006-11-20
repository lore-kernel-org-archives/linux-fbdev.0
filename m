From: James Simmons <jsimmons@infradead.org>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: Mon, 20 Nov 2006 16:51:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611201648550.17639@pentafluge.infradead.org>
References: <20061118000235.GV31879@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966201AbWKTQv5@vger.kernel.org>
In-Reply-To: <20061118000235.GV31879@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com


> This patch removes video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_ATARI
> - FB_SUN3
> - FB_PM3

If someone is willing to send me a Permedia3 card I can port the driver. 
The rest are m68k drivers. I do have S3Trio and a Virge card but no specs.
