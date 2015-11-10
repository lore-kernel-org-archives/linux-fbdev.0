From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 10 Nov 2015 22:02:44 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <20151110220244.GU7289@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
 <20151108221624.GP18797@mwanda>
 <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
 <20151110063821.GA31014@infradead.org>
 <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
 <1447188569.2701.91.camel@perches.com>
In-Reply-To: <1447188569.2701.91.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@infradead.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Nov 10, 2015 at 12:49:29PM -0800, Joe Perches wrote:
> Is there a warning/info message produced by gcc and the
> plug-in when a non-const declaration is converted to
> const because of this attribute?

I'm not sure I understand the question.  What would the warning say?

We'll hopefully automatically make over 3000 structs const.  I
understand warning that people should make structs const when possible
but I don't understand why we would want to remove auto consting?

Putting __do_const in the .h file is basically the same as marking
every struct of that type as const in the .c file.  The errors are
caught at compile time.

regards,
dan carpenter
