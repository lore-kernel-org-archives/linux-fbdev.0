From: Ian Romanick <idr@us.ibm.com>
Subject: Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Fri, 15 Oct 2004 16:36:41 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <41705F09.4070908@us.ibm.com>
References: <416E6ADC.3007.294DF20D@localhost> <416EDA9A.9010809@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIbd1-00074n-3a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 16:36:55 -0700
Received: from e34.co.us.ibm.com ([32.97.110.132])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CIbd0-0000Gj-0L
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 16:36:55 -0700
Received: from westrelay04.boulder.ibm.com (westrelay04.boulder.ibm.com [9.17.193.32])
	by e34.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id i9FNamJ8539776
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 19:36:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i9FNalOX159756
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 17:36:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id i9FNalaZ011001
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 15 Oct 2004 17:36:47 -0600
In-Reply-To: <416EDA9A.9010809@comcast.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: penguinppc-team@lists.penguinppc.org

Zachary Smith wrote:

> This is a problem of the videocard manufacturers' making which,
> in the spirit of good engineering, they should fix before requiring
> a downstream kludge.
> 
> Specifically, ATI, rather than advocate x86 emulation in order
> to use their BIOS on non-x86 machines, should put a pseudocode BIOS
> (something like java bytecode) in the ROM instead, including
> an interpreter of course, perhaps gutting the x86 BIOS calls to use the
> pseudocode routines so there is only one version to maintain.
> And provide an entrypoint for non-x86 CPUs.

Isn't that basically what OpenFirmware is?  I think part of the issue is 
the x86 compiled BIOS is smaller than the OF BIOS, so they use smaller 
(i.e., cheaper) flash on the card.  That has prevented people from 
re-flashing PC cards with OF images from Mac cards.

I think Digital had the right idea from the beginning:  put the x86 BIOS 
emulator in the system firmware and be done with it.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
