From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 20 Nov 2009 15:55:05 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <4B06BBD9.4040407@ladisch.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
In-Reply-To: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Paulius Zaleckas wrote:
> On drivers using drm_fb_helper's in fb_ops it is not possible to change
> video mode, because of different var->pixclock evaluation: ...

patch:
http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44369.html

> P.S. check CLCOK spelling :)

This patch got lost during fb helper reorganization:
http://git.kernel.org/linus/1bcbf3948876e31a8ece28597dec447611ad9c8b


Regards,
Clemens

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
