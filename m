From: Pavel Machek <pavel@suse.cz>
Subject: Re: Radeon: do not blank screen during suspend
Date: Sat, 18 Sep 2004 12:22:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040918102255.GC832@elf.ucw.cz>
References: <20040915112652.GA21386@elf.ucw.cz> <1095482822.3574.24.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269176AbUIRKXN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1095482822.3574.24.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Patrick Mochel <mochel@digitalimplant.org>
Cc: ajoshi@shell.unixbox.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>

Hi!

> > This stops ugly flashing from radeon during suspend/resume, please
> > apply,
> 
> Shoud be fine.
> 
> BTW. What is the status with Patrick merge of pmdisk & swsusp ? Has it
> been merged at all ? (No time to check at the moment). I still hope I'll
> find some time to do real work on it (& cleanup the ppc support that I
> had working experimentally at OLS) sooner or later...

It was merged to Andrew, then to Patrick and now it is waiting on
Linus to pull it from patrick, if I understand it correctly.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
