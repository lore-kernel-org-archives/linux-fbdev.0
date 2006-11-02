From: Andrew Morton <akpm@osdl.org>
Subject: Re: radeonfb: Add ATOM BIOS parsing (rebased
 patch)
Date: Wed, 1 Nov 2006 21:33:46 -0800
Message-ID: <20061101213346.2d3bb82f.akpm@osdl.org>
References: <20060905153713.GA22789@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVD6-000631-IK for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:33:52 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVD5-0002uX-7g
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:33:52 -0800
In-Reply-To: <20060905153713.GA22789@shaftnet.org>
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
Cc: Stuffed Crust <pizza@shaftnet.org>

On Tue, 5 Sep 2006 11:37:13 -0400
Stuffed Crust <pizza@shaftnet.org> wrote:

> From: Stuffed Crust <pizza@shaftnet.org>
> ...
> Signed-Off-By:  Solomon Peachy <pizza@shaftnet.org>
> 

Problem.  We've decided to not take contributions from
anonymous/pseudonymous contributors, as it weakens the intent of the
Developer's Certificate of Origin.  I don't think either of those are your
real name ;)  Sorry.


If you can sort that out then please ensure that future patches are
prepared in `patch -p1' form, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.  That means the
diff headers should look like:


--- a/drivers/video/aty/ati_ids.h
+++ a/drivers/video/aty/ati_ids.h

etc.  Thanks.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
