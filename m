From: Kees Cook <keescook@chromium.org>
Date: Mon, 09 Nov 2015 21:20:12 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
	<20151108221624.GP18797@mwanda>
In-Reply-To: <20151108221624.GP18797@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, Nov 8, 2015 at 2:16 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Cool.  So, in grsec they use a GCC plugin to make these const
> automatically since they only contain function pointers.  There about
> 100 struct types marked as __no_const.  Kees would like to adopt the
> grsec pluggin approach I expect.  Do you have an idea how many structs
> only contain function pointers or how many consts we would have to add
> to get the same effect without the plugin?

Just to remind everyone: while we certainly want to clean these up in
the code where possible, we still want to make the constification
plugin part of the regular builds. We want to provide a
secure-by-default build, even when vendors are adding their own
out-of-tree code when producing Linux-based products. So, we'll always
want to have the plugin as a back-stop for out-of-tree code, or places
where const was accidentally missed upstream.

-Kees

>
> regards,
> dan carpenter
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Kees Cook
Chrome OS Security
