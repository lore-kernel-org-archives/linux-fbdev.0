From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:43:29 +0000
Subject: Re: [PATCH] video:uvesafb: check the return value of kzalloc
Message-Id: <503695F1.50207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120813100232.GA16363@udknight>
In-Reply-To: <20120813100232.GA16363@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wang YanQing <udknight@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, spock@gentoo.org

On 08/13/2012 10:02 AM, Wang YanQing wrote:
> 
> Michal maybe forgot it merely, we should add code
> to check the return value of kzalloc to make the
> code more robust.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/uvesafb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index b0e2a42..2f8f82d 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -659,6 +659,8 @@ static int __devinit uvesafb_vbe_getedid(struct uvesafb_ktask *task,
>  	task->t.flags = TF_BUF_RET | TF_BUF_ESDI;
>  	task->t.buf_len = EDID_LENGTH;
>  	task->buf = kzalloc(EDID_LENGTH, GFP_KERNEL);
> +	if (!task->buf)
> +		return -ENOMEM;
>  
>  	err = uvesafb_exec(task);
>  

