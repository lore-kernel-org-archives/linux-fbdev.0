From: Joe Perches <joe@perches.com>
Date: Tue, 25 Jun 2019 17:49:01 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: Mark expected switch fall-throughs
Message-Id: <9c0d4ed622d6b8e47e040d398f764d52a9ac396d.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625160103.GA13133@embeddedor>
         <2bdbbd7909c5c4ad96d32c0c5be4690292132a34.camel@perches.com>
         <201906251029.08B862130@keescook>
In-Reply-To: <201906251029.08B862130@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.ngsorg>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild <linux-kbuild@vger.kernel.org>

On Tue, 2019-06-25 at 10:31 -0700, Kees Cook wrote:
> On Tue, Jun 25, 2019 at 09:52:23AM -0700, Joe Perches wrote:
> > On Tue, 2019-06-25 at 11:01 -0500, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > cases where we are expecting to fall through.
> > []
> > > This patch is part of the ongoing efforts to enable
> > > -Wimplicit-fallthrough.
> > 
> > Just enable the thing already.
> 
> Linus has been pretty clear about not wanting warning options enabled
> without first fixing all the cases it warns about first.

Hey Kees.

I don't recall that particular tidbit.  Got a link?  

cheers, Joe
