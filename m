From: Eric Schoeller <erics@plek.net>
Subject: 855resolution patch and linux framebuffer
Date: Tue, 03 Jan 2006 11:35:25 -0700
Message-ID: <43BAC3ED.1090900@plek.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Etr0J-0004eo-5T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 10:35:27 -0800
Received: from edgar1.colorado.edu ([128.138.129.100])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Etr0H-0005wQ-Lf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 10:35:26 -0800
Received: from [198.11.27.13] (vpn-dhcp-13.colorado.edu [198.11.27.13])
	(authenticated bits=0)
	by edgar1.colorado.edu (8.13.3/8.13.3/UnixOps+Hesiod+SSL) with ESMTP id k03IZO9E023558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 3 Jan 2006 11:35:24 -0700 (MST)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

I have been working recently with the framebuffer driver vesafb and 
kernel 2.6.14. I am using the Intel 855GME chipset on a dell 700m 
laptop. The native resolution of the LCD on this device is 1280x800 - 
but can only be achieved after using Alain Porier's 855resolution patch 
to enter the correct mode into the chipset's BIOS. The sad thing is that 
I have to do this on every boot - and thus I have to run it before I 
load the vesafb driver. This procedure is undesirable.
Is there a way similar functionality of this 855resolution patch could 
be integrated into the kernel in some way?
I think it would be very useful for everyone who is using this chipset 
and is dealing with having to enter modes into the BIOS in similar fashions.

-eric



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
