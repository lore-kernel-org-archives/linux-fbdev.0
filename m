From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jan 2013 21:49:36 +0000
Subject: Re: [PATCH v5 3/8] video: mmp display controller support
Message-Id: <20130130134936.d85b5a9e.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358411023-2667-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1358411023-2667-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:23:43 +0800
Zhou Zhu <zzhu3@marvell.com> wrote:

> From: Guoqing Li <ligq@marvell.com>
> 
> Marvell mmp series display controller support in mmpdisp subsystem.
> This driver focus on implementation of hardware operations of path/ovly,
> which is defined in mmp display subsystem interface.
> This driver registers all pathes to mmp display framework.
> 
> ...
>
> +#define ovly_is_vid(ovly) (ovly->dmafetch_id % 2)
> +#define path_to_path_plat(path) \
> +	((struct mmphw_path_plat *)path->plat_data)
> +#define ovly_to_ctrl(ovly) \
> +	(path_to_ctrl(ovly->path))
> +#define path_to_ctrl(path) \
> +	(path_to_path_plat(path)->ctrl)
> +#define ctrl_regs(path) \
> +	(path_to_ctrl(path)->reg_base)

These could be implemented in C rather than in CPP.  The result would
be improved typechecking and improved readability.

>
> ...
>
