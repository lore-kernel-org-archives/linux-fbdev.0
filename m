From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Mon, 16 Apr 2012 16:36:27 +0000
Subject: Re: [PATCH] video/via: Convert to kstrtou8_from_user
Message-Id: <CACVxJT96rXRqMoeabdDyNEjXCubuAnQ_fonisbopQvYL=Qhp2w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334445886-32448-1-git-send-email-peterhuewe@gmx.de>
In-Reply-To: <1334445886-32448-1-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Apr 15, 2012 at 2:24 AM, Peter Huewe <peterhuewe@gmx.de> wrote:
> This patch replaces the code for getting an number from a
> userspace buffer by a simple call to kstrou8_from_user.
> This makes it easier to read and less error prone.

Initialization with 0 is not necessary then.
Also "count < 1" check could be dropped, since empty string will fail
with EINVAL.
Otherwise OK.

> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -1276,17 +1276,14 @@ static int viafb_dfph_proc_open(struct inode *inode, struct file *file)
>  static ssize_t viafb_dfph_proc_write(struct file *file,
>        const char __user *buffer, size_t count, loff_t *pos)
>  {
> -       char buf[20];
> +       int err;
>        u8 reg_val = 0;
> -       unsigned long length;
>        if (count < 1)
>                return -EINVAL;
> -       length = count > 20 ? 20 : count;
> -       if (copy_from_user(&buf[0], buffer, length))
> -               return -EFAULT;
> -       buf[length - 1] = '\0'; /*Ensure end string */
> -       if (kstrtou8(buf, 0, &reg_val) < 0)
> -               return -EINVAL;
> +       err = kstrtou8_from_user(buffer, count, 0, &reg_val);
> +       if (err)
> +               return err;
> +
>        viafb_write_reg_mask(CR97, VIACR, reg_val, 0x0f);
>        return count;
>  }
> @@ -1316,17 +1313,14 @@ static int viafb_dfpl_proc_open(struct inode *inode, struct file *file)
>  static ssize_t viafb_dfpl_proc_write(struct file *file,
>        const char __user *buffer, size_t count, loff_t *pos)
>  {
> -       char buf[20];
> +       int err;
>        u8 reg_val = 0;
> -       unsigned long length;
>        if (count < 1)
>                return -EINVAL;
> -       length = count > 20 ? 20 : count;
> -       if (copy_from_user(&buf[0], buffer, length))
> -               return -EFAULT;
> -       buf[length - 1] = '\0'; /*Ensure end string */
> -       if (kstrtou8(buf, 0, &reg_val) < 0)
> -               return -EINVAL;
> +       err = kstrtou8_from_user(buffer, count, 0, &reg_val);
> +       if (err)
> +               return err;
> +
>        viafb_write_reg_mask(CR99, VIACR, reg_val, 0x0f);
>        return count;
>  }
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
