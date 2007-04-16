From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [KJ][PATCH]vfc_dev.c-kzalloc
Date: Tue, 17 Apr 2007 05:25:34 +0800
Message-ID: <1176758734.10238.3.camel@daplas>
References: <1176703528.13066.9.camel@wriver-t81fb058.linuxcoe>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HdYhl-0002Tr-2T for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Apr 2007 14:25:45 -0700
Received: from wx-out-0506.google.com ([66.249.82.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HdYhj-0003X3-IB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Apr 2007 14:25:45 -0700
Received: by wx-out-0506.google.com with SMTP id i30so3089855wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 16 Apr 2007 14:25:42 -0700 (PDT)
In-Reply-To: <1176703528.13066.9.camel@wriver-t81fb058.linuxcoe>
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
To: vignesh.babu@wipro.com
Cc: kernel-janitors@lists.osdl.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, 2007-04-16 at 11:35 +0530, vignesh.babu@wipro.com wrote:
> Replacing kmalloc/memset combination with kzalloc.

Wrong subsystem, it's not a framebuffer but a frame grabber, and it's a
Sparc only device.  Maintainers: Ultrasparc (David Miller), Sparc
(William L. Irvin)

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
