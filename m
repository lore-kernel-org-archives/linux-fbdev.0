From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] au1100fb.c cursor enable/disable
Date: Sat, 15 Jul 2006 21:07:24 +0800
Message-ID: <44B8E88C.7050804@gmail.com>
References: <20060712064519.GA17240@gundam.enneenne.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1jrv-0002tg-In for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 06:07:39 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G1jru-0005mU-8E
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 06:07:39 -0700
Received: by py-out-1112.google.com with SMTP id c31so1334458pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Jul 2006 06:07:37 -0700 (PDT)
In-Reply-To: <20060712064519.GA17240@gundam.enneenne.com>
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
Cc: linux-mips@linux-mips.org, Rodolfo Giometti <giometti@linux.it>

Rodolfo Giometti wrote:
> Hello,
> 
> here a patch to add cursor enable/disable, very useful if you wish a
> full screen boot logo.
> 
> Cursor can be disabled from kernel command line:
> 
>    video=au1100fb:nocursor,panel:Toppoly_TD035STED4
> 
> or from sysfs interface:
> 
>    echo 1 > /sys/module/au1100fb/parameters/nocursor
> 
> The patch also fixes up some wrong indentation issues.

I'm getting rejects with this patch and with the startup patch.
I'm manually fixing it but please check if its okay.

Tony
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
