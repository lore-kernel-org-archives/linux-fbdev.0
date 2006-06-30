From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: [PATCH] add framebuffer and display update
	module support for pnx4008
Date: Fri, 30 Jun 2006 10:22:18 +0400
Message-ID: <acd2a5930606292322i657ddadfj77a77b0339d13f51@mail.gmail.com>
References: <20060628143006.f3d1b80a.vitalywool@gmail.com>
	<44A45F9A.2070207@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwCOT-0000o0-F0 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 23:22:21 -0700
Received: from nz-out-0102.google.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FwCOS-00023a-5A
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 23:22:21 -0700
Received: by nz-out-0102.google.com with SMTP id 16so271889nzp
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 29 Jun 2006 23:22:18 -0700 (PDT)
In-Reply-To: <44A45F9A.2070207@gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Tony,

> I did a final review before sending this to akpm, I noticed that in
> put_cmd_string(), it is reading and writing to io memory but is not using
> the standard IO accessors.  Is this intended or an oversight?
>
> If it's an oversight, would you prefer to fix it first, or should I post
> it to akpm with the provision that it will be fixed later?

thanks for pointing that out, that's an oversight and I'll repost the
updated version shortly.

Vitaly

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
