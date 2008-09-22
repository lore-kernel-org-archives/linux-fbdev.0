From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: don't allow to set a video
 mode via vga= if FB doesn't support it
Date: Mon, 22 Sep 2008 22:00:54 +0200
Message-ID: <20080922220054.4e74c099@neptune.home>
References: <20080921210219.GC21215@spock.one.pl>
	<20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753250AbYIVUI6@vger.kernel.org>
In-Reply-To: <20080922214747.c8bc57eb.krzysztof.h1@poczta.fm>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Michal Januszewski <spock@gentoo.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Michal Januszewski <spock@gentoo.org>
> Currently, it is possible to set a VESA graphics mode at boot time
> via the vga= parameter even when no framebuffer driver supporting
> this is configured.  This could lead to the system booting with a
> black screen, without a usable console.
> 
This looks pretty much the same as what I requested some time ago:

http://bugzilla.kernel.org/show_bug.cgi?id=8062

Would need to check -mm archives for the actual patch.

Don't remember why it did not make it to mainline...

Bruno
