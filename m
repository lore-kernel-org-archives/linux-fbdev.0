From: "Eric Miao" <ymiao3@marvell.com>
Subject: Re: Debugging pxafb and am200epd
Date: Sun, 11 May 2008 20:25:42 -0700
Message-ID: <E913911567467945BBEB9277E27868B0C5D4D2@msiexch01.marvell.com>
References: <45a44e480805081306v17421858w3fbde163d43118e8@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1CDD5@msiexch01.marvell.com>
	<45a44e480805091037q43942e20s28a7960cfb53c4ae@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C5D4B3@msiexch01.marvell.com>
	<45a44e480805112022n547f2691n431b3e7cd9b84d33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvOfa-0001L5-Hb for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 20:25:46 -0700
Received: from host2.marvell.com ([65.219.4.2] helo=maili.marvell.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvOfZ-0001mm-AG
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 20:25:46 -0700
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>



> -----Original Message-----
> From: Jaya Kumar [mailto:jayakumar.lkml@gmail.com]
> Sent: Monday, May 12, 2008 11:23 AM
> To: Eric Miao
> Cc: Linux Frame Buffer Device Development
> Subject: Re: Debugging pxafb and am200epd
> 
> On Sun, May 11, 2008 at 11:07 PM, Eric Miao <ymiao3@marvell.com> wrote:
> >
> > The pxafb_init() should really be __init, as well as the pxafb_probe(), since
> > the device itself isn't a hotplug one, according to the
> ocumentation/PCI/pci.txt
> 
> I got things to work only if I set pxafb_init to __init and
> pxafb_probe as __devinit. With pxafb_probe as __init, the overlap
> still occurred. I think this is consistent with the explanation in
> pci.txt.
> 

Please also try modify pxafb_setup_options() and g_options[] to __init,
I don't think they deserve a __devinit either.

> >
> > And I think it's better to fire a separate patch to fix this.
> 
> Agreed. I'll make sure to do each of the patches as individual ones.
> 
> >
> >> While I was doing this, I cooked up the following patch to pxafb to
> >> make it unloadable. I've appended the code below. If it looks okay to
> >> you, I would like to test it a bit and then submit it as a patch.
> >>
> >
> > This is good, I like this one. Please also submit to the linux-arm-kernel
> > <linux-arm-kernel@lists.arm.linux.org.uk>, we have some users there who
> > might be also interested in a removable pxafb driver.
> >
> 
> Ok, will do.
> 
> Thanks,
> jaya
-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
