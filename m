Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06FC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Oct 2022 05:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJUFhk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUFhj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Oct 2022 01:37:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110981D3EB9
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Oct 2022 22:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666330651;
        bh=HqtILfRl3OtBhy475GM5r0NjKFQPRHcClOGgl4juyvM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iW3ze8qMe76pzEWYy6RwK3UBmgdeKnL4yVjTGtVhu84AxYOn5oeNyAaklMkGo8Hgi
         mMVYWQBv5G9hCDoJMhVSBe6xejyicflh5RzvXzI3DOPP0o1htPJUVp9BcHK5hTgi/l
         T4fmnVCXvHCnuCCDCGyr9u8QC9g9dfrQ+qQayNIY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42nS-1olkip2K7E-00040o; Fri, 21
 Oct 2022 07:37:31 +0200
Message-ID: <b01674d2-07f6-f94e-9a7f-b8d43055728b@gmx.de>
Date:   Fri, 21 Oct 2022 07:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] video: fbdev: smscufx: Fixed several use-after-free
 bugs
Content-Language: en-US
To:     Hyunwoo Kim <imv4bel@gmail.com>, steve.glendinning@shawell.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221021011544.GA339803@ubuntu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221021011544.GA339803@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NbDtIc/xvHxHrlPsWYs2BR0Q/BmvG+wbS9TUv89KJRmAH07cYz6
 9110l0go/QCMjkSB6dNu2NkOxzrsku3tWL7myRgUdIMiZwOARQ69EEJFlnsLK8AgM0RA7kl
 P9sJQVxcxsBibzPqNNg7rANJpL868ViwXSfpi8zSJh/izUldM4z/9JX4/Dqh6qRmP6F3VMj
 WByL8WH8SscXxW3NFxyZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVHk6wWhKVk=:eYMqVlevGeyPBH4z1dFN0g
 CFvXCG7TrBctaG+kh+0y5hHG3160bG0kYyNBlUhLxj5js1F8/TalkxtZl1BlzZdD8b3rtfC3I
 xzwEqKnRAEWnHS6Sknbw7uCXB/LHKKizOx7P/gJ4V6nhlb6+R6PQ0CG5Ip0vmFxQ8k45UpNMX
 JxIqJaqGNn+oCZJ3l5B0a/0Jr8oY/ROk9T7KzR8gXlST7S24S1UPsES6yEvdAYVfTAMuwS8o6
 Ibprya2t7npa1tRU4zHsNB9sHxdk5WjXmoteIAtCtHQyF1xd9WUzkmI5QVzdMyYOctwN5JyfJ
 DvGlEYlfrYLM2nqNZd6H1/dLIbX1kivqe2g8gqbL6GHRHIzOwBawtOfvL4hHbS5caF3VjkcXP
 tqZfm1zP//IL5TSKsImbaJEvk5KQ/HoX90/Y39fkju2rAJ1l4YJsFZPn/N1xW0HLBL83yDLIZ
 yB0qD1kk1oZVmrd03tOk7pRuDfWy49Iba427aRE/7hwKO7DPjgYEqaybhh+DxUnggN/isiniD
 tX4I1sKX3pXAL6Wm34BkhIrh1g0uAQ46icSbFuu5OZggIW0uPtIuhy9KfAzQNdmKZdSjetzLo
 unqLc4h1baXcpzq9DoKfJTI49glf+AM3u9cK245sYHwZSVXbcBfAkqXggiJApaidnvrHPzm06
 WoKcDS0Nlu9nTN2d0C0yp0cL5iKz1Su4nIzMc32Q8g/LIjm4xlDDJumw3S/QAersIQdYcnFB7
 DIUdzJXBvkSbnSubgs+B979t2V2pn+R5l2gSgx7/+CEF14h7eU48Po7xFz5L0CkDuzJAtKM7u
 Va8gRi5ycX7AJKCE6EpIOKx5QB8W1TNAb+dB4sle83jia5cy1vFJW35/EOiYjMdcTdTTDzRY+
 JxR2kd18hK9mgDqXxkk9BC8CQ+fa7/XSMVWx+JuOqDsznHHAFqoJyXbaMO8GsMOZDrWFt1qls
 e4RDlXAA+2TspKkMQoeikPatha5hSR2j3sPew1eGa8ctC+v+PRmqP6eCP6TDRN/pXkdjfkWAb
 FRllY6tIdwsnUiCOWmUTacZ3Ptk2dNe1lLq4LDacFSdONfFxr+E+i6ewn8j2mqKzMgWsB8JVp
 B+iSawly/ypzqtgUaHQiEjIH0T9ID04puaxrMkd3hfVKBIQP0e47/vJsNCA6jYHkBmx2WPaA+
 ZghuWRvgY909YWLFob221ui9c00S4LDuZPiWsCX65GqNzYAXTDMQS1jHyBU/gQ2bw7usYQMlb
 RVx8UE6bCie7fMCUzGYhEt4dVZ8UV9drStw50j+k0kna18HYyIzlAi2SGP3z7u7GIp3usHu5t
 O9uKHnciZXtkR7qX3Bh5D5g87NefVGapnF+MtCUsrJ7bX8OaDjXhidHbleo3nn9z99ZC2+PEm
 vNzMI4vui0YNp/Y9KwRoYfXqse7Kk9e8cFDXKxC76mg/1iULG+T7oxYdkNUhVzGyJ8DwL13n5
 NiNw6iXqKgGzD+sAXU808vMXSvJ+BAQ7sbnXAX8CK4aqt7DTFc/mmNhClVgbS7VerUAs/aSjH
 wwS6HKMW7EJQW4b8HFlrxc+qyE5yZY3FFXoWJWkxNhQUM
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 10/21/22 03:15, Hyunwoo Kim wrote:
> Several types of UAFs can occur when physically removing a USB device.
>
> Adds ufx_ops_destroy() function to .fb_destroy of fb_ops, and
> in this function, there is kref_put() that finally calls ufx_free().
>
> This fix prevents multiple UAFs.
>
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/linux-fbdev/20221011153436.GA4446@ubuntu/

applied.
Thanks!
Helge

> ---
> v2:
> The v1 patch fixed several UAFs, but "info" was not kfree()d after the d=
evice
> was removed by calling the framebuffer_release() function from
> ufx_free_framebuffer().
> This is because fb_info->count was not 0 at the time the
> framebuffer_release() function was called.
>
> Moved the framebuffer_release() function to the ufx_ops_destory() functi=
on.
> The ufx_ops_destory() function is a .fb_destory ops that is called
> after fb_info->count goes to zero.
> ---
>   drivers/video/fbdev/smscufx.c | 55 +++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx=
.c
> index e65bdc499c23..9343b7a4ac89 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -97,7 +97,6 @@ struct ufx_data {
>   	struct kref kref;
>   	int fb_count;
>   	bool virtualized; /* true when physical usb device not present */
> -	struct delayed_work free_framebuffer_work;
>   	atomic_t usb_active; /* 0 =3D update virtual buffer, but no usb traff=
ic */
>   	atomic_t lost_pixels; /* 1 =3D a render op failed. Need screen refres=
h */
>   	u8 *edid; /* null until we read edid from hw or get from sysfs */
> @@ -1117,15 +1116,24 @@ static void ufx_free(struct kref *kref)
>   {
>   	struct ufx_data *dev =3D container_of(kref, struct ufx_data, kref);
>
> -	/* this function will wait for all in-flight urbs to complete */
> -	if (dev->urbs.count > 0)
> -		ufx_free_urb_list(dev);
> +	kfree(dev);
> +}
>
> -	pr_debug("freeing ufx_data %p", dev);
> +static void ufx_ops_destory(struct fb_info *info)
> +{
> +	struct ufx_data *dev =3D info->par;
> +	int node =3D info->node;
>
> -	kfree(dev);
> +	/* Assume info structure is freed after this point */
> +	framebuffer_release(info);
> +
> +	pr_debug("fb_info for /dev/fb%d has been freed", node);
> +
> +	/* release reference taken by kref_init in probe() */
> +	kref_put(&dev->kref, ufx_free);
>   }
>
> +
>   static void ufx_release_urb_work(struct work_struct *work)
>   {
>   	struct urb_node *unode =3D container_of(work, struct urb_node,
> @@ -1134,14 +1142,9 @@ static void ufx_release_urb_work(struct work_stru=
ct *work)
>   	up(&unode->dev->urbs.limit_sem);
>   }
>
> -static void ufx_free_framebuffer_work(struct work_struct *work)
> +static void ufx_free_framebuffer(struct ufx_data *dev)
>   {
> -	struct ufx_data *dev =3D container_of(work, struct ufx_data,
> -					    free_framebuffer_work.work);
>   	struct fb_info *info =3D dev->info;
> -	int node =3D info->node;
> -
> -	unregister_framebuffer(info);
>
>   	if (info->cmap.len !=3D 0)
>   		fb_dealloc_cmap(&info->cmap);
> @@ -1153,11 +1156,6 @@ static void ufx_free_framebuffer_work(struct work=
_struct *work)
>
>   	dev->info =3D NULL;
>
> -	/* Assume info structure is freed after this point */
> -	framebuffer_release(info);
> -
> -	pr_debug("fb_info for /dev/fb%d has been freed", node);
> -
>   	/* ref taken in probe() as part of registering framebfufer */
>   	kref_put(&dev->kref, ufx_free);
>   }
> @@ -1169,11 +1167,13 @@ static int ufx_ops_release(struct fb_info *info,=
 int user)
>   {
>   	struct ufx_data *dev =3D info->par;
>
> +	mutex_lock(&disconnect_mutex);
> +
>   	dev->fb_count--;
>
>   	/* We can't free fb_info here - fbmem will touch it when we return */
>   	if (dev->virtualized && (dev->fb_count =3D=3D 0))
> -		schedule_delayed_work(&dev->free_framebuffer_work, HZ);
> +		ufx_free_framebuffer(dev);
>
>   	if ((dev->fb_count =3D=3D 0) && (info->fbdefio)) {
>   		fb_deferred_io_cleanup(info);
> @@ -1186,6 +1186,8 @@ static int ufx_ops_release(struct fb_info *info, i=
nt user)
>
>   	kref_put(&dev->kref, ufx_free);
>
> +	mutex_unlock(&disconnect_mutex);
> +
>   	return 0;
>   }
>
> @@ -1292,6 +1294,7 @@ static const struct fb_ops ufx_ops =3D {
>   	.fb_blank =3D ufx_ops_blank,
>   	.fb_check_var =3D ufx_ops_check_var,
>   	.fb_set_par =3D ufx_ops_set_par,
> +	.fb_destroy =3D ufx_ops_destory,
>   };
>
>   /* Assumes &info->lock held by caller
> @@ -1673,9 +1676,6 @@ static int ufx_usb_probe(struct usb_interface *int=
erface,
>   		goto destroy_modedb;
>   	}
>
> -	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
> -			  ufx_free_framebuffer_work);
> -
>   	retval =3D ufx_reg_read(dev, 0x3000, &id_rev);
>   	check_warn_goto_error(retval, "error %d reading 0x3000 register from =
device", retval);
>   	dev_dbg(dev->gdev, "ID_REV register value 0x%08x", id_rev);
> @@ -1748,10 +1748,12 @@ static int ufx_usb_probe(struct usb_interface *i=
nterface,
>   static void ufx_usb_disconnect(struct usb_interface *interface)
>   {
>   	struct ufx_data *dev;
> +	struct fb_info *info;
>
>   	mutex_lock(&disconnect_mutex);
>
>   	dev =3D usb_get_intfdata(interface);
> +	info =3D dev->info;
>
>   	pr_debug("USB disconnect starting\n");
>
> @@ -1765,12 +1767,15 @@ static void ufx_usb_disconnect(struct usb_interf=
ace *interface)
>
>   	/* if clients still have us open, will be freed on last close */
>   	if (dev->fb_count =3D=3D 0)
> -		schedule_delayed_work(&dev->free_framebuffer_work, 0);
> +		ufx_free_framebuffer(dev);
>
> -	/* release reference taken by kref_init in probe() */
> -	kref_put(&dev->kref, ufx_free);
> +	/* this function will wait for all in-flight urbs to complete */
> +	if (dev->urbs.count > 0)
> +		ufx_free_urb_list(dev);
>
> -	/* consider ufx_data freed */
> +	pr_debug("freeing ufx_data %p", dev);
> +
> +	unregister_framebuffer(info);
>
>   	mutex_unlock(&disconnect_mutex);
>   }

