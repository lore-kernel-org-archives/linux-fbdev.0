From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] fbdev: Add framebuffer and
 display update module support for pnx4008
Date: Fri, 30 Jun 2006 20:44:54 -0700
Message-ID: <20060630204454.4ca27a23.akpm@osdl.org>
References: <44A51257.10804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwWPk-00057e-Oz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 20:45:00 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FwWPj-0003qy-B6
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 20:45:00 -0700
In-Reply-To: <44A51257.10804@gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, gtolstolytkin@ru.mvista.com

On Fri, 30 Jun 2006 20:00:23 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> +	if ((ret = put_cmd_string(cmds_c)) != 0) {
> +		return ret;
> +	}

Guys, please avoid the assign-then-test trick.  Kernel style is
super-simple style.  The above should be coded as:


	ret = put_cmd_string(cmds_c);
	if (ret != 0)
		return ret;

Nice and easy.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
