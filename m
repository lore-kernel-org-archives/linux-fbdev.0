From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sun, 08 Nov 2015 22:16:24 +0000
Subject: Re: [PATCH] video: constify geode ops structures
Message-Id: <20151108221624.GP18797@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Cool.  So, in grsec they use a GCC plugin to make these const
automatically since they only contain function pointers.  There about
100 struct types marked as __no_const.  Kees would like to adopt the
grsec pluggin approach I expect.  Do you have an idea how many structs
only contain function pointers or how many consts we would have to add
to get the same effect without the plugin?

regards,
dan carpenter

