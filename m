From: Dennis Munsie <dmunsie@cecropia.com>
Subject: Re: [PATCH 2.6.17-1] fbmon: add generic
	ddc	read functionality
Date: Mon, 17 Jul 2006 10:27:49 -0400
Message-ID: <37BAF066-F9CF-4F0F-97F0-C06F27486EE8@cecropia.com>
References: <CCAD6957-F582-48B5-AD3F-E93330489913@cecropia.com>
	<04D28BB4-A610-486B-B314-9D6D44E0B09B@cecropia.com>
	<44B8EA8E.3070808@gmail.com>
	<A05EFD86-EE99-4252-B99B-8E684905B0BB@cecropia.com>
	<44B9B140.5090701@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2U18-000219-19 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 07:24:14 -0700
Received: from mail4.sea5.speakeasy.net ([69.17.117.6])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G2U16-0003E5-P3
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Jul 2006 07:24:13 -0700
Received: from lex098.cecropia.com (HELO [192.168.3.132])
	(dmunsie@cecropia.com@[63.138.212.98])
	(envelope-sender <dmunsie@cecropia.com>)
	by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with RC4-SHA encrypted
	SMTP for <linux-fbdev-devel@lists.sourceforge.net>;
	17 Jul 2006 14:24:06 -0000
In-Reply-To: <44B9B140.5090701@gmail.com>
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
To: "Antonino A.Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

It looks good, but the copyright should be in my company's name, not  
mine -- Cecropia, Inc.  My name and email can still be there, though,  
for contact purposes.

Also, I looked on the original file in the radeon driver for a  
copyright, but there wasn't one there -- whoever wrote that original  
code should also be listed in the copyright.

BTW -- are you going to modify the radeon patch to account for the  
Kconfig change or should I send up a new version?

dennis

On Jul 15, 2006, at 11:23 PM, Antonino A. Daplas wrote:
> I'm attaching an update patch. The authorship will be in your name  
> (so people
> can hunt you down when they have problems :-)). Anyway, check the  
> version,
> and let me know of any changes you want.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
