From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005	with radeonfb enabled
Date: Sat, 11 Nov 2006 12:49:06 +1100
Message-ID: <1163209746.4982.203.camel@localhost.localdomain>
References: <200611110031.16173.rjw@sisk.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gihzg-0002mi-LN for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 17:49:16 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX188zXBZsTX80vbz+pEaGfq2b/d1WZlw2UE=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gihzf-0003sI-6Z
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Nov 2006 17:49:16 -0800
In-Reply-To: <200611110031.16173.rjw@sisk.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Christian.Hoffmann@wallstreetsystems.com, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl, Hoffmann@albercik.sisk.pl

On Sat, 2006-11-11 at 00:31 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> We've just got the appended report.  Could you please have a look at this?

There are many possible reasons for that. The most likely is that the
BIOS isn't bringing the chip back on resume, causing radeonfb to
crash when trying to access it.

Ben.
 
> Greetings,
> Rafael
> 
> 
> ----------  Forwarded Message  ----------
> 
> Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
> Date: Friday, 10 November 2006 20:44
> From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
> To: suspend-devel@lists.sourceforge.net
> 
> Hello,
>  
> when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
> anymore. Screen stays black and nothing works anymore, no capslock light, no
> ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
>  
> You can see dmesg output and lspci -vv output here 
>  http://christianhoffmann.de/temp/radeon.log
>  http://christianhoffmann.de/temp/lspci.log
>  
> Thanks a lot for any input.
>  
> Chris
>  
> PS: I use kernel 2.18.1 + patch for radeonfb from
> http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
