From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:41:58 +0000
Subject: Re: [PATCH] vmlfb: use list_move_tail instead of list_del/list_add_tail
Message-Id: <505F6606.3000706@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd_SinBfmVH2erdTq5howN3yAsjhoV+MdSShPgT5Nr5mLg@mail.gmail.com>
In-Reply-To: <CAPgLHd_SinBfmVH2erdTq5howN3yAsjhoV+MdSShPgT5Nr5mLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/05/2012 06:40 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Using list_move_tail() instead of list_del() + list_add_tail().
> 
> spatch with a semantic match is used to found this problem.
> (http://coccinelle.lip6.fr/)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/vermilion/vermilion.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
> index 970e43d..083f0c8 100644
> --- a/drivers/video/vermilion/vermilion.c
> +++ b/drivers/video/vermilion/vermilion.c
> @@ -1168,8 +1168,7 @@ void vmlfb_unregister_subsys(struct vml_sys *sys)
>  	list_for_each_entry_safe(entry, next, &global_has_mode, head) {
>  		printk(KERN_DEBUG MODULE_NAME ": subsys disable pipe\n");
>  		vmlfb_disable_pipe(entry);
> -		list_del(&entry->head);
> -		list_add_tail(&entry->head, &global_no_mode);
> +		list_move_tail(&entry->head, &global_no_mode);
>  	}
>  	mutex_unlock(&vml_mutex);
>  }
> 
> 
> 

