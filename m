From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Mon, 25 Jun 2018 22:02:56 +0000
Subject: Re: [PATCH 3/4] video: fbdev: pxafb: handle errors from pxafb_init_fbinfo() correctly
Message-Id: <87h8lqmsmn.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180624153817.24387-3-daniel@zonque.org>
In-Reply-To: <20180624153817.24387-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Daniel Mack <daniel@zonque.org> writes:

> pxafb_init_fbinfo() can not only report errors caused by failed
> allocations but also when the clock can't be found.
>
> To fix this, return an error pointer instead of NULL in case of errors,
> and up-chain the result.
>
> Signed-off-by: Daniel Mack <daniel@zonque.org>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
