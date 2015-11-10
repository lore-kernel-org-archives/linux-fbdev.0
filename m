From: Joe Perches <joe@perches.com>
Date: Tue, 10 Nov 2015 20:49:29 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <1447188569.2701.91.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
	 <20151108221624.GP18797@mwanda>
	 <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
	 <20151110063821.GA31014@infradead.org>
	 <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
In-Reply-To: <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, 2015-11-10 at 12:34 -0800, Kees Cook wrote:
> We can't make everything work just by static
> analyzers and checkpatch.pl runs (meaning the "backstop" comment
> above).
> 
> Additionally, having the plugin infrastructure gets us the ability to
> do things that aren't presently possible (see the thread on the
> initify plugin, which can't be done in source alone).

#define __do_const __attribute__((do_const))
...
#ifndef __do_const
#define __do_const
#endif

I think it's always better for the reader to know that a
const struct declaration is used over a non-const struct
when the compiler, via plug-in extension, could convert
the declaration to const.

Is there a warning/info message produced by gcc and the
plug-in when a non-const declaration is converted to
const because of this attribute?
