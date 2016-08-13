From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 13 Aug 2016 09:40:48 +0000
Subject: Re: [PATCH -next] video: fbdev: pxafb: add missing of_node_put() in of_get_pxafb_mode_info()
Message-Id: <87vaz5t3a7.fsf@belgarion.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1471078643-4815-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> This node pointer is returned by of_graph_get_next_endpoint() with
> refcount incremented in this function. of_node_put() on it before
> exitting this function.
>
> Found by Coccinelle.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
