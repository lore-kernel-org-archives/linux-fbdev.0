From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] add framebuffer and display update
 module support for pnx4008
Date: Fri, 30 Jun 2006 07:17:46 +0800
Message-ID: <44A45F9A.2070207@gmail.com>
References: <20060628143006.f3d1b80a.vitalywool@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw5lk-0007GM-9N for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 16:17:56 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fw5li-0000fR-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 16:17:56 -0700
Received: by py-out-1112.google.com with SMTP id c31so497236pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 29 Jun 2006 16:17:53 -0700 (PDT)
In-Reply-To: <20060628143006.f3d1b80a.vitalywool@gmail.com>
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

Vitaly Wool wrote:
> Hi folks,
> 
> inlined is the updated version of the patch that adds support for
> Display Update Module and RGB framebuffer device on Philips PNX4008
> ARM board.
> 

I did a final review before sending this to akpm, I noticed that in
put_cmd_string(), it is reading and writing to io memory but is not using
the standard IO accessors.  Is this intended or an oversight?

If it's an oversight, would you prefer to fix it first, or should I post
it to akpm with the provision that it will be fixed later?

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
