From: Sylvain Garrigues <garrigue@enst.fr>
Subject: Re: Framebuffer output but no framebuffer console output
Date: Tue, 16 May 2006 16:39:21 +0200
Message-ID: <4469E419.2040805@enst.fr>
References: <4469E269.7090605@enst.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg0gt-00054S-KQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 07:38:27 -0700
Received: from a.mx.realmagic.fr ([82.229.218.57])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Fg0gt-0006gx-B3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 16 May 2006 07:38:27 -0700
In-Reply-To: <4469E269.7090605@enst.fr>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Sylvain Garrigues wrote:
> To redirect a tty to the framebuffer, I'm using the con2fb program 
> (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz 
> <ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/con2fb.c.gz>) which 
> redirects a tty to a framebuffer. So, as I said, once redirected, I 
> don't get any echo on the screen, althought key strokes are taken into 
> account.
s/echo on the screen/echo on the TV
Sorry, I don't get any echo on the _TV_. No more echo on the screen is 
normal since the tty has been redirected.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
