From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus
	rework
Date: Tue, 19 Jun 2007 16:47:52 +1000
Message-ID: <18039.31768.282185.497245@cargo.ozlabs.ibm.com>
References: <20070615204749.629571012@am.sony.com>
	<46730D32.8060803@am.sony.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I0XWX-00025U-5f for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Jun 2007 23:49:09 -0700
Received: from ozlabs.org ([203.10.76.45])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I0XWV-0002C2-Da
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Jun 2007 23:49:09 -0700
In-Reply-To: <46730D32.8060803@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net

Geoff Levand writes:

> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> Convert the ps3fb device from a platform device to a PS3 system bus device.
> Fix the remove and shutdown methods to support kexec and to make ps3fb a
> loadable module.

Are you going to submit this to the fb maintainer (Antonio Daplas?) or
do you want me to take it because of dependencies on other patches in
your series?

Paul.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
