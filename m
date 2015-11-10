From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 10 Nov 2015 06:38:21 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <20151110063821.GA31014@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
 <20151108221624.GP18797@mwanda>
 <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 09, 2015 at 01:20:12PM -0800, Kees Cook wrote:
> Just to remind everyone: while we certainly want to clean these up in
> the code where possible, we still want to make the constification
> plugin part of the regular builds. We want to provide a
> secure-by-default build, even when vendors are adding their own
> out-of-tree code when producing Linux-based products. So, we'll always
> want to have the plugin as a back-stop for out-of-tree code, or places
> where const was accidentally missed upstream.

Who is 'we'?  While a plugin like this that warns would be very ueful
I strongly disagree with bloating the kernel tree with any infrastructure
primarily aimed at out of tree code.
