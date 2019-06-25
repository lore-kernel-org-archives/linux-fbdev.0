From: Kees Cook <keescook@chromium.org>
Date: Tue, 25 Jun 2019 20:18:22 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <201906251312.5059C51334@keescook>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625160103.GA13133@embeddedor>
 <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
 <201906251029.08B862130@keescook>
 <9c0d4ed622d6b8e47e040d398f764d52a9ac396d.camel@perches.com>
In-Reply-To: <9c0d4ed622d6b8e47e040d398f764d52a9ac396d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild <linux-kbuild@vger.kernel.org>

On Tue, Jun 25, 2019 at 10:49:01AM -0700, Joe Perches wrote:
> On Tue, 2019-06-25 at 10:31 -0700, Kees Cook wrote:
> > On Tue, Jun 25, 2019 at 09:52:23AM -0700, Joe Perches wrote:
> > > On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
> > > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > > cases where we are expecting to fall through.
> > > []
> > > > This patch is part of the ongoing efforts to enable
> > > > -Wimplicit-fallthrough.
> > > 
> > > Just enable the thing already.
> > 
> > Linus has been pretty clear about not wanting warning options enabled
> > without first fixing all the cases it warns about first.
> 
> Hey Kees.
> 
> I don't recall that particular tidbit.  Got a link?  

It was spread out over the discussion around removing __deprecated,
about enabling -Wvla, and in person at the kernel summit when asking
what approach to take for -Wimplicit-fallthrough.

-- 
Kees Cook
