From: "Eric Schoeller" <erics@plek.net>
Subject: RE: 855resolution patch and linux framebuffer
Date: Mon, 9 Jan 2006 15:33:12 -0700
Message-ID: <01fb01c6156c$ac9169a0$43030f0a@CUERIC>
References: <43BF18CD.8060706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ew5ZC-0000Yw-PI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 14:32:42 -0800
Received: from edgar1.colorado.edu ([128.138.129.100])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ew5ZC-0006xe-9w
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Jan 2006 14:32:42 -0800
Received: from CUERIC (comp113np-67-dhcp.int.Colorado.EDU [10.15.3.67])
	(authenticated bits=0)
	by edgar1.colorado.edu (8.13.3/8.13.3/UnixOps+Hesiod+SSL) with ESMTP id k09MWeid017488
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Jan 2006 15:32:40 -0700 (MST)
In-Reply-To: <43BF18CD.8060706@gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Would you, or anyone else be able to recommend an alternative?

Thanks


-----Original Message-----
From: linux-fbdev-devel-admin@lists.sourceforge.net
[mailto:linux-fbdev-devel-admin@lists.sourceforge.net] On Behalf Of Antonino
A. Daplas
Sent: Friday, January 06, 2006 6:27 PM
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] 855resolution patch and linux framebuffer

Eric Schoeller wrote:
> I have been working recently with the framebuffer driver vesafb and
> kernel 2.6.14. I am using the Intel 855GME chipset on a dell 700m
> laptop. The native resolution of the LCD on this device is 1280x800 -
> but can only be achieved after using Alain Porier's 855resolution patch
> to enter the correct mode into the chipset's BIOS. The sad thing is that
> I have to do this on every boot - and thus I have to run it before I
> load the vesafb driver. This procedure is undesirable.
> Is there a way similar functionality of this 855resolution patch could
> be integrated into the kernel in some way?
> I think it would be very useful for everyone who is using this chipset
> and is dealing with having to enter modes into the BIOS in similar
> fashions.
> 

It would require BIOS calls, and we don't have any facility yet to make
BIOS calls in the kernel.

Tony



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
