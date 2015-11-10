From: Joe Perches <joe@perches.com>
Date: Tue, 10 Nov 2015 22:17:12 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <1447193832.2701.102.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
	 <20151108221624.GP18797@mwanda>
	 <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
	 <20151110063821.GA31014@infradead.org>
	 <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
	 <1447188569.2701.91.camel@perches.com> <20151110220244.GU7289@mwanda>
In-Reply-To: <20151110220244.GU7289@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@infradead.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, 2015-11-11 at 01:02 +0300, Dan Carpenter wrote:
> On Tue, Nov 10, 2015 at 12:49:29PM -0800, Joe Perches wrote:
> > Is there a warning/info message produced by gcc and the
> > plug-in when a non-const declaration is converted to
> > const because of this attribute?
> 
> I'm not sure I understand the question.  What would the warning say?

Perhaps something like:

declaration of struct <foo> converted to const by __attribute__((do_const))

> We'll hopefully automatically make over 3000 structs const.  I
> understand warning that people should make structs const when possible
> but I don't understand why we would want to remove auto consting?

I'm not suggesting removing the attribute.
It seems sensible enough.

I just think the plug-in should at least optionally
note the instances when non-const declarations are
converted to const.

> Putting __do_const in the .h file is basically the same as marking
> every struct of that type as const in the .c file.

Not for a reader of the code that doesn't first
inspect the header files.

