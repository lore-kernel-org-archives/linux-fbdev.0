From: Andrew Morton <akpm@osdl.org>
Subject: Re: fbdev maintenance
Date: Wed, 1 Nov 2006 21:52:09 -0800
Message-ID: <20061101215209.2e1e18d1.akpm@osdl.org>
References: <20061101214953.48dc7e17.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUp-0007mW-UL for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:52:11 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUo-0007pq-L2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:52:11 -0800
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA25q9Po004690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 1 Nov 2006 21:52:09 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kA25q9xI002383
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 1 Nov 2006 21:52:09 -0800
In-Reply-To: <20061101214953.48dc7e17.akpm@osdl.org>
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

On Wed, 1 Nov 2006 21:49:53 -0800
Andrew Morton <akpm@osdl.org> wrote:

> For the longer term, well, it would be good if someone else could step up
> to take over Tony's role.  If nobody has the knowledge/time/inclination to
> do that then can we please all spend more effort than we usually would in
> reviewing and testing each other's work?

oh, and if you have a patch which is presently in -mm, or if there are
patches in -mm which affect hardware which you own then please do test the
-mm tree to make sure that we're not about to add bugs to the mainline
kernel, thanks.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
