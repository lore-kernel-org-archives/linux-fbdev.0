From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Date: Thu, 21 Oct 2004 16:10:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <88056F38E9E48644A0F562A38C64FB60032879CA@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S271101AbUJUXWW@vger.kernel.org>
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Pavel Machek <pavel@ucw.cz>
Cc: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, stefandoesinger@gmx.at

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz] 
>Sent: Thursday, October 21, 2004 4:00 PM
>To: Pallipadi, Venkatesh
>Cc: Kendall Bennett; linux-kernel@vger.kernel.org; 
>linux-fbdev-devel@lists.sourceforge.net
>Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer 
>driver and Video card BOOT?
>
>Hi!
>
>> >The rest of the code you have above seems superfluous to me 
>as we have 
>> >never needed to do that. Then again we boot the card using the BIOS 
>> >emulator, which is different because it runs within a 
>> >protected machine 
>> >state.
>> >
>> >Have you taken a look at the X.org code? They have code in 
>> >there to POST 
>> >the video card also (either using vm86() or the BIOS emulator).
>> >
>> 
>> I have done some experiments with this video post stuff.
>> I think this should be done using x86 emulator rather than doing 
>> in real mode. The reason being, with an userlevel emulator 
>we can call
>> it at different times during resume. The current real mode videopost
>> does 
>
>Actually Ole Rohne has patch that allows you to call real mode any
>time you want.
>								Pavel

Yes. I tried Ole's patch. That helped on one of my laptops. But, on 
the other one it doesn't work. It goes into real mode but never returns.
Both systems had Radeom 9000M cards, but one with older version of the 
firmware (didn't work) and one with newer version.

IIRC, even Stefan had similar problems with Ole's patch.

Thanks,
Venki
