From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: please disconsider bl_mutex patch
Date: Sat, 15 Jul 2006 20:39:32 +0800
Message-ID: <44B8E204.30807@gmail.com>
References: <20060704015311.GJ27596@cathedrallabs.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1jQy-0000VO-13 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 05:39:48 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G1jQw-00007U-Al
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 15 Jul 2006 05:39:48 -0700
Received: by py-out-1112.google.com with SMTP id c31so1299510pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 15 Jul 2006 05:39:45 -0700 (PDT)
In-Reply-To: <20060704015311.GJ27596@cathedrallabs.org>
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
Cc: aris@cathedrallabs.org

Aristeu Sergio Rozanski Filho wrote:
> Hi,
> 	just noticed that the bl_mutex removal from nvidiafb_blank() is
> 	wrong. while at that, noticed that recursive bl_mutex retrieval
> 	is also present at least on aty128fb and riva. checking how to
> 	fix it properly now.
> 

What's the status of this patch?

Tony


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
