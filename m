From: James Simmons <jsimmons@infradead.org>
Subject: Re: also frustrated with the framebuffer and your matrox-card in
 2.5.53? hack/patch available!
Date: Thu, 26 Dec 2002 19:47:52 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212261942290.5748-100000@phoenix.infradead.org>
References: <20021226142032.GA7852@middle.of.nowhere>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18RdzY-00061S-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 26 Dec 2002 11:48:29 -0800
In-Reply-To: <20021226142032.GA7852@middle.of.nowhere>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jurriaan <thunder7@xs4all.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> It's rather annoying that in a feature-freeze period a change goes in
> that cripples the one framebuffer with the best speed and features -
> the matrox framebuffer. 

Because a driver has over 10,000 lines of code does not mean it is a 
quality driver.

> The author mentioned it could be weeks or months
> before he would be able to get his matrox framebuffer working with the
> new framework, since its simple API doesn't fit the possibilities of the
> matrox framebuffer. Read more about it on the fbdev-users or
> fbdev-developers mailinglist on sourceforge.

Petr is expressing his political view. It has nothing to do with technical 
arguments. In fact I place a bet. I will port the matrox driver and it 
will have the same functionality as the previous driver except for text 
mode support. If I can't do it I will not only revert the changes but I 
will give Petr his wetdream. I will start inetergrating vt.c and 
vt_ioctl.c into each fbdev driver. Each fbdev driver will be its own 
console system. We will not longer need vt.c and vt_ioctl.c as each driver 
will have its own version intergated into the driver. Sound fair?



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
