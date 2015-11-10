From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Nov 2015 22:34:00 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <20151110223400.GX18797@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
 <20151108221624.GP18797@mwanda>
 <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
 <20151110063821.GA31014@infradead.org>
 <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
 <1447188569.2701.91.camel@perches.com>
 <20151110220244.GU7289@mwanda>
 <1447193832.2701.102.camel@perches.com>
In-Reply-To: <1447193832.2701.102.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@infradead.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Nov 10, 2015 at 02:17:12PM -0800, Joe Perches wrote:
> On Wed, 2015-11-11 at 01:02 +0300, Dan Carpenter wrote:
> > On Tue, Nov 10, 2015 at 12:49:29PM -0800, Joe Perches wrote:
> > > Is there a warning/info message produced by gcc and the
> > > plug-in when a non-const declaration is converted to
> > > const because of this attribute?
> > 
> > I'm not sure I understand the question.  What would the warning say?
> 
> Perhaps something like:
> 
> declaration of struct <foo> converted to const by __attribute__((do_const))

No one will ever think to turn on that output.  By the time they think
of turning it on, it means they have already figured out the issue.

regards,
dan carpenter

