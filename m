From: James Simmons <jsimmons@infradead.org>
Subject: Re: Extending vesafb for modes switching ?
Date: Tue, 3 Feb 2004 17:54:30 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402031751510.7693-100000@phoenix.infradead.org>
References: <401D4B63.1080203@free.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoM3W-0004pe-4f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 04:22:58 -0800
Received: from externalmx.valinux.com ([198.186.202.147] helo=externalmx.vasoftware.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoM3V-0006na-Bj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 Feb 2004 04:22:57 -0800
Received: from phoenix.infradead.org ([213.86.99.234]:3216)
	by externalmx.vasoftware.com with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 4.24 #1 (Debian))
	id 1Ao58K-0007H6-0o
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 03 Feb 2004 10:18:48 -0800
In-Reply-To: <401D4B63.1080203@free.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?Ga=EBl_Deest?= <GUtopiste@free.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net


> Ok, this may be a silly question. I am not a kernel/fbdev hacker, so I 
> may ignore some relevant issues. But after many researches, I can't see 
> why it would be impossible for the vesafb driver to handle modes switching.

The vesafb driver only supports VESA 2.0 standard so we can cover as many 
cards as possible. My experience with vesa 3.0 is alot of cards lack 
support for it.
 
> According to my understanding of this stuff, vesafb mode setting is 
> possible only during real mode, via a boot argument,  set by bios 
> interrupts, which prevent from changing it later (if I said something 
> wrong, please correct me.) But what about the xfree86 driver ? It seems 
> to do its job via the VBE bios of the card. What would prevent vesafb 
> from doing the same ? I know vesafb only supports VBE 2.0, not 3.0. I 
> couldn't find the VBE 2.0 documentation, but in VBE 3.0 one, protected 
> mode is supported.

This has been discussed before. That would require writing code that would 
execute the BIOS on the card. This would be really nasty and has always 
been rejected.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
