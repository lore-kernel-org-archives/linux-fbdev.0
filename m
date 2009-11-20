From: James Simmons <jsimmons@infradead.org>
Date: Fri, 20 Nov 2009 18:53:37 +0000
Subject: Re: [Linux-fbdev-devel] drm_fb_helper: Impossible to change video
Message-Id: <alpine.LFD.2.00.0911201848380.22712@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
In-Reply-To: <badfd5ba0911200516m55693acbp8fc5164bd6d828cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> Paulius Zaleckas wrote:
> > On drivers using drm_fb_helper's in fb_ops it is not possible to change
> > video mode, because of different var->pixclock evaluation: ...
> 
> patch:
> http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg44369.html

Those patches will enable fbdev apps to run properly. More patches are 
needed if you want to support mode switching using the fbdev emulation 
layer. I noticed my patches and yours where lost. Who do you send patches 
too that can merge them ?  
 
