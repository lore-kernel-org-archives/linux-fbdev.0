From: Jamey Hicks <jamey.hicks@hp.com>
Subject: lcd and backlight module class
Date: Thu, 23 Oct 2003 10:39:38 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F97E82A.20001@hp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACtOZ-000427-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 21:17:52 -0700
Received: from crl-mail.crl.dec.com ([192.58.206.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1ACgfk-00029q-Cf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Oct 2003 07:42:44 -0700
Received: from quabbin.crl.dec.com (quabbin.crl.dec.com [16.11.0.45])
	by crl-mail.crl.dec.com (8.12.8/8.12.5) with ESMTP id h9NEe8Go008333
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 10:40:08 -0400
Received: from hp.com (thorin.crl.dec.com [16.11.100.19])
	by quabbin.crl.dec.com (8.12.10/8.12.10) with ESMTP id h9NEe8Hq445592
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 10:40:08 -0400 (EDT)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

A while back I posted a note to arm-linux-kernel about developing some 
low-level API's to separate out platform-specific code from drivers such 
as sa1100fb.c.
  
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2003-July/016235.html

As a particular example, the sa1100fb driver is cluttered with the 
platform initialization and control code for the many SA11x0-based 
platforms supported by the ARM linux kernel.  My thought is that the new 
device model gives a good framework to decouple the fbdev drivers and 
the platforms.  I've been busy with other things, so progress on this 
has been slower than I hoped.  But I have prototyped it.  For usespace 
access to these controls, I envision sysfs attributes.  I also think 
that the fb drivers might register an interface with the lcd/backlight 
classes so that they can be notified if an LCD is hotplugged.  It  would 
also help loosen the dependence on link/initialization order.

Anyway, please review and comment on this patch:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1696/1

There are uses of lcd module in subsequent ipaq patches, such as this
one:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=1699/1

Thanks,
Jamey Hicks







-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
