From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 01:23:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041021232313.GB8376@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S271090AbUJUXb6@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, stefandoesinger@gmx.at

Hi!

> >> I have done some experiments with this video post stuff.
> >> I think this should be done using x86 emulator rather than doing 
> >> in real mode. The reason being, with an userlevel emulator 
> >we can call
> >> it at different times during resume. The current real mode videopost
> >> does 
> >
> >Actually Ole Rohne has patch that allows you to call real mode any
> >time you want.
> 
> Yes. I tried Ole's patch. That helped on one of my laptops. But, on 
> the other one it doesn't work. It goes into real mode but never returns.
> Both systems had Radeom 9000M cards, but one with older version of the 
> firmware (didn't work) and one with newer version.
> 
> IIRC, even Stefan had similar problems with Ole's patch.

It did not work for me, either, but I verified that it works as
expected if I comment out actuall call of BIOS. So the problem is not
with Ole's patch but with bios, and it may be the same if you emulate
it...

[Of course, it will not crash whole system when emulated, but system
without video is not too good, either].
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
