From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Fri, 22 Oct 2004 01:00:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041021230027.GA24762@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S271084AbUJUXRN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> >The rest of the code you have above seems superfluous to me as we have 
> >never needed to do that. Then again we boot the card using the BIOS 
> >emulator, which is different because it runs within a 
> >protected machine 
> >state.
> >
> >Have you taken a look at the X.org code? They have code in 
> >there to POST 
> >the video card also (either using vm86() or the BIOS emulator).
> >
> 
> I have done some experiments with this video post stuff.
> I think this should be done using x86 emulator rather than doing 
> in real mode. The reason being, with an userlevel emulator we can call
> it at different times during resume. The current real mode videopost
> does 

Actually Ole Rohne has patch that allows you to call real mode any
time you want.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
