From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Thu, 25 Nov 2004 08:07:29 +0800
Message-ID: <200411250807.32040.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CX7As-0001W3-U3
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 16:07:50 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CX7Ao-0006hA-En
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 24 Nov 2004 16:07:50 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6469A7075A
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 25 Nov 2004 00:07:38 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Walrond <andrew@walrond.org>, linux-fbdev-devel@lists.sourceforge.net


--- Andrew Walrond <andrew@walrond.org> wrote:

> On Tuesday 23 Nov 2004 18:26, Antonino A. Daplas
> wrote:
> >
> > Does vesafb work in x86_64?  If it does you can
> add this in your
> > commandline:
> >
> > vga=0x307
> >
> > 0x306 is the code for 1280x1024, see
> Documentation/fb/vesafb.txt.
> >
> > Then check your dmesg if the panel size also
> changed.  If it did, then
> > you can do this:
> >
> > vga=0x307 video=nvidiafb:1280x1024@60.
> >
> 
> If I did this right, it doesn't help. I built in the
> vesafb as well as your 
> new nvidafb, then booted with the commandline
> 
>  vga=0x31b video=nvidiafb:1280x1024-32@60

That's assuming 0x31b is supported by your card.  Why not
try:

vga=ask

Choose 'scan', choose the highest size, and check if the panel
size changed again.

> 
> It looks like the nvidafb got the first bite of the
> cherry:

No, vesafb will always get the first bite, it's initialized when the OS is in
real mode.

> 
>  ...
>  nvidiafb: CRTC 1 is currently programmed for DFP
>  nvidiafb: Using DFP on CRTC 1
>  Panel size is 1024 x 768
>  nvidiafb: MTRR set to ON
>  Console: switching to colour frame buffer device
> 128x48
>  nvidiafb: PCI nVidia NV25 framebuffer (128MB @
> 0xE0000000)
>  vesafb: probe of vesafb0 failed with error -6
>  ...
> 
> 
> Do you know if the nvidia developers lurk on lkml? I

I did not subscribe to lkml.  But I do occassionally look at the archives.

> seem to remember somebody 
> saying that they do. If so, is it worth asking them
> for a bit of help with 
> this? I know they're not about to open source their
> binary driver due to ip 
> license problems, but the information we require to
> overcome this problem in 
> the fb driver is probably quite trivial in nature. I

Well, checking the latest Xorg again, it seems that the nv driver also
depends on the BIOS for the panel size.  And they are the people who does
have access to the docs.

> assume they have been 
> forthcoming in the past wrt the open source X
> driver.
> 
> What do you think? Worth asking?

Sure, no harm in asking.  But I would rather ask the Xorg people first.  If
we can't get the vga=ask to work, then I really don't know what to do,
besides perhaps experimenting with VBE calls.  I can  do that, but I do not
have any flatpanel to test on.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
