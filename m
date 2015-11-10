From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Nov 2015 20:34:42 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <CAGXu5j+59jPqd5QWq38KH--i=gBzq2d5j_Z0c2ygG=pfr2+tzw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
	<20151108221624.GP18797@mwanda>
	<CAGXu5jJp4hQKWyQhu5fqgnvAEgeWDAKtaDm2norVM19n=+qigQ@mail.gmail.com>
	<20151110063821.GA31014@infradead.org>
In-Reply-To: <20151110063821.GA31014@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 9, 2015 at 10:38 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Nov 09, 2015 at 01:20:12PM -0800, Kees Cook wrote:
>> Just to remind everyone: while we certainly want to clean these up in
>> the code where possible, we still want to make the constification
>> plugin part of the regular builds. We want to provide a
>> secure-by-default build, even when vendors are adding their own
>> out-of-tree code when producing Linux-based products. So, we'll always
>> want to have the plugin as a back-stop for out-of-tree code, or places
>> where const was accidentally missed upstream.
>
> Who is 'we'?  While a plugin like this that warns would be very ueful

I understand "we" here to mean people interested in the proactive
defense of the Linux kernel, and by extension the Linux kernel
community as a whole. :)

> I strongly disagree with bloating the kernel tree with any infrastructure
> primarily aimed at out of tree code.

It's not "primarily aimed at out of tree code", that is simply an
additional side-effect (though the need must be recognized: a billion
android devices, and none of them are running a stock kernel). What it
gets us is _coverage_. We can't make everything work just by static
analyzers and checkpatch.pl runs (meaning the "backstop" comment
above).

Additionally, having the plugin infrastructure gets us the ability to
do things that aren't presently possible (see the thread on the
initify plugin, which can't be done in source alone).

-Kees

-- 
Kees Cook
Chrome OS Security
