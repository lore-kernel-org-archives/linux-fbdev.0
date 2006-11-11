From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
Subject: resume not working on acer ferrari 4005 with
	radeonfb enabled
Date: Sat, 11 Nov 2006 14:34:10 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE043CB3@labex2.corp.trema.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Giszu-00066A-Ci for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 05:34:14 -0800
Received: from wshld2.trema.com ([194.103.215.196]
	helo=webshieldout.corp.trema.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Giszs-0006C2-LJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 05:34:14 -0800
content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net



(Sorry maybe you receive that twice as parts of the email seemed to bounce back)

I asked, if it s possible to confirm that this is a BIOS issue and how to workaround it... BTW: suspend resume works fine with vesa (and under windows xp as well)

Chris

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
Sent: Saturday, November 11, 2006 2:49 AM
To: Rafael J. Wysocki
Cc: linux-fbdev-devel@lists.sourceforge.net; LKML; Christian@ogre.sisk.pl; Hoffmann@albercik.sisk.pl; Christian Hoffmann
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled

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





Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
