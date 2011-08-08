From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 08 Aug 2011 00:10:55 +0000
Subject: Re: [PATCH V2] viafb: replace strict_strtoul to kstrto* and check
Message-Id: <4E3F298F.406@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312760553-2143-1-git-send-email-wangshaoyan.pt@taobao.com>
In-Reply-To: <1312760553-2143-1-git-send-email-wangshaoyan.pt@taobao.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: stufever@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, lethal@linux-sh.org, Wang Shaoyan <wangshaoyan.pt@taobao.com>

On 08/07/2011 11:42 PM, stufever@gmail.com wrote:
> diff --git drivers/video/via/viafbdev.c drivers/video/via/viafbdev.c

Um, you did something different this time, causing another (not critical) 
checkpatch warning
WARNING: patch prefix 'drivers' exists, appears to be a -p0 patch

> @@ -1325,7 +1328,8 @@ static ssize_t viafb_dfpl_proc_write(struct file *file,
>   	if (copy_from_user(&buf[0], buffer, length))
>   		return -EFAULT;
>   	buf[length - 1] = '\0';	/*Ensure end string */
> -	strict_strtoul(&buf[0], 0, (unsigned long *)&reg_val);
> +	if (kstrtou8(buf, -1,&reg_val)<  0)

Did you miss my comment about the -1 above last time? Why it is there?

> +		return -EINVAL;
>   	viafb_write_reg_mask(CR99, VIACR, reg_val, 0x0f);
>   	return count;
>   }

Thanks,

Florian Tobias Schandinat
