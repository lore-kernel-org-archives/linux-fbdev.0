From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Extending vesafb for modes switching ?
Date: 05 Feb 2004 07:50:05 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1075938613.1368.38.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0402031751510.7693-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoXDj-0006dL-39
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 16:18:15 -0800
Received: from rizzo.jerky.net ([38.113.2.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoXDi-0006KU-H5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 16:18:14 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by rizzo.jerky.net (Postfix) with SMTP id D34E6325FF
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  4 Feb 2004 23:50:09 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.44.0402031751510.7693-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: =?ISO-8859-1?Q?Ga=EBl?= Deest <GUtopiste@free.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-02-04 at 01:54, James Simmons wrote:
> 
> > Ok, this may be a silly question. I am not a kernel/fbdev hacker, so I 
> > may ignore some relevant issues. But after many researches, I can't see 
> > why it would be impossible for the vesafb driver to handle modes switching.
> 
> The vesafb driver only supports VESA 2.0 standard so we can cover as many 
> cards as possible. My experience with vesa 3.0 is alot of cards lack 
> support for it.
>  
> > According to my understanding of this stuff, vesafb mode setting is 
> > possible only during real mode, via a boot argument,  set by bios 
> > interrupts, which prevent from changing it later (if I said something 
> > wrong, please correct me.) But what about the xfree86 driver ? It seems 
> > to do its job via the VBE bios of the card. What would prevent vesafb 
> > from doing the same ? I know vesafb only supports VBE 2.0, not 3.0. I 
> > couldn't find the VBE 2.0 documentation, but in VBE 3.0 one, protected 
> > mode is supported.
> 
> This has been discussed before. That would require writing code that would 
> execute the BIOS on the card. This would be really nasty and has always 
> been rejected.
> 

Not really.  The current vesafb driver already executes BIOS code
(pan_display and setcolreg).  

The difficulty lies in the code interface provided by the VIDEO BIOS. 
It will have 3:

a. int 10 - useful only in real mode, all functions supported

b. protected mode interface - code enters BIOS while in protected mode, 
CPU goes to 16-bit mode and back again to protected mode before
exiting.  In VBE 3.0, all functions have a protected mode interface.

c. simple 32-bit interface - Practically similar to b, but the CPU never
leaves protected mode. Only a few functions are supported (set color
registers, set start address, etc) even in VBE 3.0.  The most important
function (set video mode) does not have this interface.

While in kernel space, the CPU cannot go to 16-bit mode.  This is the
reason interface "a" and "b" cannot be used by vesafb. In user space, it
can go to real mode.  This means that only userspace apps (such as
XFree86) can take advantage of the functionality (and brokenness of
course) of the BIOS.

There are a few patches in the wild to extend the functionality of
vesafb, all of them need to go to userspace to execute code.  One as
pointed out by Jak, uses LRMI (Linux Real Mode Interface) which is a
user space library.

Tony





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
