From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] add framebuffer and display update
 module support for pnx4008
Date: Wed, 28 Jun 2006 13:36:59 +0400
Message-ID: <20060628133659.3a6b10e9.vitalywool@gmail.com>
References: <20060627191747.4b455b24.vitalywool@gmail.com>
	<44A1A2A6.5080206@gmail.com>
	<20060628114633.d96c8155.vitalywool@gmail.com>
	<44A246E1.20801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvWTm-00048X-Vd for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:37:03 -0700
Received: from [85.21.88.2] (helo=mail.dev.rtsoft.ru)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FvWTl-0002Mw-5B
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Jun 2006 02:37:02 -0700
In-Reply-To: <44A246E1.20801@gmail.com>
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

On Wed, 28 Jun 2006 17:07:45 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:


> > Hmmm, the thing is that the frambuffer can actually be anyone of a kind.
> > Display Update Module provides interface to the actual device and the only difference it makes is whether it's a RGB or YUV framebuffer.
> > 
> 
> Well, something like pnxrgbfb, pnxyuvfb? But it's your driver, so
> your call.

It's in pnx4008/ subdir, is it really reasonable to prefix the FB driver name with pnx?

Vitaly

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
