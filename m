From: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus
	rework
Date: Thu, 21 Jun 2007 15:18:25 -0700
Message-ID: <591B6A09961C354991CD653B274DC8C203E0521B@ussdixms03.am.sony.com>
References: <20070615204749.629571012@am.sony.com><46730D32.8060803@am.sony.com>
	<18039.31768.282185.497245@cargo.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I1Uz8-0000Oe-1W for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 15:18:38 -0700
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound5-dub-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I1Uz6-0004y6-8r
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Jun 2007 15:18:37 -0700
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
To: Paul Mackerras <paulus@samba.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org]
Sent: Mon 6/18/2007 11:47 PM
To: Levand, Geoffrey
Cc: linuxppc-dev@ozlabs.org; linux-fbdev-devel@lists.sourceforge.net; Geert Uytterhoeven
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus rework
 
Geoff Levand writes:

> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Convert the ps3fb device from a platform device to a PS3 system bus device.
> Fix the remove and shutdown methods to support kexec and to make ps3fb a
> loadable module.

Are you going to submit this to the fb maintainer (Antonio Daplas?) or
do you want me to take it because of dependencies on other patches in
your series?


Hi Paul,

Sorry for the delay, and this formatting.  I am away on holiday,
with just a crappy Web browser interface...

I was hoping you could take it, as it fits in with the series, and
touches my platform code.  Thanks.

-Geoff



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
